# Solution 1: Public transport routes and wait times app
## Problem
Public transport (Transmilenio and SITP buses) users don't really know how long will they have to wait for their route, as the buses very often don't arrive in regular intervals. This affects their estimations of the time they will take to get to their destinations.
## Solution
A mobile app in which users select beforehand the route that they are going to take and go to their stop. The app starts timing their wait time using the device GPS, when the user leaves in their bus the data is sent to the server. This data from all users is gathered and analyzed so that the wait times can be predicted based on historic data. On the other hand, the users can select their origin and destination and the app will select the best transport option for them based on trip and wait times.
## Personas
### Persona 1 
![persona_1](uploads/c8f95121fa260f4dd0402b248ae84431/persona_1.jpg)
### Persona 2 
![persona_2](uploads/2e77efe37bba441a01397dbf226ae7e6/persona_2.jpg)
### Persona 3 
![persona_3](uploads/31207c3feb9f833fabbaacadb76c818f/persona_3.jpg)
### Persona 4 
![persona4](uploads/012e01d0904f44613a4188c0868d24fe/persona4.jpg)
## Context canvas
![Context_Canvas_Transmilenio](uploads/b7b9e93a33e9443d2adaddaaee304d10/Context_Canvas_Transmilenio.png)
## Business Questions
1. What’s the traveling time of a specific route at a specific time?
2. What’s the waiting time of a specific station at a specific time?
3. How crowded is a specific station at a specific time?
4. What’s the best time to wait for a specific bus?
5. How many people are traveling a route at a specific time?
6. How does waiting time change during the day on a specific station?
7. How does traveling time change during the day for a specific route?
8. How does the amount of people vary during the day for a specific station?
9. What weekday has the most amount of users?
10. What weekday has the highest average waiting time?
11. What weekday has the highest average travelling time?
12. How many buses are in transit at a specific time?
13. How many buses are in transit for a specific route?
14. How many stops does a bus have?
15. Which buses have the most stops?
16. How many stops does a route have?
17. Which routes have the most stops?
18. Which are the longest routes?
19. How many buses travel across different areas?
20. What is the area where most people are moving at a certain hour?
21. From which areas do most trips originate?
22. To which areas are most trips heading?
23. At what time are buses moving slowest?
24. How long are buses taking on average at each stop?
25. Which are the routes with the most transfers?
26. At what hours do people tend to start using public transport?
27. Which stations have the least recollected data from users?
28. Which trips have the least recollected data from users?
29. What months have the most traffic?
30. How much time is spent inside public transportation each day?
31. How many users does the app have?
32. Which routes don’t have a viably efficient alternate route?
33. How will the app affect the routes taken by the users?
34. Which buses have the least amount of users?
35. Which routes have the least amount of users?
36. How far apart is a specific station from another one?
37. How many users stop their trip midway?
38. How many users cancel their planned trips?
39. How much time in advance do people plan their trips?
40. How does the expected time of a planned trip change with new information?
## VD map
![VD_Map](uploads/3b58b48f7f845433c5f9f890884226c7/image.png)
## Functional scenarios 
1. Me, Juan, given that I know which route to take and have internet access, I want to know how much time it will take me to get to class, taking into account the time that I will have to wait for the bus so I can get in time.
2. Me, David, given that I know which route to take, have traveled in it previously at this time and don't have internet access, I want to know how much time it will take me to get to class, taking into account the time that I will have to wait for the bus so I can get in time.
3. Me, María, given that I don't know which route to take and have internet access, I want to know how much time it will take to get to my work, taking into account the time that I will have to wait for the bus so I can get in time. 
4. Me, María, given that I know my destination, route and desired arrival time and have internet access at the moment of making the request, I want to be notified when it is a good time to leave to be on time.
5. Me, David, given that I know my destination, route, and desired arrival time and have traveled in that route at this time of the day, I want to be notified when it is a good time to leave to be on time even if I don't have internet access.
6. Me, María, given that I have several route options to get to work, the time that I want to arrive and that I have internet access, I want to know which of them is fastest. 
7. Me, Ricardo, given that I am a Transmilenio executive, I want to know which are the routes that have longer waiting times on average so that I can make decisions based on that information. 
8. Me, Ricardo, given that I am a Transmilenio executive, I want to know which stations have the longer waiting times and at what time of the day so that I can make decisions based on that information.
9. Me, Ricardo, given that I am a Transmilenio executive, I want to know which stations are more crowded at a certain time and day so that I can make decisions based on that information.
10. Me, Juan, given that I have to make a route transfer in my commute and that I have internet access, I want to know which transfer is the best, so that I can get home faster. 
11. Me, David, given that I know my destination, route and desired arrival time, and I have internet access, I want to be notified if I will not arrive on time at my destination via public transportation. 
12. Me, María, Given that I'm already on my way to work and have internet access, and there has been an incident preventing me from taking my usual route I want to know the best possible alternate route and the time it will take to travel it.
13. Me, Juan, Given that I have internet access, I want to be able to plan a trip with multiple stops, get the fastest possible route and be informed the time it will take to complete.
14. Me, David, Given that I have internet access, I don't know my route but I do know my destination, and public transportation is closing soon, I want to be notified when I have to leave so that I reach my destination before it closes.
15. Me, María, Given that I don't know the route I'm about to take, I want detailed information about travelling the route so that I don't get lost.

## Quality scenarios
| Item | Description |
| ------ | ------ |
| Scenario number | 1 |
| Scenario name | Lack of internet connection when searching an unknown route |
| Quality Attributes | Eventual connectivity, resilience | 
| App status and context | The app is trying to connect to the internet to find the route. | 
| Changes in the context | The user loses connection when he arrives to the station. | 
| System reaction | The app notifies the user of the lack of internet connection, the task will be started if the connection restablishes |

| Item | Description |
| ------ | ------ |
| Scenario number | 2 |
| Scenario name | Lack of internet connection when searching wait times for a known route |
| Quality Attributes | Eventual connectivity, resilience | 
| App status and context | The app is finding the wait times for a route that the user has used before | 
| Changes in the context | The user loses internet connection | 
| System reaction | The app notifies the user of the lack of internet connection and shows him only the wait times that are stored locally if there are any for the time of the day, or else it shows  | 

| Item | Description |
| ------ | ------ |
| Scenario number | 3 |
| Scenario name | Location fails while a wait time is being mesured |
| Quality Attributes | Resilience | 
| App status and context | The app is measuring a wait time while the phone is in the user's pocket | 
| Changes in the context | The GPS service fails for an unknown reason | 
| System reaction | The app stops the timer and discards the wait time. When the user opens the app again (or immediately, depending on the configuration), they will be told that the measuring failed due to an error in the location |

| Item | Description |
| ------ | ------ |
| Scenario number | 4 |
| Scenario name | Backend availability |
| Quality Attributes | Availability | 
| App status and context | The backend is operating normally | 
| Changes in the context | The backend service crashes | 
| System reaction | The backend service is running on a load balancing cluster, so the service stays available even if one of the replicas fails. The user that made the request that crashed the service gets an error message and has to repeat it |
 
| Item | Description |
| ------ | ------ |
| Scenario number | 5 |
| Scenario name | Unauthorized users |
| Quality Attributes | Security | 
| App status and context | The backend is operating normally | 
| Changes in the context | An unauthorized user tries to access any backend service that is not intended from final users and that has user data (e.g. user profiles or wait times from different users) | 
| System reaction | The system doesn't allow it because the user doesn't have a valid API key and sends him a 401 error |

| Item | Description |
| ------ | ------ |
| Scenario number | 6 |
| Scenario name | Malicious users |
| Quality Attributes | Security | 
| App status and context | The backend is operating normally | 
| Changes in the context | Someone with a valid API key tries to access the user profile of someone else| 
| System reaction | The system doesn't allow it because the user isn't authenticated as the user profile that he wants to visit |

| Item | Description |
| ------ | ------ |
| Scenario number | 7 |
| Scenario name | Password security |
| Quality Attributes | Security | 
| App status and context | The user opens the app | 
| Changes in the context | The user logs in with his username and password | 
| System reaction | The user can log in if the password is correct. The passwords are cyphered in the transmission and are compared against a hash in the database. Passwords are never stored | 

| Item | Description |
| ------ | ------ |
| Scenario number | 8 |
| Scenario name | General request performance |
| Quality Attributes | Performance | 
| App status and context | The backend is operating normally | 
| Changes in the context | A user makes any request to the backend | 
| System reaction | The app responds to the request properly and in less than 2s |  

| Item | Description |
| ------ | ------ |
| Scenario number | 9 |
| Scenario name | Scalability and availability in rush hour |
| Quality Attributes | Scalabilty, availability | 
| App status and context | The server is working in normal conditions | 
| Changes in the context | Rush hour starts, so the number of requests increases |
| System reaction | The system should work under high loads of requests, the backend application should be executed using a load balancer tactic |

| Item | Description |
| ------ | ------ |
| Scenario number | 10 |
| Scenario name | Performance in rush hour |
| Quality Attributes | Performance, scalability | 
| App status and context | The server is working in normal conditions | 
| Changes in the context | Rush hour starts, so the number of requests increases  | 
| System reaction | The system should not decrease its performance in rush hour, the backend application is being executed using a load balancer tactic. If the performance decreases, more hardware resources should be put in the system | 

| Item | Description |
| ------ | ------ |
| Scenario number | 11 |
| Scenario name | The user should be find what he is looking for in a few taps |
| Quality Attributes | Usability | 
| App status and context | The user opens the app | 
| Changes in the context | The user wants to look for a wait time or route | 
| System reaction | The user should be abe to find what he is looking for in less than 4 taps, one text entry if necessary and one scroll down if necessary | 

| Item | Description |
| ------ | ------ |
| Scenario number | 12 |
| Scenario name | The app should be easy to understand |
| Quality Attributes | Usability | 
| App status and context | The user opens the app | 
| Changes in the context | The user is trying to do any action | 
| System reaction | Without effort, the user should be able to understand how to do what he wants to | 
 
| Item | Description |
| ------ | ------ |
| Scenario number | 13 |
| Scenario name | The app works properly in the background |
| Quality Attributes | Efficience, resilience | 
| App status and context | The user is using the app | 
| Changes in the context | The user starts to use another app and this one goes to the background | 
| System reaction | The app doesn't close, so if the user was in the middle of a search he can continue from where he left it when he comes back. Also, if there was a timer running it continues running and stops running automatically according to the location even if the app is in the 

| Item | Description |
| ------ | ------ |
| Scenario number | 14 |
| Scenario name | Battery consumption |
| Quality Attributes | Efficience | 
| App status and context | The app is measuring a wait time | 
| Changes in the context | Several minutes pass | 
| System reaction | The location should be detected in long enough time intervals that the battery is not drained and the mearurements are still precise | 

| Item | Description |
| ------ | ------ |
| Scenario number | 15 |
| Scenario name | Wait time accuracy |
| Quality Attributes | Accuracy | 
| App status and context | The app is working with internet connection | 
| Changes in the context | The user looks for a wait time of a particular route | 
| System reaction | The app gives the user a wait time estimation that is never less than the real one and is as close to reality as possible the great majority of the times if there aren't any special traffic events | 
## UX/UI Models 
### Android models
An Android digital prototype was made following the Material Desing metaphor. Regarding the color palette choice, as the app wants to transmit confidence to the users and is also related with motion, the color palette was made with blue and orange as the main colors. On the other hand, the SITP and Transmilenio buses have distinguishable colors so they are represented with them in the app. However, some of them (like red) are not part of the color palette itself. Finally, a couple of light colors were chosen for the background and cards when there are any.

![color_palette](uploads/3d1ae2e4f2f14d82da21e9557d23fa65/color_palette.jpg) 

These are some model screenshots, the complete model was uploaded to [Adobe XD](https://xd.adobe.com/view/6119a3eb-982c-4594-6dc9-1e6731c69666-1728/)

![proto1](uploads/e08fc52299532393181cf667ccdbc6e4/proto1.jpg)

![proto2](uploads/3235f937365164ebe8d3c589fbfe8a0b/proto2.jpg)

![proto3](uploads/5917f81148d32e66ca3e820159358ce6/proto3.jpg)

![proto4](uploads/68f957977bebce24faaf7db26c76942f/proto4.jpg)

![proto5](uploads/9290d5a030fc68ba18ef68a8ef14477b/proto5.jpg)

![proto6](uploads/23951fcee1b010f33ab1087f05bee98d/proto6.jpg)

![proto7](uploads/f32508e39c64f0b22f2ad47a5084e1f5/proto7.jpg)

### iOS Model
An iOS solution was made following the flat design metaphor in alignment with apple's app design pattern. It was discussed within the team that the app should convey security, reliability and easy mobility; with these concepts in mind, a color palette centered around the colors blue and orange. A couple of colors were added for contrast within the UI.
![image](uploads/1940db949182b856c0df49ea0ab59821/image.png)
### Prototype
[Adobe XD prototype](https://xd.adobe.com/spec/cb36acb7-0b22-4078-44f2-0fd94f4fb372-bd07/)

## Guerrilla testing reports 
### Android 
#### Interview template 
1. First, the app functionality is described to the user.
2. Then, he is asked to do these things. The idea is that they do them without being told how:
   * Find the stop times for a route.
   * Find directions to a place 
   * Navigate to a place (set the timer)
   * Set a reminder for when it is a good time to leave to a desired destination and at a specific arrival time
   * Check the saved times and places
3. Then, the user was asked about how easy was to do what they were asked to and what did they think about the app design.
#### User feedback
##### User 1
* He is a 21 year old university student. Has an Android phone, he uses Google Maps frequently. He commutes daily using public transport.
* He didn't have any problem making any of the tasks. He said that it was intuitive and that the design looked good.
##### User 2
* He is a 21 year old university student. Has an Android phone. However, he doesn't use navigation apps very often. He commutes daily using public transport.
* He only had difficulty when asked to open the sidebar to check the wait times and places. He thought the design was fine.
##### User 3
* She is a 20 year old university student. Has an iPhone. She uses navigation apps frequently. She uses public transport a few times a week. 
* She only had problems finding the sidebar to check the wait times and places. She thought that the app colors looked good but most of the icons and cards were too big.
### iOS
#### Interview Template
1. The purpose of the app is explained to the user. Then, the user is left to explore the app alone.
2. After observations are made and the user finishes exploring the app, any unexplored functionality is the explained and shown to the user.
3. The user is asked about the quality and simplicity of the app, and is asked to make comments about possible improvements that can be made to the design of the app.
#### User feedback
##### User 1
**Basic information:** She is a 61 year old housekeeper and uses mostly WhatsApp, Google Chrome, Youtube the Camera and calls from her Huawei.

**Observations while using the app:** Immediately she tried to move and explore the map, but this map is not interactive because it is just a prototype.Then, she tried tapped on the Split Views at the bottom of the screen. She barely interacted with the information displayed in the different tabs (maybe it was not clear she could tap on them). She didn’t notice the Search Bar at the top of the map for a couple of minutes and finally had to be told that it was there and she could interact with it. Finally, after exploring the whole app once, she went through it again retracing her steps.

**User comments:**
- Home screen: She says it’s ok even though she had trouble understanding the different parts of the welcoming screen.
- Navigation: She says the app is easy to navigate, but the symbols’ meaning can be unclear. She had trouble realizing there was a search bar and says it does not pop out enough.
- Look and feel: Overall, she likes how the app feels and transitions from one screen or function to another. She thinks the app looks a bit bland.
- Other comments: Map should be interactive in the real version of the app. Trouble understanding the app since the prototype is in English (app should be in Spanish).
##### User 2
**Basic information:** He is a 52 year old driver and bodyguard who uses mostly WhatsApp, Waze, Google Maps, Cyclingoo, ESPN, Facebook and Instagram in his Huawei.

**Observations while using the app:** He has a clear grasp of how to navigate through the app. Does not try to perform actions twice if the action was not successful the first try. No trouble overall probably because of his experience with similar apps like Waze and Google Maps.

**User comments:**
- Home screen: He says the search bar's contrast and size should be improved for easier understanding of the UI. Home screen map should zoom in to user location and show nearby bus stops for easier usability.
- Navigation: He says navigation is easy. The app is simple and anyone could pick it up quickly.
- Look and feel: The app seems bland and not provocative for the user. He suggests adding more color (color palette had not been applied when performing the test).
- Other comments: Highlight interest points in map to encourage the user to visit them and change the apps language to Spanish.
##### User 3
**Basic information:** He is a 33 year old security guard and uses WhatsApp, Youtube, Facebook, Instagram and Twitter
on his Samsung 

**Observations while using the app:** Immediately tries to interact with the image of the map until he is told that it’s not interactive. Voices concern about not knowing how to operate the app since he does not own an iPhone and is not familiar with the interface. Quickly notices the Split Views on the bottom and interacts with them. Attempts to interact with the home button placed at the bottom of the screen until he is told that it is a home button and will only be functional in the real version of the app. Does not interact with certain views of the app reinforcing the idea that it is not clear when the user can interact with certain parts of the app.

**User comments:**
- Home screen: Says it’s fine. No additional comments.
- Navigation: Easy and intuitive navigation even though he does not have knowledge of iPhone products. He says the app fails to encourage its exploration.
- Look and feel: Says it’s fine. No additional comments.
- Other comments: He had few comments overall. Says the app seems useful and he would download it.

##### User 4
**Basic information:** He is a 23 year old student and usually uses WhatsApp, Google Chrome, Marca, Facebook and Facebook Messenger on his iPhone6

**Observations while using the app:** Again, immediately tries to interact with the map. As an iPhone user, he is pretty familiar with the layout and navigates through the app easily. Taps randomly in some views (little clarity on which parts of the app can be interacted with). 

**User comments:**
- Home screen: He says it’s pretty standard. Not bad, but not special either.
- Navigation: Navigation is easy and pretty in line with iPhone apps in general.
- Look and feel: Says it looks decent and feels like a standard iPhone app. It is not clear where the user can interact and where he cannot.
- Other comments: No other comments.

##### User 5
**Basic information:** She is a 28 year old video editor and usually uses WhatsApp, Instagram, Facebook, Food Monster, YouTube, Uber and Photoshop Express on her Samsung.

**Observations:** She first focuses on the split views and explores the different views it leads to. She has no problem following visual queues probably because she used to own an iPhone. She has similar problems as the other users with attempting to manipulate the map and trying to interact with objects that have no interaction.

**User comments:**
- Home screen: She says the home screen is pretty good and compared it to Uber's welcoming screen.
- Navigation: She says navigation is pretty standard and easy to understand. Visual queues are "on point".
- Look and feel: She says she does not like the color palette and the app seems a bit "rigid". She suggests a softer appearance.
- Other comments: Says the app is too similar to Moovit app and it is necessary to find a substantial difference with it so the app finds some success.
## Comparison
* Google Maps: This is the default maps and navigation app of all Android phones. It is also the one that everyone uses most of the time. Google Maps allows to search places and get directions to them driving or using public transport. It also allows the user to have favorite places. These are features that this app would also have (although its purpose is to give directions using public transport only). On the other hand, it differs from this app in that there is no wait time calculation: if you ask for directions and see the details of the route, it shows regular time intervals. The core feature of our app is that it would predict the wait time with more accuracy and it allows the user to save their registered wait times and also notify them when it is time to leave so that they can get there on time.
* Moovit: It features places search and gives directions using public transport. This is also a feature that our app would have. In similar fashion to Google Maps, when giving directions, Moovit assumes that the arrival times of the buses are regular. Our app would estimate them as it has been explained previously.
* Maps (Apple): Maps can be used to look for places, but doesn't have navigation. If the user wants to go somewhere, it redirects them to an app that has that function in the user's phone. 

# Solution 2 : Massive transportation app
## Problem
Crowds, times and safety are among the biggest causes of discomfort in the public transportation. People are not confortable taking their daily buses and would rather prefer other cheap option. 
## Solution
We are the mobile app development team 6, and we are developing a way to solve the problem, focusing on people that use public transportation in a daily basis by providing on-demand planned transportation (scheduled transportation in buses) with the purpose of improving comfort in transportation and help reduce air pollution by promoting shared transportation.
### Persona 1 
![Persona1](uploads/b058931eaac88ccaff51497e03610bcf/Persona1.jpg)
### Persona 2 
![Persona2](uploads/f30c7392dfd6d37db54209b11467117f/Persona2.jpg)
### Persona 3 
![Persona3](uploads/0b6443ac932ad974c6298039d3c664a2/Persona3.jpg)
### Persona 4 
![Persona4](uploads/366195b5f5f7ba7109ae78eca172c24d/Persona4.jpg)
## Context canvas
![contextCanvas](uploads/397d1b01f955f1183c628d5f7f1d8345/contextCanvas.jpg)
## Business Questions
1. Which is the most traveled route?
2. How long does it take a bus to finish a route?
3. How much is a user willing to pay for the service?
4- Where are the best spots to pick up and let off passengers?
5. What type of people use the app?
6. How much are people saving by using the app?
7. Which is the least traveled route?
8. When is a new service required in a specific sector?
9. What areas are critical (areas that cause more traffic)?
10. What is the earliest and latest times passengers request transportation?
11. What buses will be driven?
12. Which sector or neighborhood has the highest amount of clients?
13. Which rout has the highest amount of accidents?
14. Which route has the highest amount of gas consumption?
15. Which driver has the best rating?
16. Which driver has the worst rating?
17. How many disabled people use the app?
18. At what time during the day are most of the requests for the service made?
19. How fast in average a transportation service is confirmed?
20. How many cancellations are made?
21. How long in advance is a cancellation made on average?
22. How long does a passenger last in the bus in average?
23. In what weather conditions are the most requests made?
24. At what time of the day are the most requests made?
25. What's the average age of users?
26. What's the distribution of gender between users?
27. How is the user population distributed throughout a specific sector?
28. Which are the most frequent destinations for a group of users?
29. How can alternate routes be made in case of a mishap?
30. How many people are moving at a certain time?
31. How many people request a bus with a specific anticipation time (e.g. how many people request service 3 days in advance)
32. On average how many days in advance do people request a service?
33. How many buses are moving at a certain time? 
34. How much distance do buses transit on average each day?
35. How many stops do a bus make on average per trip?
36. How long does a bus driver work before having to stop?
37. What is the longest trip a user makes?
38. How long does a passenger have to wait until a bus is confirmed?  
39. How many times does a bus have to change its planned route?
40. How many buses are involved in accidents?
41. How many users does the app have?
## VD map
![VD_map_2](uploads/d3df07fde2064d73b3d69ea6abb3dd6c/VD_map_2.jpg)
## Functional scenarios 
1. Me, Sofia, as a passenger, given that I take a route to my university daily and I have internet access at some point days before my trip, I want to schedule my trip so I know the time a bus will pick me up.
2. Me, as Nicolas, as a bus driver, I want to offer capacity in my bus to potential passengers so I optimize the number of trips I make with my bus and I make more money.
3. Me, Juan Pablo, as a Bus company planning worker, I want to manage my buses idle time so I can earn more money the times the bus is not in use. 
4. Me, Camilo as a passenger, I want to know if the people I am going to take the bus with don't have bad intentions and I can feel safe in my trip. 
5. Me, Nicolas, as a bus driver, I want to make less stops so I can avoid traffic.
6. Me, Camilo as a passenger, I want to know the localization of my bus before arriving so I know where exactly to go out and wait for the bus.
7. Me, Sofia, as a passenger, I want to be seated while I move to my destination so I am comfortable and safe.
8. Me, Sofia, as a passenger, I want to share my trip so I know I am contributing to less pollution. 
9.  Me, Juan Pablo, as a Bus company planning worker, I want bad passengers to be identified so I don't let them in my buses and I can take more care of my buses.
10. Me, Nicolas, as bus driver I want to know the exact positions of my stops in advance so I can drive better. 
11. Me, Camilo, as a passenger I want to rate my bus driver based on his way of driving so I know which drivers are better.
12. Me, Camilo as a passenger, I don't want my trip to be delayed because of another passenger so I get on time to my destination
13. Me, Juan Pablo, as a bus company CEO I want to know keep track of the locations of my buses so I know if a bus driver is trying to do something else with my buses. 
14. Me, Camilo as a passenger I want to be picked up near my home so I am more comfortable waiting for my transportation.
15. Me, Nicolas, as a bus driver I want to know in advance for cancellations so I can re-schedule my trips. 
## Quality scenarios
| Item | Description |
| ------ | ------ |
| Scenario name | Lack of notifications when waiting for a bus to arrive |
| Quality Attributes | Connectivity | 
| App status and context | The app is trying to notify the user of when his/her bus will arrive. | 
| Changes in the context | The user looses connection to the internet. | 
| System reaction | The app notifies the user that there is no connection and that an update will be given when connection is restablished | 

| Item | Description |
| ------ | ------ |
| Scenario name | Lack of connectivity when tring to make a reservation for a bus ride. |
| Quality Attributes | connectivity, resilence | 
| App status and context | The user is trying to make a reservation through the app | 
| Changes in the context | The device looses connection in the middle of the process of finding a bus and time | 
| System reaction | The app notifies the user that there is no connection and that the process will continue when connection is restablished | 

| Item | Description |
| ------ | ------ |
| Scenario name | Sniffing attempts on the information transmitted |
| Quality Attributes | security | 
| App status and context | The app is transmitting information to and from the server and someone is trying to collect that information | 
| Changes in the context | The user is inserting it's username and password | 
| System reaction | Packets sent from the device and from the server should be encrypted | 

| Item | Description |
| ------ | ------ |
| Scenario name | Many many requests to the server |
| Quality Attributes | Performance, scalability | 
| App status and context | The server is receiving more requests than usual | 
| Changes in the context | It is rush hour/special day and many people are asking and/or looking for transport | 
| System reaction | The system manages petitions through a balancer that distributes them among 2 or more servers. So the platform is able to scale up and process the requests | 

| Item | Description |
| ------ | ------ |
| Scenario name | System down |
| Quality Attributes | Resilence, availability | 
| App status and context | System is down and not able to show the available buses | 
| Changes in the context | There is a maintenance schedule on the servers | 
| System reaction | The system shoudl recover ASAP. Holding an overall availability of 99.9% | 


| Item | Description |
| ------ | ------ |
| Scenario name | Locating users position |
| Quality Attributes | Performance, accuracy | 
| App status and context | App is trying to zone in on the location of a passenger | 
| Changes in the context | The user is requesting a service close to him | 
| System reaction | The app uses GPS to locate the user and locate a bus service near him |

| Item | Description |
| ------ | ------ |
| Scenario name | New user tries the app for the first time |
| Quality Attributes | Simplicity, accesibility | 
| App status and context | The mobile app is being used and explored by a new user | 
| Changes in the context | The user downloads the app for the first time, register and reserves a bus | 
| System reaction | The app is simple enough for a new user to understand and it is accesible enough for everyone (all people) to use | 

| Item | Description |
| ------ | ------ |
| Scenario name | Lack of internet connection during cancellation |
| Quality Attributes | Eventual connectivity, resilience | 
| App status and context | The mobile app is uploading data to the remote server. The user is trying to cancel a planned ride.  | 
| Changes in the context | The user gets into a lie-fi zone (i.e., connection is poor) and eventually the data connection is lost. | 
| System reaction | The app notifies the user about the poor connection and the "upload" task is moved to a local queue for being resumed later. Log of tasks that has the timestamp of the time the user made the cancellation. | 

| Item | Description |
| ------ | ------ |
| Scenario name | Battery saver mode |
| Quality Attributes | Performance, resilience | 
| App status and context | The mobile app is showing the map so the user can request a planned ride. Battery saver mode kicks in. | 
| Changes in the context | The processor speed is reduced and memory available is shortened. | 
| System reaction | The app should use the available resources to show the map in a simplified way (e.g. showing less area).  | 

| Item | Description |
| ------ | ------ |
| Scenario name | Encrypted storage |
| Quality Attributes | Security | 
| App status and context | User information stored in the database | 
| Changes in the context | At any moment in time. | 
| System reaction | The system should not store the information in plain text. It should be encrypted. | 


| Item | Description |
| ------ | ------ |
| Scenario name | Long term app growth  |
| Quality Attributes | Scalability | 
| App status and context | X number using the app, but with time more users join the app. | 
| Changes in the context | More petitions managed and more information stored. | 
| System reaction | Horizontal and vertical scalability for new users. More severs able to join the servers responding to the balancer. | 


| Item | Description |
| ------ | ------ |
| Scenario name | Performance |
| Quality Attributes | Resilience | 
| App status and context | X number of users have requested transportation. | 
| Changes in the context | New users in the same area as last users make new petitions for transportation. | 
| System reaction | A backend algorithm recalculates the optimal routing for picking and droping the users in the shortest time. | 


| Item | Description |
| ------ | ------ |
| Scenario name | Immediate response |
| Quality Attributes | Usability | 
| App status and context | An user has requested a transportation. | 
| Changes in the context | Petition was sent. | 
| System reaction | App should show an accepted petition screen, even though the bus not necessarily was assigned. | 


| Item | Description |
| ------ | ------ |
| Scenario name | Battery consumption |
| Quality Attributes | Performance | 
| App status and context | App is showing the map. Using user's location | 
| Changes in the context | At any moment in time. | 
| System reaction | App should not use much battery and perform in a optimal form | 


| Item | Description |
| ------ | ------ |
| Scenario name | Responsiveness |
| Quality Attributes | Accessibility | 
| App status and context | User using the app in his phone vertically | 
| Changes in the context | User changes the position of his phone to horizontal form. | 
| System reaction | App should be responsive  | 
## UX/UI Models 
### Android models
The Android prototype was made following the material design metaphor. The colors were chosen taking into account the feeling we want the app to transmit: Being safe, stable, reliable but also cool. Blue and green for safety and stability, the dark colors for simplicity and cleanness. To access the interactive prototype go to: https://xd.adobe.com/view/a7a1e763-22d7-4dd0-45f4-cc290c4fef11-d190/ 
We must credit Aurélien Salomon for the UI kit template we used for building this prototype. 

The selected font is Gibson. https://typekit.com/fonts/gibson

![PaletteImage](uploads/5abe8f4c298a1399e3cced8744a5cf9d/PaletteImage.png)

![PrototipoLInea1](uploads/7624619baeaebb2b380327645cd11540/PrototipoLInea1.png)
![PrototipoLInea2](uploads/08857bff2df7995585391bb211ee8454/PrototipoLInea2.png)
![PrototipoLInea3](uploads/43f46d747afd599ad46767b41bf69f1a/PrototipoLInea3.png)


## IOs model

The IOs model was developed using the flat deign metaphor. As said before the app's colors were chose to express a feeling of safety, stability and reliability, while also looking premium and exclusive. This is why diferent fases of color blue were chose, red to demonstrate contrast and express "not good options.

![CollorPallete](uploads/b86072eec8b7f61cc83b5ebbd577c912/CollorPallete.png)

A continuación se muestra una imagen del prototipo:

![Prototipo](uploads/16a41f3553de9871afff25b7219580fd/Prototipo.PNG)

Link - Adobe XD: https://xd.adobe.com/view/4bb57e9a-c3e7-42f2-4869-fd07ebc7667c-3d84/?fullscreen

## Guerrilla testing reports 

| User | Gender | Age | What kind of phone do you use?  | What do you do for work? | What apps do you use most on your phone? | We are done! Do you have any questions for   me?                                                                                                                                                                          | How would you describe the app you just saw?   What is it for?                                                       | If this application something that you   personally want to install on your phone? | I would/wouldn't install this app on my phone   because:                                                                                                                                                                                           | Homescreen notes:                                                                                                                                                        | Navigation drawer notes:                                                                                                        | Map notes:                                                                                                                                                                                                                                                                                                    | Other notes: |
|------|--------|-----|----------------------------------------------------------------------------------------|--------------------------|-----------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------|
| 1    | Female | 20  | Android, mid-tier                                                                      | study                    | Instagram, WhatsApp, Netflix and   YouTube.          Yes                                      | No                                                                                                                                                                                                                        | To schedule trips.                                                                                                   | No, because:                                                                       | I already got uber, didi, beat and cabify.                                                                                                                                                                                                         | It's fine.                                                                                                                                                               | I don't like it, I love it. Uh oh                                                                                               | It is like uber.                                                                                                                                                                                                                                                                                              |              |
| 2    | Male   | 22  | Android, high-end                                                                      | I'm student              | Games, social networks, calendars   and reminders.                                            | Simple pero útil.                                                                                                                                                                                                         | No, because:                                                                                                         | I have my own car.                                                                 | Es simple y directa al punto. Sin embargo, la interfaz en su totalidad   fue tratada con un mapa, me gustaría que se mostrara el mapa en los casos en   los que es necesarios y no todo el tiempo, porque daña mi experiencia de   usuario.        | Está bien definido los pasos para usar la aplicación.                                                                                                                    | Es clara la posición mía y la de mi destino, además de la de mi conductor   a la hora de encontrarnos.                          | Odio el hecho de usar Bluetooth para conectarme con mi conductor y   comprobarlo, pues normalmente el bluetooth no sincroniza muy bien y nadie lo   mantiene prendido. Debería ser con internet, o con lectura de QR, algo por el   estilo y que me permitan usar cosas más cotidianas (datos, cámara, etc.). |              |
| 3    | Male   | 18  | Android, mid-tier                                                                      | Estudiante               | WhatsApp, Facebook, Google                                                                    | None                                                                                                                                                                                                                      | Amplia y de mucha utilidad a la hora de establecer nuestros tiempos                                                  | Yes, because:                                                                      | Me ayudaría a recordar mis   actividades y compromisos ayudándome a organizar mis tiempos a demás que el   GPS es una buena adicion porque hay personas que necesitan de esa herramienta   en todo momento                                         | En lo posible agregar notificaciones sobre los lugares que aparecen en el   mapa como un pequeño número o punto que indique que habrá una actividad   pronto o pendiente | Sería bueno que guardara los caminos   más rápidos de un punto a otro según el menor tiempo que se haya tardado en   recorrerlo |                                                                                                                                                                                                                                                                                                               |              |
| 4    | Male   | 23  | Android, low-end                                                                       | Zootecnista              | Facebook, Instagram and Google, en mi otro celular uso beat.                                  | Si llega a existir algún robo en   un carro, o algún inconveniente quién respondería y como se haría la parte   legal del asunto.                    Se puede compartir el viaje seguro con las personas que uno conozca? | Es una aplicación para el   transporte seguro de las personas.                    Comodidad y seguridad garantizada. | Yes, because:                                                                      | Si hoy en día las aplicaciones de movilidad son de mucha importancia,   para poder transportarse a cualquier hora y con seguridad, la descargaría y   usaría siempre que presente costos adecuados, y garantía de que la seguridad   es prioridad. | Me gusta la plataforma es cómoda.                                                                                                                                        | Perfecto letra adecuada, moderna pero sería y con un buen toque urbano.                                                         | Correctos, solo que cuando sale que   llegó el carro sale es un bus, y pues es como raro jajaja                                                                                                                                                                                                               |              |


## IOs Guerrilla Testing

#### Interview template 
1. First, the app functionality is described to the user.
2. The user is then asked to use the app, this means the user needs to:
   * Enter
   * Make a reservation
   * Cancel de reservation
   * Look at history/Statistics
   * Look at his profile
3. Then, the user was asked basic questions to get to know his demographics; Age, gender, occupation.
4. Later, the user was asked four questions more:
   * ¿What are your general thoughts on the app?
   * ¿Would you be willing to give an app like this a try?
   * ¿What feature did you like the most?
   * ¿What recommedations you have about the app?



#### User feedback
##### User 1
 * **Age:** 23
 * **Gender:** male
 * **Occupation:** student
 * **¿What are your general thoughts on the app?:** it's a good app with a lot of potential. The colors are nice and the way it feels is nice. The pictures and the images.
 * **¿Would you be willing to give an app like this a try?:** I would if I needed to go to more places constantyl, like work or school. But I use a car.
 * **¿What feature did you like the most?:** That you connected bluetooth with the bus driver to know when you get in and out.
 * **¿What recommedations you have about the app?:** Expand more on the idea of making it a social network.

##### User 2
 * **Age:** 53
 * **Gender:** female
 * **Occupation:** Housewife
 * **¿What are your general thoughts on the app?:** It's a very pretty app. I like that I can see how my driver looks and how the bus I will use looks. I also like that I have my own page. I think it needs more things.
 * **¿Would you be willing to give an app like this a try?:** Yes. I need to go to errands everyday. This would be great.
 * **¿What feature did you like the most?:** The main one, make bus reservations that are cheaper and safer.
 * **¿What recommedations you have about the app?:** Let me see how much it will cost before making the reservation.

##### User 3
 * **Age:** 62
 * **Gender:** male
 * **Occupation:** Head of Family
 * **¿What are your general thoughts on the app?:* It's a good idea, But I'm not sure if it is permitted by law.
 * **¿Would you be willing to give an app like this a try?:** I would. Going to and from office would be good. But not if I'm in a hurry.
 * **¿What feature did you like the most?:** That I can see all my history and keep everything in order.
 * **¿What recommedations you have about the app?:** Make sure this is legal.

##### User 4
 * **Age:** 21
 * **Gender:** male
 * **Occupation:** student
 * **¿What are your general thoughts on the app?:** It's a good app. The idea is very good. The colors are very pretty. The way it shows you your driver and then your bus, the fact that you can see how far away and how much time until your bus arrives. Getting to know new people. all that.
 * **¿Would you be willing to give an app like this a try?:** Yes it's a good idea for university.
 * **¿What feature did you like the most?:** Saving money on making a reservation of a bus through here.
 * **¿What recommedations you have about the app?:** I have no recomendations.

##### User 5
 * **Age:** 25
 * **Gender:** male
 * **Occupation:** Worker in Bogotá
 * **¿What are your general thoughts on the app?:** It's a good app. But I think there is a lot of transport apps in the market and I'm not sure if this app is different enough to make it into the market. Specially in a place like Colombia where people don't trust each other.
 * **¿Would you be willing to give an app like this a try?:** Yes, but the app needs to feel safer. I need to know that all the people in the bus are good people. Otherwise is just another bus.
 * **¿What feature did you like the most?:** Having my profile and having my own statistics. Knowing how much money you spent and how you didi it is fantastic.
 * **¿What recommedations you have about the app?:** Make sure to verify your users, the only way that people use the app is if they feel more safe than in a regular bus.





## Comparison
* Uber: Lets its users schedule and order transportation from two points. It also lets you share your rides, but does not let you schedule a shared transportation. You can share your ride with 3 people at most. Our app is conceived as a multiple sharing app, so it uses buses. 

* Cabify: Lets its users schedule and order transportation from two points. It does not let you share your rides, our app does. 

* Carma Carpooling: lets users share commuting costs with neighbors and colleagues headed the same way. Riders pay .20 per mile, standard, which means drivers don't make a profit. So it lets users share their ride, but the driver does not make profit. Our app uses buses and the driver makes profit of it. 

* Beat: This transportationg app arrived in the market a few years after Uber. And as Uber, it allows you to look for a car to take you from point A to point B. Beat let's you contact your driver, share your trip and too see previous payments. The difference between beat and this app is that Beat is a one person transportation method. You are charged premium for a premium service, go alone in a car without being bothered. Our app will be premium in it's userbase but massive in it's reach.

* BidRide: BidRide is yet another transportation app. The difference this app has that puts it on a different class that the other transportation apps is that in this app you can negotiate with your driver. You offer how much you want to pay, they say how much they are willing to recieve, this goes back and forth until you both reach an agreement. Our app will not have negotioation because it will be cheap in it's own regard. This because it is made to be used massively.