//
//  UpdateViewController.swift
//  PapaFit
//
//  Created by Bilven on 03/06/18.
//  Copyright © 2018 Bilven. All rights reserved.
//

import UIKit
import CoreData

class UpdateViewController: UIViewController,UITextFieldDelegate
{
    var context: NSManagedObjectContext?
    var device : NSManagedObject!
    var contactId : Int!
    @IBOutlet weak var txtContactNo: UITextField!
    @IBOutlet weak var txtName: UITextField!
    var user = Person()
    var name : String = ""
    var people = [Person]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtName.text = (device.value(forKey: "name") as! String)
        self.txtContactNo.text = String(device.value(forKey: "contactno") as! String)
        self.getDataFromDB()
        txtName.delegate = self
        txtContactNo.delegate = self
        self.txtName.tag = 1
        self.txtContactNo.tag = 2
    }
    
    func getDataFromDB()
    {
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        
        do {
            let people = try PersistenceServce.context.fetch(fetchRequest)
            self.people = people
        } catch {}
    }
    @IBAction func btnEditTapped(_ sender: Any)
    {
        let name = txtName.text
        let contactNo = Double(txtContactNo.text!)
        if(name == nil )
        {
            self.alertMSG(title: "", Message: "Name Should not be empty")
        }
        else if(contactNo == nil)
        {
            self.alertMSG(title: "", Message: "ContactNo Should not be empty")
        }
        else
        {
            self.device.setValue(self.txtName.text, forKey: "name")
            self.device.setValue(self.txtContactNo.text!, forKey: "contactno")
            self.moveToViewController()
        }
    }
    
    
    @IBAction func btnCancelTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func alertMSG(title:String,Message:String)
    {
        let alert = UIAlertController(title: title, message: Message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (_) in
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func moveToViewController()
    {
        let addUpdateVCLR : ViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(addUpdateVCLR, animated: true)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        switch textField.tag
        {
        case 1:
            let maxLength = 25
            let currentString: NSString = txtName.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        case 2:
            let maxLength = 10
            let currentString: NSString = txtContactNo.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        default:
            break
        }
        return true
    }
}
