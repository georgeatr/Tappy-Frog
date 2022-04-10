//
//  ViewController.swift
//  Final_Project
//
//  Created by Jorge Torres on 2022-03-30.
//

import UIKit

class MainMenuController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set background Image to size of screen
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        let imageBackground = UIImageView(frame: CGRect(x: 0,y: 0,width: width,height: height))
        imageBackground.image = UIImage(named: "Background2.jpg")
        self.view.addSubview(imageBackground)
        self.view.sendSubviewToBack(imageBackground)
        
        
    }
    
    // Reset button for all default values
    @IBAction func resetbutton(_ sender: UIButton) {

        GlobalVariables.defaults.set(0,forKey: "score")
        
        GlobalVariables.defaults.set(5,forKey: "frogInterval")
        
        GlobalVariables.defaults.set(10,forKey: "maxFrogs")
        
        GlobalVariables.defaults.set(1,forKey: "multiplier")
        
        GlobalVariables.defaults.set(1,forKey: "frogAmmount")
        
        GlobalVariables.defaults.set(1,forKey: "nxspawn")
    
        GlobalVariables.defaults.set(1,forKey: "nxinterval")
        
        GlobalVariables.defaults.set(1,forKey: "nxmaxfrogs")
        
        GlobalVariables.defaults.set(1,forKey: "nxmultiplier")
    }
    
}

