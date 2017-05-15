$(document).ready(function() {
  
  var async = function() {
    $.getJSON("http://localhost:4567/data", function(data) {
      $("#chatroom").text(data)
    });
  }
  setInterval(async,2000);
});
