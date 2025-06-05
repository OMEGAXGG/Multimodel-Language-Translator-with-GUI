import sqlite3
import os

class TranslationDatabase:
    def __init__(self, db_file='translations.db'):
        self.db_file = db_file
        self.conn = None
        self.create_table()

    def connect(self):
        if not self.conn:
            self.conn = sqlite3.connect(self.db_file)
        return self.conn

    def create_table(self):
        conn = self.connect()
        cursor = conn.cursor()
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS translations (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                source_text TEXT,
                translated_text TEXT,
                from_lang TEXT,
                to_lang TEXT,
                timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
            )
        ''')
        conn.commit()

    def add_translation(self, source_text, translated_text, from_lang, to_lang):
        conn = self.connect()
        cursor = conn.cursor()
        cursor.execute('''
            INSERT INTO translations (source_text, translated_text, from_lang, to_lang)
            VALUES (?, ?, ?, ?)
        ''', (source_text, translated_text, from_lang, to_lang))
        conn.commit()

    def get_recent_translations(self, limit=10):
        conn = self.connect()
        cursor = conn.cursor()
        cursor.execute('''
            SELECT * FROM translations
            ORDER BY timestamp DESC
            LIMIT ?
        ''', (limit,))
        return cursor.fetchall()

    def close(self):
        if self.conn:
            self.conn.close()
            self.conn = None

    def delete_recent_translations(self):
        conn = self.connect()
        cursor = conn.cursor()
        cursor.execute('DELETE FROM translations')
        conn.commit()
