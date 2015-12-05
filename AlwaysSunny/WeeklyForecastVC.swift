// TODO: add the min and max temps of the day from the json obj
//
//  WeeklyForecastVC.swift
//  AlwaysSunny
//
//  Created by Will Wyatt on 12/5/15.
//  Copyright © 2015 Will Wyatt. All rights reserved.
//

import UIKit

class WeeklyForecastVC: UIViewController {
    
//    var forecast:[Forecast]?
//    var currentForecast:Forecast?

//****  OUTLETS  ****//
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currentForecastImage: UIImageView!
    @IBOutlet weak var currentForecastDescriptionLabel: UILabel!
    @IBOutlet weak var currentDateLabel: UILabel!
// TODO: add the min and max temps of the day from the json obj
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension WeeklyForecastVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("ForecastCellReuseID") as? ForecastTableViewCell {
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
}