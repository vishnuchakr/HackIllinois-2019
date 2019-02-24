from ortools.constraint_solver import pywrapcp
from ortools.constraint_solver import routing_enums_pb2
from backend import get_distance_matrix
import pandas as pd

# Distance callback
def create_distance_callback(dist_matrix):
  # Create a callback to calculate distances between cities.

  def distance_callback(from_node, to_node):
      return int(dist_matrix[from_node][to_node])

  return distance_callback

def optimal_route():

    patient_df = pd.read_csv('backend/CSV/PATIENT_TASK_DATA.csv')
    patient_df = patient_df[patient_df['employee_id'] == 1]
    patient_df['full_address'] = patient_df['street_address'] + ', ' + patient_df['city'] +  ', ' + patient_df['state']

    city_names = list(patient_df['full_address'])
    
    dist_matrix = get_distance_matrix.get_distance_matrix('backend/CSV/PATIENT_TASK_DATA.csv', 1)
    
    tsp_size = len(dist_matrix)
    num_routes = 1
    depot = 0
        
    # Create routing model
    if tsp_size > 0:
        routing = pywrapcp.RoutingModel(tsp_size, num_routes, depot)
        search_parameters = pywrapcp.RoutingModel.DefaultSearchParameters()

        # Create the distance callback.
        dist_callback = create_distance_callback(dist_matrix)
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
            route = ''
            while not routing.IsEnd(index):
                # Convert variable indices to node indices in the displayed route.
                route += str(city_names[routing.IndexToNode(index)]) + ' -> '
                index = assignment.Value(routing.NextVar(index))
            route += str(city_names[routing.IndexToNode(index)])
            print("Route:\n\n" + route)
        else:
            print('No solution found.')

    else:
        print('Specify an instance greater than 0.')
    
    print(dist_matrix)

optimal_route()