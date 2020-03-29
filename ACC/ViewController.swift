//
//  ViewController.swift
//  ACC
//
//  Created by Hung-Yun Liao on 5/23/16.
//  Copyright © 2016 Hung-Yun Liao. All rights reserved.
//
import UIKit
import CoreMotion

class ViewController: UIViewController, DataProcessorDelegate {
    
    // Retreive the managedObjectContext from AppDelegate
    //let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    // MARK: Model
    var dataSource: DataProcessor = DataProcessor()
    let publicDB = UserDefaults.standard
    
    // MARK: Outlets
    
    @IBOutlet weak var currentSpeedLabel: UILabel!
    @IBOutlet weak var currentSpeed: UILabel!
    @IBOutlet weak var unitLable: UILabel!
    
    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet var info: UILabel?
    
    @IBOutlet var disX: UILabel?
    @IBOutlet var disY: UILabel?
    @IBOutlet var disZ: UILabel?
    
    @IBOutlet var accX: UILabel?
    @IBOutlet var accY: UILabel?
    @IBOutlet var accZ: UILabel?
    
    @IBOutlet var velX: UILabel?
    @IBOutlet var velY: UILabel?
    @IBOutlet var velZ: UILabel?
    
    @IBAction func reset() {
        dataSource.reset()
    }
    
    // MARK: Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.startsDetection()
        //gradientView.colorSetUp(UIColor.yellow.cgColor, bottomColor: UIColor.yellow.cgColor)
        //self.reset()
    }

    // MARK: Functions
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            // Landscape orientation
            currentSpeedLabel.text = ""
            currentSpeed.text = ""
            unitLable.text = ""
            
        } else {
            // Portrait orientation
            currentSpeedLabel.text = "current speed:"
            currentSpeed.text = "0.0"
            unitLable.text = "m/s"
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "dataSource"), object: dataSource)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dataSource.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    
    // MARK: Delegate
    func sendingNewData(person: DataProcessor, type: speedDataType, data: ThreeAxesSystemDouble) {
        switch type {
        case .accelerate:
            accX?.text = "\(roundNum(number: data.x))"
            accY?.text = "\(roundNum(number: data.y))"
            accZ?.text = "\(roundNum(number: data.z))"
        case .velocity:
            velX?.text = "\(roundNum(number: data.x))"
            velY?.text = "\(roundNum(number: data.y))"
            velZ?.text = "\(roundNum(number: data.z))"
            currentSpeed.text = "\(Double(Int(modulus(x: data.x, y: data.y, z: data.z)*10))/10)"
        case .distance:
            disX?.text = "\(roundNum(number: data.x))"
            disY?.text = "\(roundNum(number: data.y))"
            disZ?.text = "\(roundNum(number: data.z))"
        }
    }
    
    func sendingNewStatus(person: DataProcessor, status: String) {
        info?.text = status
    }
    
}
