from ortools.constraint_solver import pywrapcp
from ortools.constraint_solver import routing_enums_pb2
import get_distance_matrix 
import get_priority_matrix
import get_due_date_matrix
import math
import pandas as pd
import numpy as np


# Distance callback
def create_distance_callback(dist_matrix):
  # Create a callback to calculate distances between cities.

  def distance_callback(from_node, to_node):
      return int(dist_matrix[from_node][to_node])

  return distance_callback 

def optimal_route(employee_id): 
    patient_df = pd.read_csv('CSV/PATIENT_TASK_DATA.csv')
    patient_df = patient_df[patient_df['employee_id'] == employee_id]
    patient_df['full_address'] = patient_df['street_address'] + ', ' + patient_df['city'] +  ', ' + patient_df['state']
    patient_df = patient_df.dropna(subset=['full_address'])

    distance_matrix = get_distance_matrix.get_distance_matrix('CSV/PATIENT_TASK_DATA.csv', employee_id)
    priority_matrix = get_priority_matrix.get_priority_matrix('CSV/PATIENT_TASK_DATA.csv', employee_id)
    due_date_matrix = get_due_date_matrix.get_due_date_matrix('CSV/PATIENT_TASK_DATA.csv', employee_id)

    distance_matrix = sigmoid(distance_matrix)
    priority_matrix = sigmoid(priority_matrix)
    due_date_matrix = sigmoid(due_date_matrix)

    print(distance_matrix.shape)
    print(priority_matrix.shape)
    print(due_date_matrix.shape)

    addresses = list(patient_df['full_address'])

    weighted_matrix = np.array(.33*distance_matrix + .33*priority_matrix + .33*due_date_matrix)

    for i in range(0, len(weighted_matrix)):
        weighted_matrix[i,i] = 0

    print(distance_matrix)
    print(type(distance_matrix))
    print(weighted_matrix)
    print(type(weighted_matrix))
    
    tsp_size = len(weighted_matrix)
    num_routes = 1 
    depot = 0
        
    # Create routing model
    if tsp_size > 0:
        routing = pywrapcp.RoutingModel(tsp_size, num_routes, depot)
        search_parameters = pywrapcp.RoutingModel.DefaultSearchParameters()

        # Create the distance callback.
        dist_callback = create_distance_callback(weighted_matrix)
        routing.SetArcCostEvaluatorOfAllVehicles(dist_callback)

        # Solve the problem.
        assignment = routing.SolveWithParameters(search_parameters)

        if assignment:
            # Solution distance.
            print("Total distance: " + str(assignment.ObjectiveValue()) + " miles\n")
            # Display the solution.
            # Only one route here; otherwise iterate from 0 to routing.vehicles() - 1
            route_number = 0
            index = routing.Start(route_number) # Index of the variable for the starting node.
            route = []

            print(type(patient_df))

            while not routing.IsEnd(index):
                # Convert variable indices to node indices in the displayed route.
                route.append({list(patient_df['last_name'])[routing.IndexToNode(index)] : addresses[routing.IndexToNode(index)]})
                index = assignment.Value(routing.NextVar(index))
            route.append({list(patient_df['last_name'])[routing.IndexToNode(index)] : addresses[routing.IndexToNode(index)]})
            # print("Route:\n\n" + route)
        else:
            print('No solution found.')

    else:
        print('Specify an instance greater than 0.')

    return route
    
def sigmoid(x):
  return 1 / (1 + np.exp(-x))

print(optimal_route(55))