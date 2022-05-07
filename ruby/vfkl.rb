#Author    : Erlend Thune (erlend.thune@udir.no)
#Purpose   : Lag strukturert oversikt over alle læreplaner i grunn- og videregående skole til bruk i VFKL.

# http://ruby-doc.org/stdlib-2.0.0/libdoc/open-uri/rdoc/OpenURI.html 
require 'open-uri'
# https://github.com/flori/json
require 'json'
# http://stackoverflow.com/questions/9008847/what-is-difference-between-p-and-pp
require 'pp'
require_relative 'udirutility'  


def getJsonFromUrl(url, kode)
    buffer = nil
    result = nil

    fileName = kode + ".json"
    begin
        buffer = open(fileName).read
    rescue
        buffer = open(url).read
        open(fileName, 'wb') do |file|
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

def createCodeObject(value, label)
    return { "Value" => "#{value}", "Label" =>  label}
end

def HandleProgramOmraader(alle, lpInnhold, opplaeringsnivaa, fagtype, opplaeringsfagLaereplanKode, opplaeringsfagLaereplanTittel, opplaeringsfagLaereplanUrl)
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

            if(!alle[opplaeringsnivaa][typeUtdanningsProgram][utdanningsProgramTittel][fagtype])
                alle[opplaeringsnivaa][typeUtdanningsProgram][utdanningsProgramTittel][fagtype] = {}
            end

            alle[opplaeringsnivaa][typeUtdanningsProgram][utdanningsProgramTittel][fagtype][opplaeringsfagLaereplanTittel] = opplaeringsfagLaereplanKode
        end
    end 
end

def HandleOpplaeringsFagInnhold(alle, opplaeringsFagInnhold, opplaeringsnivaa, fagtype, opplaeringsfagLaereplanKode, opplaeringsfagLaereplanTittel, opplaeringsfagLaereplanUrl)
    lpProcessed = {}

    if(opplaeringsFagInnhold['programomraader-referanse'].length > 0) 
        HandleProgramOmraader(alle, opplaeringsFagInnhold, opplaeringsnivaa, fagtype, opplaeringsfagLaereplanKode, opplaeringsfagLaereplanTittel, opplaeringsfagLaereplanUrl)
    else
        if(opplaeringsnivaa.include? "videregaaende")
            puts "Videregående fag mangler programområde #{opplaeringsfagLaereplanKode} nivå:#{opplaeringsnivaa}"
        end
        if(!alle[opplaeringsnivaa][fagtype])
            alle[opplaeringsnivaa][fagtype] = {}
        end
        alle[opplaeringsnivaa][fagtype][opplaeringsfagLaereplanTittel] = opplaeringsfagLaereplanKode
    end
    print "."
end

def outputFagomraade(o, navn, fagomraade)
    o = []
    fagomraade.each do |k, v|   
        o.push(createCodeObject("#{k}; #{v}", "#{k} (#{v})"))
    end       
    #Uncomment this line if you want separate json files for each fagområde.
#    output(navn, o)
    return o;
end

def outputUtdanningsprogram(navn, utdanningsprogram)
    o = []
    utdanningsprogram.each do |k, v|   
        o.concat outputFagomraade(o, "#{navn}#{k}", v)
    end       
    output(navn, o)
end

def outputProgramomraade(navn, programomraade)
    o = []
    programomraade.each do |k, v|   
        o.push(createCodeObject(k,k))
        outputUtdanningsprogram("#{navn}#{k}", v)
    end       
    output(navn, o)
end

def outputProgramomraader(navn, programomraader)
    o = []
    programomraader.each do |k, v|   
        o.push(createCodeObject(k,k))
        outputProgramomraade("#{navn}#{k}", v)
    end       
    output(navn, o)
end

def outputGrunnskoleFagomraade(navn, fagomraade)
        o = []
        fagomraade.each do |k, v|   
            o.push(createCodeObject("#{k}; #{v}", "#{k} (#{v})"))
        end       
        output(navn, o)
    end
    
def outputGrunnskole(navn, grunnskole)
    o = []
    grunnskole.each do |k, v|   
        o.push(createCodeObject(k,k))
        outputGrunnskoleFagomraade("#{navn}#{k}", v)
    end
    output(navn, o)
end


def output(name, o)
    open("#{name}.json", 'wb') do |file|
        oSorted = o.sort_by{ |e| e["Label"] }
        file << oSorted.to_json
        file.close
    end  
end

alle = {}
manglerData = {}

puts "Get opplæringsfag."
result = getJsonFromUrl('https://data.udir.no/kl06/v201906/opplaeringsfag.json', 'opplaeringsfag.json')

result.each do |fag|
    if(!fag['status'].include? "utgaatt")
        opplaeringsFagInnhold = getJsonFromUrl(fag["url-data"], fag["kode"])

        opplaeringsfag = opplaeringsFagInnhold["tittel"][0]["verdi"]
        opplaeringsnivaa = opplaeringsFagInnhold["opplaeringsnivaa"]["kode"]
        fagtype = opplaeringsFagInnhold["fagtype"]["tittel"]

        if(!alle[opplaeringsnivaa]) 
            alle[opplaeringsnivaa] = {}
        end

        opplaeringsFagInnhold["laereplan-referanse"].each do |laereplanreferanse|        
            opplaeringsfagLaereplanUrl = laereplanreferanse["url-data"]
            opplaeringsfagLaereplanKode = laereplanreferanse["kode"]

            laereplanInnhold = getJsonFromUrl(opplaeringsfagLaereplanUrl, "#{opplaeringsfagLaereplanKode}.json")
#            puts opplaeringsfagLaereplanUrl
            gyldigLaereplan = false
            gyldigtil = laereplanInnhold["gyldighetsperiode"]["gyldig-til"]["dato"]
#            puts gyldigtil
            if(!gyldigtil)
                gyldigLaereplan = true
            elsif (gyldigtil > "2022-04-10T00:00:00") 
                gyldigLaereplan = true
            else 
                puts "Utgått på dato:#{opplaeringsfagLaereplanUrl}"
            end

            opplaeringsfagLaereplanKode = laereplanreferanse["kode"]
            opplaeringsfagLaereplanTittel = laereplanreferanse["tittel"]
            opplaeringsfagLaereplanTittel.sub!("Læreplan i ", "")
            opplaeringsfagLaereplanTittel.sub!("Læreplan for ", "")
            letters = opplaeringsfagLaereplanTittel.split('')
            letters.first.upcase!
            opplaeringsfagLaereplanTittel = letters.join # + " (" + opplaeringsfagLaereplanKode + ")"

            if(gyldigLaereplan)
                HandleOpplaeringsFagInnhold(alle, opplaeringsFagInnhold, opplaeringsnivaa, fagtype, opplaeringsfagLaereplanKode, opplaeringsfagLaereplanTittel, opplaeringsfagLaereplanUrl)
            end
        end
    end
end

#These two lines can be replaced by API responses.
outputGrunnskole("Grunnskole", alle["opplaeringsnivaa_grunnskole"])
outputProgramomraader("Videregaaende", alle["opplaeringsnivaa_videregaaende"])

open("grepManglerData.json", 'wb') do |file|
    file << manglerData.to_json
    file.close
end  
