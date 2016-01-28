//
//  ViewController.swift
//  ToDoPresentation
//
//  Created by Rikki Gibson on 1/27/16.
//  Copyright © 2016 Rikki. All rights reserved.
//

import UIKit

class FirstViewController: UITableViewController, SecondViewControllerDelegate {
    var toDoItems = ["Get groceries", "Wash my car", "Pet the dog"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("toDoItem") ?? UITableViewCell(style: .Default, reuseIdentifier: "toDoItem")
        cell.textLabel?.text = toDoItems[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            toDoItems.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }

    func secondViewControllerDidSetItemName(itemName: String) {
        toDoItems.append(itemName)
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController.childViewControllers.first as? SecondViewController {
            destination.delegate = self
        }
    }
}

