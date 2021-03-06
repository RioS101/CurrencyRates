//
//  AllCurrenciesTableViewController.swift
//  CurrencyConverter
//
//  Created by Riad on 5/26/20.
//  Copyright © 2020 Projectum. All rights reserved.
//

import UIKit

class AllCurrenciesTableViewController: UITableViewController, UISearchResultsUpdating {
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //make isCheked property of all currencies false
        for currency in allCurrencies {
            if currency.isChecked == true {
                currency.isChecked = false
            }
        }
        
        //then set isCheked property to true only for those currencies whose .title property is contained in checkedCurrencies
        for checkedCurrency in checkedCurrencies {
            for currency in allCurrencies {
                if currency.title == checkedCurrency.title {
                    currency.isChecked = true
                    //break, continue, fallthrough? чтобы после нахождения дальше не искал
                }
            }
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // MARK: SearchController
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Type currency name to search"
        navigationItem.searchController = searchController
        // if table view isn't embedded in navigation controller then:   tableView.tableHeaderView = searchController.searchBar
        
        //set the title of cancel button to "done" in searchBar
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Done"
        
    }

    var searchController: UISearchController!
    //protocol's required method
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }
    
    var searchResults: [Currency] = []
    
    func filterContent(for searchText: String) {
        searchResults = allCurrencies.filter({ (currency) -> Bool in
            return currency.title.localizedCaseInsensitiveContains(searchText)
//   or       return currency.title.lowercased().contains(searchText.lowercased())
        })

// даже без этого работает почему-то!!! Почему???
//                for currency in searchResults {
//                    if currency.isChecked == true {
//                        for anotherCurrency in allCurrencies {
//                            if anotherCurrency.title == currency.title {
//                                anotherCurrency.isChecked = true
//                            }
//                        }
//                    }
//                }
    }
    
    var allCurrencies = Currency.allCurrencies
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return searchResults.count
        } else {
            return allCurrencies.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currency", for: indexPath)

        let currency = searchController.isActive ? searchResults[indexPath.row] : allCurrencies[indexPath.row]
        cell.textLabel?.text = currency.title
        cell.accessoryType = currency.isChecked ? .checkmark : .none
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
     
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            allCurrencies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            tableView.insertRows(at: [indexPath], with: .fade)
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
*/
    //MARK: - Table view delegate 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = searchController.isActive ? searchResults[indexPath.row] : allCurrencies[indexPath.row]
               item.isChecked.toggle()
        
        guard let cell = tableView.cellForRow(at: indexPath) else {return}
       
        if item.isChecked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
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
    var checkedCurrencies: [Currency] = []
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        checkedCurrencies.removeAll()
        for currency in allCurrencies {
            if currency.isChecked == true {
                checkedCurrencies.append(currency)
            }
        }
    }
    

}
