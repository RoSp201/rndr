//
//  StatusViewController.swift
//  RndrApp
//
//  Created by William Smith on 11/12/16.
//  Copyright © 2016 William Smith. All rights reserved.
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

var updates : [Update] = [Update(name : "Will", distance: 2.0), Update(name : "Georgy", distance : 5.1), Update(name : "Bryce", distance : 1.1), Update(name: "Gera", distance : 0.4)] // for hacking only

class StatusViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var trendingSelected = true
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        let leftImage = UIImage(named: "trending.png")
        let rightImage = UIImage(named: "friends.png")
        segmentedControl.setImage(leftImage, forSegmentAt: 0)
        segmentedControl.setImage(rightImage, forSegmentAt: 1)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func segmentedControlToggled(_ sender: Any) {
    }
    
    @IBOutlet weak var tableView: UITableView!
    
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
            cell.trendingCellIcon.image = UIImage(named: "sign.png")
            cell.trendingCellTextField.text = "\(currentUpdate.name) made a post \(currentUpdate.distance) miles from you."
            
            print(currentUpdate.name)
            print(currentUpdate.distance)
        }
        else {
            identifier = "friendsCell"
            cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! StatusTableViewCell
            cell.friendsCellImage.image = UIImage(named: "friends")
            cell.friendsCellTextField.text = "\(currentUpdate.name) made a post \(currentUpdate.distance) from you."
            
            print(currentUpdate.name)
            print(currentUpdate.distance)
        }
        
        return cell
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
