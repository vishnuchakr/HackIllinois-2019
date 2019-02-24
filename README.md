# HackIllinois-2019
A route optimization tool for nurses traveling between numerous patients.

## The problem

Briova currently has no system in place to optimize the order in which nurses treat their patients. Our app aims to maximize the number of patients a Briova nurse can see in any given day by accounting for the time it takes to travel between patient's houses, while still putting high priority patients first.

## Our Tech Stack

* Swift (for iOS app)
* Flask (for communication with python script and CSVs in the backend)
* Google's Distance Matrix API (for route information)
* Google's ORTools, an open source software suite that we used to solve the Traveling Salesman Problem aspect of this optimization  task
* Python

## Our Algorithm

We factored in three different measurements into our optimization algorithm:

1. Distance between patient houses (weighted highest)
2. Priority level of task
3. Due date of task

Using these three factors, we created weighted matrices that we passed into a tool built by Google to solve TSPs.

## Our App

Our app takes in the ID of the employee and gets a list of that employee's patients based on the CSV's given to us by Optum (all patients were given random addresses in Champaign county for testing and development purposes). The app then communicates with a Flask server to get the optimal route based on our algorithm and displays it to the user in the form of a map.

![Diagram](https://github.com/vishnuchakr/HackIllinois-2019/blob/master/Simulator%20Screen%20Shot%20-%20iPad%20Pro%20(12.9-inch)%20(2nd%20generation)%20-%202019-02-24%20at%2001.34.37.png)

This is a visual of the Optimal Path based on an employee id and and an Implementation of the Traveling Salesman problem. According to our method this is very close to the optimal path for this one employee to take. If another nurse were to run this algorithm they would get a different result based on thier start position and time of departure. The start position could be something like the office or the nurse's home. 
