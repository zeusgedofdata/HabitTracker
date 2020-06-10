import csv
import Activity
from datetime import datetime


# noinspection SpellCheckingInspection
class DaylioImporter:
    def __init__(self):
        self._file_path = r"C:\Users\zeusg\OneDrive\Documents\Takeout\daylio_export_2020_05_05.csv"

    def ingest_data(self):
        with open(self._file_path) as csv_file:
            csv_reader = csv.reader(csv_file, delimiter=',')
            line_count = 0
            for row in csv_reader:
                if line_count == 0:
                    line_count += 1
                else:
                    date = self.convert_date(row[0])
                    activities = row[5].split("|")
                    note = row[6]
                    for activity in activities:
                        activity = self.normalize_activity(activity)
                        Activity.Activity(activity, activity + " - " + date, date, note).add_entry()
                    line_count += 1

    @staticmethod
    def normalize_activity(activity):
        if "yoga" in activity.lower():
            activity = 'Yoga'
        return activity.strip().capitalize()

    @staticmethod
    def convert_date(date_string):
        date_obj = datetime.strptime(date_string, '%Y-%m-%d')
        return date_obj.strftime('%A %B %d %Y')


