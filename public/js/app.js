var jsonData = {
  objects: []
}

var dataOrganize = function(rawData) {
  $("#chatroom").text("");
  for (i=0; i < rawData.length; i++) {
    $("#chatroom").append('<li>' + rawData[i].created_at + rawData[i].content + '</li>');
  }
}
$(document).ready(function() {
  var async = function() {
    $.getJSON("http://localhost:4567/data", function(data) {
      jsonData.objects = data;
    });
    dataOrganize(jsonData.objects)
  }
  setInterval(async ,2000);
});
