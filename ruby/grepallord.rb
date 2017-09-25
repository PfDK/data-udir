#The code below is based on https://gist.githubusercontent.com/kyletcarlson/7911188/raw/34a01eaf7e4c6cdaeb0ac0f479cad9deae7311ff/json_response_handling_ruby.rb

# http://ruby-doc.org/stdlib-2.0.0/libdoc/open-uri/rdoc/OpenURI.html 
require 'open-uri'
# https://github.com/flori/json
require 'json'
# http://stackoverflow.com/questions/9008847/what-is-difference-between-p-and-pp
require 'pp'

$file = nil
$outdir = "../../../d3-wordcloud/udir/"
$filterWords = ["det", "dei", "eller", "eit", "kan", "bm.:","fra", "etter", "desse", "to", "den", "å", "han", "ein", "eitt", "ved", 
                "som", "med", "på", "i", "til", "og", "for", "av", "om"] 

$unimportantWords = ["bruke", "enkle", "gjere", "praktiske", "beskrive", "ulike"]
$importantWords = ["berekne", "geometriske", "brøkar", "teknologi", "vurdere", "matematiske", "digitale", "resonnement", 
                   "argumentere"]
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

def printWords()
    sz = $words.size
    no = 0
    prev = 0
    wordsSorted = $words.sort_by { |_, value| value }.reverse
    printf "Words sorted:"
    puts wordsSorted
    wordsSorted.each do |i,w|
#  {text: 'have', size: 102},
      if w != prev
        no = no + 1
        prev = w
      end
      s = sprintf "  {text: '%s', size: %d}", i, no 
      myputs(s)
      if(no < sz)
        myputs(",\n")
      end
    end
end

def removeWords
end

def filterWord(w)
end

def handleKompetansemaal(s)
    s.each do |m|
#        puts m
        tittel = m["tittel"]
        puts tittel
        o = tittel.split(" ")
        
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

def createHtmlFile(htmlFileName,jsFileName,name,url)
    filename = "#{$outdir}#{htmlFileName}"
	file = File.open( filename,"w" )
    file << "<!DOCTYPE html>"
    file << "<html>"
    file << " <head>"
    file << "    <title>#{name}</title>"
    file << "    <script src='../lib/d3/d3.js' charset='utf-8'></script>"
    file << "    <script src='../lib/d3/d3.layout.cloud.js'></script>"
    file << "    <script src='../d3.wordcloud.js'></script>"
    file << "    <script src='#{jsFileName}'></script>"
    file << "  </head>"
    file << "  <meta charset='UTF-8'>"
    file << "  <body style='text-align: center'>"
    file << "    <h2><a target='_blank' href='#{url}'>#{name}</a></h2><br/>"
    file << "    <div id='wordcloud'></div>"
    file << "    <script>"
    file << "      d3.wordcloud()"
    file << "        .size([800, 800])"
    file << "        .fill(d3.scale.ordinal().range(['#884400', '#448800', '#888800', '#444400']))"
    file << "        .words(words)"
    file << "        .onwordclick(function(d, i) {"
    file << "          if (d.href) { window.location = d.href; }"
    file << "        })"
    file << "        .start();"
    file << "    </script>"
    file << "  </body>"
    file << "</html>"
    file.close
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

Dir.foreach('.') do |item|
  
  next if item == '.' or item == '..'

#  item = "MAT1-01"
  OpenFile("#{$outdir}#{item}.js")

  lpInnhold = getJsonFromUrl(item)
#  puts lpInnhold
  lpTittel = lpInnhold['tittel']
  puts lpTittel
  lpTittelVerdi = lpTittel[0]['verdi']
  lpUrl = sprintf "%s.html", lpInnhold["url-data"]
  
  printf "Læreplannavn:%s\n", lpTittelVerdi
  printf "url:%s\n", lpUrl

  htmlFileName = sprintf "%s.html", item
  jsFileName = sprintf "%s.js", item
  createHtmlFile(htmlFileName, jsFileName,lpTittelVerdi, lpUrl)

  indexHtmlFile << "<a target='_blank' href='#{htmlFileName}'>#{lpTittelVerdi}</a><br/>"

  myputs("var words = [\n")
  $words = {}

  gfk = lpInnhold['kompetansemaal-kapittel']
#  puts gfk
  gfs = gfk['kompetansemaalsett']
#  puts gfs
  handleKompetansemaalsett(gfs)
  printWords()
  myputs("\n];")
  CloseFile()
end

indexHtmlFile.close

