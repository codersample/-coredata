//
//  UserTableViewController.swift
//  CoreDataDemo
//
//  Created by VVDN on 26/07/18.
//  Copyright © 2018 AppDmmo. All rights reserved.
//

import UIKit
import MBProgressHUD
import MGSwipeTableCell

class UserTableViewController: UITableViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var array : [User] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        NetworkClass.callApiWithBlock { (array, error) in
            if let userArray = array{
                self.array = userArray
                DispatchQueue.main.async { [unowned self] in
                    self.tableView.reloadData()
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.array.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)  as! MGSwipeTableCell
        cell.delegate = self
        let user = array[indexPath.row]
        let userAddress = user.userAddress
        if  let name = user.name , let city = userAddress?.city{
            cell.textLabel?.text = name
            cell.detailTextLabel?.text = city
        }
        cell.rightButtons = [MGSwipeButton(title: "Delete", backgroundColor: .red)]
        cell.rightSwipeSettings.transition = .rotate3D
        
  
        return cell
    }
}

extension UserTableViewController: MGSwipeTableCellDelegate {
    
  func swipeTableCell(_ cell: MGSwipeTableCell, tappedButtonAt index: Int, direction: MGSwipeDirection, fromExpansion: Bool) -> Bool {
     let indexPath = tableView.indexPath(for: cell)
    SingloltonClass.sharedObject.deletData(user: array[(indexPath?.row)!])
    self.array.remove(at: (indexPath?.row)!)
    self.tableView.deleteRows(at: [indexPath!], with: .fade)
    return true
   }
}
