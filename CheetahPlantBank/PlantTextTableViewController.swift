//
//  PlantTextTableViewController.swift
//  CheetahPlantBank
//
//  Created by Fox on 9/11/24.
//

import Foundation
import UIKit

protocol EditPlantTextTableViewControllerDelegate: AnyObject
{
   func editPlantTextTableViewControllerDidCancel(
      _ controller: PlantTextTableViewController)
   
   func editPlantTextTableViewController(
      _ controller: PlantTextTableViewController,
      didFinishAdding item: PlantItem)
   
   func editPlantTextTableViewController(
      _ controller: PlantTextTableViewController,
      didFinishEditing item: PlantItem)
}

class PlantTextTableViewController: UITableViewController
{

   @IBOutlet weak var textFieldSpeciesName: UITextField!
   @IBOutlet weak var textFieldFamilyName: UITextField!
   @IBOutlet weak var doneBarButton: UIBarButtonItem!
   @IBOutlet weak var cancelButton: UIBarButtonItem!
   
   weak var delegate: EditPlantTextTableViewControllerDelegate?
   
   var plantSpeciesNameText: String = ""
   var plantFamilyNameText: String = ""
   var plantItem = PlantItem()
   

   
    override func viewDidLoad()
   {
        super.viewDidLoad()

      
      // Hide keyboard
      let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
      
      gestureRecognizer.cancelsTouchesInView = false
      tableView.addGestureRecognizer(gestureRecognizer)
    }

    // MARK: - Table View Data Source

    override func numberOfSections(in tableView: UITableView) -> Int 
   {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int 
   {
        // #warning Incomplete implementation, return the number of rows
        return 2
   }

   override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?
   {
      return nil
   }
   
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
   
   //MARK:  - Hide Keyboard on Tap
   
   @objc func hideKeyboard(
      _ gestureRecognizer: UIGestureRecognizer)
   {
      let point = gestureRecognizer.location(in: tableView)
      
      let indexPath = tableView.indexPathForRow(at: point)
      if indexPath != nil && indexPath!.section == 0 &&
	    indexPath!.row == 0 {
	 return
      }
      textFieldFamilyName?.resignFirstResponder()
   }
   
   //MARK:  - Actions
   
   @IBAction func cancel()
   {
      navigationController?.popViewController(animated: true)
   }
   
   @IBAction func done()
   {
      print("Contents of TextField: \(textFieldSpeciesName.text!)")
      print("Contents of TextField: \(textFieldFamilyName.text!)")
      
      let item = PlantItem()
      
      item.plantSpeciesName = textFieldSpeciesName.text!
      item.plantFamilyName = textFieldFamilyName.text!
      
      delegate?.editPlantTextTableViewController(self, didFinishAdding: item)
   }
   
}
