# fictional spacecraft names from Wikipedia: https://en.wikipedia.org/wiki/List_of_fictional_spacecraft
{:ok, result} = Starscraper.get_spacecraft_name()
names = result |> Starscraper.extract_names()
spacecraft_words = names |> Starscraper.extract_words()

#get common glossary from https://skyandtelescope.org/astronomy-terms/
#{:ok, glossary} = Starscraper.get_common_glossary()
#terms = glossary |> Starscraper.extract_names()
#space_glossary = terms |> Starscraper.extract_words()

common_words = [
"Battle", "Star", "Galactic", "Ship", "Craft", "Destroyer", "Cruiser", "Bruiser", "Black", "Hole", "Flight", "Copter", "Mighty", "Large", "Asteroid", "Lens",
]

final = spacecraft_words #++ space_glossary ++ common_words
File.write("words3.txt", Enum.join(final, "\n"))