$(document).ready(function() {
  var async = function() {
    $.getJSON("http://localhost:4567/data", function(data) {
      for (var key in data) {
       if (data.hasOwnProperty(key)) {
          messages.push(data[key].content)
       }
      }
    });
  }
  $("#chatroom").text(messages)
  setInterval(async,2000);
});
