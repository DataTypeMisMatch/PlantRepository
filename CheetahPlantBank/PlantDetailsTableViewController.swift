//
//  PlantDetailsTableViewController.swift
//  CheetahPlantBank
//
//  Created by Fox on 9/11/24.
//

import Foundation
import UIKit


class PlantDetailsTableViewController: UITableViewController, EditPlantTextTableViewControllerDelegate
{
   func editPlantTextTableViewControllerDidCancel(_ controller: PlantTextTableViewController)
   {
      navigationController?.popViewController(animated: true)
   }
   
   func editPlantTextTableViewController(_ controller: PlantTextTableViewController, didFinishAdding item: PlantItem)
   {
      
      item.plantSpeciesName = controller.textFieldSpeciesName.text!
      
      if let cell = cellToEdit
      {
	 updatePlantSpeciesNameLabel(for: cell, with: item)
	 updatePlantFamilyNameLabel(for: cell, with: item)
      }
      
      navigationController?.popViewController(animated: true)
   }
   
   func editPlantTextTableViewController(_ controller: PlantTextTableViewController, didFinishEditing item: PlantItem) 
   {
      //
   }
   
   
   
   @IBOutlet weak var plantImageView: UIImageView?
   @IBOutlet weak var plantSpeciesNameLabel: UILabel!
   @IBOutlet weak var plantFamilyNameLable: UILabel!
   @IBOutlet weak var doneBarButton: UIBarButtonItem!
   @IBOutlet weak var cancelButton: UIBarButtonItem!

   var plantItem = PlantItem()
   var cellToEdit: UITableViewCell?
   
   
    override func viewDidLoad()
   {
        super.viewDidLoad()

       
      
      plantItem.plantSpeciesName = ""
      plantItem.plantFamilyName = ""
      
      
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
/*
   override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?
   {
      return nil
   }
*/
   
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
   {
      if indexPath.section == 0 && indexPath.row == 0 
      {
	 pickPhoto()
      }
      else if indexPath.section == 1 && indexPath.row == 0 
      {
	 takePhotoWithCamera()
      }
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

   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) 
   {
      if segue.identifier == "PlantName"
      {
	 let controller = segue.destination as! PlantTextTableViewController
	 controller.title = "Edit Plant Details"
	 controller.delegate = self
	 
	 if let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
	 {
	    cellToEdit = tableView.cellForRow(at: indexPath)
	    
	    controller.plantItem = plantItem
	 }
      }
      else
      {
	       
      }
   }
   
   //MARK:  - Hide Keyboard
   
   @objc func hideKeyboard(
      _ gestureRecognizer: UIGestureRecognizer)
   {
      let point = gestureRecognizer.location(in: tableView) 
      
      let indexPath = tableView.indexPathForRow(at: point)
      if indexPath != nil && indexPath!.section == 0 &&
	    indexPath!.row == 0 {
	 return
      }
      plantImageView?.resignFirstResponder()
   }
   
   //MARK:  - Actions
   
   @IBAction func cancel()
   {
      navigationController?.popViewController(animated: true)
   }
   
   
   func updatePlantSpeciesNameLabel(
      for cell: UITableViewCell,
      with item: PlantItem)
   {
      let tempPlantSpeciesName = cell.viewWithTag(1) as! UILabel
      
      tempPlantSpeciesName.text = item.plantSpeciesName
      
      self.plantItem.plantSpeciesName = item.plantSpeciesName
   }

   
   func updatePlantFamilyNameLabel(
      for cell: UITableViewCell,
      with item: PlantItem)
   {
      let tempPlantFamilyName = cell.viewWithTag(2) as! UILabel
      
      tempPlantFamilyName.text = item.plantFamilyName
      
      self.plantItem.plantFamilyName = item.plantFamilyName
   }
   
}

extension PlantDetailsTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
   
   // MARK: - Image Helper Methods
   
   func takePhotoWithCamera()
   {
      let imagePicker = UIImagePickerController()
      
      imagePicker.sourceType = .camera
      imagePicker.delegate = self
      imagePicker.allowsEditing = true
      
      present(imagePicker, animated: true, completion: nil)
   }
   
   func choosePhotoFromLibrary() 
   {
      let imagePicker = UIImagePickerController()
      
      imagePicker.sourceType = .photoLibrary
      imagePicker.delegate = self
      imagePicker.allowsEditing = true
      
      present(imagePicker, animated: true, completion: nil)
   }
   
   
   func pickPhoto()
   {
      if UIImagePickerController.isSourceTypeAvailable(.camera) {
	 showPhotoMenu()
      } else {
	 choosePhotoFromLibrary()
      }
   }
   
   func showPhotoMenu()
   {
      let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
     
      let actCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

      alert.addAction(actCancel)

      let actPhoto = UIAlertAction(title: "Take Photo", style: .default) 
      { _ in
	    self.takePhotoWithCamera()
      }
      
      alert.addAction(actPhoto)

      let actLibrary = UIAlertAction(title: "Choose From Library", style: .default)
      { _ in
	    self.choosePhotoFromLibrary()
      }
      
      alert.addAction(actLibrary)

      present(alert, animated: true, completion: nil)
   }
   
   // MARK: - Image Picker Delegates
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:
   [UIImagePickerController.InfoKey: Any] )
   {
      dismiss(animated: true, completion: nil)
   }
   
   func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
   {
      dismiss(animated: true, completion: nil)
   }
   
   
}
