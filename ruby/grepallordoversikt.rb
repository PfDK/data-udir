#The code below is based on https://gist.githubusercontent.com/kyletcarlson/7911188/raw/34a01eaf7e4c6cdaeb0ac0f479cad9deae7311ff/json_response_handling_ruby.rb

# http://ruby-doc.org/stdlib-2.0.0/libdoc/open-uri/rdoc/OpenURI.html 
require 'open-uri'
# https://github.com/flori/json
require 'json'
# http://stackoverflow.com/questions/9008847/what-is-difference-between-p-and-pp
require 'pp'
require_relative 'udirutility'

OpenFile("#{$outdir}alle.js")
htmlFileName = sprintf "alle.html"
jsFileName = sprintf "alle.js"

myputs("var words = [\n")
$words = {}
Dir.foreach('.') do |item|
  next if item == '.' or item == '..'

#  item = "MAT1-01"

  lpInnhold = getJsonFromUrl(item)
#  puts lpInnhold
  lpTittel = lpInnhold['tittel']
  
  lpTittelVerdi = getTittel(lpTittel)
  lpUrl = sprintf "%s.html", lpInnhold["url-data"]
  
  printf "Læreplannavn:%s\n", lpTittelVerdi
  printf "url:%s\n", lpUrl

  gfk = lpInnhold['kompetansemaal-kapittel']
#  puts gfk
  gfs = gfk['kompetansemaalsett']
#  puts gfs
  handleKompetansemaalsettForWordCloud(gfs)
end
wordHtmlFile = createHtmlFileForWordCloud(htmlFileName, jsFileName, "Alle læreplaner", "index.html")
printWordsForWordCloud(wordHtmlFile)
closeHtmlFileForWordCloud(wordHtmlFile)
myputs("\n];")
CloseFile()


