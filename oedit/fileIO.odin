package tedit

import "core:strings"
import "core:mem"
import "core:os"
import "core:fmt"
import rl "vendor:raylib"

DEFAULT_FILE :: "";

FileError :: union{
  // UnableToOpenFile,
  UnableToReadFile,
  mem.Allocator_Error,
}

//UnableToOpenFile :: struct{
//  filename: string,
//  error: os.Errno,
//}

UnableToReadFile :: struct {
  filename: string,
  error: os.Errno,
}

readEmptyBuff :: proc() {
  buf: [256]byte;
  fmt.println("Enter the file data");
  n, err := os.read(os.stdin, buf[:]);
  if err != nil {
    fmt.println("Error reading file name, ", err);
    return;
  }

  str := string(buf[:n]);
  fmt.println("output text: ", str);
}

loadText :: proc(tbox: TextBox, text: ^TextInfo, pieceTable: ^[dynamic]PieceTable){
  //DrawTextBox(tbox);
  // draw piece table data here
  for index:=0; index < len(pieceTable);index+=1{
    rl.DrawTextEx(text.font,strings.clone_to_cstring(pieceTable[0].original.line),{f32(tbox.xpos),f32(tbox.ypos)-text.size},text.size,2,rl.RED);
  }
}

readFile :: proc(filename: string) -> ([dynamic]PieceTable,FileError){
  fileHandle, openError := os.open(filename,os.O_RDWR);
  allFileText: [dynamic]PieceTable;// = new([dynamic]PieceTable);
  fileText: PieceTable;
  // cannot open the file
  if openError != os.ERROR_NONE{
    fmt.println("in empty buffer");
    //open empty  buffer here
    // TOOD: sort this out
    // readEmptyBuff(); append(allFileText, fileText); return allFileText, nil;// , UnableToOpenFile{filename, openError}; }
  }

  // fileData: string;
  readBuff:[mem.Kilobyte]byte;
  //for{
    bytesRead, readError := os.read(fileHandle, readBuff[:]);
    if readError != os.ERROR_NONE {
      //append(&allFileText, fileText);
      return nil, UnableToReadFile{filename, readError};
    }
    if bytesRead == 0 {
      fmt.println("bytes read is 0");
      // tmp usaage
      return nil,UnableToReadFile{filename,readError};
    }
    // add to original in  PieceTable
    st := string(readBuff[:bytesRead-1]);
    // fmt.println("st: ", st);
    lines := strings.split_n(st,"\n",len(st));
    for line in lines {
    //fmt.println("Line: ", line);
      fileText.original.line = strings.clone(line);
      fmt.println("Orig Line: ", fileText.original.line);
      // TODO: read meta data into the add for a file
      //  add to Add in piece table
      append(&fileText.add.text, "");
      // add PieceTableDecorator information
      decor := PieceTableDecorator{0, auto_cast len(fileText.original.line), typeid_of(type_of(fileText.original))};
      append(&fileText.pieces, decor);

      // fileData = strings.join(lines, "\n");
      // pushing onto allFileText
      append(&allFileText, fileText);
      // fmt.println(allFileText[len(allFileText)-1],"\n");
    }
  return allFileText, nil;
}
