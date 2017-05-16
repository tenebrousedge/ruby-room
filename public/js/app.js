var jsonData = {
  objects: []
};

var dataOrganize = function(rawData) {
  $("#chatroom").text("");
  for (i=0; i < rawData.length; i++) {
    $("#chatroom").append('<li>' + rawData[i]['username'] + " | " + rawData[i]['display_time']+ " | " + rawData[i]['content'] + '</li>');
  }
};

var displayUsers = function(userData) {
  userData.forEach(function(user) {  
  $("#users").append(user[username]);
  });
};

$(document).ready(function() {

    var opts = {
    lines: 13 // The number of lines to draw
  , length: 28 // The length of each line
  , width: 14 // The line thickness
  , radius: 42 // The radius of the inner circle
  , scale: 0.15 // Scales overall size of the spinner
  , corners: 1 // Corner roundness (0..1)
  , color: '#000' // #rgb or #rrggbb or array of colors
  , opacity: 0.25 // Opacity of the lines
  , rotate: 0 // The rotation offset
  , direction: 1 // 1: clockwise, -1: counterclockwise
  , speed: 1 // Rounds per second
  , trail: 60 // Afterglow percentage
  , fps: 20 // Frames per second when using setTimeout() as a fallback for CSS
  , zIndex: 2e9 // The z-index (defaults to 2000000000)
  , className: 'spinner' // The CSS class to assign to the spinner
  , top: '50%' // Top position relative to parent
  , left: '50%' // Left position relative to parent
  , shadow: false // Whether to render a shadow
  , hwaccel: false // Whether to use hardware acceleration
  , position: 'absolute' // Element positioning
  }

  var target = document.getElementById("load");
  var spinner = new Spinner(opts).spin(target);

  var async = function() {

    fetch("/data")
      .then(response => {
        if (response.ok) {
          return response.json();
        } else {
          return Promise.reject({
            status: response.status,
            statusText: response.statusText
          });
        }
      })
      .then(data => {
        jsonData.objects = data;
      })
      .catch(error => {
        if (error.status !== 200) {
          $("#chatroom").text(`Something isn't quite right: ${error.status} ${error.statusText}`);
        }
      })
      .then(function() {
        dataOrganize(jsonData.objects)
        spinner.stop();
        spinner2.stop();
      });

    dataOrganize(jsonData.objects);

    fetch("/active-users")
      .then(response => {
        if (response.ok) {
          return response.json();
        } else {
          return Promise.reject({
            status: response.status,
            statusText: response.statusText
          });
        }
      })
      .then(data => {
        jsonData.objects = data;
      })
      .catch(error => {
        if (error.status !== 200) {
          $("#chatroom").text(`Something isn't quite right: ${error.status} ${error.statusText}`);
        }
      })
      .then(function() {
        displayUsers(jsonData.objects)
      });
  };

  var target2 = document.getElementById("load-below");
  var spinner2 = new Spinner(opts)

  $("#new-msg-form").submit(function(e){
    e.preventDefault();

    spinner2.spin(target2)
    var newMessage = $("#new-message").val();

    var user_id = $("#id").val();

    fetch('/chat/messages/new', {
      method: 'post',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(newMessage + "~||~" + user_id)
    });
    $("#new-message").val("");
  });

  setInterval(async , 2000);
});
