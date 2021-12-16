//
//  TodoListCustomCell.swift
//  TodoListApp
//
//  Created by admin on 16/12/2021.
//

import UIKit

class TodoListCustomCell: UITableViewCell {

   
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemsNotes: UILabel!
    @IBOutlet weak var itemDueDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
