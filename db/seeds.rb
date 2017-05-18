require './lib/user'

User.create(
:username => 'seanpierce',
:password => 'test',
:profile_picture => "/img/no-profile-picture.jpg",
:about_me => "no description available",
:address => 0,
:admin => true
)
User.create(
:username => 'ken',
:password => 'aloha',
:profile_picture => "/img/no-profile-picture.jpg",
:about_me => "no description available",
:address => 0,
:admin => true
)
User.create(
:username => 'nik',
:password => 'nik',
:profile_picture => "/img/no-profile-picture.jpg",
:about_me => "no description available",
:address => 0,
:admin => true
)
User.create(
:username => 'tanner',
:password => 'tanner',
:profile_picture => "/img/no-profile-picture.jpg",
:about_me => "no description available",
:address => 0,
:admin => true
)
