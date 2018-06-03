//
//  DetailViewController.swift
//  PapaFit
//
//  Created by Bilven on 03/06/18.
//  Copyright © 2018 Bilven. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController
{
    var device : NSManagedObject!
    var Detailuser = Person()
    var contactId : Int = 0
    @IBOutlet weak var lblFirstName: UILabel!
    @IBOutlet weak var lblContactNo: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblFirstName.text = (device.value(forKey: "name") as! String)
        let contactNo = String(device.value(forKey: "contactno") as! String )
        self.lblContactNo.text = String(contactNo)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnDoneTapped(_ sender: Any) {
        let addUpdateVCLR : ViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(addUpdateVCLR, animated: true)
    }
    
    @IBAction func btnEditTapped(_ sender: Any)
    {

    }
    
}
