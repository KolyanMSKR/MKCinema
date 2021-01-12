//
//  Extension+String.swift
//  MKCinema
//
//  Created by Admin on 1/11/21.
//

import Foundation

extension String {
    
    func convertDateFormat() -> String {

         let olDateFormatter = DateFormatter()
         olDateFormatter.dateFormat = "yyyy-MM-dd"
         let oldDate = olDateFormatter.date(from: self)
         let convertDateFormatter = DateFormatter()
         convertDateFormatter.dateFormat = "yyyy"

         return convertDateFormatter.string(from: oldDate!)
    }
    
}
