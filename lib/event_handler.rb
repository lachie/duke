class EventHandler < Mongrel::HttpHandler
  def process(request, response)
    
    response.status = 200
    # false means do not calculate content-length (this is up to your app)
    response.send_status(false)
    
    response.header["Content-Type"] = "text/html"
    response.send_header
    
    response.socket.flush
    
    query = Mongrel::HttpRequest.query_parse(request.params['QUERY_STRING'])
    
    response.write("#{"b" * 5000}\n<br/>")
    response.socket.flush
    
    while true
      response.write("<script>console.log('scripty goodness #{Time.now}')</script>\n")
      response.socket.flush
      sleep 1
    end
    
    response.done = true
  end # process
end