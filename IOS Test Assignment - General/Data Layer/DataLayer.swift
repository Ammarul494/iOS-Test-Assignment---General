//
//  DataLayer.swift
//  IOS Test Assignment - General
//
//  Created by Ammar Ul Haq on 15/05/2022.
//

import UIKit
import Alamofire

class DataLayer: NSObject {
    
    static let sharedInstance = DataLayer()
    
    
    func getSearchResults(search: String, completionHandler: @escaping ([model_LoginSearch], Bool,String) -> Void)
    {
        NetworkServicesHelper.sharedInstance.search(search: search) { Result, sucess, error in
            
            if sucess
            {
                let parsedArray = JsonHelper.sharedInstance.parsSearchList(Result: Result)
                completionHandler(parsedArray,sucess,error)
            }
            else
            {
                completionHandler([model_LoginSearch](),sucess,error)
            }
            
            
        }
        
    }

}
