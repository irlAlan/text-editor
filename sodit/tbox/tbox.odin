package tbox

import "core:strings"
import "core:fmt"
import "core:log"
import "base:runtime"
import sdl "vendor:sdl2"
import ttf "vendor:sdl2/ttf"
import util "../util"
import pt "../piecetable"

/*
  Design choice: each textbox has a text
  the textbox has:
    - [X] total lines
    - font
    - [X] bacnkground col
    - [X] text col
    - [X] size
    - [X] is wrapped
    - [X] bounderies
    - [X] textbox position 
    - A dynamic array of type Text 

  each Text type will have:
    - PieceTable

*/

/**
  TODO: check file extension to see if can be tokenised or smthing
*/

Tbox :: struct {
  max_lines: i32,
  dim: util.Dim,
  font: ^ttf.Font,
  pos: util.Vec2i, // TODO: change soon to only contain the x component
  col: util.Col,
  txtcol: util.Col,
  txtsize: i32,
  //text: [dynamic]Text, // TODO: make this an array of text where each line is a text or fuse this with the piece table struct and make that an array
  ptext: [dynamic]pt.PieceTable,
  iswrapped: bool,
  rect: sdl.Rect,
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
