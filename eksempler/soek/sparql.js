//Denne javascriptfilen gjør SparQL spørringer mot læreplanene.

//Gjør endringer i SpqrQL queriet nedenfor
//Bruk f.ex. {{sokeOrd}} og bruk replace i Javascript til å bytte ut med variabler.
function getSparQLquery(sokeOrd)
{
    var queryTemplate    = (function(){ /*
prefix u: <http://psi.udir.no/ontologi/kl06/> prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> SELECT * WHERE { ?uri rdf:type u:laereplan_lk20 } LIMIT 10
	*/}).toString().split('\n').slice(1, -1).join('\n');    
                
    query = queryTemplate.replace("{{sokeOrd}}", sokeOrd);
    console.log(query);
    return query;
}


// Denne funksjonen knytter "Søk" knappen til sparqlQuery funksjonen
$(document).ready(function(){
	$("#sok").click(function() {
	  sparqlQuery();
	});
  $('#sokeOrd').keypress(function(event){
        var keycode = (event.keyCode ? event.keyCode : event.which);
        if(keycode == '13'){
            sparqlQuery();
        }
    });
});

function sparqlQuery()
{
  var sokeOrd = $("#sokeOrd").val();
  if(sokeOrd == "")
  { 
	updateResultDiv("<b>Vær vennlig å skrive inn et ord eller en setning du vil søke etter.</b>");
	return;
  }
	var query = getSparQLquery(sokeOrd);
	console.log("Query:" + query);

	updateResultDiv('<img width="50" src="https://pfdk.github.io/data-udir-no/eksempler/loading.gif"/>');

	GrepAPI.sparqlQuery(query, function(data) {
	 present(data);
	});
}
function updateResultDiv(html)
{
	$("#resultat").html(html);	
}
function presentLaereplan(binding)
{
	//Her har jeg satt inn http://www.udir.no/kl06/ foran læreplankoden som jeg har har kalt ?laereplan i spørringen.
  var s = "<tr><td><a target=top href='http://www.udir.no/kl06/" + binding.laereplan.value + "'>" + binding.kmkode.value + ":" + binding.laereplantittel.value + "</a></td>";
  console.log(s);
  return s;
}
function presentAarstrinn(binding)
{
  var s ="<td>" + binding.trinn.value + "</td>";
  console.log(s);
  return s;
}

function presentLaereplanmaal(binding)
{
  var s ="<td>" + binding.kmtekst.value + "</td></tr>";
  console.log(s);
  return s;
}


function present(data)
{
	var bindings = data.results.bindings;
	var html = "<table><tr><th>Læreplan</th><th>Årstrinn</th><th>Kompetansemål</th></tr>";
	var previousLaereplan = "";
	var laereplan = "";

	for(var i = 0; i< bindings.length; i++)
	{
		laereplan = bindings[i].laereplan.value;
		console.log(laereplan);
		html += "<tr>";
		if(previousLaereplan != laereplan)
		{
			console.log(laereplan + "!=" + previousLaereplan);
		    html += presentLaereplan(bindings[i]);
			previousLaereplan = laereplan;
		}
		else
		{
			html += "<td></td>";
		}
		html += presentAarstrinn(bindings[i]);
		html += presentLaereplanmaal(bindings[i]);
	}
	html += "</table>";
	updateResultDiv(html);	
}

//Finn mer inspirasjon her
//http://grepwiki.udir.no/index.php?title=SPARQL-sp%C3%B8rringer#Teksts.C3.B8k_i_kompetansem.C3.A5l_for_.C3.A5_finne_l.C3.A6replan
//https://www.openlinksw.com/blog/~kidehen/index.vspx?page=&id=1653
//https://stackoverflow.com/questions/7163639/how-to-use-json-output-from-external-sparql-request-directly-from-browser
//http://biohackathon.org/d3sparql/
//https://stackoverflow.com/questions/15298091/d3-sparql-how-to-query-sparql-endpoints-directly-from-d3js
