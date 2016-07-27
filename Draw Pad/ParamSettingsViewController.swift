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
    @IBOutlet weak var returnButton: UIButton!
    
    var hueSlider = UISlider()
    var saturationSlider = UISlider()
    var brightnessSlider = UISlider()
    var color = UIColor(hue: 0.5, saturation: 1.0, brightness: 1.0, alpha: 1.0)
    
    var opacitySlider = UISlider()
    
    var thicknessSlider = UISlider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = String(buttonTag)
        
        switch (buttonTag) {
        case 0:
            chooseColor()
        default:
            chooseColor()
        }
    }
    
    func chooseColor() {
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
    
    func chooseOpacity() {
        opacitySlider.tag = 3
        opacitySlider = UISlider(frame:CGRectMake(view.frame.size.width/2 - 50, view.frame.size.height, 100, 30))
        opacitySlider.minimumValue = 0.0
        opacitySlider.maximumValue = 1.0
        opacitySlider.value = 1.0
        opacitySlider.continuous = true
        opacitySlider.tintColor = UIColor(hue: CGFloat(hueSlider.value), saturation: 1.0, brightness: 1.0, alpha: 1.0)
        opacitySlider.addTarget(self, action: #selector(sliderValueDidChange), forControlEvents: .ValueChanged)
        self.view.addSubview(opacitySlider)
    }
    
    func chooseThickness() {
        thicknessSlider.tag = 4
        thicknessSlider = UISlider(frame:CGRectMake(view.frame.size.width/2 - 50, view.frame.size.height, 100, 30))
        thicknessSlider.minimumValue = 0.0
        thicknessSlider.maximumValue = 1.0
        thicknessSlider.value = 1.0
        thicknessSlider.continuous = true
        thicknessSlider.tintColor = UIColor(hue: CGFloat(hueSlider.value), saturation: 1.0, brightness: 1.0, alpha: 1.0)
        thicknessSlider.addTarget(self, action: #selector(sliderValueDidChange), forControlEvents: .ValueChanged)
        self.view.addSubview(thicknessSlider)
    }
    
    func updateColor() {
        color = UIColor(hue: CGFloat(hueSlider.value), saturation: CGFloat(saturationSlider.value), brightness: CGFloat(brightnessSlider.value), alpha: 1.0)
    }
    
    func sliderValueDidChange(sender: UISlider!) {
        switch (sender.tag) {
        case 0, 1, 2:
            updateColor()
            hueSlider.tintColor = color
            saturationSlider.tintColor = color
            brightnessSlider.tintColor = color
        case 3:
            opacitySlider.tintColor = UIColor(hue: 1.0, saturation: 1.0, brightness: CGFloat(saturationSlider.value), alpha: 1.0)
        case 4:
            thicknessSlider.tintColor = UIColor(hue: 1.0, saturation: 1.0, brightness: CGFloat(saturationSlider.value), alpha: 1.0)
        default:
            print("default")
        }
    }
}
