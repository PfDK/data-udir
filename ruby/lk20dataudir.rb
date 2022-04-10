#Author    : Erlend Thune (erlend.thune@udir.no)
#Purpose   : Finn digitale ferdigheter i alle fag og skriv de til filen dataudir.html

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
$URLDATA = 0
$LPINNHOLD = 1
$TITTEL = 2
$KODE = 3
$BESKRIVELSE = 4

$dfArray = []
$dfMissingArray = []


def getJsonFromUrl(url)
    # Actually fetch the contents of the remote URL as a String.
	puts "Getting" + url
	buffer = open(url).read
	# Convert the String response into a plain old Ruby array. It is faster and saves you time compared to the standard Ruby libraries too.
	result = JSON.parse(buffer)

	return result
end

def outputDfHeader(df)
	kode = df[$KODE]
	tittel = df[$TITTEL]
	urlData = df[$URLDATA]
	myputs "<p>"
	myputs "<a target='_blank' href='https://www.udir.no/lk20/#{kode}'>#{tittel} - #{kode}</a>\n"
	myputs "<a target='_blank' href='#{urlData}'.html'>json</a>\n"
	myputs "</p>"
end
OpenFile("lk20dataudir.html")
myputs('<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Digitale ferdigheter i alle fag</title>
</head><body>')

# Construct the URL we'll be calling
request_uri = 'http://data.udir.no/kl06/v201906/laereplaner-lk20.json'
request_query = ''
url = "#{request_uri}#{request_query}"
result = getJsonFromUrl(url)

# Loop through each of the elements in the 'result' Array & print some of their attributes.
i=0

result.each do |laereplan|
	i = i + 1

	urlData = laereplan['url-data']
	tittel = laereplan['tittel'][0]["verdi"]
	kode = laereplan['kode']
	lpInnhold = getJsonFromUrl(laereplan['url-data'])
	omf = lpInnhold['om-faget-kapittel']
#	puts omf
	gfk = omf["grunnleggende-ferdigheter-i-faget"]
#	puts gfk
	gf = gfk["grunnleggende-ferdigheter"]
#	puts gf
	dfm = []
	dfm[$URLDATA] = urlData
	dfm[$LPINNHOLD]=lpInnhold
	dfm[$TITTEL]=tittel
	dfm[$KODE]=kode
	if gf.length == 0
		$dfMissingArray << dfm
	else
		gfdFound = false
		gf.each do |gfd|
			gfdo = gfd["overskrift"]["tekst"][0]["verdi"]
			if gfdo.include? "Digi"	   
				gfdFound = true
				gfdb = gfd["beskrivelse"]["tekst"][0]["verdi"]
				dfm[$BESKRIVELSE] = gfdb
				$dfArray << dfm
				break
			end
		end
		if !gfdFound
			$dfMissingArray << dfm
		end
	end
	puts "\n"
#	if i== 5
#		break
#	end
end
myputs "<h1>Læreplaner som har digitale ferdigheter</h1>"
$dfArray.each do |df|
	outputDfHeader(df)
	myputs df[$BESKRIVELSE]
end
myputs "<h1>Læreplaner som ikke har digitale ferdigheter</h1>"
$dfMissingArray.each do |df|
	outputDfHeader(df)
end

myputs ("</body></html>")
CloseFile()

