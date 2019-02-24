#Helper Script to create the weighted priority matrix for each edge

import pandas as pd
import numpy as np

def get_priority_matrix(filename, employee_id):
    patient_df = pd.read_csv(filename)
    patient_df = patient_df[patient_df['employee_id'] == employee_id]

    patient_df['priority_value'] = patient_df['prioirty_level'].apply(get_priority_value)
    patient_matrix = np.matrix(patient_df['priority_value'])
    
    priority_matrix = np.matmul(patient_matrix.transpose(), patient_matrix)
    return priority_matrix


def get_priority_value(str):
    if str == None:
        return 0
    elif  str == 'Low':
        return .9
    elif str == 'Medium':
        return .6
    elif str == 'High':
        return .3

print(get_priority_matrix('CSV/PATIENT_TASK_DATA.csv', 55))