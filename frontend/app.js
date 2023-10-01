window.onload = function() {
  var host = window.location.hostname;
  var port = window.location.port;
  var term = new Terminal();
  term.open(document.getElementById( "terminal" ));

  // Create WebSocket connection.
  const socket = new WebSocket('ws://' + host + ':' + port + '/socket');

  // Connection opened
  socket.addEventListener('open', function (event) {
    term.onData((val) => {
      socket.send(val);
    }); 
  });

  // Listen for messages
  socket.addEventListener('message', function (event) {
    term.write(event.data);
  });
}
