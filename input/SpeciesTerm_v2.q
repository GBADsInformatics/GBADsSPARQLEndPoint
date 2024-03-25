[QueryItem="GetAllCattle"]
PREFIX : <https://gbadske.org/ontologies/2024/2/SpeciesTerm#>

SELECT DISTINCT ?species {
  ?cattle a :All_Cattle ; :species ?species .
}
[QueryItem="GetAllCattleByCountry"]
PREFIX : <https://gbadske.org/ontologies/2024/2/SpeciesTerm#>

SELECT DISTINCT ?species ?country { 
  ?cattle a :All_Cattle ; :species ?species ; :country ?country .
  FILTER (?country = 'Albania'^^xsd:string ) . 
}
[QueryItem="GetAllCattleByCountryYear"]
PREFIX : <https://gbadske.org/ontologies/2024/2/SpeciesTerm#>

SELECT DISTINCT ?species ?country ?year { 
  ?cattle a :All_Cattle ; :species ?species ; :country ?country ; :year ?year .
  FILTER (?country = "Albania"^^xsd:string  && ?year = "1961"^^xsd:string) . 
}
[QueryItem="GetAllPoultry"]
PREFIX : <https://gbadske.org/ontologies/2024/2/SpeciesTerm#>

SELECT DISTINCT ?species {
  ?chicken a :All_Poultry ; :species ?species .
}
[QueryItem="GetAllPoultryByCountry"]
PREFIX : <https://gbadske.org/ontologies/2024/2/SpeciesTerm#>

SELECT DISTINCT ?species ?country { 
  ?chicken a :All_Poultry ; :species ?species ; :country ?country .
  FILTER (?country = "Albania"^^xsd:string ) . 
}
[QueryItem="GetAllPoultryByCountryYear"]
PREFIX : <https://gbadske.org/ontologies/2024/2/SpeciesTerm#>

SELECT DISTINCT ?species ?country ?year { 
  ?chicken a :All_Poultry ; :species ?species ; :country ?country ; :year ?year .
  FILTER (?country = "Albania"^^xsd:string  && ?year = "1961"^^xsd:string) . 
}
[QueryItem="GetAllCattle_Ethiopia"]
PREFIX : <https://gbadske.org/ontologies/2024/2/SpeciesTerm#>

SELECT DISTINCT ?species ?country ?year {
  ?cattle a :All_Cattle ; :species ?species ; :country ?country ; :year ?year .
  FILTER (?country = "Ethiopia"^^xsd:string ) . 
}
[QueryItem="GetAllPoultry_Ethiopia"]
PREFIX : <https://gbadske.org/ontologies/2024/2/SpeciesTerm#>

SELECT DISTINCT ?species ?country { 
  ?chicken a :All_Poultry ; :species ?species ; :country ?country .
  FILTER (?country = "Ethiopia"^^xsd:string ) . 
}
[QueryItem="GetAllCattleFromYear"]
PREFIX : <https://gbadske.org/ontologies/2024/2/SpeciesTerm#>

SELECT DISTINCT ?species { 
  ?cattle a :All_Cattle ; :species ?species ; :country ?country ; :year ?year .
  FILTER (?country = "Albania"^^xsd:string  && ?year > "2017"^^xsd:string) . 
}
[QueryItem="GetAllCattleOfCountries"]
PREFIX : <https://gbadske.org/ontologies/2024/2/SpeciesTerm#>

SELECT DISTINCT ?species {
  ?cattle a :All_Cattle ; :species ?species ; :country ?country .
  FILTER (?country IN ("Ethiopia"^^xsd:string, "Albania"^^xsd:string) ) . 
}
[QueryItem="CheckAllCattleSpecies"]
PREFIX : <https://gbadske.org/ontologies/2024/2/SpeciesTerm#>

SELECT (COUNT(DISTINCT ?species) AS ?count) ("All_Cattle" AS ?superclass){
  ?chicken a :All_Cattle ; :species ?species .
  FILTER (?species = "Cattle"^^xsd:string ) . 
}
[QueryItem="CheckAllPoultry"]
PREFIX : <https://gbadske.org/ontologies/2024/2/SpeciesTerm#>

SELECT (COUNT(DISTINCT ?species) AS ?count) ("All_Poultry" AS ?superclass){
  ?chicken a :All_Poultry ; :species ?species .
  FILTER (?species = "Broilers"^^xsd:string ) . 
}
[QueryItem="Test"]
PREFIX : <https://gbadske.org/ontologies/2024/2/SpeciesTerm#>
SELECT distinct ?species
WHERE { ?animal a :All_Cattle .
?animal :species ?species .
FILTER ( ?species = "Cattle"^^<http://www.w3.org/2001/XMLSchema#string> ) }