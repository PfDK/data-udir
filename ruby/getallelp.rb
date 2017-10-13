#The code below is based on https://gist.githubusercontent.com/kyletcarlson/7911188/raw/34a01eaf7e4c6cdaeb0ac0f479cad9deae7311ff/json_response_handling_ruby.rb

# http://ruby-doc.org/stdlib-2.0.0/libdoc/open-uri/rdoc/OpenURI.html 
require 'open-uri'
# https://github.com/flori/json
require 'json'
# http://stackoverflow.com/questions/9008847/what-is-difference-between-p-and-pp
require 'pp'

def getJsonFromUrl(url)
    # Actually fetch the contents of the remote URL as a String.
	puts "Getting" + url
	buffer = open(url).read
	# Convert the String response into a plain old Ruby array. It is faster and saves you time compared to the standard Ruby libraries too.
	result = JSON.parse(buffer)

	return result
end

def printDigitaleFerdigheter(uri)
     url = uri + ".json"
	 
end



# Construct the URL we'll be calling
request_uri = 'http://data.udir.no/kl06/laereplaner.json'
request_query = ''
url = "#{request_uri}#{request_query}"
result = getJsonFromUrl(url)

# Loop through each of the elements in the 'result' Array & print some of their attributes.
result.each do |laereplan|
  puts laereplan['status']
  if(!laereplan['status'].eql? "http://data.udir.no/kl06/status_utgaatt")
      request_uri = laereplan['url-data'] + ".json"
      puts request_uri
      url = "#{request_uri}#{request_query}"
      puts url
      # Actually fetch the contents of the remote URL as a String.
      puts "Getting" + url
      buffer = open(url).read
      # Convert the String response into a plain old Ruby array. It is faster and saves you time compared to the standard Ruby libraries too.
      result = JSON.parse(buffer)

      kode = result["kode"];
      open(kode, 'wb') do |file|
        file << buffer
        file.close
      end  
  else
    puts "Skip utgått læreplan.\n"
  end
end

