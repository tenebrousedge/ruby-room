require './lib/user'

User.create(
:username => 'admin',
:password => 'admin',
:profile_picture => "/img/no-profile-picture.jpg",
:about_me => "no description available",
:address => 0,
:admin => true
)
