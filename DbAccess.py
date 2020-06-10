import psycopg2
import pandas as pd


# TODO Load params from prop file

class Db:

    def __init__(self):
        separator = "="
        db_prop = {}

        # I named your file conf and stored it
        # in the same directory as the script

        with open('./config/database.properties') as f:

            for line in f:
                if separator in line:
                    # Find the name and value by splitting the string
                    name, value = line.split(separator, 1)

                    # Assign key value pair to dict
                    # strip() removes white space from the ends of strings
                    db_prop[name.strip()] = value.strip()
        print(db_prop)
        self._username = db_prop.get('username')
        self._password = db_prop.get('password')
        self._host = db_prop.get('host')
        self._port = db_prop.get('port')
        self._database = db_prop.get('database')

    def make_connection(self):
        connection = psycopg2.connect(user=self._username,
                                      password=self._password,
                                      host=self._host,
                                      port=self._port,
                                      database=self._database)
        return connection, connection.cursor()

    def insert_adv(self, query, values):
        try:
            connection, cursor = self.make_connection()
            cursor.execute(query, values)
            connection.commit()

            # Return the id of the new row
            return cursor.fetchone()[0]
        except (Exception, psycopg2.Error) as error:
            print("Error while connecting to PostgreSQL", error)
        finally:
            # closing database connection.
            if connection:
                cursor.close()
                connection.close()

    def select_adv(self, query, values):
        try:
            connection, cursor = self.make_connection()
            cursor.execute(query, (values,))
            return cursor.fetchall()
        except(Exception, psycopg2.Error) as error:
            print("Error while connecting to PostgreSQL", error)
        finally:
            if connection:
                cursor.close()
                connection.close()

    def add_activity(self, name, date, category, notes):
        cat_query = 'SELECT id FROM public.category WHERE name = %s'
        cat_value = category.lower().strip()
        cat = self.select_adv(cat_query, cat_value)

        if len(cat) > 0:
            cat_id = str(cat[0][0])
            activity_query = 'INSERT INTO public.activity ("name","date",note,category_fk) ' \
                             'VALUES(%s,%s,%s,%s) RETURNING id;'
            activity_values = (str(name), str(date), str(notes), cat_id)
            return self.insert_adv(activity_query, activity_values)
        else:
            return -1
            print("Could not find activity category for: " + category)

    def add_fit_activity(self, calories, heart_rate, pace, duration, distance, activity_fk):
        fit_insert = "INSERT INTO public.fit_activity (calories,heart_rate,pace,duration," \
                     "distance,activity_fk) VALUES(%s,%s,%s,%s,%s,%s)"
        fit_values = (str(calories), str(heart_rate), str(pace), str(duration), str(distance), str(activity_fk))
        self.insert_adv(fit_insert, fit_values)

    def check_activity_exists(self, name):
        activity_select = 'SELECT * FROM public.activity WHERE name = %s'
        row = self.select_adv(activity_select, str(name))
        if len(row) > 0:
            return row[0][0]
        else:
            return False

    def get_activity(self):
        try:
            activity_select = 'select c."name", m."name", a."name" , a."date", f.duration, f.distance, f.heart_rate, ' \
                              'f.calories, f.pace from public.activity a ' \
                              'LEFT join public.fit_activity f on a.id = f.activity_fk ' \
                              'inner join public.category c on a.category_fk = c.id ' \
                              'inner join public.meta_category m on c.metacat_fk = m.id order by a."date" '
            connection, cursor = self.make_connection()
            return pd.read_sql(activity_select, connection)
        except (Exception, psycopg2.Error) as error:
            print("Error while connecting to PostgreSQL", error)
        finally:
            if connection:
                cursor.close()
                connection.close()

# db = Db()
# db.connect_test()
