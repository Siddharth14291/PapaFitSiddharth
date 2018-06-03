//
//  ViewController.swift
//  PapaFit
//
//  Created by Bilven on 03/06/18.
//  Copyright © 2018 Bilven. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController
{
    @IBOutlet weak var btnAdd: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    var people = [Person]()
    var selectedDevice : NSManagedObject!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getDataFromDB()
    }
    func getDataFromDB()
    {
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let people = try PersistenceServce.context.fetch(fetchRequest)

            self.people = people
            self.tableView.reloadData()
        } catch {}
    }
    @IBAction func btnEditTapped(_ sender: Any)
    {
        let addUpdateVCLR : UpdateViewController = self.storyboard?.instantiateViewController(withIdentifier: "UpdateViewController") as! UpdateViewController
        self.selectedDevice = people[(sender as AnyObject).tag]
        addUpdateVCLR.device = selectedDevice
        addUpdateVCLR.contactId = (sender as AnyObject).tag
        self.navigationController?.pushViewController(addUpdateVCLR, animated: true)
    }
    
    @IBAction func onPlusTapped() {
   
        let addVC : AddViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
        self.navigationController?.pushViewController(addVC, animated: true)
}
}
extension ViewController: UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! cellName
        cell.lblName.text = people[indexPath.row].name
        cell.btnEdit.tag = indexPath.row
        cell.btnEdit.addTarget(self, action: #selector(ViewController.btnEditTapped(_:)), for: .touchUpInside)
        
        return cell
    }
    private func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC : DetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        self.selectedDevice = people[indexPath.row]
        detailVC.device = selectedDevice
        detailVC.contactId = indexPath.row
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        switch editingStyle
        {
        case .delete:
            let managedContext = PersistenceServce.persistentContainer.viewContext
            managedContext.delete(people[indexPath.row] as Person)
            do {
                try managedContext.save()
                self.getDataFromDB()
                tableView.reloadData()
            } catch _ {
            }
        default:
            break
        }
    }
}

