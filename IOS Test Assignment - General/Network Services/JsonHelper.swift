//
//  JsonHelper.swift
//  IOS Test Assignment - General
//
//  Created by Ammar Ul Haq on 15/05/2022.
//

import Foundation
import SwiftyJSON
import Alamofire

class JsonHelper
{
    static let sharedInstance = JsonHelper()
    
    
    func parsSearchList (Result: Result<Any>) -> [model_LoginSearch]
    {
        var ParsedArray = [model_LoginSearch]()
        let data = JSON(Result.value!).dictionaryObject
        let brands = data!["items"] as! NSArray
        
        for obj in brands
        {
            let  Jobj = JSON(obj).dictionaryObject as AnyObject
            
            
            let login = Jobj["login"] as? String ?? ""
            let avatar = Jobj["avatar_url"] as? String ?? ""
            let type = Jobj["type"] as? String ?? ""
            let brand = model_LoginSearch(avatar_url: avatar, login: login, type: type)
            ParsedArray.append(brand)
        }
        
        
        return ParsedArray
        
    }
    
}
