import Foundation
import CSV

//Total Qty
//Reg Qty
//Foil Qty
//Card
//Set
//Mana Cost
//Card Type
//Color
//Rarity
//Mvid
//Single Price
//Single Foil Price
//Total Price
//Price Source
//Notes

//to ->>

//amount
//card_name
//is_foil
//set_name
//language


func parseCSV(inputPath: String, outputPath: String) {
  guard let inputStream = InputStream(fileAtPath: inputPath) else {
    print("Error reading file at path \(inputPath)")
    return
  }
  
  guard let csv = try? CSVReader(stream: inputStream, hasHeaderRow: true) else {
    print("Error reading CSV at \(inputPath)")
    return
  }
  
  guard let outputStream = OutputStream(toFileAtPath: outputPath, append: false),
    let output = try? CSVWriter(stream: outputStream) else {
    print("Error writing to \(outputPath)")
    return
  }

  try! output.write(
    row: ["amount", "card_name", "is_foil", "set_name", "language"]
  )
  
  while csv.next() != nil {
    if let regCount = Int(csv["Reg Qty"]!), regCount > 0 {
      try! output.write(row: [
        csv["Reg Qty"]!, //amount
        csv["Card"]!, //card_name
        "", //is_foil
        csv["Set"]!, //set_name
        "en", //language
      ]);
    }
    if let foilCount = Int(csv["Foil Qty"]!), foilCount > 0 {
      try! output.write(row: [
        csv["Foil Qty"]!, //amount
        csv["Card"]!, //card_name
        "1", //is_foil
        csv["Set"]!, //set_name
        "en", //language
      ]);
    }
  }
  
  print("Complete")
}

guard CommandLine.arguments.count >= 3 else {
  print("Requires a file path and destination")
  exit(1)
}


parseCSV(
  inputPath: CommandLine.arguments[1],
  outputPath: CommandLine.arguments[2]
)



