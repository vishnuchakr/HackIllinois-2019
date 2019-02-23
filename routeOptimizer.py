#Route optimization algorithm for nurses

import googlemaps
from datetime import datetime
import pandas as pd

def next_destination(filename):
	patient_df = pd.read_csv(filename)

	node_list = []

	for index, row in patient_df.iterrows():
		node_list.append(Node(row['patient_id'], row['last_name'], row['street_address'], row['city'], row['state'], row['prioirty_level']))

	api_key = open("api_key.txt","r")

	

class Node():

	def __init__(self, patient_id, patient_name, street_address, city, state, priority_level, therapy_type, edge_list):
		self.patient_id = patient_id
		self.patient_name = patient_name
		self.street_address = street_address
		self.city = city
		self.state = state
		self.full_address = street_address + ', ' + city  + ', ' + state
		self.priority_level = priority_level
		self.therapy_type = therapy_type
		self.edge_list = []

	def initialize_edge_list(other_nodes, key):
		gmaps = googlemaps.Client(key=key)
		now = datetime.now()

		for node in other_nodes:
			edge_dict = {}
			edge_dict['patient_id'] = node.patient_id

			directions_result = gmaps.directions(self.full_address, node.full_address, mode="transit", departure_time=now)

			edge_dict['time_to_destination'] = directions_result[]








