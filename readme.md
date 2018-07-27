# Project 2 CRUD APP

## Happy Hour Melbs.

### A crowd sourced application designed to suss out the best drinks at the cheapest prices.

[Happy Hour Melbs](https://salty-retreat-68815.herokuapp.com/happyhour) 
[Link to Github](https://github.com/razbag18/happyhour)

This second project was my first foray into building a full-stack database backed application. This application was built in a Sinatra app and utilizes SQL to create a database table structure where I can interact with my relationally-stored data. 
Written in html, Ruby and includes the smallest amount of Javascript to create a back button. CSS styling.
Technologies used were ActiveRecord, Pry and PostGres. 

You can view my database table diagram [here](https://github.com/razbag18/happyhour/blob/master/public/flowchart/Screen%20Shot%202018-07-27%20at%209.49.59%20am.png)

### What is a CRUD app? 
In computer programming, create, read, update, and delete (as an acronym CRUD) are the four basic functions of persistent storage. They are also referred to as RESTful routes: GET, POST, PUT, PATCH, and DELETE.

### Happy Hour Melbs Guide
READ: My application allows visitors to navigate around the pages, veiwing what specials fall on what days and the details of the venue and special but not cause any other effects. 

CREATE & UPDATE: After users register and login, users can create new specials and edit existing specials by posting what day the special falls on, the venue name, suburb, the happy hour time, the special details and a link to the venue's website. After login, users also are given the ability comment on venues and specials. 

DELETE: The delete function in my app is executed when a user logs out of their session. 

### Extensions and oversights:
 #### Extensions:
 1. I need to let the user edit and delete their own comments.
 2. I would like to find a way to pull an image of the venue rather than allowing users to upload one. I chose to not allow users to upload photos as I think it gives the user too much control in what they post. It could be completely unrelated to the special. Some research using a Google Image API is required.
 3. Responsiveness is important as I essentially want this to be an 'on-the-go' app.
 4. I would like to implement a search bar so users can see if a venue is already in the database.
 5. A "Specials-Near-Me" would be really handy too.
 6. Users can upload the same venue as many times as they like. I would like to stop this by searching if the same venue name and address is in the database already.
 7. Need to make user names unique. 

#### Oversights
  I think this is a major one: I haven't accounted for venue having multiple specials on different days. My form will need to change to account for this.

