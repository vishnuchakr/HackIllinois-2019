#Route optimization algorithm for nurses

import googlemaps
from datetime import datetime
import pandas as pd
import numpy as np


def sigmoid(x, derivative=False):
    sigm = 1. / (1. + np.exp(-x))
    if derivative:
        return sigm * (1. - sigm)
    return sigm

def get_due_date_matrix(filename, employee_id):
	patient_df = pd.read_csv(filename)
	patient_df = patient_df[patient_df['employee_id'] == employee_id]
	patient_df['full_address'] = patient_df['street_address'] + ', ' + patient_df['city'] +  ', ' + patient_df['state']

	patient_df = patient_df.dropna(subset=['full_address'])

	patient_df['datetime'] = pd.to_datetime(patient_df['due_date'])

	min_date = min(patient_df['datetime'])

	patient_df['time_since_first'] = patient_df['datetime'] - min_date

	patient_df['time_since_first'] = patient_df['time_since_first'].apply(days)

	patient_df['time_since_first'] = patient_df['time_since_first'] + 1

	patient_matrix = [0] + list(patient_df['time_since_first'])

	patient_num = len(patient_matrix)

	new_patient_matrix = np.array([patient_matrix,]*patient_num).transpose()

	# print(new_patient_matrix)

	# new_patient_matrix = np.matrix(patient_matrix)

	# due_date_matrix = np.matmul(patient_matrix.transpose(), patient_matrix)

	#due_date_matrix = sigmoid(due_date_matrix)

	return new_patient_matrix

def days(td):
    return td.days

print(get_due_date_matrix('CSV/PATIENT_TASK_DATA.csv', 1))