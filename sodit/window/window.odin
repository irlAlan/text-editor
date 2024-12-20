package window

import "core:c"
import "core:fmt"
import "core:log"
import "core:mem"
import "core:os"
import sdl "vendor:sdl2"
import ttf "vendor:sdl2/ttf"

import util "../util"

//WINDOW_FLAGS :: sdl.WINDOW_SHOWN
//RENDER_FLAGS :: sdl.RENDERER_ACCELERATED
//TARGET_DT :: 1000.0/60.0

Window :: struct {
	win:   ^sdl.Window,
	// renderer: WinRenderer,
	flags: sdl.WindowFlags,
	title: cstring,
	dim:   util.Dim,
	pos:   util.Vec2i,
}
Renderer :: struct {
	renderer: ^sdl.Renderer,
	flags:    sdl.RendererFlags,
}

@(private = "file")
checkNil :: proc(a: $any, msg: string, err: cstring) {
	if (a == nil) {
		log.fatalf(msg, err)
		os.exit(-1)
	}
}

init :: proc(window: ^Window, renderer: ^Renderer) {
	if (sdl.Init(sdl.INIT_VIDEO) < 0) {
		log.fatalf("COULD NOT INIT VIDEO, %s", sdl.GetError())
	}
  if(ttf.Init() < 0){
    log.fatalf("COULD NOT INIT VIDEO, %s", ttf.GetError())
  }
	window.win = sdl.CreateWindow(
		window.title,
		window.pos.x,
		window.pos.y,
		window.dim.width,
		window.dim.height,
		window.flags,
	)
	checkNil(window.win, "Unable to create window, %s", sdl.GetError())
	renderer.renderer = sdl.CreateRenderer(window.win, -1, renderer.flags)
	checkNil(renderer.renderer, "Unable to create surface, %s", sdl.GetError())
  sdl.RenderSetLogicalSize(renderer.renderer, window.dim.width/2, window.dim.height/2)
	// sdl.UpdateWindowSurface(window.win)
}

//draw :: proc(renderer: ^sdl.Renderer) {
//  sdl.SetRenderDrawColor(renderer,0xaa,0xaa,0xaa,0xff);
//  sdl.RenderClear(renderer)
//  sdl.RenderPresent(renderer)
//}

//handleEvents :: proc(event: sdl.Event) {
//
//}
