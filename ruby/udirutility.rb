$maxWordsInWordCloud = 100
$filterLetters = ',.\/\-\')(+\’”"«–§π'
$filterWords = ["a", "et", "én", "en", "det", "andre", "dei", "eller", "eit", "kan", "bm.:","fra", "etter", "desse", "to", "den", "å", "han", "ein", "eitt", "ved", 
                "som", "med", "på", "i", "til", "og", "for", "av", "om", 
               "er", "kva", "hos", "frå"] 

$unimportantWords = []
$importantWords = []
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


def printCommonLinks(fil)
    fil << "På disse nettsidene eksperimenterer jeg med nye måter å bruke læreplanene på. Alt er laget vha. <a href='https://www.udir.no/om-udir/data/kl06-grep/' target='_blank'>Grep</a>. "
    fil << "Ta kontakt med <a href='mailto:erlend.thune@iktsenteret.no'>erlend.thune@iktsenteret.no</a>, dersom du har forslag til forbedringer av disse sidene. "
    fil << "Se forøvrig <a href='https://github.com/PfDK/data-udir'>https://github.com/PfDK/data-udir</a> for informasjon om hvordan jeg har laget sidene. <hr/>"
    fil << "<a href='index.html'>Gå til oversikt over læreplaner</a><hr/>"
    fil << "<a href='alle.html'>Se ordsky og tabell over ord på tvers av alle læreplaner</a><hr/>"
end

def printCommonWordCloudInformation(fil)
    fil << "Klikk på ordene for å se hvilke andre læreplaner som bruker det ordet."
    fil << "Alle tall eller <i>ord</i> som begynner med tall blir ignorert."
end

def getJsonFromUrl(url)
    # Actually fetch the contents of the remote URL as a String.
	puts "Getting" + url
	buffer = open(url).read
	# Convert the String response into a plain old Ruby array. It is faster and saves you time compared to the standard Ruby libraries too.
	result = JSON.parse(buffer)

	return result
end

def printIgnoredLetters(fil)
    fil << "Disse bokstavene/tegnene blir ignorert dersom de står alene:"
    if($filterLetters == "")
      fil << "<b>Ingen</b>"
    else
      fil << "<b>"
      fil << $filterLetters
      fil << "</b>"
    end
    fil << "<br/>"
end

def printIgnoredWords(fil)
    fil << "Disse ordene blir ignorert:"
    if($filterWords.size == 0)
      fil << "<b>Ingen</b>"
    end
    $filterWords.each do |w|
     fil << "<b>"
     fil << w
     fil << " "
     fil << "</b>"
    end
    fil << "<br/>"
end

def printImportantWords(fil)
    fil << "Disse ordene blir gitt ekstra tyngde:"

    if($importantWords.size == 0)
      fil << "<b>Ingen</b>"
    end
    $importantWords.each do |w|
     fil << "<b>"
     fil << w
     fil << " "
     fil << "</b>"
    end
     fil << "<br/>"

end

def getTittel(tittelArr)
  tittelArr.each do |t|
    puts t
    if(t["spraak"].eql? "default")
        return t['verdi']
    end
  end
end
def handleKompetansemaalForWordCloud(s)
    s.each do |m|
        tittel = m["tittel"]
        trimTittel = tittel.tr($filterLetters, '')
        o = trimTittel.split(" ")
        
        o.each do |w|
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
def handleKompetansemaalsettForWordCloud(gfs)
    gfs.each do |s|
      handleKompetansemaalForWordCloud(s["kompetansemaal"])  
    end
end



def createHtmlFileForWordCloud(htmlFileName,jsFileName,name,url)
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
    file << "  <body>"
    printCommonLinks(file)
    printIgnoredLetters(file)
    printImportantWords(file)
    printIgnoredWords(file)
    file << "    <h1>Ordsky og tabell over de #{$maxWordsInWordCloud} mest brukte ordene i læreplanen for"
    file << "    <h2><a target='_blank' href='#{url}'>#{name}</a></h2><br/>"
    file << "    Scroll ned for å se ordene i en tabell.<br>"
    file << "    Klikk på et ord for å se hvilke andre læreplaner som også bruker det ordet.<br/>"
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
    file << "    <h1>Oversikt over alle ord og hvor hyppig de forekommer i læreplanen</h1>"
    noOfWords = $words.size
    file << "    Totalt antall ord: #{noOfWords}"
    file << "    <table><tr><th>Ord</th><th>Frekvens</th></tr>"
    return file
end

def closeHtmlFileForWordCloud(htmlFile)
    htmlFile << "  </table>"
    htmlFile << "  </body>"
    htmlFile << "</html>"
end

def GetFirstLetter(ord)
    l = ord[0].downcase
    if (l == 'æ')
        l = 'ae'
    elsif (l == 'ø')
        l = 'oe'
    elsif (l == 'å')
        l = 'aa'
    end
    return l
end
def printWordsForWordCloud(htmlFile)
    sz = $words.size
    no = 0
    prevfrekvens = 0
    wordsSorted = $words.sort_by { |_, value| value }.reverse
#    printf "Words sorted:"
#    puts wordsSorted
    wordsSorted.each do |ord,frekvens|
#  {text: 'have', size: 102},
      firstLetter = GetFirstLetter(ord)
      url = sprintf "%s.html#%s", firstLetter, ord
      htmlFile << "<tr><td>"
      htmlFile << "<a href='#{url}'>#{ord}</a>"
      htmlFile << "</td><td>"
      htmlFile << frekvens
      htmlFile << "</td></tr>"
      if frekvens != prevfrekvens
        no = no + 1
        prevfrekvens = frekvens
      end
      if (no < $maxWordsInWordCloud)
          s = sprintf "  {text: '%s', size: %d, href:'%s'}", ord, no, url 
          myputs(s)
          if(no < sz)
            myputs(",\n")
          end
      end
    end
end

