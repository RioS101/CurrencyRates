//
//  CurrencyListTableViewController.swift
//  CurrencyConverter
//
//  Created by Riad on 5/25/20.
//  Copyright © 2020 Projectum. All rights reserved.
//

import UIKit

class CurrencyListTableViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        if let data = Currency.loadChosenCurrencies() {
            chosenCurrency = data
        } else {
            chosenCurrency.append(Currency(title: "EUR", isChecked: true, rate: nil))
        }
    }
    
    var chosenCurrency: [Currency] = [Currency(title: "EUR", isChecked: true, rate: nil)]

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chosenCurrency.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chosenCurrency", for: indexPath)

    // Configure the cell...
        cell.textLabel?.text = chosenCurrency[indexPath.row].title
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
        if segue.identifier == "addItem",
            let destinationNavigationController = segue.destination as? UINavigationController,
            let allCurrenciesTableViewController = destinationNavigationController.topViewController as? AllCurrenciesTableViewController {
            allCurrenciesTableViewController.checkedCurrencies.removeAll()
            allCurrenciesTableViewController.checkedCurrencies = chosenCurrency
        }
        
        if segue.identifier == "ratesSegue",
            let ratesViewController = segue.destination as? RatesViewController {
            let selectedIndexPath = tableView.indexPathForSelectedRow
            let selectedCurrency = chosenCurrency[selectedIndexPath!.row]
            
            ratesViewController.baseCurrency = selectedCurrency.title
        }
        
    }
    
    @IBAction func unwindToChosenCurrencies(_ unwindSegue: UIStoryboardSegue) {
        if let sourceViewController = unwindSegue.source as? AllCurrenciesTableViewController {
            chosenCurrency = sourceViewController.checkedCurrencies
            tableView.reloadData()
        }
        //save data every time when returning from allCurrencies screen to list of chosen currencies by pressing "Done" button.
        Currency.saveChosenCurrencies(chosenCurrency)
    }

}
