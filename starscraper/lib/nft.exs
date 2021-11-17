# fictional spacecraft names from Wikipedia: https://en.wikipedia.org/wiki/List_of_fictional_spacecraft
{:ok, result} = Starscraper.get_spacecraft_name()
names = result |> Starscraper.extract_names()
spacecraft_words = names |> Starscraper.extract_words()
IO.puts("got spacecraft names from wikipedia")

# ------------------------------------

#get common glossary from https://skyandtelescope.org/astronomy-terms/
#Commenting out below code as it is throwing a :timeout when script s run directly. Have run the exact same code as below in iex and created space_glossary.txt
#{:ok, glossary} = Starscraper.get_common_glossary()
#terms = glossary |> Starscraper.extract_names()
#space_glossary = terms |> Starscraper.extract_words()

# ------------------------------------

{:ok, star_groups} = Starscraper.get_constellation()
con_names = star_groups |> Starscraper.extract_names()
constellations = con_names |> Starscraper.extract_words()
IO.puts("got constellation names from wikipedia")

# ------------------------------------

#getting terms from space_glossary.txt
doc = case File.read("space_glossary.txt") do
    {:ok, body} -> body
    {:error, reason} -> ""
  end
space_glossary =  doc |> String.split("\n")

IO.puts("got space_glossary terms from .txt file")

# ------------------------------------

rejected = ["(UT)", "Time", "Woman", "LCAM", "owned", "by", "which",  "terraforming", "planets", "mission", "shot", "down", "when", "attempting", "maneuver", "around", "planet", "Trip", "Private", "UNSC", "with", "type", "Vehicle", "Escape", "Space", "Earth", "Toon", "News", "Network", "Zone", "Gamer", "comic", "watch", "Young", "Effect", "effect"]
final = (spacecraft_words ++ constellations ++ space_glossary) |> Enum.filter(fn x -> !Enum.member?(rejected, x) end)
#File.write("text_files/all_words.txt", Enum.join(final, "\n"))
IO.puts("got final words list")

# ------------------------------------

l = length(final)

#using the random function here to generate a tuple with indexes, and then a list of 2-word names based on those indexes

#Seeding the random function
:rand.seed(:exs1024, :erlang.timestamp())
#Number of names to be generated
n = IO.gets("enter the number of NFTs: ") |> String.trim() |> String.to_integer()

generated = Enum.map(
1..n, 
fn x -> Enum.fetch!(final, :rand.uniform(l) - 1) <> " " <> Enum.fetch!(final, :rand.uniform(l) - 1) end)

IO.puts("generated spacecraft names")

#File.write("text_files/spaceship.txt", Enum.join(generated, "\n"))

#IO.puts("created spaceship.txt")

# ------------------------------------
# Generating images

#get the background image file
base = "images/background.jpg"

#get the names to be written
#file = "name_files/" <> IO.gets("Enter the .txt file from which you want to get the spacecraft names. Only enter file names inside name_files folder: ")
#{:ok, doc} = File.read(String.slice(file, 0..-2))
#ships = doc |> String.split("\n")

#Commenting out above to use the generated list of names

#Create image for each ship-name
#get the image details
img = Mogrify.open("images/background.jpg")

#
Enum.map(
generated,
  fn x -> 
    #taking image details from img, but changing the path to relative path
    %{img | path: "./images/background.jpg"}
      |> Mogrify.custom("pointsize", 120)
      |> Mogrify.custom("fill", "white")
      |> Mogrify.custom("font", "DejaVu-Sans-Mono-Bold")
      |> Mogrify.custom("annotate", "+50+600 #{x}")
      |> Mogrify.save(path: "./nfts/" <> String.downcase(x) <> ".jpg")
    
  end
)
