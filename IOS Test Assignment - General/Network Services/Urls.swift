//
//  Urls.swift
//  IOS Test Assignment - General
//
//  Created by Ammar Ul Haq on 15/05/2022.
//

import Foundation

class Urls
{
    static let sharedInstance = Urls()
    
    func getBaseURL() -> String
    {
        return "https://api.github.com"
        
    }
    
    static var loginPath = "/search/users?q="
    
    
}
