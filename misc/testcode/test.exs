#get the background image file - check whether png or jpg needed
base = "images/background.png"

#get the names to be written
file = "name_files/" <> IO.gets("Enter the .txt file from which you want to get the spacecraft names. Only enter file names inside name_files folder: ")
{:ok, doc} = File.read(String.slice(file, 0..-2))
ships = doc |> String.split("\n")

#Create image for each ship-name
#get the image details
img = Mogrify.open("images/background.png")

#
Enum.map(
ships,
  fn x -> 
    #taking image details from img, but changing the path to relative path
    %{img | path: "./images/background.jpg"}
      |> Mogrify.custom("pointsize", 200)
      |> Mogrify.custom("fill", "white")
      |> Mogrify.custom("font", "DejaVu-Sans-Mono-Bold")
      |> Mogrify.custom("annotate", "+250+600 #{x}")
      |> save(path: "./images/" <> String.downcase(x) <> ".jpg")
    
  end
)

#Sample code from: https://stackoverflow.com/questions/57416721/adding-text-to-an-image-with-elixir-mogrify
#%Mogrify.Image{path: "background.png", ext: "png"} |> custom("size", "1920x1080") |> custom("gravity", "center") |> custom("fill", "white") |> custom("font", "DejaVu-Sans-Mono-Bold") |> custom("annotate", Enum.fetch!(ships, 0)) |> create(path: ".")