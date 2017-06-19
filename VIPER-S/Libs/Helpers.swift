import Foundation


func dateFormat(date:Date)->String{
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM dd,yyyy"
    
    return dateFormatter.string(from: date)
}
