//
//  shopView.swift
//  Final_Project
//
//  Created by Jorge Torres on 2022-03-30.
//

import UIKit

class shopView: UITableViewController{
    
    @IBOutlet weak var numOfFrogsLabel: UILabel!
    @IBOutlet weak var intervalLabel: UILabel!
    @IBOutlet weak var maxFrogLabel: UILabel!
    @IBOutlet weak var multiplierLabel: UILabel!
    
    @IBOutlet weak var numOfFrogsPriceLabel: UILabel!
    @IBOutlet weak var intervalPriceLabel: UILabel!
    @IBOutlet weak var maxFrogsPriceLabel: UILabel!
    @IBOutlet weak var multiplierPriceLabel: UILabel!
    
    @IBOutlet weak var pointTrackerLabel: UILabel!
    
    //Price control variables
    var numFrogsPrice = 0
    var intervalPrice = 0
    var maxFrogPrice = 0
    var multiplierPrice = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Labels for the count of each of the upgrades
        numOfFrogsLabel.text = "\(GlobalVariables.numOfFrogsSapwned)"
        intervalLabel.text = "\(GlobalVariables.interval) sec"
        maxFrogLabel.text = "\(GlobalVariables.maxFrogs) max"
        multiplierLabel.text = "x\(GlobalVariables.scoreMultiplier)"
        
        //Price Increase formulas
        numFrogsPrice = Int(pow(Double(GlobalVariables.nTimesFrogsSpwn), Double(2)))
        intervalPrice = 10 * GlobalVariables.nTimesInterval
        maxFrogPrice = GlobalVariables.nTimesMaxFrogs
        multiplierPrice = 10 + Int(pow(Double(GlobalVariables.nTimesMultiplier), Double(3)))
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Hides back button on store
        self.navigationController?.navigationBar.isHidden = true
        
        //Point label to keep track
        pointTrackerLabel.text = "Points: \(GlobalVariables.score)"
        
        //Set labels for the upgrades
        numOfFrogsLabel.text = "\(GlobalVariables.numOfFrogsSapwned)"
        multiplierLabel.text = "x\(GlobalVariables.scoreMultiplier)"
        maxFrogLabel.text = "\(GlobalVariables.maxFrogs) max"
        intervalLabel.text = "\(GlobalVariables.interval) sec"
        
        //Updating prices with global vatiables
        numOfFrogsPriceLabel.text = "\(numFrogsPrice) pts"
        intervalPriceLabel.text = "\(intervalPrice) pts"
        maxFrogsPriceLabel.text = "\(maxFrogPrice) pts"
        multiplierPriceLabel.text = "\(multiplierPrice) pts"
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch(indexPath[1]){
            //Incresing the amount of frogs spawned at a time, also updating the price.
            //First line on each case checks if the user has enough money to buy the upgrade
            //Case 0 includes comments which explain the basic structrue of each of the cases
        case 0:
            if(GlobalVariables.score >= numFrogsPrice){
                //Increase the number of frogs spawned at at time
                GlobalVariables.numOfFrogsSapwned += 1
                //Set the global variable on defaults
                GlobalVariables.defaults.set(GlobalVariables.numOfFrogsSapwned, forKey: "frogAmmount")
                //Update text
                numOfFrogsLabel.text = "\(GlobalVariables.numOfFrogsSapwned)"
                
                //Change number of points back based on the price
                GlobalVariables.score -= numFrogsPrice
                //Set global default for score
                GlobalVariables.defaults.set(GlobalVariables.score,forKey: "score")
                
                //Update the amount of times the upgrade has been bought
                GlobalVariables.nTimesFrogsSpwn += 1
                GlobalVariables.defaults.set(GlobalVariables.nTimesFrogsSpwn, forKey: "nxspawn")
                //Change the price with the forumla
                numFrogsPrice = Int(pow(Double(GlobalVariables.nTimesFrogsSpwn), Double(2)))
                //Update the labels
                numOfFrogsPriceLabel.text = "\(numFrogsPrice) pts"
                pointTrackerLabel.text = "Points: \(GlobalVariables.score)"
            }
            break
            
            //Increasing the interval at which frogs spawn, updates price.
        case 1:
            if(GlobalVariables.score >= intervalPrice){
                //Conditional for interval so that it doesnt go lower than 1 frog per second
                if(GlobalVariables.interval > 1){
                    GlobalVariables.interval -= 0.2
                    GlobalVariables.interval = ceil(GlobalVariables.interval * 10) / 10.0
                    GlobalVariables.defaults.set(GlobalVariables.interval, forKey: "frogInterval")
                }
                intervalLabel.text = "\(GlobalVariables.interval) sec"
                GlobalVariables.score -= intervalPrice
                GlobalVariables.defaults.set(GlobalVariables.score,forKey: "score")
                
                GlobalVariables.nTimesInterval += 1
                GlobalVariables.defaults.set(GlobalVariables.nTimesInterval, forKey: "nxinterval")
                intervalPrice = 10 * GlobalVariables.nTimesInterval
                intervalPriceLabel.text = "\(intervalPrice) pts"
                pointTrackerLabel.text = "Points: \(GlobalVariables.score)"
            }
            break
            
            //Increasing the ammount of frogs allowed in the screen at once, updates price
        case 2:
            if(GlobalVariables.score >= maxFrogPrice && GlobalVariables.maxFrogs < 1000){
                GlobalVariables.maxFrogs += 10
                GlobalVariables.defaults.set(GlobalVariables.maxFrogs, forKey: "maxFrogs")
                maxFrogLabel.text = "\(GlobalVariables.maxFrogs) max"
                GlobalVariables.score -= maxFrogPrice
                GlobalVariables.defaults.set(GlobalVariables.score,forKey: "score")
                
                GlobalVariables.nTimesMaxFrogs += 10
                GlobalVariables.defaults.set(GlobalVariables.nTimesMaxFrogs, forKey: "nxmaxfrogs")
                maxFrogPrice = GlobalVariables.nTimesMaxFrogs
                maxFrogsPriceLabel.text = "\(maxFrogPrice) pts"
                pointTrackerLabel.text = "Points: \(GlobalVariables.score)"
            }
            break
            
            //Increasing the score multiplier for the ammount of points gained per frog
        case 3:
            if(GlobalVariables.score >= multiplierPrice){
                GlobalVariables.scoreMultiplier += 1
                GlobalVariables.defaults.set(GlobalVariables.scoreMultiplier, forKey: "multiplier")
                multiplierLabel.text = "x\(GlobalVariables.scoreMultiplier)"
                GlobalVariables.score -= multiplierPrice
                GlobalVariables.defaults.set(GlobalVariables.score,forKey: "score")
                
                GlobalVariables.nTimesMultiplier += 1
                GlobalVariables.defaults.set(GlobalVariables.nTimesMultiplier,forKey: "nxmultiplier")
                multiplierPrice = 10 + Int(pow(Double(GlobalVariables.nTimesMultiplier), Double(3)))
                multiplierPriceLabel.text = "\(multiplierPrice) pts"
                pointTrackerLabel.text = "Points: \(GlobalVariables.score)"
            }
            break
        default:
            break
        }
    }
    
}
