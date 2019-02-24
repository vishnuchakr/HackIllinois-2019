from flask import jsonify
from flask import Flask, request, url_for
import tsp

application = Flask(__name__)



@application.route('/')
def hello_world():
    return "baseURL"

@application.route('/getMapData/<employeeID>')
def getPath(employeeID):
    pathDict = tsp.optimal_route(int(employeeID))
    print(pathDict)
    return jsonify(pathDict)



'''
This function runs the application properly 
The debugger is enabled
'''
if __name__ == "__main__":
    application.debug = True
    application.run(host='0.0.0.0', port=3000)
