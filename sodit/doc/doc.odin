package doc

// handles reading from config
import "core:os"
import "core:strings"
import "core:log"
import "core:fmt"
import ptable "../piecetable"
import "../util"

loadfile :: proc(filename: string) -> [dynamic]ptable.PieceTable{
  data, ok := os.read_entire_file(filename)
	if !ok {
    fmt.println("cannot read the file: ", filename)
    os.exit(-1)
	}
	defer delete(data, context.allocator)
	sdata := string(data)
  ptline: [dynamic]ptable.PieceTable
  parse(&ptline, &sdata)
  for line in ptline{
    fmt.println("line: ", line)
  }
	//for {
	//  // process line
  //  line, ok := strings.split_lines_iterator(&sdata) 
  //  if(!ok){break;}
  //  ptline = parse_into_piecetable(strings.clone_to_cstring(line))
  //  fmt.println("file data: " , ptline.original.line)
  //}
  return ptline
  // return strings.clone_to_cstring(sdata)
}

parse :: proc(pt: ^[dynamic]ptable.PieceTable, sdata: ^string){
  // change the position so that its contains only the y of the text
  // i.e. this will only contain the line number the text is on when it comes to drawing it
  // the text box will contain the x component in the event there are multiple text boxes
  @(static) pos: util.Vec2i = {0,0}
  for{
    ptline := new(ptable.PieceTable)
    line, ok := strings.split_lines_iterator(sdata)
    if(!ok){break;}
    ptline.original.line = strings.clone_to_cstring(line)
    ptline.pos = pos;
    append(&pt^, ptline^);
    free(ptline)
    pos.y += 1;
  }
}


parse_into_piecetable :: proc(filedata: cstring) -> ptable.PieceTable{
  // parse line by line into piece table
  // TODO: store the swap file and be able to read into the other stuff
  //       i.e. parse file into normal save file and metadata file that stores piece table info
  ptline: ptable.PieceTable
  ptline.original.line = filedata
  return ptline
}
