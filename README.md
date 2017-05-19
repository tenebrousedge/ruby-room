# chatroom
Ruby team-week project

# Ruby Room Chat Room Group Project

#### _The Ruby Room Team, May 18th, 2017_

#### By _**Niklas Long, Tanner Eustice, Sean Pierce, Ken Rutan**_

## Overview

This website will allow the user to enter a new account, then login in under that account and visit a chatroom.  Within that chatrooms, the user is able to post messages, which contain a record of their date, the user who posted the message and the content of the message.  There exist administrator accounts which allow the administrator to either remove individual messages, or ban users entirely, which will prevent them from ever creating new accounts from their own ip address.
- Github link:
- Heroku link:

## Objective

The objective here was to create a functional front-end and back-end logic for a chat room and database.  The front end of the chat room will allow for very-near instantaneous communication between multiple users who are visiting the same url, but are logged in using different accounts.  The back end will allow for database access containing a record of all users, messages and allow for administrator functions to be performed on accounts.

## Specifications

| behavior |  input   |  output  |
|----------|:--------:|:--------:|
|Allow the user to create a new account|*creates new account*|*new account is now logged*|
|Allow the user to login under that account|*enter user credentials*|*user is redirected to their own homepage*|

## User Stories

- This site will allow the user to create a new user name and password which will then be stored in the database.
- This site will allow the user to log in under that user name and password and visit various parts of the site as their permission allows.
- This site will block access to parts of the site that should not be available to the user unless they are properly logged in under their own account.
- This site will allow the user to visit a chatroom and post messages under their name, with a timestamp at the date of message creation and the content of the message.
- This site will archive all posts made by each user in a database, which allows for review later on.
- This site will periodically fetch data from the archives to update the list of messages frequently every few seconds.
- This site will allow an administrator to moderate the site, and allow that administrator to either remove offensive message posts from the site or to ban users altogether, and to prevent those users from creating new accounts under the same ip.

## Installation

You may visit the live version of the app <a href="">here</a>, or to run the app locally you can:

* Locate the git repository of this project.
* Clone or download the git repository.
* Using your command line, navigate to the directory containing the repo
* Run this series of commands
  * `$ postgres`
  * `$ bundle install`
  * `$ rake db:create`
  * `$ rake db:migrate`
  * `$ ruby app.rb`


* In your browser, navigate to localhost:4567

## Usage

Navigate to the 'index' page which should be the first page that you are directed to upon opening the app. From there, navigate to the link to 'create new account', which will allow you to put in the user name and password for your new account. Upon submitting the new account, you will be redirected to the login page, at which point logging in with your user name and password will now be possible. You should be directed to a landing page for the individual user, where you can click the link 'Enter Ruby Room', where the chatroom will be immediately apparent. You can then enter messages into the chat room with the 'send' button, which allows you to post messages that will appear to all users logged into that chat room near instantaneously.

## Known Bugs
There are currently no known bugs. If you discover a bug, please raise an issue here.

#### Page Views

_landing page:_
![](https://github.com/niklaslong/chatroom/blob/master/public/img/landing-page.png?raw=true)
_create an account:_
![](https://github.com/niklaslong/chatroom/blob/master/public/img/create_account.png?raw=true)
_view and edit profile info:_
![](https://github.com/niklaslong/chatroom/blob/master/public/img/edit-profile.png?raw=true)
_chat room:_
![](https://github.com/niklaslong/chatroom/blob/master/public/img/chat-view.png?raw=true)
_view user info:_
![](https://github.com/niklaslong/chatroom/blob/master/public/img/view-user-info.png?raw=true)

## Support and contact details

For further support, please contact any contributing member of the group through their respective Github accounts. E-mails will not be listed here as this README is publicly displayed.

## Technologies Used

This website was constructed using HTML, CSS, Javascript and Ruby as well as jQuery and Active Record elements.

- spin.js https://github.com/fgnass/spin.js
- bcrypt https://github.com/codahale/bcrypt-ruby
- sinatra http://www.sinatrarb.com/
- capybara https://github.com/teamcapybara/capybara
- rspec https://github.com/rspec/rspec

## License

&copy; 2017 Ken Rutan, Niklas Long, Sean Pierce Sumler and Tanner Eustice.  This software is licensed under the **MIT License**.
