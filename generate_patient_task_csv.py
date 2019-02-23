import pandas as pd

patient_data_df = pd.read_csv('CSV/PATIENT_DATA_EDITED.csv')
patient_task_df = pd.read_csv('CSV/TASK_DATA.csv')

new_df  = pd.merge(patient_data_df, patient_task_df, how='outer', on='patient_id')

new_df.to_csv('PATIENT_TASK_DATA.csv')