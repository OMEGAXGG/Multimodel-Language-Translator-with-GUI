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

# Add this import at the top of the file
from database import TranslationDatabase

# Suppress FutureWarnings from the Stanza library
warnings.filterwarnings("ignore", category=FutureWarning)

# Set the console to use UTF-8 encoding
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')
sys.stderr = io.TextIOWrapper(sys.stderr.buffer, encoding='utf-8')

# Initialize the database
db = TranslationDatabase()

def translate_text(text, from_lang, to_lang):
    argostranslate.package.update_package_index()
    available_packages = argostranslate.package.get_available_packages()

    # Try direct translation
    direct_package = next((x for x in available_packages if x.from_code == from_lang and x.to_code == to_lang), None)

    if direct_package:
        # Direct translation package found
        argostranslate.package.install_from_path(direct_package.download())
        translated_text = argostranslate.translate.translate(text, from_code=from_lang, to_code=to_lang)
    else:
        # No direct translation package, try using English as an intermediate
        to_en_package = next((x for x in available_packages if x.from_code == from_lang and x.to_code == 'en'), None)
        en_to_dest_package = next((x for x in available_packages if x.from_code == 'en' and x.to_code == to_lang), None)

        if to_en_package and en_to_dest_package:
            argostranslate.package.install_from_path(to_en_package.download())
            argostranslate.package.install_from_path(en_to_dest_package.download())

            # Translate to English first, then to the target language
            english_text = argostranslate.translate.translate(text, from_code=from_lang, to_code='en')
            translated_text = argostranslate.translate.translate(english_text, from_code='en', to_code=to_lang)
        else:
            return f"Error: No suitable translation package found for {from_lang} to {to_lang}."

    # Add the translation to the database
    db.add_translation(text, translated_text, from_lang, to_lang)

    return translated_text

def translate_speech(from_lang, to_lang):
    r = sr.Recognizer()
    with sr.Microphone() as source:
        print('Listening...')
        audio = r.listen(source)
        print('Processing...')
    try:
        text = r.recognize_google(audio, language=from_lang)
        print('Recognized text:', text)
        translated_text = translate_text(text, from_lang, to_lang)
        return translated_text
    except sr.UnknownValueError:
        return 'Speech recognition could not understand audio'
    except sr.RequestError as e:
        return f'Could not request results from speech recognition service; {e}'

def translate_image(image_path, from_lang, to_lang):
    try:
        # Read the image using OpenCV
        img = cv2.imread(image_path)
        if img is None:
            return f"Error: Unable to read the image at {image_path}"

        # Create a reader instance
        reader = easyocr.Reader([from_lang])

        # Read the text from the image
        result = reader.readtext(img)

        # Extract the text from the response
        text = ' '.join([item[1] for item in result])

        print('Extracted text:', text)
        translated_text = translate_text(text, from_lang, to_lang)
        return translated_text
    except Exception as e:
        return f"Error: {str(e)}"

# Add a new function to get recent translations
def get_recent_translations(limit=10):
    return db.get_recent_translations(limit)

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print('Usage: python translator.py <mode> [<args>]')
        sys.exit(1)

    mode = sys.argv[1]

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

    # Close the database connection
    db.close()
