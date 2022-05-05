require 'rubygems'
require 'sparql/client'

query = %{
    PREFIX u: <http://psi.udir.no/ontologi/kl06/>
    PREFIX d: <http://psi.udir.no/kl06/>
    select ?lpJson ?kmJson ?kmTittel ?lpKode ?lpTittel where {
        ?km a u:kompetansemaal_lk20 ;
        u:tittel ?kmTittel ;
        u:url-data ?kmJson ;
        u:kode ?lpKode ; 
        u:tilhoerer-laereplan ?lp ;
        u:tilknyttede-grunnleggende-ferdigheter ?grf .
        FILTER (lang(?kmTittel) = "default")
        FILTER (REGEX(str(?grf), "GF5", "i"))
        ?lp u:url-data ?lpJson ;
        u:tittel ?lpTittel ;
    } ORDER BY ?lp ?km
}

result = {}
client = SPARQL::Client.new("http://sandkasse-data.udir.no:7200/repositories/KL06_201906_2102")
solutions = client.query(query)
solutions.each { |solution| 
    puts "==========="
    #https://www.udir.no/lk20
        puts "SOLUTION"
    #puts solution.inspect 
    solution.each { |o| 
        puts o
    }
    puts "==========="
}
