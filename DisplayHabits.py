import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np
import pandas as pd
import DbAccess as db

pd.options.mode.chained_assignment = None

my_db = db.Db()
activity_df = my_db.get_activity()

frequency_df = activity_df.iloc[:, [0, 3]]
frequency_df.insert(2, "frequency", 1)

frequency_df['date'] = pd.to_datetime(frequency_df['date'], errors='coerce')

frequency_df = frequency_df.sort_values('date').sort_values('name')

frequency_df['date'] = frequency_df['date'].dt.strftime("%a")
frequency_df = frequency_df.set_index(['name', 'date'])

#frequency_df = frequency_df.reset_index()
#frequency_df.loc['date'] = pd.Categorical(frequency_df.loc['date'], ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'])
#frequency_df.sort_values("date")
print(frequency_df)



frequency_by_activity = frequency_df.groupby(level=0).sum().reset_index()
frequency_by_date = frequency_df.groupby(level=1).sum().reset_index()

frequency_df = frequency_df.reset_index()
frequency_by_both = frequency_df.groupby(['name', 'date']).sum()

# print(frequency_by_activity)
# print(frequency_by_date)
print(frequency_by_both)

activity_types = frequency_by_both.index.get_level_values(0).unique()

sns.set(style='whitegrid')
ax = sns.barplot(x='name', y='frequency', data=frequency_by_activity)
#ax = sns.barplot(x='date', y='frequency', data=frequency_by_date)
#ax = sns.barplot(x='date', y='frequency', hue='name', data=frequency_by_both.reset_index())

plt.show()
