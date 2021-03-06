# Star Cruiser NFT

Star Cruiser NFT is a text-based NFT generator for generating spacecraft names. It:
  - fetches names of constellations, fictional spacecraft and common space terms from web links using the [HTTPoison](https://github.com/edgurgel/httpoison) and [Floki](https://github.com/philss/floki) libraries
  - creates a list of words from these names using Elixir standard library functions
  - generates names for spacecraft based on combinations of words from the list above - using the `erlang random` module here.
  - creates a jpeg for each name selected using the [mogrify](https://github.com/elixir-mogrify/mogrify) library and [ImageMagick](http://www.imagemagick.org/script/index.php)

# To Run

[![Run on Repl.it](https://repl.it/badge/github/aar2dee2/starscraper)](https://repl.it/github/aar2dee2/starscraper)

Click on the button above to Run. 

The images will be created using `background.jpg` in `starscraper/images`. To use a different image backgound, upload your file to the `starscraper/images` folder and rename it to backgound.jpg (you can delete the file already provided.)

When you click run, you will prompted to enter the number of NFTs required in the console. Enter a valid integer only. Since, this project involves image generation, a large number may take a long while to process. Ideally run for 50 or less NFTs in one go.

The images will show up in `starscraper/nfts`

Two text files `all_words.txt` and `spaceship.txt` will also be generated in the `text_files` folder.

If you do multiple runs, the `all_words.txt` and `spaceship.txt` files will be overwritten, but new nfts will keep getting added to the `generated` folder

If you want to repeat runs without compiling deps each time, type `mix run lib/nft.exs` in the Shell when you're in the `starscraper/starscraper` directory.
  
  ---
  __Note:__ ImageMagick has been added as a Nix package in `replit.nix`

  To check that `ImageMagick` is working type the following commands in the terminal
  ```
  magick logo: logo.gif
  identify logo.gif
  display logo.gif
  ```

  When using the annotate option in `Mogrify.custom/3`, must add the value of x & y offsets along with txt as `+25+45 #{text}` - `25` is the x offset and `45` is the y offset here. Also, the `pointsize` option needs to be set, else the font is too small and you will not see any text on the image.

  Helpful links for mogrify:
  - [SO Adding text to an image with Elixir Mogrify](https://stackoverflow.com/questions/57416721/adding-text-to-an-image-with-elixir-mogrify)
  -  [Image resizing and uploading with Mogrify](https://elixirforum.com/t/image-resizing-and-uploading-to-s3-bucket-with-mogrify-image-not-resized/27754)
  - (https://stackoverflow.com/questions/45915567/generating-image-in-elixir-with-text)
  - [Mogrify hexdocs](https://hexdocs.pm/mogrify/Mogrify.html#content)
  - [Adding fonts for ImageMagick](https://legacy.imagemagick.org/Usage/scripts/imagick_type_gen)
 - [On missing fonts](https://legacy.imagemagick.org/discourse-server/viewtopic.php?t=34911)
  - [ImageMagick Annotate command usage](https://legacy.imagemagick.org/Usage/annotating/#anno_on)
  - [SO link for adding text to image using ImageMagick](https://stackoverflow.com/questions/23236898/add-text-on-image-at-specific-point-using-imagemagick)
  - [X, Y Offsets and Angle in the Annotate command](https://www.php.net/manual/en/imagick.annotateimage.php)