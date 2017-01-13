all: app.js 

app.js: src/*.elm
	elm-make src/main.elm --output app.js

