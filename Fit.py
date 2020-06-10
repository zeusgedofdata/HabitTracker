import tcxparser
from os import listdir
import os
from os import path

import Activity
from datetime import datetime


class GoogleFitImporter:

    def __init__(self):
        self._folderLocation = r"C:\Users\zeusg\OneDrive\Documents\Takeout\Fit"
        self._activitiesLocation = self._folderLocation + r"\Activities"
        self._dailyAggLocation = self._folderLocation + r"\DailyAggregations"

    def import_fit_data(self):
        """
        Will look at the file location for our google fit files and loop though imported them by category. It will
        ignore any walking activity to remove clutter. Then call a function to move any read files to the ./imported
        folder
        """
        categories = ['Running', 'Yoga', 'Weights', 'Wal']
        for category in categories:
            file_names = self.get_tcx_files(category)
            for file in file_names:
                if category is not 'Wal':
                    tcx = tcxparser.TCXParser(self._activitiesLocation + '\\' + file)
                    date_str, duration, pace = self.convert_data(tcx)
                    name = category + " - " + date_str
                    notes = tcx.activity_notes
                    calories = tcx.calories
                    heart_rate = self.get_heart_rate(tcx)
                    distance = tcx.distance

                    fit_activity = Activity.Activity(category, name, date_str, notes)
                    fit_activity.add_fit_entry(calories, heart_rate, pace, duration, distance)
                self.move_read_files(file)

    def convert_data(self, tcx):
        """
        @:param a .tcx file from google fit

        This method converts the date, and duration from the tcx file into a postgres friendly format
        """
        date_str = self.convert_date(tcx.started_at)
        duration = self.convert_time(tcx.duration)
        pace = self.convert_time(tcx.duration)
        return date_str, duration, pace

    def get_tcx_files(self, category):
        """
            @:param a string with the name of the exercise category we wish to use

            This methods loops through all files in the activity folder returns only
            the files of the correct category type
        """
        category_files = [file for file in listdir(self._activitiesLocation)
                          if category.lower() in file.lower()]
        return category_files

    def move_read_files(self, file):
        """
            @:param A file name that has been read

            This method move any read files to the /imported folder
        """
        if not path.exists(self._activitiesLocation + r'\imported'):
            os.mkdir(self._activitiesLocation + r'\imported')
        os.replace(self._activitiesLocation + "\\" + file, self._activitiesLocation + '\\imported\\' + file)

    @staticmethod
    def convert_date(date_string):
        # Remove the time
        date_string = date_string.split('T')[0]
        date_obj = datetime.strptime(date_string, '%Y-%m-%d')
        return date_obj.strftime('%A %B %d %Y')

    @staticmethod
    def convert_time(sec):
        total_seconds = int(sec)
        hours, remainder = divmod(total_seconds, 60 * 60)
        minutes, seconds = divmod(remainder, 60)
        hours = str(hours).zfill(2)
        minutes = str(minutes).zfill(2)
        seconds = str(seconds).zfill(2)
        return '{}:{}:{}'.format(hours, minutes, seconds)

    @staticmethod
    def get_heart_rate(tcx):
        try:
            return tcx.hr_avg
        except Exception:
            return 0



