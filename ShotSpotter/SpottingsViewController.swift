//
//  SpottingsViewController.swift
//  ShotSpotter
//
//  Created by Jonah Witcig on 5/22/19.
//  Copyright © 2019 University of Missouri. All rights reserved.
//

import UIKit

class SpottingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var spottings: [ShotSpotting] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // find the JSON file
        guard let url = Bundle.main.url(forResource: "shot-spottings", withExtension: "json") else {
            print("JSON file not found!")
            return
        }
        
        // grab the contents of the JSON file
        guard let data = try? Data(contentsOf: url) else {
            print("Could not retrieve contents of file!")
            return
        }
        
        // the decoder we will use to read out our data
        let decoder = JSONDecoder()
        
        // a custom date formatter for the decoder to use
        // since our JSON file's dates are in a tricky format
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMMM-yy"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        // decode the JSON file, given it is an array of ShotSpotting objects
        guard let spottings = try? decoder.decode([ShotSpotting].self, from: data) else {
            print("Serialization failed!")
            return
        }
        
        // store the data on the view controller and reload the table view
        self.spottings = spottings
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spottings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShotSpottingCell", for: indexPath)
        
        let spotting = spottings[indexPath.row]
        
        // time is stored as a String, so lets do some converting
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss"
        timeFormatter.dateFormat = "h:mm a"
        let timeString = timeFormatter.string(from: spotting.time)
        
        cell.textLabel?.text = "\(spotting.rounds) shots - \(timeString)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        let dateString = dateFormatter.string(from: spotting.date)
        
        cell.detailTextLabel?.text = dateString
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "SpottingDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let selectedPath = tableView.indexPathForSelectedRow else {
            print("No spottings selected...did something go wrong?")
            return
        }
        
        let spotting = spottings[selectedPath.row]
        
        // if this is a segue to a SpottingViewController, assign the spotting property
        if let spottingViewController = segue.destination as? SpottingViewController {
            spottingViewController.spotting = spotting
        }
    }
}

