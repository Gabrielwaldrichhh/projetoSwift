//
//  BarTableViewController.swift
//  myFirstApp
//
//  Created by Jonathan on 04/02/20.
//  Copyright © 2020 HBSIS. All rights reserved.
//

import UIKit
import os.log

class BarTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var Bars = [Bar]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        if let savedBares = loadBares() {
            Bars += savedBares
        } else {
            // Load the sample data.
            loadSampleMeals()
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Bars.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "BarTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? BarTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let Bar = Bars[indexPath.row]
        
        cell.nameLabel.text = Bar.name
        cell.ratingBar.rating = Bar.rating
        cell.photoImageView.image = Bar.photo
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Bars.remove(at: indexPath.row)
            saveBares()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let barDetailViewController = segue.destination as? ViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedBarCell = sender as? BarTableViewCell else {
                fatalError("Unexpected sender: \(sender!)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedBarCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedBar = Bars[indexPath.row]
            barDetailViewController.bar = selectedBar
            
        default:
            fatalError("Unexpected Segue Identifier")
        }
    }
    
    
    
    //MARK: Private Methods
    private func loadBares() -> [Bar]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Bar.ArchiveURL.path) as? [Bar]
    }
    
    private func saveBares() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(Bars, toFile: Bar.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Bares successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save bares...", log: OSLog.default, type: .error)
        }
    }
    
    //MARK: Actions
    
    
    private func loadSampleMeals() {
        
    }
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ViewController, let bar = sourceViewController.bar {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                Bars[selectedIndexPath.row] = bar
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                // Add a new meal.
                let newIndexPath = IndexPath(row: Bars.count, section: 0)
                
                Bars.append(bar)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            // Save the meals.
            saveBares()
        }
    }
    
}



