package tedit

import "core:fmt"
import "core:strings"
import "core:os"
import rl "vendor:raylib"

// usr input text will only be drawn in the bounds of the text box

/*
Piece Table:
  When reading from file into piece  table, each line is stored in a single string called the `original buff`
  which is read only
  
  when we add text to the file the text is  appended to the `add buffer` of the piece table which is initially empty
  it is append only

  in piece table are piece descriptors which helps us keep track of which data came from the original buffer or the add buffer
  A piece descriptor containes 3 data points:
    source -> tells us which buffer to read from
    start -> tells us which index in tihat buffer to start reading from
    length -> tells us how many characters to read from that buffer
*/

TextBox :: struct {
  xpos, ypos: i32,
  width, height: i32,
  wordwrapping: bool,
  backgroundColour: rl.Color,
}

TextInfo :: struct {
  font: rl.Font,
  size: f32,
}

InitTextInfo :: proc (font: cstring, size: f32) -> TextInfo{
  rl.SetTextLineSpacing(i32(size/2));
  return {rl.LoadFontEx(font,i32(size),nil,0),size};
}
UnloadFont :: proc(textinfo: TextInfo){
  rl.UnloadFont(textinfo.font);
}

DrawTextBox :: proc(tbox: ^TextBox){
  //rectangle for inner box
  rect: rl.Rectangle = {f32(tbox.xpos), f32(tbox.ypos),f32(tbox.width), f32(tbox.height)};
  rl.DrawRectangleRec(rect, tbox.backgroundColour);
}

HandleText :: proc(tbox: TextBox, textinfo: ^TextInfo, pieceTable: ^[dynamic]PieceTable){
  // future: for commands create a command box thats called
  textline: cstring; // will add characters to until a new line is pressed then pushed onto the piece table
  if(rl.IsWindowFocused()){
    fmt.println("yes");
    rl.SetMouseCursor(rl.MouseCursor.IBEAM);
    if(IsAnyKeyPressed()){
      // window is focused and key is pressed
      charPressed := rl.GetCharPressed();
      if(charPressed == 'p'){
        textinfo.size+=5;
      }
      if(charPressed == 'n'){
        textinfo.size-=5;
      }
      fmt.println("TextInfo Size: ", textinfo.size);
    }
  }else{
    fmt.println("no");
    rl.SetMouseCursor(rl.MouseCursor.DEFAULT);
  }
  for index:=0; index < len(pieceTable);index+=1{
    rl.DrawTextEx(textinfo.font,strings.clone_to_cstring(pieceTable[index].original.line),{f32(tbox.xpos),f32(tbox.ypos)+(textinfo.size*f32(index))},textinfo.size,2,rl.RED);
  }
}

IsAnyKeyPressed :: proc() -> bool{
  isKeyPressed: bool = false;
  key := i32(rl.GetKeyPressed());
  if(key<=256){
    isKeyPressed = true;
  }
  return isKeyPressed;
}

_DeprecatedDrawText :: proc (text: TextInfo, textData: string, posy: f32){
  rl.DrawTextEx(text.font,strings.clone_to_cstring(textData),{10,posy},text.size,2,rl.BLACK);
}
