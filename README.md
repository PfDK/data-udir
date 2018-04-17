# data-udir

Scripts for å hente ut data fra data.udir.no og lage presentasjoner av innholdet for web.

# Søk i læreplanene med javascript og html
I mappen (https://PfDK.github.io/data-udir-no/eksempler/) finner du eksempler med html og javascript for å f.eks. søke etter ord og setninger i læreplanene.

# Slik kan du lage ordskyer av læreplanene

Ved å følge instruksjonene nedenfor kan du lage ordskyer over alle læreplanene. Resultatet ser slik ut: [læreplanene som ordskyer](https://www.erlendthune.com/lp/wordcloud)

### ruby
Siden det ville tatt mye tid å hente ned alle læreplanene og analysere disse hver gang man ønsker å lage ordskyene, henter jeg i stedet først ned læreplanene fra Grep ved hjelp av programmeringsspråket ruby.

Dersom du er på mac har du allerede programmet ruby installert. Dersom du er på pc kan du installere det [https://www.ruby-lang.org/en/documentation/installation/#rubyinstaller](herfra).

## Fremgangsmåte med ruby

- Gå inn på https://github.com/wvengen/d3-wordcloud og velg "Clone or download->Download ZIP".
- Pakk ut zip-filen.
- Gå inn på https://github.com/PfDK/data-udir og gjør det samme med den pakken.

Nå skal du ha fått to mapper:

- d3-wordcloud-master
- data-udir-master


### Last ned informasjon om alle læreplanene
Gå inn i `d3-wordcloud-master` og opprett en mappe du kaller for `ordskyer` og en du kaller for `ordskyerhtml`. Gå inn i mappen `ordskyer` og skriv følgende kommando:

```ruby ../../data-udir-master/ruby/getallelp.rb```

Ruby laster nå ned alle læreplanene og lagrer de til filer i ordskyer mappen.

### Lag alfabetisk oversikt over alle læreplanene

```ruby ../../data-udir-master/ruby/tverrfaglig.rb```

Oppretter filer `a.html`, `b.html`, ... som lister opp alle ord som brukes i læreplanene som begynner på a, b, ... samt hvilke læreplaner disse brukes i.

### Lag ordsky over ordene i hver av læreplanene

```ruby ../../data-udir-master/ruby/grepalleord.rb```

Oppretter frekvensoversikter over de mest brukte ordene i læreplanene med tilhørende html-filer som viser ordene som ordskyer.

### Lag ordsky over ordene i alle læreplanene

```ruby ../../data-udir-master/ruby/grepalleordoversikt.rb```

Oppretter filen `alle.js` som inneholder en frekvensoversikt over de mest brukte ordene på tvers av læreplanene. Ordene i denne filen vises som ordsky i filen `alle.html` som også inneholder lenker til hver enkelt læreplan som ordsky.

# Digitale ferdigheter

Det første scriptet jeg lagde for å se om jeg klarte å hente ut data fra Grep var `dataudir.rb`. Dersom du kjører

```ruby dataudir.rb```

Så opprettes filen `dataudir.html` som lister opp de digitale ferdighetene man skal kunne i alle fag.



# data fra udir

Les mer om data.udir.no her: http://data.udir.no/
