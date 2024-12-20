package tedit


// to work source of Piece Decorator with PieceTable think about adding or converting a struct - union
// where a original has type string: original with string param and add has type string add with []string params

import "core:mem"
import "core:fmt"
import "../util"

@(private="file")
PieceTableType :: union {
  OriginalType,
  AddType,
}

@(private="file")
OriginalType :: struct {
  // type: typeid,
  line: cstring,
}
@(private="file")
AddType :: struct {
  // type: typeid,
  text: [dynamic]cstring,
}

PieceTableDecorator :: struct {
  start: i32,
  length: i32,
  source: typeid,
}


PieceTable :: struct {
  original: OriginalType,
  pos: util.Vec2i,
  add: AddType,
  pieces: [dynamic]PieceTableDecorator,
}

PieceTableDefault :: PieceTable{OriginalType{"default"},{0,0},AddType{nil}, nil};

printPieceTable :: proc(pieceTable: ^[dynamic]PieceTable){
  for &pieceData in pieceTable{

    fmt.println("-> original: ", pieceData.original, "\n\t-> add: ", pieceData.add, "\n\t\t-> pieces: ", pieceData.pieces);
    //fmt.println("-> OriginalType: ", n.original, "\n\t-> ", n.add, "\n\t\t-> ", n.pieces,false);
    //fmt.printf("-> OriginalType=(type: %s, line: %s)\n\t-> AddType=(type: %s, text: %v)\n\t\t-> %v\n",
    //n.original.type, n.original.line, n.add.type, n.add.text, n.pieces)

    //fmt.printfln("-> %#v",n)
  }
  // fmt.println(pieceTable);
}
