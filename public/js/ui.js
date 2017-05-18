var userModal = function(input) {
  $('#user-modal-image-div').html(
    "<div class='profile-picture-wrapper' style='margin: auto; background-image: url(" + input[1] + "); border-radius: 50%; width: 150px; height: 150px; background-size: cover; background-position: center;'></div>");
  $('#user-modal-name-div').html(input[0]);
  $('#user-modal-about-div').html("<em>" + input[2] + "</em>");
  $('#user-modal').show();
};

var termsModal = function() {
  $('#terms-modal').show();
};

var displayUsers = function(userData) {
  $("#users").text("");
  userData.forEach(function(user) {
    user_a = [user['username'], user['profile_picture'], user['about_me'].replace('"', '&quote')];
    $("#users").append("<a onclick='userModal([" + "\"" + user_a[0] + "\"," + "\"" + user_a[1] + "\"," + "\"" + user_a[2] + "\"" + "]);' href='#' id='" + user['username'] + "'>" + user['username'] + "</a><br>");
  });
};
