//
//  NoConnectionViewController.swift
//  CurrencyConverter
//
//  Created by Riad on 6/8/20.
//  Copyright © 2020 Projectum. All rights reserved.
//

import UIKit

class NoConnectionViewController: UIViewController {
    
    @IBAction func retryButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "retrySegue", sender: sender)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
