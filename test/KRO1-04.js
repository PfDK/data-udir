var words = [
  {text: 'praktisere', size: 1, href:'p.html#praktisere'},
  {text: 'ulike', size: 2, href:'u.html#ulike'},
  {text: 'seg', size: 3, href:'s.html#seg'},
  {text: 'bruke', size: 4, href:'b.html#bruke'},
  {text: 'trening', size: 4, href:'t.html#trening'},
  {text: 'gjere', size: 5, href:'g.html#gjere'},
  {text: 'helse', size: 6, href:'h.html#helse'},
  {text: 'rørsleaktivitetar', size: 7, href:'r.html#rørsleaktivitetar'},
  {text: 'aktivitetar', size: 7, href:'a.html#aktivitetar'},
  {text: 'vatn', size: 7, href:'v.html#vatn'},
  {text: 'utføre', size: 7, href:'u.html#utføre'},
  {text: 'orientere', size: 8, href:'o.html#orientere'},
  {text: 'forklare', size: 8, href:'f.html#forklare'},
  {text: 'eiga', size: 8, href:'e.html#eiga'},
  {text: 'greie', size: 8, href:'g.html#greie'},
  {text: 'grunnleggjande', size: 8, href:'g.html#grunnleggjande'},
  {text: 'enkle', size: 8, href:'e.html#enkle'},
  {text: 'aktivitet', size: 9, href:'a.html#aktivitet'},
  {text: 'gjennomføre', size: 9, href:'g.html#gjennomføre'},
  {text: 'planleggje', size: 9, href:'p.html#planleggje'},
  {text: 'prinsipp', size: 9, href:'p.html#prinsipp'},
  {text: 'idrettar', size: 9, href:'i.html#idrettar'},
  {text: 'varierte', size: 10, href:'v.html#varierte'},
  {text: 'alternative', size: 10, href:'a.html#alternative'},
  {text: 'vere', size: 10, href:'v.html#vere'},
  {text: 'ferdigheiter', size: 10, href:'f.html#ferdigheiter'},
  {text: 'utvalde', size: 10, href:'u.html#utvalde'},
  {text: 'eigen', size: 11, href:'e.html#eigen'},
  {text: 'trygg', size: 11, href:'t.html#trygg'},
  {text: 'vurdere', size: 11, href:'v.html#vurdere'},
  {text: 'kart', size: 11, href:'k.html#kart'},
  {text: 'under', size: 11, href:'u.html#under'},
  {text: 'individuelle', size: 11, href:'i.html#individuelle'},
  {text: 'lagidrettar', size: 11, href:'l.html#lagidrettar'},
  {text: 'fair', size: 11, href:'f.html#fair'},
  {text: 'play', size: 11, href:'p.html#play'},
  {text: 'utvikle', size: 11, href:'u.html#utvikle'},
  {text: 'leike', size: 11, href:'l.html#leike'},
  {text: 'bruk', size: 11, href:'b.html#bruk'},
  {text: 'uthald', size: 12, href:'u.html#uthald'},
  {text: 'ferdsel', size: 12, href:'f.html#ferdsel'},
  {text: 'nokre', size: 12, href:'n.html#nokre'},
  {text: 'reglar', size: 12, href:'r.html#reglar'},
  {text: 'dans', size: 12, href:'d.html#dans'},
  {text: 'funksjonell', size: 12, href:'f.html#funksjonell'},
  {text: 'treningsmetodar', size: 12, href:'t.html#treningsmetodar'},
  {text: 'naturen', size: 12, href:'n.html#naturen'},
  {text: 'kulturar', size: 12, href:'k.html#kulturar'},
  {text: 'fysisk', size: 12, href:'f.html#fysisk'},
  {text: 'dansar', size: 12, href:'d.html#dansar'},
  {text: 'mellom', size: 12, href:'m.html#mellom'},
  {text: 'ta', size: 12, href:'t.html#ta'},
  {text: 'førstehjelp', size: 12, href:'f.html#førstehjelp'},
  {text: 'magen', size: 12, href:'m.html#magen'},
  {text: 'svømme', size: 12, href:'s.html#svømme'},
  {text: 'skape', size: 12, href:'s.html#skape'},
  {text: 'friluftsliv', size: 12, href:'f.html#friluftsliv'},
  {text: 'flyte', size: 12, href:'f.html#flyte'},
  {text: 'øvingar', size: 12, href:'oe.html#øvingar'},
  {text: 'kropp', size: 12, href:'k.html#kropp'},
  {text: 'der', size: 12, href:'d.html#der'},
  {text: 'livsstil', size: 12, href:'l.html#livsstil'},
  {text: 'korleis', size: 12, href:'k.html#korleis'},
  {text: 'føresetnader', size: 13, href:'f.html#føresetnader'},
  {text: 'koordinasjon', size: 13, href:'k.html#koordinasjon'},
  {text: 'rørsler', size: 13, href:'r.html#rørsler'},
  {text: 'rulle', size: 13, href:'r.html#rulle'},
  {text: 'påverkar', size: 13, href:'p.html#påverkar'},
  {text: 'dykke', size: 13, href:'d.html#dykke'},
  {text: 'uti', size: 13, href:'u.html#uti'},
  {text: 'relevant', size: 13, href:'r.html#relevant'},
  {text: '100', size: 13, href:'1.html#100'},
  {text: 'meter', size: 13, href:'m.html#meter'},
  {text: 'over', size: 13, href:'o.html#over'},
  {text: 'drøfte', size: 13, href:'d.html#drøfte'},
  {text: 'hjelp', size: 13, href:'h.html#hjelp'},
  {text: 'naturmiljø', size: 13, href:'n.html#naturmiljø'},
  {text: 'førebyggje', size: 13, href:'f.html#førebyggje'},
  {text: 'måtar', size: 13, href:'m.html#måtar'},
  {text: 'kroppslege', size: 13, href:'k.html#kroppslege'},
  {text: 'kompass', size: 13, href:'k.html#kompass'},
  {text: 'sjølv', size: 13, href:'s.html#sjølv'},
  {text: 'spel', size: 13, href:'s.html#spel'},
  {text: 'dansekomposisjonar', size: 13, href:'d.html#dansekomposisjonar'},
  {text: 'idrett', size: 13, href:'i.html#idrett'},
  {text: 'ski', size: 13, href:'s.html#ski'},
  {text: 'ligg', size: 13, href:'l.html#ligg'},
  {text: 'rette', size: 13, href:'r.html#rette'},
  {text: 'gode', size: 13, href:'g.html#gode'},
  {text: 'kunnskapar', size: 13, href:'k.html#kunnskapar'},
  {text: 'kunne', size: 13, href:'k.html#kunne'},
  {text: 'forbetre', size: 13, href:'f.html#forbetre'},
  {text: 'følgje', size: 13, href:'f.html#følgje'},
  {text: 'leik', size: 13, href:'l.html#leik'},
  {text: 'teknikkar', size: 13, href:'t.html#teknikkar'},
  {text: 'samspel', size: 13, href:'s.html#samspel'},
  {text: 'ivareta', size: 13, href:'i.html#ivareta'},
  {text: 'rørsleevne', size: 13, href:'r.html#rørsleevne'},
  {text: 'styrke', size: 13, href:'s.html#styrke'},
  {text: 'eksperimentere', size: 13, href:'e.html#eksperimentere'},
  {text: 'trene', size: 13, href:'t.html#trene'},
  {text: 'terreng', size: 13, href:'t.html#terreng'},
  {text: 'balltypar', size: 14, href:'b.html#balltypar'},
  {text: 'tradisjon', size: 14, href:'t.html#tradisjon'},
  {text: 'samisk', size: 14, href:'s.html#samisk'},
  {text: 'røter', size: 14, href:'r.html#røter'},
  {text: 'overnattingstur', size: 14, href:'o.html#overnattingstur'},
  {text: 'uavhengig', size: 14, href:'u.html#uavhengig'},
  {text: 'danseformer', size: 14, href:'d.html#danseformer'},
  {text: 'vêrtilhøve', size: 14, href:'v.html#vêrtilhøve'},
  {text: 'friluftslivsaktivitetar', size: 14, href:'f.html#friluftslivsaktivitetar'},
  {text: 'friluftslivstradisjonar', size: 14, href:'f.html#friluftslivstradisjonar'},
  {text: 'lokale', size: 14, href:'l.html#lokale'},
  {text: 'fortelje', size: 14, href:'f.html#fortelje'},
  {text: 'inkludere', size: 14, href:'i.html#inkludere'},
  {text: 'kjent', size: 14, href:'k.html#kjent'},
  {text: 'dag', size: 14, href:'d.html#dag'},
  {text: 'kvar', size: 14, href:'k.html#kvar'},
  {text: 'viktig', size: 14, href:'v.html#viktig'},
  {text: 'lokal', size: 14, href:'l.html#lokal'},
  {text: 'forankring', size: 14, href:'f.html#forankring'},
  {text: 'kvifor', size: 14, href:'k.html#kvifor'},
  {text: 'framkomstmiddel', size: 14, href:'f.html#framkomstmiddel'},
  {text: 'sykkel', size: 14, href:'s.html#sykkel'},
  {text: 'faktorar', size: 14, href:'f.html#faktorar'},
  {text: 'danse', size: 14, href:'d.html#danse'},
  {text: 'uttrykk', size: 14, href:'u.html#uttrykk'},
  {text: 'sentrale', size: 14, href:'s.html#sentrale'},
  {text: 'skøyteteknikkar', size: 14, href:'s.html#skøyteteknikkar'},
  {text: 'motivasjonen', size: 14, href:'m.html#motivasjonen'},
  {text: 'innanfor', size: 14, href:'i.html#innanfor'},
  {text: 'effektive', size: 14, href:'e.html#effektive'},
  {text: 'svømmeteknikkar', size: 14, href:'s.html#svømmeteknikkar'},
  {text: 'lengre', size: 14, href:'l.html#lengre'},
  {text: 'rørslemønster', size: 14, href:'r.html#rørslemønster'},
  {text: 'resultata', size: 14, href:'r.html#resultata'},
  {text: 'respektere', size: 14, href:'r.html#respektere'},
  {text: 'distanse', size: 14, href:'d.html#distanse'},
  {text: 'samhandling', size: 14, href:'s.html#samhandling'},
  {text: 'oppvarming', size: 14, href:'o.html#oppvarming'},
  {text: 'vêrforhold', size: 14, href:'v.html#vêrforhold'},
  {text: 'sikkerheitsvurderingar', size: 14, href:'s.html#sikkerheitsvurderingar'},
  {text: 'risiko', size: 14, href:'r.html#risiko'},
  {text: 'berge', size: 14, href:'b.html#berge'},
  {text: 'uttøying', size: 14, href:'u.html#uttøying'},
  {text: 'sida', size: 14, href:'s.html#sida'},
  {text: 'ryggen', size: 14, href:'r.html#ryggen'},
  {text: 'svømming', size: 14, href:'s.html#svømming'},
  {text: 'basert', size: 14, href:'b.html#basert'},
  {text: 'utvikling', size: 14, href:'u.html#utvikling'},
  {text: 'kroppsleg', size: 14, href:'k.html#kroppsleg'},
  {text: 'anna', size: 14, href:'a.html#anna'},
  {text: 'før', size: 14, href:'f.html#før'},
  {text: 'fremjar', size: 14, href:'f.html#fremjar'},
  {text: 'målsetjing', size: 14, href:'m.html#målsetjing'},
  {text: 'delta', size: 14, href:'d.html#delta'},
  {text: 'syklistar', size: 14, href:'s.html#syklistar'},
  {text: 'fotgjengarar', size: 14, href:'f.html#fotgjengarar'},
  {text: 'trafikkreglar', size: 14, href:'t.html#trafikkreglar'},
  {text: 'idrettsskadar', size: 14, href:'i.html#idrettsskadar'},
  {text: 'trivsel', size: 14, href:'t.html#trivsel'},
  {text: 'treningsaktivitetar', size: 14, href:'t.html#treningsaktivitetar'},
  {text: 'andres', size: 14, href:'a.html#andres'},
  {text: 'overføre', size: 14, href:'o.html#overføre'},
  {text: 'seie', size: 14, href:'s.html#seie'},
  {text: 'har', size: 14, href:'h.html#har'},
  {text: 'hygiene', size: 14, href:'h.html#hygiene'},
  {text: 'personleg', size: 14, href:'p.html#personleg'},
  {text: 'gje', size: 14, href:'g.html#gje'},
  {text: 'rørslemåtar', size: 14, href:'r.html#rørslemåtar'},
  {text: 'kroppsdelar', size: 14, href:'k.html#kroppsdelar'},
  {text: 'namn', size: 14, href:'n.html#namn'},
  {text: 'setje', size: 14, href:'s.html#setje'},
  {text: 'teknikk', size: 14, href:'t.html#teknikk'},
  {text: 'sporlaus', size: 14, href:'s.html#sporlaus'},
  {text: 'taktikk', size: 14, href:'t.html#taktikk'},
  {text: 'eigne', size: 14, href:'e.html#eigne'},
  {text: 'opphald', size: 14, href:'o.html#opphald'},
  {text: 'gjeld', size: 14, href:'g.html#gjeld'},
  {text: 'evne', size: 14, href:'e.html#evne'},
  {text: 'samtale', size: 14, href:'s.html#samtale'},
  {text: 'måte', size: 14, href:'m.html#måte'},
  {text: 'rekreasjon', size: 14, href:'r.html#rekreasjon'},
  {text: 'skadar', size: 14, href:'s.html#skadar'},
  {text: 'belastningslidingar', size: 14, href:'b.html#belastningslidingar'},
  {text: 'opphalde', size: 14, href:'o.html#opphalde'},
  {text: 'bruksreiskapar', size: 14, href:'b.html#bruksreiskapar'},
  {text: 'utstyr', size: 14, href:'u.html#utstyr'},
  {text: 'klede', size: 14, href:'k.html#klede'},
  {text: 'nærområdet', size: 14, href:'n.html#nærområdet'},
  {text: 'arbeidsteknikkar', size: 14, href:'a.html#arbeidsteknikkar'},
  {text: 'lage', size: 14, href:'l.html#lage'},
  {text: 'utøve', size: 14, href:'u.html#utøve'},
  {text: 'ungdomskulturar', size: 14, href:'u.html#ungdomskulturar'},
  {text: 'skøyter', size: 14, href:'s.html#skøyter'},
  {text: 'saman', size: 14, href:'s.html#saman'},
  {text: 'arbeidsstillingar', size: 14, href:'a.html#arbeidsstillingar'},
  {text: 'vise', size: 14, href:'v.html#vise'},
  {text: 'songleikar', size: 14, href:'s.html#songleikar'},
  {text: 'musikk', size: 14, href:'m.html#musikk'},
  {text: 'rytmar', size: 14, href:'r.html#rytmar'},
  {text: 'uttrykkje', size: 14, href:'u.html#uttrykkje'},
  {text: 'utforske', size: 14, href:'u.html#utforske'},
  {text: 'ballspel', size: 14, href:'b.html#ballspel'},
  {text: 'medelevar', size: 14, href:'m.html#medelevar'},
  {text: 'enkel', size: 14, href:'e.html#enkel'},
  {text: 'mot', size: 14, href:'m.html#mot'},
  {text: 'avlevere', size: 14, href:'a.html#avlevere'},
  {text: 'gjennom', size: 14, href:'g.html#gjennom'},
  {text: 'deltaking', size: 14, href:'d.html#deltaking'},
  {text: 'tradisjonelle', size: 14, href:'t.html#tradisjonelle'},
  {text: 'apparat', size: 14, href:'a.html#apparat'},
  {text: 'småreiskapar', size: 14, href:'s.html#småreiskapar'},
  {text: 'livberging', size: 14, href:'l.html#livberging'},
  {text: 'livbergande', size: 14, href:'l.html#livbergande'},
  {text: 'kompetanse', size: 14, href:'k.html#kompetanse'},
  {text: 'skilnader', size: 14, href:'s.html#skilnader'},
  {text: 'kroppsideal', size: 14, href:'k.html#kroppsideal'},
  {text: 'variert', size: 14, href:'v.html#variert'},
  {text: 'anerkjenne', size: 14, href:'a.html#anerkjenne'},
  {text: 'vidare', size: 14, href:'v.html#vidare'},
  {text: 'samhandle', size: 14, href:'s.html#samhandle'},
  {text: 'allemannsretten', size: 14, href:'a.html#allemannsretten'},
  {text: 'tilkalle', size: 14, href:'t.html#tilkalle'},
  {text: 'farane', size: 14, href:'f.html#farane'},
  {text: 'turar', size: 14, href:'t.html#turar'},
  {text: 'utøving', size: 14, href:'u.html#utøving'},
  {text: 'trygt', size: 14, href:'t.html#trygt'},
  {text: 'ferdast', size: 14, href:'f.html#ferdast'},
  {text: 'land', size: 14, href:'l.html#land'},
  {text: 'opp', size: 14, href:'o.html#opp'},
  {text: 'påverke', size: 14, href:'p.html#påverke'},
  {text: 'rygg', size: 14, href:'r.html#rygg'},
  {text: 'så', size: 14, href:'s.html#så'},
  {text: 'rygg;', size: 14, href:'r.html#rygg;'},
  {text: 'årstider', size: 14, href:'aa.html#årstider'},
  {text: 'imens', size: 14, href:'i.html#imens'},
  {text: 'minutt', size: 14, href:'m.html#minutt'},
  {text: '3', size: 14, href:'3.html#3'},
  {text: 'kvile', size: 14, href:'k.html#kvile'},
  {text: 'stoppe', size: 14, href:'s.html#stoppe'},
  {text: 'hendene', size: 14, href:'h.html#hendene'},
  {text: 'gjenstand', size: 14, href:'g.html#gjenstand'},
  {text: 'hente', size: 14, href:'h.html#hente'},
  {text: 'ned', size: 14, href:'n.html#ned'},
  {text: 'undervegs', size: 14, href:'u.html#undervegs'},
  {text: 'turopplegg', size: 14, href:'t.html#turopplegg'},
  {text: 'også', size: 14, href:'o.html#også'},
  {text: 'overnatting', size: 14, href:'o.html#overnatting'},
  {text: 'grunngje', size: 14, href:'g.html#grunngje'},
  {text: 'djupt', size: 14, href:'d.html#djupt'},
  {text: 'falle', size: 14, href:'f.html#falle'},
  {text: 'svømmedyktig', size: 14, href:'s.html#svømmedyktig'},
  {text: 'ute', size: 14, href:'u.html#ute'},
  {text: 'fremje', size: 14, href:'f.html#fremje'},
  {text: 'moglege', size: 14, href:'m.html#moglege'},
  {text: 'treningsformer', size: 14, href:'t.html#treningsformer'},
  {text: 'hoppe', size: 14, href:'h.html#hoppe'},
  {text: 'framdrift', size: 14, href:'f.html#framdrift'},
  {text: 'uheldige', size: 14, href:'u.html#uheldige'},
  {text: 'gli', size: 14, href:'g.html#gli'},
  {text: 'sider', size: 14, href:'s.html#sider'},
  {text: 'ernæring', size: 14, href:'e.html#ernæring'},
  {text: 'vasstilvenning', size: 14, href:'v.html#vasstilvenning'},
  {text: 'eigentrening', size: 14, href:'e.html#eigentrening'},
  {text: 'organiserte', size: 14, href:'o.html#organiserte'},
  {text: 'utfolding', size: 14, href:'u.html#utfolding'},
  {text: 'fri', size: 14, href:'f.html#fri'},
  {text: 'rørslekultur', size: 14, href:'r.html#rørslekultur'},
  {text: 'vende', size: 14, href:'v.html#vende'},
  {text: 'lande', size: 14, href:'l.html#lande'},
  {text: 'satse', size: 14, href:'s.html#satse'},
  {text: 'hinke', size: 14, href:'h.html#hinke'},
  {text: 'springe', size: 14, href:'s.html#springe'},
  {text: 'gå', size: 14, href:'g.html#gå'},
  {text: 'krype', size: 14, href:'k.html#krype'},
  {text: 'ulik', size: 14, href:'u.html#ulik'},
  {text: 'byggjer', size: 14, href:'b.html#byggjer'},
  {text: 'måla', size: 14, href:'m.html#måla'},
  {text: 'utfordra', size: 14, href:'u.html#utfordra'},
  {text: 'blir', size: 14, href:'b.html#blir'},
  {text: 'samanhengen', size: 14, href:'s.html#samanhengen'},
  {text: 'motorikk', size: 14, href:'m.html#motorikk'},
  {text: 'sansar', size: 14, href:'s.html#sansar'},
  {text: 'eleven', size: 14, href:'e.html#eleven'},
  {text: 'miljø', size: 14, href:'m.html#miljø'},
  {text: 'samanhengar', size: 14, href:'s.html#samanhengar'},
  {text: 'regelmessig', size: 14, href:'r.html#regelmessig'},
  {text: 'inneber', size: 14, href:'i.html#inneber'},
  {text: 'ansvar', size: 14, href:'a.html#ansvar'},

];