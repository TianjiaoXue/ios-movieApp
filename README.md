# ios-movieApp

##Application Overview 
My application is intended provide movie lovers a platform to communicate. And also provide up-to-date information for users.

##Three main models – User, Post and Movie
User: Each user has to log in to use the app, and each user have their own profile including username, user_id, photoUrl (User can upload an image when sign up on the app)
Post: User can upload their comment and thoughts on certain movie. Each time uploading the post, a time stamp and id will be created automatically by Firebase. and author is the current logged in user.
Movie: The source fetch from API instantly. But I am not using all of its json attribute. Only save the necessary part which is more straight forward for a user. The main attribute include movie_title, release_date, poster_path url, overview of the movie and vote average and total voted count from famous Website like IMDb.

## FUncitons
1.	User Controller Group: Including the basic authentication function like signup and login, which is mainly realized by Firebase Auth. Uploading user profile such as username and profile photo when signup is separated stored in Firebase database and storage. User Homepage can show the photo of user, check the saved and rated movies based on user previous action, start new posts and log out.
SignUp – User has to sign up to use the app and the sign up and 
Login – User Log in 
Main view – the start page of the app. will automatically jump to function page if user has logged in 
Userhome – the home page of user 
2.	Movie Category: There are three main categories for user to check: 
Top Rate – provided by API which is the list of movies that get most high marks during all the time
Now Online – the movie is currently showing in the local theater
Coming soon – the movie which is just release or planned to be online due to the date.
3.	Search Movie: User can search the movie by key word and check the detail of the movie. When first jump to this page. A list of most popular will be present on the table. When type into search bar, Fetch the data online and listing into the table dynamically.
4.	Posts Controller: 
Upload posts – User upload their comment and express thoughts
Display posts – All posts from different users will be presenting in the community section.


##APIs
1.	Cocoapod: easily install, update and delete other APIs by just specify the dependencies for your project in a simple text file: yourPodfile
2.	Firebase: I use three main function provided by Firebase: Auth for user signup and login using email and password, Real-time database to store basic type data and Storage to store image objects.
3.	Alamofire: Alamofire provides chainable request/response methods, JSON parameter and response serialization, authentication, and many other features. 
4.	SwiftyJSON: Since the data type is very strict in Swift. It is easy to make mistake when parse json object into self-defined object. SwifyJSON combine with Alamofire provide a much easier way to deal with the whole process by convert the json into dictionary so that can use chain to find the value.
5.	TheMovieDB(TMDb): The data source of my application. It provided not only movie resource but also information such as TV series showing time. I only use the search and other list of movie but is good enough for my app.
