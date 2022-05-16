//
//  VC_LoginSearch.swift
//  IOS Test Assignment - General
//
//  Created by Ammar Ul Haq on 15/05/2022.
//

import UIKit
import SDWebImage
import MBProgressHUD

class VC_LoginSearch: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {
   
    
    @IBOutlet weak var txt_search: UITextField!
    @IBOutlet weak var tableview_searchResults: UITableView!
    @IBOutlet weak var view_searchHere: UIView!
    @IBOutlet weak var lbl_HeadingMsg: UILabel!
    @IBOutlet weak var lbl_subHeadingMessage: UILabel!
    
    
    var searchResults:[model_LoginSearch] = [model_LoginSearch]()
    var perpageResults: [model_LoginSearch] = [model_LoginSearch]()
    var pageCount:Int = 0
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view_searchHere.isHidden = true
        
        

        tableview_searchResults.isHidden = true
        view_searchHere.isHidden = false
        self.txt_search.delegate = self
        
        self.lbl_HeadingMsg.text = "Start Searching..."
        self.lbl_subHeadingMessage.text = "Please enter a keyword you want to search and tap on submit button your results will appear here."
        
        
        
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            // Searching keyword on keyboard return key.
            self.search()
            return true;
        }
    
    
    func search()
    {
        AppHelper.sharedInstance.checkInternetConn { type, status in
            if status
            {
                if self.txt_search.text != ""
                {
                    DataLayer.sharedInstance.getSearchResults(search: self.txt_search.text!) { dataArray, success, errorDesc in
                        
                        if success
                        {
                            self.searchResults.removeAll()
                            self.searchResults = dataArray
                            self.searchResults = self.searchResults.sorted { $0.login.lowercased() < $1.login.lowercased() }
                            
                            self.perpageResults.removeAll()
                            self.pageCount = 0
                            
                            self.pageCount += 9
                            
                            
                            if self.searchResults.count > 0
                            {
                                self.tableview_searchResults.isHidden = false
                                self.view_searchHere.isHidden = true
                                
                                if self.searchResults.count > self.pageCount
                                {
                                    for i in 0...self.pageCount
                                    {
                                        self.perpageResults.append(self.searchResults[i])
                                    }
                                }
                                else
                                {
                                    self.perpageResults = self.searchResults
                                    
                                }
                                
                               
                                
                                self.tableview_searchResults.reloadData()
                                
                                
                            }
                            else
                            {
                                self.tableview_searchResults.isHidden = true
                                self.view_searchHere.isHidden = false
                                
                                self.lbl_HeadingMsg.text = "Oops..."
                                self.lbl_subHeadingMessage.text = "We didn't find anything that matches this search. Try search for something else."
                                
                            }
                            
                          
                        }
                        else
                        {
                            self.tableview_searchResults.isHidden = true
                            self.view_searchHere.isHidden = false
                            
                            self.lbl_HeadingMsg.text = "Server Error."
                            self.lbl_subHeadingMessage.text = "\(errorDesc)"
                            
                        }
                        
                    }
                    
                    self.txt_search.resignFirstResponder()
                    
                }
                else
                {
                    self.tableview_searchResults.isHidden = true
                    self.view_searchHere.isHidden = false
                    self.txt_search.resignFirstResponder()
                    self.lbl_HeadingMsg.text = "Oops..."
                    self.lbl_subHeadingMessage.text = "Login textfeild cannot be empty. Please enter a keyword to search."
                    
                }
                
                
            }
            else
            {
                self.tableview_searchResults.isHidden = true
                self.view_searchHere.isHidden = false
                
                self.lbl_HeadingMsg.text = "Oops...No Internrt Connection :("
                self.lbl_subHeadingMessage.text = "It might sound simple, but sometimes that's all it takes to fix a bad connection. If restarting doesn't work, switch between Wi-Fi and mobile data."
                
                
            }
        }
        
      
        
    }
    
    @IBAction func action_Submit(_ sender: Any) {
        
        self.search()
    }
    
    
    //tableview datasource and delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.perpageResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        var cell : cell_results? = tableView.dequeueReusableCell(withIdentifier: "cell") as! cell_results
           
        var obj = self.perpageResults[indexPath.row]

        cell?.lbl_type.text = obj.type
        cell?.lbl_login.text = obj.login
        let url = URL.init(string:obj.avatar_url)
        cell?.img_Avatar.sd_setImage(with: url , placeholderImage: nil)
        
    
        
        //Making UIImage Circular shape
        cell?.makeImageRound()
        
        //Adding shadow to Parent view
        cell?.addShadow()
        
        
        return cell!
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 130
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == perpageResults.count - 1 {
           self.loadMore()
        }
    }
    
    func loadMore()
    {
        
        let newPageCount = pageCount + 9
        
        if self.searchResults.count > newPageCount
        {
            let seconds = 1.1
            self.showHUD(progressLabel: "Loading...")
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                
                for i in self.pageCount...newPageCount
                {
                    self.perpageResults.append(self.searchResults[i])
                }
                
                self.dismissHUD(isAnimated: true)
                
                self.tableview_searchResults.reloadData()
            }
            
            
            pageCount = newPageCount
            
        }
        
        
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

