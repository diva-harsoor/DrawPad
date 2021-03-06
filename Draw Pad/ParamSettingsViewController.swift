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
    @IBOutlet weak var returnButton: UIButton!
    
    var hueLabel = UILabel()
    var hueSlider = UISlider()
    var saturationLabel = UILabel()
    var saturationSlider = UISlider()
    var brightnessLabel = UILabel()
    var brightnessSlider = UISlider()
    var color = UIColor(hue: 0.5, saturation: 1.0, brightness: 1.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chooseColor()
    }
    
    func chooseColor() {
        
        hueLabel = UILabel(frame:CGRectMake(view.frame.size.width/2 - 150, view.frame.size.height/5 - 60, 300, 60))
        hueLabel.textAlignment = NSTextAlignment.Center
        hueLabel.text = "Hue"
        hueLabel.font = hueLabel.font.fontWithSize(30)
        hueLabel.textColor = color
        self.view.addSubview(hueLabel)

        saturationLabel = UILabel(frame:CGRectMake(view.frame.size.width/2 - 150, view.frame.size.height/5, 300, 60))
        saturationLabel.textAlignment = NSTextAlignment.Center
        saturationLabel.text = "Saturation"
        saturationLabel.font = hueLabel.font.fontWithSize(30)
        saturationLabel.textColor = color
        self.view.addSubview(saturationLabel)

        brightnessLabel = UILabel(frame:CGRectMake(view.frame.size.width/2 - 150, view.frame.size.height/5 + 60, 300, 60))
        brightnessLabel.textAlignment = NSTextAlignment.Center
        brightnessLabel.text = "Brightness"
        brightnessLabel.font = hueLabel.font.fontWithSize(30)
        brightnessLabel.textColor = color
        self.view.addSubview(brightnessLabel)
        
        hueSlider.tag = 0
        hueSlider = UISlider(frame:CGRectMake(view.frame.size.width/2 - 150, view.frame.size.height/2 - 30, 300, 30))
        hueSlider.minimumValue = 0.0
        hueSlider.maximumValue = 1.0
        hueSlider.value = 0.5
        hueSlider.continuous = true
        hueSlider.tintColor = UIColor(hue: CGFloat(hueSlider.value), saturation: 1.0, brightness: 1.0, alpha: 1.0)
        hueSlider.addTarget(self, action: #selector(sliderValueDidChange), forControlEvents: .ValueChanged)
        self.view.addSubview(hueSlider)
        
        saturationSlider.tag = 1
        saturationSlider = UISlider(frame:CGRectMake(view.frame.size.width/2 - 150, view.frame.size.height/2, 300, 30))
        saturationSlider.minimumValue = 0.0
        saturationSlider.maximumValue = 1.0
        saturationSlider.value = 1.0
        saturationSlider.continuous = true
        saturationSlider.tintColor = UIColor(hue: CGFloat(hueSlider.value), saturation: 1.0, brightness: 1.0, alpha: 1.0)
        saturationSlider.addTarget(self, action: #selector(sliderValueDidChange), forControlEvents: .ValueChanged)
        self.view.addSubview(saturationSlider)
        
        brightnessSlider.tag = 2
        brightnessSlider = UISlider(frame:CGRectMake(view.frame.size.width/2 - 150, view.frame.size.height/2 + 30, 300, 30))
        brightnessSlider.minimumValue = 0.0
        brightnessSlider.maximumValue = 1.0
        brightnessSlider.value = 1.0
        brightnessSlider.continuous = true
        brightnessSlider.tintColor = UIColor(hue: CGFloat(hueSlider.value), saturation: 1.0, brightness: 1.0, alpha: 1.0)
        brightnessSlider.addTarget(self, action: #selector(sliderValueDidChange), forControlEvents: .ValueChanged)
        self.view.addSubview(brightnessSlider)

    }
    
    func updateColor() {
        color = UIColor(hue: CGFloat(hueSlider.value), saturation: CGFloat(saturationSlider.value), brightness: CGFloat(brightnessSlider.value), alpha: 1.0)
    }
    
    func sliderValueDidChange(sender: UISlider!) {
        updateColor()
        hueSlider.tintColor = color
        saturationSlider.tintColor = color
        brightnessSlider.tintColor = color
        hueLabel.textColor = color
        saturationLabel.textColor = color
        brightnessLabel.textColor = color
    }
}
