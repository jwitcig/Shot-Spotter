//
//  ShotSpotting.swift
//  ShotSpotter
//
//  Created by Jonah Witcig on 5/22/19.
//  Copyright © 2019 University of Missouri. All rights reserved.
//

import Foundation

enum JSONDecodingError: Error {
    case noTime
}

/*
 Represents a single shot spotting.
 */
struct ShotSpotting: Decodable {
    
    // Translating between the names of the properties on our struct
    // and the keys in the JSON under which you can find the data
    private enum CodingKeys: String, CodingKey {
        case type = "Type"
        case id = "ID"
        case date = "Date"
        case time = "Time"
        case rounds = "Rnds"
        case beat = "Beat"
        case location = "Location 1"
    }
    
    // Decoding our fields from the JSON data. All are primitive types except
    // for Location, which itself implements Decodable, making this all possible.
    let type: String
    let id: Int
    let date: Date
    let time: Date
    let rounds: Int
    let beat: String
    let location: Location
    
    // Custom decoding because the 'time' property needs some special treatment.
    // 'date' is handled by the decoder's date formatting strategy, so the time
    // property needs its own formatter.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(String.self, forKey: .type)
        self.id = try container.decode(Int.self, forKey: .id)
        self.date = try container.decode(Date.self, forKey: .date)
        self.rounds = try container.decode(Int.self, forKey: .rounds)
        self.beat = try container.decode(String.self, forKey: .beat)
        self.location = try container.decode(Location.self, forKey: .location)
        
        let timeString = try container.decode(String.self, forKey: .time)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        guard let time = formatter.date(from: timeString) else {
            throw JSONDecodingError.noTime
        }
        self.time = time
    }
}
