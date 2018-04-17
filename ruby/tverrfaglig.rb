#Author    : Erlend Thune (erlend.thune@udir.no)
#Purpose   : Finn alle ord i læreplanene i mappen som scriptet kjøres fra. 
#            Sorter ordene i alfabetisk rekkefølge og skriv ut 
#            Hvilke læreplaner som bruker ordene under hvert ord.
#Dependency: Avhenger av at alle læreplanene er lastet ned som fil 

#The code below is based on https://gist.githubusercontent.com/kyletcarlson/7911188/raw/34a01eaf7e4c6cdaeb0ac0f479cad9deae7311ff/json_response_handling_ruby.rb

# http://ruby-doc.org/stdlib-2.0.0/libdoc/open-uri/rdoc/OpenURI.html 
require 'open-uri'
# https://github.com/flori/json
require 'json'
# http://stackoverflow.com/questions/9008847/what-is-difference-between-p-and-pp
require 'pp'

#Funksjoner som brukes av flere script ligger i denne ruby filen.
require_relative 'udirutility'

$letters = []
def createHtmlFile(letter)
    OpenFile( "#{$outdir}#{letter}.html")
    myputs "<!DOCTYPE html>"
    myputs "<html>"
    myputs " <head>"
    myputs "    <title>Felles ord i læreplaner</title>"
    myputs "  </head>"
    myputs "  <meta charset='UTF-8'>"
    myputs "  <body>"
    myputs "  <h1>Felles ord i læreplaner</h1>"
    printCommonLinks($file)
    $letters.each do |l|
       if(l == letter)
         myputs("<a style='font-size:30px' href='#{letter}.html'>#{letter}</a> ")
       else
         myputs("<a href='#{l}.html'>#{l}</a> ")
       end
    end
end


def printWords()
    sz = $words.size
    firstLetter = ""
    $wordsSorted = $words.sort_by{|k,v| k.downcase}.to_h
    $wordsSorted.each do |ord,w|
        puts ord
        firstLetter = GetFirstLetter(ord)
        if(!$letters.include?(firstLetter) )
           $letters << firstLetter
        end
    end

    firstLetter = ""
    $wordsSorted.each do |ord,w|
        nextFirstLetter = GetFirstLetter(ord)
        if (firstLetter != nextFirstLetter)
            if(firstLetter != "")
                CloseFile()
            end
            firstLetter = nextFirstLetter
            createHtmlFile(firstLetter)
        end
        myputs("<hr/>")
        s = sprintf "<h2 id='%s'>Ord:%s</h2>", ord, ord
        myputs(s)
    
        w.each do |fag, lp|
          lpLinkWritten = false    
          lp.each do |lpm, url|
            if !(lpLinkWritten)
                s = sprintf "<h3><a href='%s'>%s</a></h3><ul>", url,fag
                myputs(s)
                lpLinkWritten = true
            end
            s = sprintf "<li>%s</li>", lpm
            puts s
            myputs(s)
          end
          myputs("</ul>")
        end
    end
end

def MarkWordInSentence(s, w)
    s2 = s.dup
    return s2.gsub! w, "<b style='color:red'>#{w}</b>"
end

#ord->fag->læreplanmål
def handleKompetansemaal(lpInnhold,s)
    lpTittel = lpInnhold['tittel']
    fag = getTittel(lpTittel)
    htmlFileName = sprintf "%s.html", lpInnhold['kode']
    s.each do |m|
        tittel = m["tittel"]
        trimTittel = tittel.tr($filterLetters, '')
        o = trimTittel.split(" ")
        
        o.each do |w|
            if !(/^[0-9]+/.match w)
                if !$filterWords.include?(w)            
                    if(!$words[w])
                        $words[w] = {}
                    end
                    if(!$words[w][fag])
                        $words[w][fag] = {}
                    end
                
                    tittelMarkWord = MarkWordInSentence(tittel, w)
                    $words[w][fag][tittelMarkWord] = htmlFileName
                end
            end
        end
    end
    
end

$words = {}
Dir.foreach('.') do |item|
  next if item == '.' or item == '..'
  lpInnhold = getJsonFromUrl(item)
  gfk = lpInnhold['kompetansemaal-kapittel']
  gfs = gfk['kompetansemaalsett']
  gfs.each do |s|
    handleKompetansemaal(lpInnhold,s["kompetansemaal"])  
  end
end
printWords()

