//
//  ModelAreaData.swift
//  TenkiAPIForRxSwift
//
//  Created by Isami Odagiri on 2020/12/06.
//

import Foundation
import ObjectMapper

final class ModelAreaData: Mappable {
    
    var name: String?
    var country: String?
    var lon: Float?
    var lat: Float?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        name <- map["name"]
        country <- map["country"]
        var coord: Any?
        coord <- map["coord"]
        if let coord = coord as? [String: Any] {
            lon = (coord["lon"] as? NSNumber)?.floatValue
            lat = (coord["lat"] as? NSNumber)?.floatValue
        }
    }
    
    
}
