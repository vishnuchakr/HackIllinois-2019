from ortools.constraint_solver import pywrapcp
from ortools.constraint_solver import routing_enums_pb2
from routeOptimizer.py import get_distance_matrix

# Distance callback
def create_distance_callback(dist_matrix):
  # Create a callback to calculate distances between cities.

  def distance_callback(from_node, to_node):
      return int(dist_matrix[from_node][to_node])

  return distance_callback

def optimal_route():
    
    distance_array = get_distance_matrix('CSV/PATIENT_TASK_DATA.csv', 55)
    '''
    tsp_size = len(distance_array)
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
    '''
    print(distance_array)