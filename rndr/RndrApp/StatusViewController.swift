//
//  StatusViewController.swift
//  RndrApp
//
//  Created by William Smith on 11/12/16.
//  Modified by Robert Spark on 12/1/16.
//  Copyright © 2016 William Smith and Robert Spark. All rights reserved.
//

import UIKit

class Update {
    var name : String = ""
    var distance : Double = 1.0
    
    init(name : String, distance : Double) {
        self.name = name
        self.distance = distance
    }
}

class StatusViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Properties
    var trendingSelected = true
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var fav = false
    
    
    //some sample data to populate the tableview
    var updates : [Update] = [Update(name : "Will", distance: 2.0), Update(name : "Georgy", distance : 5.1), Update(name : "Bryce", distance : 1.1), Update(name: "Gera", distance : 0.4)] // for hacking only

    var savedPosts = [Update]() //will save removed posts from discover tab
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        let leftImage = UIImage(named: "trending_icon.png")
        let rightImage = UIImage(named: "friends.png")
        segmentedControl.setImage(leftImage, forSegmentAt: 0)
        segmentedControl.setImage(rightImage, forSegmentAt: 1)

    }

    //give options when swiping to the side on a UItableViewCell
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let save = UITableViewRowAction(style: .normal, title: "Save") { action, index in
            print("Save button tapped, moved obj to saved list")
            self.savedPosts.append(self.updates.remove(at: indexPath.row))
            self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            
        }
        save.backgroundColor = UIColor.lightGray
        let cell = self.tableView.cellForRow(at: indexPath) as! StatusTableViewCell
        var title = ""
        if cell.favorite {
            title = "Uncheck"
        } else {
            title = "Favorite"
        }
        
        let favorite = UITableViewRowAction(style: .normal, title: title) { action, index in
            print("Favorite button tapped")
            //let identifier = self.tableView.ide
            //let cell = self.tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! StatusTableViewCell
            
            if cell.favorite == false {
                cell.trendingCellIcon.image = UIImage(named: "star.png")
                cell.favorite = true
            }
            else {
                cell.trendingCellIcon.image = UIImage(named: "sign.png")
                cell.favorite = false
            }
            self.tableView.reloadData()
        }
        favorite.backgroundColor = UIColor.orange
    
        
        let remove = UITableViewRowAction(style: .normal, title: "Remove") { action, index in
            print("Remove Post button tapped")
            self.updates.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
        remove.backgroundColor = UIColor.red
        
        return [remove, favorite, save]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // the cells you would like the actions to appear for needs to be editable
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // you need to implement this method too or you can't swipe to display the actions
    }
    
    // MARK: TableViewController functions
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return updates.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var identifier : String
        var cell : StatusTableViewCell
        let currentUpdate = updates[indexPath.row]
        
        if trendingSelected {
            identifier = "trendingCell"
            cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! StatusTableViewCell
            if cell.favorite == false {
                cell.trendingCellIcon.image = UIImage(named: "sign.png")
            }
            
            cell.trendingCellTextField.text = "\(currentUpdate.name) made a post \(currentUpdate.distance) miles from you."
            
            //print(currentUpdate.name)
            //print(currentUpdate.distance)
        }
        else
        {
            identifier = "friendsCell"
            cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! StatusTableViewCell
            cell.friendsCellImage.image = UIImage(named: "friends.png")
            cell.friendsCellTextField.text = "\(currentUpdate.name) made a post \(currentUpdate.distance) from you."
            
            //print(currentUpdate.name)
            //print(currentUpdate.distance)
        }
        return cell
    }
    
    
    
    // MARK: Actions
    @IBAction func segmentedControlToggled(_ sender: Any) {
    }
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
