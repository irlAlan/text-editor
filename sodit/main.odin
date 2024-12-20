package odit

import "core:fmt"
import "core:os"
import "core:log"
import "core:strings"
import sdl "vendor:sdl2"
import ttf "vendor:sdl2/ttf"
import "window"
import "tbox"
import "doc"

main :: proc() {
	//winconf := window.WindowConfig{"odit", 800, 550}
	//win, renderer := window.init(winconf)

  win := window.Window{title="odit", dim={1200,800}, pos={sdl.WINDOWPOS_UNDEFINED, sdl.WINDOWPOS_UNDEFINED} ,flags=sdl.WINDOW_SHOWN};
  renderer := window.Renderer{flags=sdl.RENDERER_ACCELERATED};
  window.init(&win, &renderer)

	defer sdl.DestroyWindow(win.win)
	defer sdl.DestroyRenderer(renderer.renderer)
  defer ttf.Quit()
	defer sdl.Quit()

  text := tbox.Text{font=ttf.OpenFont("../assets/fonts/agave/AgaveNerdFont-Regular.ttf", 12), size=12,pos={0,0}}
  maintbox := tbox.Tbox{dim={win.dim.width,win.dim.height}, pos={0,0}, col={0x99,0x99,0x99,0xff}, text=&text, iswrapped=true}
  defer tbox.cleanFont(text)

  // open document 
  cli_args := os.args[1:]
  // use the filename for saving aswell
  filename: string = ""
  if(len(cli_args) == 1){
    filename = cli_args[0]
    // text.text = doc.loadfile(filename)
    text.ptext = doc.loadfile(filename)
  } else{
    // text.text = "Still in alpha, needs file input: <program> <filename>\n" 
    text.ptext[0].original.line = "Still in alpha, needs file input: <program> <filename>\n"
    // return;
  }

  // fmt.println("text from file: ", text.text);

	event: sdl.Event
	quit: bool = false
	for (!quit) {
		for (sdl.PollEvent(&event)) {
      if (event.type == sdl.EventType.QUIT) {
				quit = true
			}
      // window.handleEvents(event)
      tbox.handleEvents(event, &maintbox, filename)
		}
    sdl.SetRenderDrawColor(renderer.renderer,0x00,0x00,0x00,0xff);
    sdl.RenderClear(renderer.renderer)
    tbox.draw(renderer.renderer,maintbox)
    sdl.RenderPresent(renderer.renderer)
	}
}
