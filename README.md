# data-udir

Scripts for å hente ut data fra data.udir.no og lage presentasjoner av innholdet for web. Vi anbefaler deg å ta kurset "Grep" i kursportalen til UDIR, [kurs.udir.no](https://kurs.udir.no)

# Eksempler på hva du kan gjøre med javascript og html
I mappen [https://github.com/PfDK/PfDK.github.io/tree/master/data-udir-no/eksempler](https://github.com/PfDK/PfDK.github.io/tree/master/data-udir-no/eksempler) finner du kildekoden til eksempler med html og javascript for å f.eks. søke etter ord og setninger i læreplanene, vise en læreplan som en ordsky og vise felles ord på tvers av læreplaner som ordsky. Sistnevnte eksempel kan f.eks. egne seg til å finne tverrfaglige muligheter.

Se eksempelkoden live her:

- [Søk i læreplanene](PfDK.github.io/data-udir-no/eksempler/soek/sparql.html)
- [Læreplan som ordsky](https://pfdk.github.io/data-udir-no/eksempler/ordsky/ordsky.html)
- [Tverrfaglighet som ordsky](https://pfdk.github.io/data-udir-no/eksempler/tverrfaglig/tverrfaglig.html)

# Eksempler på hva du kan gjøre med ruby, javascript og html

Det er totalt mange hundre læreplaner. Dersom man skal analysere innholdet i alle disse kan det være tidkrevende å hente ned disse fra Grep. I stedet kan man laste de ned en gang, gjøre nødvendig analyse, lagre resultatet av analysen og presentere denne. Ruby er et programmeringspråk som enkelt lar deg hente ned data og analysere disse.

Nedenfor viser jeg hvordan jeg lastet ned alle læreplanene med Ruby for å finne ut hvilke ord som blir brukt mest, og hvordan jeg presenterte resultatet som ordsky. Resultatet ser slik ut: [læreplanene som ordskyer](https://www.erlendthune.com/lp/wordcloud)

## Ruby

Dersom du er på mac har du allerede programmet ruby installert. Dersom du er på pc kan du installere det [https://www.ruby-lang.org/en/documentation/installation/#rubyinstaller](herfra).

## Last ned nødvendig kode

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
