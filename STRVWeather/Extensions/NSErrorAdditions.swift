//
//  NSErrorAdditions.swift
//  STRVWeather
//
//  Created by yusuf_kildan on 26.06.2018.
//  Copyright © 2018 yusuf_kildan. All rights reserved.
//

import Foundation

let NetworkClientErrorDomain = "NetworkClientErrorDomain"

enum ErrorCode: Int {
    case success                            = 200
    
    case notFound                           = 404
    
    case invalidParameters                  = -1000
    case invalidJSON                        = -1001
    case invalidData                        = -1002
    case unknownError                       = -1003
    
    case locationAccessDenied               = -1004
    case locationAccessRestricted           = -1005
    case locationAccessFailure              = -1006
}

extension NSError {
    class func inlineErrorWithErrorCode(code: ErrorCode) -> NSError {
        return NSError(domain: NetworkClientErrorDomain,
                       code: code.rawValue,
                       userInfo: nil)
    }
    
    class func inlineErrorWith(Code code: Int?, andMessage message: String?) -> NSError {
        var userInfo: [String : AnyObject]?
        
        var inlineCode: Int!
        var inlineMessage: String! = message
        
        if code == nil {
            inlineCode = ErrorCode.unknownError.rawValue
            
            inlineMessage = "Unknown Error"
        } else {
            inlineCode = code
        }
        
        if let _ = inlineMessage {
            userInfo = [:]
            
            userInfo![NSLocalizedDescriptionKey] = inlineMessage as AnyObject
        }
        
        return NSError(domain: NetworkClientErrorDomain,
                       code: inlineCode,
                       userInfo: userInfo)
    }
}
