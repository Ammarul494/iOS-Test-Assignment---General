//
//  NetworkServicesHelper.swift
//  IOS Test Assignment - General
//
//  Created by Ammar Ul Haq on 15/05/2022.
//

import Foundation
import SwiftyJSON
import Alamofire

class NetworkServicesHelper
{
    static let sharedInstance = NetworkServicesHelper()
    
    
    func search(search: String, completionHandler: @escaping (_ Result:Result<Any>, Bool,String) -> Void)
    {
        let completeURL = "\(Urls.sharedInstance.getBaseURL())\(Urls.loginPath)\(search)"
        let urlString = completeURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
       
        Alamofire.request(urlString!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in

            switch response.result {
            case .success:
                if let value = response.result.value {
                    print(value)
                    completionHandler(response.result,true,"success")
                }
            case .failure(let error):
                print(error)
                completionHandler(response.result,false,error.localizedDescription)
            }
            
            
        }
        
    }
    
    
}
