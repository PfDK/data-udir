#Author    : Erlend Thune (erlend.thune@udir.no)
#Purpose   : Finn alle ord i læreplanene i mappen som scriptet kjøres fra. 
#            Lag input filer for ordskyer og lag html filer som viser ordskyene. 
#            Lag index.html fil som lenker til alle ordskyene.
#Dependency: Avhenger av at alle læreplanene er lastet ned som fil 
#The code below is based on https://gist.githubusercontent.com/kyletcarlson/7911188/raw/34a01eaf7e4c6cdaeb0ac0f479cad9deae7311ff/json_response_handling_ruby.rb

# http://ruby-doc.org/stdlib-2.0.0/libdoc/open-uri/rdoc/OpenURI.html 
require 'open-uri'
# https://github.com/flori/json
require 'json'
# http://stackoverflow.com/questions/9008847/what-is-difference-between-p-and-pp
require 'pp'
require_relative 'udirutility'  

if(ARGV.size < 1)
	puts("Usage: ruby #{$0} trinn")
	puts("Generer ordsky og statistikk over ord for trinn")
	exit
end

trinn = ARGV[0]

$file = nil
$words = nil

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


  item = "KRO1-04"
  OpenFile("#{$outdir}#{item}_#{trinn}.js")

  lpInnhold = getJsonFromUrl("KRO1-04")
  lpTittel = lpInnhold['tittel']
  
  lpTittelVerdi = getTittel(lpTittel) + " " + trinn
  lpUrl = sprintf "%s.html", lpInnhold["url-data"]
  
  printf "Læreplannavn:%s\n", lpTittelVerdi
  printf "url:%s\n", lpUrl

  htmlFileName = sprintf "%s_#{trinn}.html", item
  jsFileName = sprintf "%s_#{trinn}.js", item

  myputs("var words = [\n")
  $words = {}

  gfk = lpInnhold['kompetansemaal-kapittel']
  gfs = gfk['kompetansemaalsett']
  handleKompetansemaalsettForWordCloud(gfs, trinn)
  wordHtmlFile = createHtmlFileForWordCloud(htmlFileName, jsFileName,lpTittelVerdi, lpUrl)
  printWordsForWordCloud(wordHtmlFile)
  closeHtmlFileForWordCloud(wordHtmlFile)
  myputs("\n];")
  CloseFile()


