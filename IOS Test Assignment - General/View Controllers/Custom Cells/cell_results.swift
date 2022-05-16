//
//  cell_results.swift
//  IOS Test Assignment - General
//
//  Created by Ammar Ul Haq on 15/05/2022.
//

import UIKit

class cell_results: UITableViewCell {

    @IBOutlet weak var img_Avatar: UIImageView!
    @IBOutlet weak var lbl_login: UILabel!
    @IBOutlet weak var lbl_type: UILabel!
    @IBOutlet weak var view_parent: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func addShadow()
    {
        view_parent.layer.masksToBounds = false
        view_parent.layer.shadowColor =  UIColor.init(red: 0.5058823529, green: 0.5333333333, blue: 0.6117647059, alpha: 1).cgColor
            
        view_parent.layer.shadowOffset = CGSize(width: 0, height: 1)
        view_parent.layer.shadowRadius = 5.0
        view_parent.layer.shadowOpacity = 15.0
        view_parent.layer.cornerRadius = 25.0
        
    }
    
    func makeImageRound()
    {
        img_Avatar.layer.cornerRadius = (img_Avatar.frame.height)/2
        img_Avatar.clipsToBounds  = true
        img_Avatar.layer.borderWidth = 2.0
        img_Avatar.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
