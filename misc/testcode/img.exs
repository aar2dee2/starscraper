import Mogrify

#%Mogrify.Image{path: "./lib/background.png", ext: "png"}
#img = Mogrify.open("images/background.png")

%Mogrify.Image{path: "background.png"}
|> custom("size", "1920x1080")
|> custom("gravity", "center")
|> custom("fill", "white")
|> custom("font", "DejaVu-Sans-Mono-Bold")
|> custom("label", "Ark Asterion")
|> create(in_place: true)

#path: "./images/ark_asterion"