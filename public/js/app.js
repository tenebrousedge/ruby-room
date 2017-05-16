var jsonData = {
  objects: []
};

var dataOrganize = function(rawData) {
  $("#chatroom").text("");
  for (i=0; i < rawData.length; i++) {
    $("#chatroom").append('<li>' + rawData[i]['username'] + " | " + rawData[i]['display_time']+ " | " + rawData[i]['content'] + '</li>');
  }

};

$(document).ready(function() {
  var async = function() {

    fetch("/data")
      .then(response => {
        if (response.ok) {
          return response.json();
        } else {
          return Promise.reject({
            status: response.status,
            statusText: response.statusText
          })
        }
      })
      .then(data => {
        jsonData.objects = data;
      })
      .catch(error => {
        if (error.status !== 200) {
          $("#chatroom").text(`Something isn't quite right: ${error.status} ${error.statusText}`);
        }
      });

    dataOrganize(jsonData.objects);
  };

  $("#new-msg-form").submit(function(e){
    e.preventDefault();
    // var newMessage = $("#new-message").val();
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
