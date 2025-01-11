package tbox

import "core:fmt"
import "core:strings"
import "core:log"
import "core:c"
import sdl "vendor:sdl2"
import ttf "vendor:sdl2/ttf"
import util "../util"
import ptable "../piecetable"

Text :: struct {
  // font: ^ttf.Font,
  size: u8,
  // max_lines: i32,
  pos: util.Vec2i,
  ptext: ptable.PieceTable,
}

updateText :: proc(){

}

// TODO: clean up the function and check the memory when cleaning the surfaces and textures
drawText :: proc(renderer: ^sdl.Renderer, tbox: Tbox){
  // I think the seg fault is happening because im not creating a new surface / texture for each line
  // tbox.text.font = ttf.OpenFont("../assets/fonts/agave/AgaveNerdFont-Regular.ttf",12);
  // give each text a position and increment that for each pos
  //fmt.println("Drawing the text")
  if(tbox.font == nil){
    log.fatal("Font is nil please use a valid path: ", ttf.GetError())
  }
  surface: ^sdl.Surface
  texture: ^sdl.Texture
  for &line in tbox.ptext{
    //fmt.println("Creating the textures and surfaces")
    // surface_rect: sdl.Rect
    if line.original.line == ""{
      line.original.line = " "
    }

    if  tbox.iswrapped{
      surface = ttf.RenderText_Blended_Wrapped(tbox.font, line.original.line, {0xff,0xaa,0xaa,0xff},u32(tbox.dim.width))
      //fmt.println("text is wrapped so doing belended wrapping")
    }else{
      surface = ttf.RenderText_Blended(tbox.font, line.original.line, {0xff,0xaa,0xaa,0xff})
      //fmt.println("text is not wrapped so not wrapping")
    }
    if(surface == nil){
      log.fatal("surface is nil: ", sdl.GetError())
    }
    // fmt.println("creating teh texture from surface")

    if(surface == nil){
      log.fatal("surface is nil: ", sdl.GetError())
    }
    texture = sdl.CreateTextureFromSurface(renderer, surface)
    if(texture == nil){
      log.fatal("texture is nil: ", sdl.GetError())
    }
    sdl.FreeSurface(surface)
    // fmt.println("creating the rectangle")
    surface_rect := sdl.Rect{0,0+surface.h*line.pos.y,surface.w,surface.h}
    // fmt.println(line.original.line)
    // fmt.println("w: ", surface.w, ", h: ", surface.h)
    // seg fault is happening with the new lines 
    // fmt.println("width: ", surface_rect.w, ",  height: ", surface_rect.h) 

    sdl.RenderCopy(renderer,texture,nil,&surface_rect)
  }
  sdl.DestroyTexture(texture)
}

cleanFont :: proc(text: Tbox){
  ttf.CloseFont(text.font) 
}
