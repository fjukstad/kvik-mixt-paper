# Background
Snakk litt om de forskjellige systemene i hver disciplin
--> Standing on the shoulders of giants
Analysis frameworks: R, Bioconductor, Galaxy
Visualization: Cytoscape, BioJS, D3
Databases: MSiGDB, KEGG, GeneCards, PubMed
Reproducibility: Docker, R Packages, Kube
Parallelized and distributed computation: Hadoop, Spark, Kubernets, Azure

Analysis frameworks: Bioconductor in R, Python.
Visualization: Cytoscpape, D3, BioJS.
Databases: MSigDB, KEGG, PubMed.

Data wrangling and analysis done in R or other languages.
Visualization and presentation of final datasets by external tools.
Manual database lookup is tedious and gets out of date.

Related work: OpenCPU, biogo, renjin,

LAB: overodnet, så er det en grei intro i Kvik Framework, så den kan kanskje
modifiseres hvis ikke det er en helt annen vinkling i dette paperet

LAB: forlag til struktur i Intro:

1. Jeg ville begynt med å beskrive "explorative data analysis" for å tolke
 eksperiment data. Motiver behovet for visualisering + statistisk analyse +
 referenase databaser. Jeg tror §1 og §2 fra "Kvik Framework.docx" kan brukes
 som utgangspunkt (men med System Epidemiology fjernet). Konklusjon: det er
 stort behov for slike verktøy.

BF: Tror det her egentlig er mer snakk om tolkning av resultater enn
'explorative data analysis'. Hvertfall i mitt hode er 'explorative data
analysis' noe man gjør i R, man laster inn data, prøver ut forskjellige typer
analyser og ser hvordan ting ser ut. Dette er ikke nødvendigvis det vi trenger
Kvik til. Kvik kan brukes når man allerede har plugget inn dataen sin, og
prøvd ut noen ting før man vil dele det med andre. 

2. Deretter ville jeg beskrevet behovet for å lage spesialiserte data
 exploration verktøy. Jeg tror "Such special purpose..." § fra Framwork kan
 omskrives. Konklusjon: det er behov for å raskt kunne skrive exploration apps
 prototyper. Reviwerene av app note likte dette poenget, og i mitt hode er
 dette hoved målet/bidraget i dette paperet.

BF: Enig. Man kan jo egentlig tenke litt på det som en iPython Notebook / R
Notebook, bare som er skikkelig verktøy. 

3. Jeg er usikker på om vi skal argumentere for at det ofte blir behov for å
  skalere/ optimalisere/ deploye de prototype appene. Det passer kanskje godt
  med bidraget i dette paperet?

BF: Tja, hvertfall at performance er viktig når det kommer til større analyser
er jo et poeng. Vi kan jo la det ligge litt og se hva vi får ut. Når det
kommer til hva som er gjort kan vi jo si at kvik er raskere enn opencpu. 

4. Requirements mener jeg er:
   i. "JavaScript + R"
  ii. Easy to add new functionality (viz or stat)
 iii. Short reponse times
  iv. Reference databases: up-to-date with provenance and space effecient storage
   v. Integration with (big data/ distributed) data analysis and exploration engines
  vi. Noe jeg ikke har fått med meg?

BF: 
  i: AnyLang + R 
  ii. Mulighet for å installere egne/andres R-pakker 
  iii. Fast (short response times) 
  iv: up-to-date reference databases
  v: 
  

5. Deretter hvorfor previous work ikke løser alle 5
6. Hva Kvik er:
   i. Lag mellom viz & stat & DBs (merk usikker på hvor input/output data passer inn)

           JavaScript (Visualization)
                       ||
Inpup/output data? == KVIK == Reference databases
                    //   \\
R (Statistical analysis)  Other engines (scale/speed)


 ii. Abstraksjoner/ interfaces som gjør det raskt å protype exploration apps
 iii/v. En slags execution engine som router requests til rett sted. Dvs den tilbyr funksjonalitet i seg selv (ikke sikker på hva dette er :)
BF: Denne må du fortelle meg hva er, skjønner ikke helt her. 

 iv. Caching, logging, etc. Dette er en viktig bit vil jeg tro, særlig når ref DBs begynner å bli veldig store.
BF: Yes, det som er på plass nå er caching av alt av DB requests (om jeg ikke
  husker feil) 

7. Contributions:
 i. Approach for vis + stat + DB m. enkel implementering
 ii. Demonstrasjon ved å ha implementert 3-4 apps
 iii. Performance evaluation

# Motivating example 

# Building apps
The big issue: There is no link between analysis and final presentation

Gir dette mening?
Collection of packages in the Go programming language for building data
exploration applications.  Interfaces with popular online databases such as
MSigDB and KEGG.  Provides an interface to the R programming language.
Typically used to build web apps, but commandline tools are also possible!

LAB: denne bør begynne med Architecture/overview: ASCII figuren fra Intro,
kanskje litt rafinert:
 * Interface mot JavaScript er en mer generell REST API, så kan være cli eller
 noe annet som bruker den.
 * Reference databases er kanskje en egen "ting" i Kvik. Dvs abstraksjoner som
 gjør det enkelt å implementere disse for MSigDB, KEGG. Dvs de tar seg av
 caching og provenance.

Her passer det også å vise hvordan MIxT mappes til figuren. 

LAB: jeg tenker på dette som en slags execution engine, og at dette er laget
mellom R og JS. 
Hva slags interface exporter den til JS? Og hvorfor?
Hva gjør den? Og hvorfor kan ikke dette gjøres i JS eller R?
Hva er det som er generelt? Og hva er app spesifikt?
Hva er gjort for å få god performance?
Andre ting denne tar seg av?
Hvorfor, og hvordan, det er lett å legge til ny funksjonalitet

# Stats 
LAB: jeg tenker på dette som en måte å implementere støtte for ulike refDBs.
Dvs den tilbyr abstraksjoner/ data strukturer/ wrappere/ metoder for:
* Hente data fra online DBs (feilhåndtering, etc)
* Caching av data hentet fra online DBs
* Provenance logging / managemnt for data fra online DBs
* En måte å effektivt lagre disse DB på, både for god performance og lite
space
* En måte å gjenbruke kode (og data) for en DB som feks KEGG
* Eventuelt andre ting denne tar seg av?

I tillegg:
Hvorfor ikke gjøre dette i JS eller R?
Hvordan implementerer man KEGG etc?

# Motivating example 
MIxT.
Interactive web application for exploring WGCNA modules from blood and biopsy.
Integrate results with known genesets and online databases.
Docker containers for reproducibility and portability.
Data analysis: R package  + Kvik = R in the browser.
Visualization: D3, SigmaJS, R Plots
How can we improve Kvik and its features: R user input sanitation, security,

Data analyse og livet: 
Det som oftest gjøres er at man skriver et R-scriot

# Design and implementation
LAB: Questions:
1. Er execution engine raskere en andre alternativer? Svar: måle mot andre
alternativer.
2. Gir ref DB caching bedre performance? Svar: som i master thesis.
3. Har provenance mangement høy overhead (response tid & storage)? Svar: måle
disse.
4. Er det lett å legge til ny funksjonalitet (viz & stat & optimizations)?
Svar: beskrive hvordan ikke-MIxT apps ble laget
5. Er Kvik apps raske? Svar: performance analyze av MiXT, inkl. bottlenecks,
skalerbarhet, etc.
6. Er Kvik apps enkle å utvikle/vedlikeholde? Svar: beskrive hvordan MiXT ble
laget (fra mess til den vakre nåværende kodebasen).


