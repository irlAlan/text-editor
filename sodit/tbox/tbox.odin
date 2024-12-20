package tbox

import "core:strings"
import "core:fmt"
import "core:log"
import "base:runtime"
import sdl "vendor:sdl2"
import ttf "vendor:sdl2/ttf"
import util "../util"

Tbox :: struct {
  dim: util.Dim,
  pos: util.Vec2i,
  col: util.Col,
  rect: sdl.Rect,
  text: ^Text, // TODO: make this an array of text where each line is a text or fuse this with the piece table struct and make that an array
  iswrapped: bool,
}

// TODO: sort out characters showing weirdly on screen
// sort out type conversion from text input and display it
handleEvents :: proc (event: sdl.Event, tbox: ^Tbox, file: string){
  // check if the filename is empty to save etc
  //tbox.text.text = "Text has been changed and i think that i can go ahead and do this lorem ipsum lorem ipsum hfkasdjhkjsahdfkjalsdj fklsfkajsdkf j\njaskdfljsdjfkasjdkfalsdjfkals"
  // tmp_str: [^]u8 
  #partial switch event.type {
  case .TEXTINPUT:
  for i in 0..<len(event.text.text){
      // val := event.text.text
      // tmp_str = &event.text.text[0]
      // runtime.append_elem(&tmp_str,event.text.text[i])
  }
  case .TEXTEDITING:
  }
  //for codepoint, index in tmp_str{
  //  // raw_data(codepoint)
  //  fmt.println(index, codepoint)
  //}
}

draw :: proc(renderer: ^sdl.Renderer, tbox: Tbox){
  sdl.SetRenderDrawColor(renderer, tbox.col.r,tbox.col.g,tbox.col.b,tbox.col.a)
  rect := sdl.Rect{tbox.pos.x,tbox.pos.y,tbox.dim.width,tbox.dim.height}
  sdl.RenderFillRect(renderer,&rect)
  drawText(renderer,tbox)
  sdl.SetRenderDrawColor(renderer, 0x00, 0x00, 0x00, 0xff);
}
