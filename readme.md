# Hello LÖVE: Snake

LÖVE is a 2D game engine where games are written in Lua. I'm learning it to prepare for a Luanti game :)

Run the game by installing LÖVE, cloning this repo, then running `love .`. To view print output in the console, run `lovec .`

Code is copied from https://berbasoft.com/simplegametutorials/love/snake/

## Bundling and distributing

Adapted from https://www.love2d.org/wiki/Game_Distribution#Creating_a_Windows_Executable

1. Compress `main.lua`, `conf.lua`, `license.md` and `readme.md` to a ZIP file
1. Change extension from `.zip` to `.love`, ignoring any "file unusable" warnings
1. cmd prompt: `copy /b "C:\Program Files\LOVE\love.exe"+snake.love snake.exe`
1. Move the LÖVE DLLs and license.txt, along with this repo's `license.md`, to the dist folder along with `snake.exe`
1. Compress all those files to a new `snake.zip`
1. Upload `snake.zip` wherever you like :)
