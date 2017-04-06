#The code below is based on https://gist.githubusercontent.com/kyletcarlson/7911188/raw/34a01eaf7e4c6cdaeb0ac0f479cad9deae7311ff/json_response_handling_ruby.rb

# http://ruby-doc.org/stdlib-2.0.0/libdoc/open-uri/rdoc/OpenURI.html 
require 'open-uri'
# https://github.com/flori/json
require 'json'
# http://stackoverflow.com/questions/9008847/what-is-difference-between-p-and-pp
require 'pp'

$file = nil

def OpenFile(filename)
	$file = File.open( filename,"w" )
end

def CloseFile()
	$file.close
end

def myputs(s)
	$file << s
end

def printDigitaleFerdigheter(uri)
     url = uri + ".json"
	 
end

def getJsonFromUrl(url)
    # Actually fetch the contents of the remote URL as a String.
	puts "Getting" + url
	buffer = open(url).read
	# Convert the String response into a plain old Ruby array. It is faster and saves you time compared to the standard Ruby libraries too.
	result = JSON.parse(buffer)

	return result
end

OpenFile("dataudir.html")
myputs('<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Digitale ferdigheter i alle fag</title>
</head><body>')

# Construct the URL we'll be calling
request_uri = 'http://data.udir.no/kl06/laereplaner.json'
request_query = ''
url = "#{request_uri}#{request_query}"
result = getJsonFromUrl(url)

# Loop through each of the elements in the 'result' Array & print some of their attributes.
result.each do |laereplan|
  myputs "<h2><a href='#{laereplan['url-data']}'.html'>#{laereplan['tittel'][0]["verdi"]}</a></h2>\n"
  lpInnhold = getJsonFromUrl(laereplan['url-data'])
    gfk = lpInnhold['grunnleggende-ferdigheter-kapittel']
	gfd = gfk['digitale']
	if gfd['tekst'][0]
	   gfdt = gfd['tekst'][0]["verdi"]
	   myputs gfdt
	else
	   myputs "Har ikke krav til digitale ferdigheter."
	end
	puts "\n"
  
end

myputs ("</body></html>")
CloseFile()

