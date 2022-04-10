//
//  FrogWranglerView.swift
//  Final_Project
//
//  Created by Jorge Torres on 2022-03-30.
//

import UIKit
import AVFoundation

//Global variables used to keep track of numbers on used on different views
struct GlobalVariables {
    static var defaults = UserDefaults.standard
    static var score = 0
    static var interval = 5.0
    static var maxFrogs = 10
    static var scoreMultiplier = 1
    static var numOfFrogsSapwned = 1
    static var nTimesFrogsSpwn = 1
    static var nTimesInterval = 1
    static var nTimesMaxFrogs = 1
    static var nTimesMultiplier = 1
}

class FrogWranglerView: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    //Variable to keep track of number of frogs on screen
    var frogCounter = 0
    
    //Control variables for the timer
    var isTimer = false
    var tr = Timer()
    
    //Audio player variable
    var player: AVAudioPlayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set background Image to size of screen
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        let imageBackground = UIImageView(frame: CGRect(x: 0,y: 0,width: width,height: height))
        imageBackground.image = UIImage(named: "Background.jpg")
        self.view.addSubview(imageBackground)
        self.view.sendSubviewToBack(imageBackground)
        
        
    }
    //Function used to update the timer and the price whenever we come back from the store
    override func viewWillAppear(_ animated: Bool) {
        
        //Shows back button on game
        self.navigationController?.navigationBar.isHidden = false
        
        //Check if the game launches for the first time
        if(GlobalVariables.defaults.bool(forKey: "First Launch")){
            //Reload current score
            GlobalVariables.score = GlobalVariables.defaults.integer(forKey: "score")
            scoreLabel.text = "SCORE: \(GlobalVariables.score)"
            
            //Set values from defaults every time the app is reloaded.
            setDefaultValues()
            
            GlobalVariables.defaults.set(true, forKey: "First Launch")
        }else{
            
            //Set values for when app first launches
            setFirstDefaultValues()
            
            GlobalVariables.defaults.set(true, forKey: "First Launch")
        }
        
        //Timer logic, checks if there is a timer already created so that no duplicates are made. If so it invalidates the timer.
        //Generates frogs using a custom method
        if(isTimer){
            tr.invalidate()
            isTimer = false
        }
            tr = Timer.scheduledTimer(withTimeInterval: GlobalVariables.interval, repeats: true){
            timer in
            
            self.generateFrogs(ammount: GlobalVariables.numOfFrogsSapwned)
            self.isTimer = true
        }
        
        tr.fire()
        
    }
    
    
    //Function that uses a while loop and a given ammount to randomly generate frogs on different parts of the screen
    func generateFrogs(ammount : Int){
        var i = 1
        while(i <= ammount){
            if(self.frogCounter < GlobalVariables.maxFrogs){
                let randomXpos = Int.random(in: 0..<Int(UIScreen.main.bounds.width) - 50)
                let randomYpos = Int.random(in: 100..<Int(UIScreen.main.bounds.height) - 150)
                self.view.addSubview(createFrog(xCoord: randomXpos, yCoord: randomYpos))
                frogCounter += 1
            }
            i += 1
        }
    }
    
    //Function that takes both coordiantes of the screen then generates a button with an image that works as the frogs on the screen
    func createFrog(xCoord:Int,yCoord:Int) -> UIButton{
        let button = UIButton(frame: CGRect(x: xCoord,y: yCoord,width:60,height: 50))
        button.setTitle("", for: .normal)
        button.transform = CGAffineTransform(rotationAngle: CGFloat(Int.random(in: 0...360)))
        button.setImage(UIImage(named: "frog.png"), for: .normal)
        button.addTarget(self, action: #selector(touchFrog), for: .touchUpInside)
        return button
    }
    
    //Function for the frog button which adds to the score and deletes the frog from the screen
    @objc func touchFrog(sender: UIButton!){
        
        //SoundEffects
        if let sound = NSDataAsset(name: "squish1"){
            do{
                player = try AVAudioPlayer(data: sound.data,fileTypeHint: "mp3")
                player?.play()
            }catch{
                print(error.localizedDescription)
            }
        }
        
        //Haptics
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
        //Variable Updating
        GlobalVariables.score += (1 * GlobalVariables.scoreMultiplier)
        frogCounter -= 1
        scoreLabel.text = "SCORE: \(GlobalVariables.score)"
        GlobalVariables.defaults.set(GlobalVariables.score, forKey: "score")
        sender.removeFromSuperview()
    }
    
    func setDefaultValues(){
        
        //Current upgrades
        GlobalVariables.numOfFrogsSapwned = GlobalVariables.defaults.integer(forKey: "frogAmmount")
        GlobalVariables.scoreMultiplier = GlobalVariables.defaults.integer(forKey: "multiplier")
        GlobalVariables.maxFrogs = GlobalVariables.defaults.integer(forKey: "maxFrogs")
        GlobalVariables.interval = GlobalVariables.defaults.double(forKey: "frogInterval")
        
        //Current number of times the upgrades have been bought
        GlobalVariables.nTimesFrogsSpwn = GlobalVariables.defaults.integer(forKey: "nxspawn")
        GlobalVariables.nTimesInterval = GlobalVariables.defaults.integer(forKey: "nxinterval")
        GlobalVariables.nTimesMaxFrogs = GlobalVariables.defaults.integer(forKey: "nxmaxfrogs")
        GlobalVariables.nTimesMultiplier = GlobalVariables.defaults.integer(forKey: "nxmultiplier")
    }
    
    //This function sets the values on user defaults for when the app runs for the first time
    func setFirstDefaultValues(){
        
        GlobalVariables.defaults.set(1, forKey: "frogAmmount")
        GlobalVariables.defaults.set(1, forKey: "multiplier")
        GlobalVariables.defaults.set(10, forKey: "maxFrogs")
        GlobalVariables.defaults.set(5.0,forKey: "frogInterval")
        
        GlobalVariables.defaults.set(1, forKey: "nxspawn")
        GlobalVariables.defaults.set(1, forKey: "nxinterval")
        GlobalVariables.defaults.set(1, forKey: "nxmaxfrogs")
        GlobalVariables.defaults.set(1, forKey: "nxmultiplier")
        
    }
    
}
