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

* In order to run this app:
  - Visit the pre-existing Heroku repository that has been created, and follow site usage instructions.

* OR in order to host your own chatroom:
  - Locate the git repository of this project.
  - Clone or download the git repository onto your desktop.
  - Locate home folder of the app "ie:/chatroom/"
  - Once you have navigated into this folder, open the command line or shell.
  - Once you have opened shell, run 'postgres' in the command line.
  - Open a new window in the command line/shell and run 'psql' for easy viewing of the database.
  - Open a third window in the command line and run the following commands:
  - "rake db:create"
  - "rake db:migrate"
  - "bundle"
  - run "ruby app.rb" which should open Sinatra.
  - The page should display when you navigate to localhost:4567 in the browser of your choice.

## Usage

Navigate to the 'index' page which should be the first page that you are directed to upon opening the app.  From there, navigate to the link to 'create new account', which will allow you to put in the user name and password for your new account.  Upon submitting the new account, you will be redirected to the login page, at which point logging in with your user name and password will now be possible.  You should be directed to a landing page for the individual user, where you can click the link 'Enter Ruby Room', where the chatroom will be immediately apparent.  You can then enter messages into the chat room with the 'send' button, which allows you to post messages that will appear to all users logged into that chat room near instantaneously.

## Known Bugs
There are currently no known bugs in these HTML, CSS, Bootstrap, javascript, jQuerey, Ajax, Ruby, Sinatra, PostgreSQL or Active Record files.

#### Design sketch by Sean Pierce

_landing page:_
![](https://raw.githubusercontent.com/niklaslong/chatroom/sean-design/public/img/landing_page.png)
_create an account:_
![](https://raw.githubusercontent.com/niklaslong/chatroom/sean-design/public/img/creat_accout.png)
_chat room:_
![](https://raw.githubusercontent.com/niklaslong/chatroom/sean-design/public/img/chat.png)

## Support and contact details

For further support, please contact any contributing member of the group through their respective Github accounts. E-mails will not be listed here as this README is publicly displayed.

##Technologies Used

This website was constructed using HTML, CSS, Javascript and Ruby as well as jQuerey, Ajax and Active Record elements.

## License

Copyright (c) 2017 Ken Rutan.  This software is licensed under the MIT License.
