package tedit

import "core:fmt"
import "core:strings"
import "core:os"
import rl "vendor:raylib"


main :: proc() {
  args := os.args[0:];
  filename: string;
  loadfile := false;
  fmt.println(args, len(args));
  if len(args) <= 1{
    // TODO: Open an empty buffer
    // filename = DEFAULT_FILE;
    fmt.println("IN BETA must specify a filename");
    os.exit(-1);
  }else{
    // open actual file
    loadfile = true;
    filename = args[1];
  }

  filePieceTable, file_err := readFile(filename);
  if file_err != nil {
    fmt.println("Error while handling file {} : {} ", filename, file_err);
    os.exit(-1);
  }
  // fmt.println(fileData);

  win: Window = {800, 450, 60, rl.BLACK, "test"};
  CreateWindow(win);
  defer CloseWindow()

  textInfo: TextInfo = InitTextInfo("../assets/agave/AgaveNerdFontMono-Regular.ttf", 12);
  defer UnloadFont(textInfo);
  posx: f32 = 10;
  posy: f32 = 10;

  tbox: TextBox = {10,10,win.width-20,win.height-20,false, rl.WHITE};


  for !rl.WindowShouldClose() {
    rl.BeginDrawing();
    rl.ClearBackground(win.backCol);

    DrawTextBox(&tbox);
    //if(loadfile){
      // not working because text is being overwritten each time we draw the textbox 
      // way to go: load file data into struct then draw struct data on after drawBox 
      // when input is detected we first update it on struct then draw it out
      //loadfile = false;
      //fmt.println("Loading file");
      HandleText(tbox,&textInfo, &filePieceTable);
      //fmt.println("Finished loading file");
    //}
    //rl.DrawTextEx(text.font,strings.clone_to_cstring(filePieceTable[0].original.line),{posx,10},text.size,2,rl.BLACK);
    //rl.DrawTextEx(text.font,strings.clone_to_cstring(filePieceTable[1].original.line),{posx,10+text.size},text.size,2,rl.BLACK);
    //rl.DrawTextEx(text.font,strings.clone_to_cstring(filePieceTable[2].original.line),{posx,10+(2*text.size)},text.size,2,rl.BLACK);
    //rl.DrawText(strings.clone_to_cstring(filePieceTable[1].original.line),posx,30,15,rl.BLACK);
    //rl.DrawText(strings.clone_to_cstring(filePieceTable[2].original.line),posx,50,15,rl.BLACK);
    // printPieceTable(&fileData);
    //for pieceData in fileData{

     // tmpStr := strings.clone_to_cstring(strings.concatenate({pieceData.original.line, "\n"}));
     // posy += 1;
     // fmt.println(tmpStr, "posY: ", posy);
     // rl.DrawText(tmpStr,posx,posy,15,rl.BLACK);

    ////  // append([]string{pieceData.original.line}, "\n");
    ////  //tmpStr := strings.concatenate({pieceData.original.line, "\n"});
    ////  // tmpStr := pieceData;
    //  // fmt.println("piecedata line: ",pieceData.original.line);
    //  fmt.println("piecedata: ",pieceData);
    //  printPieceTable(pieceData);
    ////  // rl.DrawText(strings.clone_to_cstring(tmpStr),10,10,15,rl.BLACK);
    // }
     rl.EndDrawing();
  }

  // prints fine but segfaults and idk why
  //for pieceData in fileData{
  //  // rl.DrawText(strings.clone_to_cstring(strings.concatenate({pieceData.original.line, "\n"})),10,10,15,rl.BLACK);
  //  fmt.println(pieceData.original.line);
  //}
}

