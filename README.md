# Portfolio Project for MSE with DevOps

### By Lane Harbarger

_What are the various features you would like your project to offer?_
I would like to write a backend application that would be used to provide access to fitness facilities. This application would keep track of memberships, classes, trainers, equipment, and amenity access.

_What are the API endpoints that you would need to set up for each feature? List them along with the respective HTTP verb, endpoint URL, and any special details (query parameters, request bodies, headers)._

1. POST to create a record for a new member with the membership level for amenity access.
2. POST to create a record for a calendar booking with a trainer.
3. POST to create a record for a workout class.
4. GET to query workout class attendees and assigned trainer.
5. GET to query if a member has access to a certain amenity.
6. POST to create a record of amenity use each time a member scans their id.

_Provide a description of the database tables required for your application, including column names, data types, constraints, and foreign keys. Include your database name. You can optionally include an ER diagram._

The tables required for Average_Joe_Gym are as follows:

gym_locations, amenities, membership_levels, gym_members, gym_trainers, access_logs, trainer_schedules, class_schedules, class_types
# mse-portfolio-project
