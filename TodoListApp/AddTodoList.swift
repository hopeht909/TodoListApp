//
//  AddTodoList.swift
//  TodoListApp
//
//  Created by admin on 16/12/2021.
//

import UIKit
import CloudKit

struct ItemsInfo{
    
var itemTitle: String
var itemNotes: String
var Datee: String
    
}

protocol TableViewDelegate: AnyObject{

    func itemSaved(by controller: AddTodoList, with object: ItemsInfo)
}

class AddTodoList: UIViewController {
    
    weak var delegate: TableViewDelegate?
         var item: ItemsInfo?
         var indexPath: NSIndexPath?
       
    
    @IBOutlet weak var itemTitleTF: UITextField!
    @IBOutlet weak var itemNotesTF: UITextField!
    @IBOutlet weak var dueDate: UIDatePicker!
    @IBOutlet weak var addItemButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemTitleTF.text = item?.itemTitle
        itemNotesTF.text = item?.itemNotes
        
    }

    @IBAction func addItemBtnPressed(_ sender: UIButton) {
        let dateFormatter = DateFormatter()

       // Set Date Format
        dateFormatter.dateFormat = "dd/MM/YYYY"

       // Convert Date to String
       let date = dateFormatter.string(from: dueDate.date)
        
        if let title = itemTitleTF.text,
           let notes = itemNotesTF.text
            {
            
            let itemInfo = ItemsInfo.init(itemTitle: title, itemNotes: notes, Datee: date)
            delegate?.itemSaved(by: self, with: itemInfo)
            
        }
    }
}
