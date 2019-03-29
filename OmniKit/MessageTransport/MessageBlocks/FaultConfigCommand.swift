//
//  FaultConfigCommand.swift
//  OmniKit
//
//  Created by Pete Schwamb on 12/18/18.
//  Copyright © 2018 Pete Schwamb. All rights reserved.
//

import Foundation

//
//  GetStatusCommand.swift
//  OmniKit
//
//  Created by Pete Schwamb on 10/14/17.
//  Copyright © 2017 Pete Schwamb. All rights reserved.
//

import Foundation

public struct FaultConfigCommand : NonceResyncableMessageBlock {

    public let blockType: MessageBlockType = .faultConfig
    public let length: UInt8 = 6
    
    public let tab5Sub16: UInt8
    public let tab5Sub17: UInt8
    public var nonce: UInt32

    public init(nonce: UInt32, tab5Sub16: UInt8, tab5Sub17: UInt8) {
        self.nonce = nonce
        self.tab5Sub16 = tab5Sub16
        self.tab5Sub17 = tab5Sub17
    }

    public init(encodedData: Data) throws {
        if encodedData.count < 8 {
            throw MessageBlockError.notEnoughData
        }
        
        nonce = encodedData[2...].toBigEndian(UInt32.self)

        self.tab5Sub16 = encodedData[6]
        self.tab5Sub17 = encodedData[7]
    }

    public var data: Data {
        var data = Data(bytes: [
            blockType.rawValue,
            length])
            
        data.appendBigEndian(nonce)
        data.append(tab5Sub16)
        data.append(tab5Sub17)
        return data
    }
}