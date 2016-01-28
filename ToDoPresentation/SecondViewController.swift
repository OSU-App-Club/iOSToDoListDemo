//
//  SecondViewController.swift
//  ToDoPresentation
//
//  Created by Rikki Gibson on 1/27/16.
//  Copyright © 2016 Rikki. All rights reserved.
//

import UIKit

protocol SecondViewControllerDelegate: NSObjectProtocol {
    func secondViewControllerDidSetItemName(itemName: String)
}

public class SecondViewController : UIViewController {
    @IBOutlet weak var textItemName: UITextField!
    weak var delegate: SecondViewControllerDelegate?

    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        if let text = textItemName.text {
            delegate?.secondViewControllerDidSetItemName(text)
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
}