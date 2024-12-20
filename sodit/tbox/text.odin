package tbox

import "core:strings"
import "core:log"
import sdl "vendor:sdl2"
import ttf "vendor:sdl2/ttf"
import util "../util"
import ptable "../piecetable"

Text :: struct {
  font: ^ttf.Font,
  size: u8,
  pos: util.Vec2i,
  ptext: [dynamic]ptable.PieceTable,
}

updateText :: proc(){

}

drawText :: proc(renderer: ^sdl.Renderer, tbox: Tbox){
  // tbox.text.font = ttf.OpenFont("../assets/fonts/agave/AgaveNerdFont-Regular.ttf",12);
  // give each text a position and increment that for each pos
  if(tbox.text.font == nil){
    log.fatal("Font is nil please use a valid path: ", ttf.GetError())
  }
  surface: ^sdl.Surface
  texture: ^sdl.Texture
  surface_rect: sdl.Rect
  for line in tbox.text.ptext{
    if  tbox.iswrapped{
      surface = ttf.RenderText_Blended_Wrapped(tbox.text.font, line.original.line, {0xff,0xaa,0xaa,0xff},u32(tbox.dim.width))
    }else{
      surface = ttf.RenderText_Blended(tbox.text.font, line.original.line, {0xff,0xaa,0xaa,0xff})
    }
    if(surface == nil){
      log.fatal("surface is nil: ", sdl.GetError())
    }
    texture = sdl.CreateTextureFromSurface(renderer, surface)
    if(texture == nil){
      log.fatal("texture is nil: ", sdl.GetError())
    }
    surface_rect = sdl.Rect{line.pos.x,line.pos.y,surface.w,surface.h}
  }
  sdl.RenderCopy(renderer,texture,nil,&surface_rect)
  sdl.FreeSurface(surface)
  sdl.DestroyTexture(texture)
}

cleanFont :: proc(text: Text){
  ttf.CloseFont(text.font) 
}
