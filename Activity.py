import DbAccess


class Activity:
    def __init__(self, category, name, date, notes):
        self._category = category
        self._name = name
        self._date = date
        self._notes = notes
        self._db = DbAccess.Db()

    def add_entry(self):
        if not self._db.check_activity_exists(self._name):
            self._db.add_activity(self._name, self._date, self._category, self._notes)
        else:
            print('Found duplicate')

    def add_fit_entry(self, calories, heart_rate, pace, duration, distance):
        print(self._name)
        row_id = self._db.check_activity_exists(self._name)
        if not row_id:
            row_id = self._db.add_activity(self._name, self._date, self._category, self._notes)
        else:
            print('Found duplicate')
        fit_id = self._db.check_fit_activity_exists(row_id)
        if not fit_id:
            self._db.add_fit_activity(calories, heart_rate, pace, duration, distance, row_id)
        else:
            print("Found duplicate fit row")
