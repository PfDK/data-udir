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


def getJsonFromUrl(url)
    # Actually fetch the contents of the remote URL as a String.
	#puts "Getting" + url
	buffer = open(url).read
	# Convert the String response into a plain old Ruby array. It is faster and saves you time compared to the standard Ruby libraries too.
	result = JSON.parse(buffer)

	return result
end

OpenFile("kryssloep.csv")
myputs("up-kode\tpo-kode\tpo-tittel\tbp-kode\tbp-tittel\n")

# Construct the URL we'll be calling
def getJson(url)
    request_uri = url
    request_query = ''
    url = "#{request_uri}#{request_query}"
    result = getJsonFromUrl(url)
    return result
end

def getProgramOmraadeTittel(detaljer)
    detaljer["tittel"].each do |tittel|
        if (tittel["spraak"].include? "default")
            return tittel["verdi"]
        end
    end
    return "-"
end

def getProgram(urldata) 
    detaljer = getJson(urldata)
    return detaljer["utdanningsprogram-referanse"][0]["kode"]
end
def behandleProgramomraadeDetaljer(utdanningsProgram, detaljer)
    if !detaljer["bygger-paa-programomraade"].length
        return
    end

    semester = detaljer["foerste-semester"]["beskrivelse"]
    #puts semester
    semesterAar = semester[0]["verdi"].scan(/\d/).join('')
    if(semesterAar.to_i > 2018)
        return
    end


    programomraadeTittel = getProgramOmraadeTittel(detaljer)

    programOmraade = detaljer["kode"]

    byggerPaa = detaljer["bygger-paa-programomraade"]
    byggerPaa.each do |kryssloep|
        byggerPaaProgram = getProgram(kryssloep["url-data"])
    
        if((byggerPaaProgram != utdanningsProgram) && (kryssloep.length > 0) && (kryssloep["status"].include? "publisert"))
            myputs "#{utdanningsProgram}\t#{programOmraade}\t#{programomraadeTittel}\t#{kryssloep['kode']}\t#{kryssloep['tittel']}\n"
        end
    end
end

result = getJson('http://data.udir.no/kl06/v201906/programomraader.json')
i=0
result.each do |programomraade|
    print "."
    if programomraade["status"].include? "publisert"
        if(programomraade['tilhoerer_utdanningsprogram'] && programomraade['tilhoerer_utdanningsprogram'].length > 0)
            utdanningsProgram = programomraade['tilhoerer_utdanningsprogram'][0]["kode"]
            programomraadeDetaljer = getJson(programomraade["url-data"])
            behandleProgramomraadeDetaljer(utdanningsProgram, programomraadeDetaljer)
        else
            puts "Hører ikke til noe utdanningsprogram: #{programomraade['kode']}"
        end
    end
end
CloseFile()

