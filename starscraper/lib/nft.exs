#get the background image file - check whether png or jpg needed
base = "images/background.png"

#get the names to be written
file = "name_files/" <> IO.gets("Enter the .txt file from which you want to get the spacecraft names. Only enter file names inside name_files folder: ")
{:ok, doc} = File.read(String.slice(file, 0..-2))
ships = doc |> String.split("\n")

#Create image for each ship-name
Enum.map(
ships,

)

