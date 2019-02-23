#Route optimization algorithm for nurses

def next_destination(filename):
    
    with open (filename) as f:
        csvReader = csv.reader(f)
        routeData = list(csvReader)
        
    

