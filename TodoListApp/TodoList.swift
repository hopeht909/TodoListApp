//
//  ViewController.swift
//  TodoListApp
//
//  Created by admin on 15/12/2021.
//

import UIKit
import CoreData

class TodoList: UITableViewController, TableViewDelegate {
    
    var itemsList = [ItemsList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getItems()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        itemsList.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let item = itemsList[indexPath.row]
        getContext().delete(item)
        
        saveItem()
        
        itemsList.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListCell", for: indexPath) as! TodoListCustomCell
        
        cell.itemTitle.text = itemsList[indexPath.row].itemTitle
        cell.itemsNotes.text = itemsList[indexPath.row].itemNotes
        cell.itemDueDate.text = itemsList[indexPath.row].dueDate
        tableView.cellForRow(at: indexPath)?.accessoryType = .detailDisclosureButton
    
        return cell
    }
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
            performSegue(withIdentifier: "AddEditItem" , sender: indexPath)
        }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func itemSaved(by controller: AddTodoList, with object: ItemsInfo, at indexPath: NSIndexPath?){
        if let ip = indexPath {
            
            let items = itemsList[ip.row]
            items.itemTitle = object.itemTitle
            items.itemNotes = object.itemNotes
            items.dueDate = object.Datee
            
        }
        else{
            
            let item = NSEntityDescription.insertNewObject(forEntityName: "ItemsList", into: getContext()) as! ItemsList
            item.itemTitle = object.itemTitle
            item.itemNotes = object.itemNotes
            item.dueDate = object.Datee
            
            itemsList.append(item)
            
        }
        saveItem()
        
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if sender is UIBarButtonItem {
               let destination = segue.destination as! AddTodoList
               destination.delegate = self
               
           }
           
           else if  sender is IndexPath   {
               
               let destination = segue.destination as! AddTodoList
               destination.delegate = self
       
               let indexPath = sender as! NSIndexPath
               if
               let title = itemsList[indexPath.row].itemTitle,
               let notes = itemsList[indexPath.row].itemNotes,
               let date = itemsList[indexPath.row].dueDate
               {
                   
                   let object = ItemsInfo.init(itemTitle: title, itemNotes: notes, Datee: date)
              
               destination.item = object
               destination.indexPath = indexPath
                   
               }
           }
       }
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func getItems() {
        let context = getContext()
        
        let request = NSFetchRequest<ItemsList>.init(entityName: "ItemsList")
        
        do {
            itemsList = try context.fetch(request)
            tableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }
    func saveItem() {
        
        let context = getContext()
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}

