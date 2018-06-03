//
//  AddViewController.swift
//  PapaFit
//
//  Created by Bilven on 03/06/18.
//  Copyright © 2018 Bilven. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController,UITextFieldDelegate
{
    var people = [Person]()
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtContactNo: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtName.delegate = self
        txtContactNo.delegate = self
        txtName.tag = 1
        txtContactNo.tag = 2
    }

    @IBAction func btnCancelTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnAddTapped(_ sender: Any)
    {
        let name = txtName.text
        let contactNo = txtContactNo.text!
        if(name?.isEmpty)!
        {
             self.alertMSG(title: "", Message: "Name Should not be empty")
        }
        else if(contactNo.isEmpty)
        {
          self.alertMSG(title: "", Message: "ContactNo Should not be empty")
        }
        else
        {
            let person = Person(context: PersistenceServce.context)
            person.name = name
            person.contactno = contactNo
            PersistenceServce.saveContext()
            self.people.append(person)
            self.moveToViewController()
        }
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
