//
//  Utility.swift
//  oly
//
//  Created by Niranjan Ravichandran on 6/1/18.
//  Copyright © 2018 Aviato. All rights reserved.
//

import Foundation

class RecordingNumbers {
    private static var recordingNumberTable: [String : Int64] = [:]
    private static let kRecordingsTableString = "kRecordingsTableString"
    
    static func loadNumberTable() {
        if let numbers = UserDefaults.standard.dictionary(forKey: kRecordingsTableString) as? [String: Int64] {
            RecordingNumbers.recordingNumberTable = numbers
        }
    }
    
    static func getNumberForRecording() -> Int64 {
        var index: Int64 = 1
        while recordingNumberTable[index.description] != nil {
            index += 1
        }
        return index
    }
    
    static func addRecordingNumber(newNumber: Int64) {
        recordingNumberTable[newNumber.description] = newNumber
    }
    
    static func removeNumber(number: Int64) {
        recordingNumberTable[number.description] = nil
    }
    
    static func saveRecordingNumbersToDisk() {
        UserDefaults.standard.setValue(recordingNumberTable, forKey: kRecordingsTableString)
        UserDefaults.standard.synchronize()
    }
    
}

struct GlobalConstants {
    static let defaultAudioFormat = ".m4a"
}
