#The code below is based on https://gist.githubusercontent.com/kyletcarlson/7911188/raw/34a01eaf7e4c6cdaeb0ac0f479cad9deae7311ff/json_response_handling_ruby.rb

# http://ruby-doc.org/stdlib-2.0.0/libdoc/open-uri/rdoc/OpenURI.html 
require 'open-uri'
# https://github.com/flori/json
require 'json'
# http://stackoverflow.com/questions/9008847/what-is-difference-between-p-and-pp
require 'pp'
require_relative 'udirutility'  

$file = nil
$words = nil
$outdir = "../../../d3-wordcloud/udir/"

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


def handleKompetansemaalForWordCloud(s)
    s.each do |m|
#        puts m
        tittel = m["tittel"]
#        puts tittel
        trimTittel = tittel.tr($filterLetters, '')
        o = trimTittel.split(" ")
        
        o.each do |w|
#            puts w
            w.delete! ","
            w.delete! "-"
            w.delete! "'"
            w.delete! ")"
            w.delete! "("
            
            if !$filterWords.include?(w)            
                if(!$words[w])
                    $words[w] = 1
                elsif $importantWords.include?(w)
                    $words[w] = $words[w] + 10
                elsif !$unimportantWords.include?(w)
                    $words[w] = $words[w] + 1
                end
            end
        end
    end
end
def handleKompetansemaalsett(gfs)
    gfs.each do |s|
      handleKompetansemaal(s["kompetansemaal"])  
    end
end


indexHtmlFile = File.open( "#{$outdir}index.html","w" )
indexHtmlFile << "<!DOCTYPE html>"
indexHtmlFile << "<html>"
indexHtmlFile << " <head>"
indexHtmlFile << "    <title>Læreplaner</title>"
indexHtmlFile << "  </head>"
indexHtmlFile << "  <meta charset='UTF-8'>"
indexHtmlFile << "  <body>"
indexHtmlFile << "  <h1>Læreplaner som ordskyer</h1>"

printCommonLinks(indexHtmlFile)

Dir.foreach('.') do |item|
  
  next if item == '.' or item == '..'

  OpenFile("#{$outdir}#{item}.js")

  lpInnhold = getJsonFromUrl(item)
  lpTittel = lpInnhold['tittel']
  
  lpTittelVerdi = getTittel(lpTittel)
  lpUrl = sprintf "%s.html", lpInnhold["url-data"]
  
  printf "Læreplannavn:%s\n", lpTittelVerdi
  printf "url:%s\n", lpUrl

  htmlFileName = sprintf "%s.html", item
  jsFileName = sprintf "%s.js", item

  indexHtmlFile << "<a target='_blank' href='#{htmlFileName}'>#{lpTittelVerdi}</a><br/>"

  myputs("var words = [\n")
  $words = {}

  gfk = lpInnhold['kompetansemaal-kapittel']
  gfs = gfk['kompetansemaalsett']
  handleKompetansemaalsettForWordCloud(gfs)
  wordHtmlFile = createHtmlFileForWordCloud(htmlFileName, jsFileName,lpTittelVerdi, lpUrl)
  printWordsForWordCloud(wordHtmlFile)
  closeHtmlFileForWordCloud(wordHtmlFile)
  myputs("\n];")
  CloseFile()
end

indexHtmlFile.close

