from flask import jsonify
from flask import Flask, request, url_for

application = Flask(__name__)



@application.route('/')
def hello_world():
    return "baseURL"

@application.route('/getMapData/<nurseType>')
def getPath(nurseType):
    return jsonify({"passed": nurseType})



'''
This function runs the application properly 
The debugger is enabled
'''
if __name__ == "__main__":
    application.debug = True
    application.run()
