import sys
import os
import io
import warnings
import argostranslate.package
import argostranslate.translate
import speech_recognition as sr
from PIL import Image
import easyocr
import cv2
import numpy as np
import sqlite3
import requests
from database import TranslationDatabase

# Suppress FutureWarnings
warnings.filterwarnings("ignore", category=FutureWarning)

# Set UTF-8 encoding
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')
sys.stderr = io.TextIOWrapper(sys.stderr.buffer, encoding='utf-8')

# Initialize database
db = TranslationDatabase()

# Groq API Configuration
GROQ_API_KEY = "API Key"

def get_facts_about_language(language_code):
    try:
        url = "https://api.groq.com/openai/v1/chat/completions"
        headers = {
            "Authorization": f"Bearer {GROQ_API_KEY}",
            "Content-Type": "application/json"
        }

        payload = {
            "model": "mixtral-8x7b-32768",
            "messages": [
                {
                    "role": "user",
                    "content": f"Give me exactly 5 interesting facts about the {language_code} language. Keep each fact brief and present them in a numbered list."
                }
            ],
            "temperature": 0.7,
            "max_tokens": 200
        }

        response = requests.post(url, headers=headers, json=payload)

        if response.status_code == 200:
            facts = response.json()["choices"][0]["message"]["content"].split("\n")
            return [fact.strip() for fact in facts if fact.strip()]
        else:
            print(f"API Error: {response.status_code} - {response.text}")
            return []

    except requests.exceptions.RequestException as e:
        print(f"Error connecting to Groq API: {str(e)}")
        return []
    except Exception as e:
        print(f"Unexpected error: {str(e)}")
        return []

def translate_text(text, from_lang, to_lang):
    try:
        # Update package index
        argostranslate.package.update_package_index()
        available_packages = argostranslate.package.get_available_packages()

        # Try direct translation
        direct_package = next((x for x in available_packages if x.from_code == from_lang and x.to_code == to_lang), None)

        if direct_package:
            argostranslate.package.install_from_path(direct_package.download())
            translated_text = argostranslate.translate.translate(text, from_code=from_lang, to_code=to_lang)
        else:
            # Try translation through English
            to_en_package = next((x for x in available_packages if x.from_code == from_lang and x.to_code == 'en'), None)
            en_to_dest_package = next((x for x in available_packages if x.from_code == 'en' and x.to_code == to_lang), None)

            if to_en_package and en_to_dest_package:
                argostranslate.package.install_from_path(to_en_package.download())
                argostranslate.package.install_from_path(en_to_dest_package.download())

                english_text = argostranslate.translate.translate(text, from_code=from_lang, to_code='en')
                translated_text = argostranslate.translate.translate(english_text, from_code='en', to_code=to_lang)
            else:
                return f"Error: No suitable translation package found for {from_lang} to {to_lang}."

        # Store translation in database
        db.add_translation(text, translated_text, from_lang, to_lang)

        # Get language facts
        print("\nInteresting facts about the target language:")
        facts = get_facts_about_language(to_lang)
        if facts:
            for i, fact in enumerate(facts, 1):
                print(f"{fact}")
        else:
            print("Could not retrieve language facts at this time.")

        print("\nTranslated Text: ")
        return translated_text

    except Exception as e:
        return f"Translation error: {str(e)}"

def translate_speech(from_lang, to_lang):
    r = sr.Recognizer()
    with sr.Microphone() as source:
        print('Listening...')
        audio = r.listen(source)
        print('Processing...')
    try:
        text = r.recognize_google(audio, language=from_lang)
        print('Recognized text:', text)
        return translate_text(text, from_lang, to_lang)  # Facts will be printed in translate_text()
    except sr.UnknownValueError:
        return 'Speech recognition could not understand audio'
    except sr.RequestError as e:
        return f'Could not request results from speech recognition service; {e}'

def translate_image(image_path, from_lang, to_lang):
    try:
        img = cv2.imread(image_path)
        if img is None:
            return f"Error: Unable to read the image at {image_path}"

        reader = easyocr.Reader([from_lang])
        result = reader.readtext(img)
        text = ' '.join([item[1] for item in result])

        print('Extracted text:', text)
        return translate_text(text, from_lang, to_lang)  # Facts will be printed in translate_text()
    except Exception as e:
        return f"Error: {str(e)}"

def get_recent_translations(limit=10):
    return db.get_recent_translations(limit)

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print('Usage: python translator.py <mode> [<args>]')
        sys.exit(1)

    mode = sys.argv[1]

    try:
        if mode == 'text':
            if len(sys.argv) != 5:
                print('Usage: python translator.py text <from_lang> <to_lang> <text>')
                sys.exit(1)
            from_lang, to_lang, text = sys.argv[2], sys.argv[3], sys.argv[4]
            print(translate_text(text, from_lang, to_lang))

        elif mode == 'speech':
            if len(sys.argv) != 4:
                print('Usage: python translator.py speech <from_lang> <to_lang>')
                sys.exit(1)
            from_lang, to_lang = sys.argv[2], sys.argv[3]
            print(translate_speech(from_lang, to_lang))

        elif mode == 'image':
            if len(sys.argv) != 5:
                print('Usage: python translator.py image <from_lang> <to_lang> <image_path>')
                sys.exit(1)
            from_lang, to_lang, image_path = sys.argv[2], sys.argv[3], sys.argv[4]
            print(translate_image(image_path, from_lang, to_lang))

        elif mode == 'recent':
            limit = int(sys.argv[2]) if len(sys.argv) > 2 else 10
            recent_translations = get_recent_translations(limit)
            for translation in recent_translations:
                print(f"From {translation[3]} to {translation[4]}:")
                print(f"Source: {translation[1]}")
                print(f"Translation: {translation[2]}")
                print(f"Timestamp: {translation[5]}")
                print("---")
        else:
            print('Invalid mode')

    except Exception as e:
        print(f"Error: {str(e)}")
    finally:
        # Close database connection
        db.close()
