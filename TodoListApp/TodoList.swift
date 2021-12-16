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
        
        let item = itemsList[indexPath.row]
        
        
        cell.itemTitle.text = item.itemTitle
        cell.itemsNotes.text = item.itemNotes
        cell.itemDueDate.text = item.dueDate
        
        
        if  item.checkmark == true {
          
         cell.accessoryType = .checkmark
            
        }
        else{
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = itemsList[indexPath.row]
        item.checkmark = true
        
        print(itemsList[indexPath.row])
        saveItem()
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        
    }
    
    func itemSaved(by controller: AddTodoList, with object: ItemsInfo){
        
        let item = NSEntityDescription.insertNewObject(forEntityName: "ItemsList", into: getContext()) as! ItemsList
        item.itemTitle = object.itemTitle
        item.itemNotes = object.itemNotes
        item.dueDate = object.Datee
        item.checkmark = false
        
        itemsList.append(item)
        print(item)
        
        saveItem()
        
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destination = segue.destination as! AddTodoList
        destination.delegate = self
        
        
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
    func updateCheckmark(at indexPath: Int) {
        let context = getContext()
        
        // update the task item array
        let request = NSFetchRequest<ItemsList>.init(entityName: "ItemsList")
        
        // query or filter
        let predicate = NSPredicate.init(format: "checkmark = %d", false)
        
        request.predicate = predicate
        do {
            if let taskItem = try context.fetch(request).first {
                taskItem.checkmark = true
                try context.save()
                getItems()
                }
            
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
