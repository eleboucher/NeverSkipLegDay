//
//  Settings.swift
//  exoapp
//
//  Created by Erwan Leboucher on 10/05/2017.
//  Copyright © 2017 Erwan Leboucher. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class Settings : UIViewController {
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var legsegment: UISegmentedControl!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    override func viewDidLoad() {
        stepper.value=GlobalVariables.nbofsec
        self.oneValue.text = Int(stepper.value).description
        segmentedControl.selectedSegmentIndex = GlobalVariables.sound=="ding" ? 0 : 1;
        legsegment.selectedSegmentIndex = GlobalVariables.nbofleg==1 ? 0 : 1;
        super.viewDidLoad()
    }

    @IBAction func indexChangedLeg(_ sender: Any) {
        switch legsegment.selectedSegmentIndex{
        case 0:
            GlobalVariables.nbofleg=1;
        case 1:
            GlobalVariables.nbofleg=2;
        default:
            break;
        }
    }
    @IBAction func indexChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex{
        case 0:
            GlobalVariables.sound="ding";
        case 1:
            GlobalVariables.sound="YouAreAPirate";
        default: break
        }
    }
    
    
    @IBOutlet weak var oneValue: UITextField!
    
    @IBAction func oneClicker(_ sender: UIStepper) {
        self.oneValue.text = Int(sender.value).description
        GlobalVariables.nbofsec=sender.value;
    }

}
