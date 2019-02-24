#Helper Script to create the weighted priority matrix for each edge

import pandas as pd
import numpy as np

def get_priority_matrix(filename, employee_id):
    patient_df = pd.read_csv(filename)
    patient_df = patient_df[patient_df['employee_id'] == employee_id]
    patient_df['full_address'] = patient_df['street_address'] + ', ' + patient_df['city'] +  ', ' + patient_df['state']
    patient_df = patient_df.dropna(subset=['full_address'])
    patient_num = len(patient_df['full_address']) + 1

    employee_df = pd.read_csv('CSV/EMPLOYEE_DATA.csv')
    employee_df = employee_df[employee_df['employee_id'] == employee_id]

    patient_df['priority_value'] = patient_df['prioirty_level'].apply(get_priority_value)
    patient_matrix = [0] + list(patient_df['priority_value'])

    new_patient_matrix = np.array([patient_matrix,]*patient_num).transpose()
    print(type(new_patient_matrix))
    # print(new_patient_matrix[0][0])

    for i in range(0, patient_num):
        new_patient_matrix[i,i] = 0.0

    print(new_patient_matrix)
    # patient_matrix = np.matrix(patient_matrix)

    # priority_matrix = np.matmul(patient_matrix.transpose(), patient_matrix)

    # return priority_matrix
    return new_patient_matrix


def get_priority_value(str):
    if str == None:
        return 0
    elif  str == 'Low':
        return .9
    elif str == 'Medium':
        return .6
    elif str == 'High':
        return .3


get_priority_matrix('CSV/PATIENT_TASK_DATA.csv', 55)