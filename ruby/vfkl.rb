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


def OpenFile(filename)
	$file = File.open( filename,"w" )
end

def CloseFile()
	$file.close
end

def myputs(s)
	$file << s
end


def getJsonFromUrl(url, kode)
    buffer = nil
    result = nil
    begin
        buffer = open(kode).read
    rescue
#        puts "Local file #{kode} not found"
#        puts "Open " + url
        buffer = open(url).read
        open(kode, 'wb') do |file|
            file << buffer
            file.close
        end  
    ensure
        # Convert the String response into a plain old Ruby array. It is faster and saves you time compared to the standard Ruby libraries too.
        if(buffer)
            result = JSON.parse(buffer)
        end
    end
	return result
end

alle = {}
manglerData = {}

result = getJsonFromUrl('https://data.udir.no/kl06/v201906/opplaeringsfag.json', 'opplaeringsfag.json')

result.each do |fag|
  if(!fag['status'].include? "utgaatt")
    lpInnhold = getJsonFromUrl(fag["url-data"], fag["kode"])

    #puts "Opplæringsfag: #{fag["url-data"]}"

    opplaeringsfag = lpInnhold["tittel"][0]["verdi"]
    opplaeringsnivaa = lpInnhold["opplaeringsnivaa"]["tittel"]

    if(!alle[opplaeringsnivaa]) 
        alle[opplaeringsnivaa] = {}
    end

    lpInnhold["laereplan-referanse"].each do |laereplanreferanse|        
        begin
            opplaeringsfagLaereplanKode = laereplanreferanse["kode"]
            opplaeringsfagLaereplanTittel = laereplanreferanse["tittel"]
            opplaeringsfagLaereplanUrl = laereplanreferanse["url-data"]

            gyldigLaereplan = false
            gyldigtil = laereplanreferanse["gyldighet"]["gyldig-til"]
            if(!gyldigtil)
                gyldigLaereplan = true
            elsif (gyldigtil > "2022-04-10T00:00:00") 
                gyldigLaereplan = true
            end
    
            if(gyldigLaereplan)
                if(lpInnhold['programomraader-referanse'].length > 0) 
                    lpInnhold['programomraader-referanse'].each do |programomraadeReferanse|
                        programomraadeReferanseKode = programomraadeReferanse['kode']
                        programomraadeReferanseUrl = programomraadeReferanse['url-data']
                        programomraade = getJsonFromUrl(programomraadeReferanseUrl, programomraadeReferanseKode)
                    
                        programomraade["utdanningsprogram-referanse"].each do |utdanningsProgram|
                            utdanningsProgramTittel = utdanningsProgram["tittel"]

                            utdanningsProgramKode = utdanningsProgram["kode"]
                            utdanningsProgramUrl = utdanningsProgram["url-data"]

                            utdanningsProgram = getJsonFromUrl(utdanningsProgramUrl, utdanningsProgramKode)

                            typeUtdanningsProgram = utdanningsProgram["type-utdanningsprogram"]["beskrivelse"][0]["verdi"]

                            if(!alle[opplaeringsnivaa][typeUtdanningsProgram])
                                alle[opplaeringsnivaa][typeUtdanningsProgram] = {}
                            end
                            
                            if(!alle[opplaeringsnivaa][typeUtdanningsProgram][utdanningsProgramTittel])
                                alle[opplaeringsnivaa][typeUtdanningsProgram][utdanningsProgramTittel] = {}
                            end

                            alle[opplaeringsnivaa][typeUtdanningsProgram][utdanningsProgramTittel][opplaeringsfagLaereplanKode] = opplaeringsfagLaereplanTittel
                        end
                    end 
                else
                    alle[opplaeringsnivaa][opplaeringsfagLaereplanKode] = opplaeringsfagLaereplanTittel
                end
            end
        rescue
            puts fag["url-data"]
            manglerData[fag["kode"]] = fag["url-data"]
        end
    end
  end
end
#alleUtdanningsProgram.each do |utdanningsProgram, laereplan|
#    appFileBuffer = laereplan.to_json
    open("vfkl.json", 'wb') do |file|
        file << alle.to_json
        file.close
    end  
#end



  

 

