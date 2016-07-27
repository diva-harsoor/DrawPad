//
//  ParamSettingsViewController.swift
//  Draw Pad
//
//  Created by Diva Harsoor on 7/26/16.
//  Copyright © 2016 Mobile Makers. All rights reserved.
//

import UIKit

class ParamSettingsViewController: UIViewController {

    var buttonTag = Int()
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = String(buttonTag)
    }
}
