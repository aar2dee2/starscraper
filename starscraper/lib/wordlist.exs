# fictional spacecraft names from Wikipedia: https://en.wikipedia.org/wiki/List_of_fictional_spacecraft
{:ok, result} = Starscraper.get_spacecraft_name()
names = result |> Starscraper.extract_names()
spacecraft_words = names |> Starscraper.extract_words()

#get common glossary from https://skyandtelescope.org/astronomy-terms/
#Commenting out below code as it is throwing a :timeout when script s run directly. Have run the exact same code as below in iex and created space_glossary.txt
#{:ok, glossary} = Starscraper.get_common_glossary()
#terms = glossary |> Starscraper.extract_names()
#space_glossary = terms |> Starscraper.extract_words()

{:ok, star_groups} = Starscraper.get_constellation()
con_names = star_groups |> Starscraper.extract_names()
constellations = con_names |> Starscraper.extract_words()

#creating a list of common_words. Can be updated
common_words = [
"Battle", "Star", "Galactic", "Ship", "Craft", "Destroyer", "Cruiser", "Bruiser", "Black", "Hole", "Flight", "Copter", "Mighty", "Large", "Asteroid", "Lens",
]

#getting terms from space_glossary.txt
doc = case File.read("space_glossary.txt") do
    {:ok, body} -> body
    {:error, reason} -> ""
  end
space_glossary =  doc |> String.split("\n")

final = spacecraft_words ++ constellations ++ common_words ++ space_glossary

#using combinations to generate names from the final list
generated = PnC.comb_helper(final, 2, 4, []) |> Enum.map(Enum.join(" "))

#File.write("words3.txt", Enum.join(final, "\n"))