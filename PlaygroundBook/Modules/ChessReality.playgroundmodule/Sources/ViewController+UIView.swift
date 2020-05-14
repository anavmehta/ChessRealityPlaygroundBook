//
//  ViewController+UIView.swift
//  ChessReality
//
//  Created by Anav Mehta on 3/05/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit


extension ViewController {
    
    @objc func changePref(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            allowComputerPlay = true
            allowMultipeerPlay = false
            restartGame()
        case 2:
            allowMultipeerPlay = true
            allowComputerPlay = false
            restartGame()
        default:
            allowMultipeerPlay = false
            allowComputerPlay = false
            restartGame()
        }
    }
    
    @objc public func hinted(sender: UIButton!) {
        if(finishedAnalyzing == false) {
            alertController.message = "Not finished analyzing yet"
            playSound(sound: 0)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        if(!planeAnchorAdded) {
            alertController.message = "Please anchor the board first"
            playSound(sound: 0)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        hintButton.setTitleColor(UIColor.red, for: .normal)
        let (_,_,_,_) = self.analyze()
        hintButton.setTitleColor(UIColor.green, for: .normal)
    }
    func setupViews() {
        alertController.addAction(OKAction)
        //let font=UIFont.boldSystemFont(ofSize: 10)
        let defaultFont = "TimesNewRomanPSMT"
        //coachingOverlay.frame = UIScreen.main.bounds
        //self.view.addSubview(coachingOverlay)
        
        
        var font=UIFont(name: defaultFont, size: 20)
        
        //customSC = UISegmentedControl(items: self.items)
        customSC.setTitleTextAttributes([NSAttributedString.Key.font: font!], for: .normal)
        customSC.selectedSegmentIndex = 0
        customSC.backgroundColor = .lightGray
        customSC.tintColor = .white
        self.view.addSubview(customSC)
        
        // Add target action method
        
        customSC.addTarget(self, action: #selector(self.changePref(_:)), for: .valueChanged)
        customSC.translatesAutoresizingMaskIntoConstraints = false
        customSC.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        customSC.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
        customSC.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05).isActive = true
        customSC.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        customSC.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        
        hintButton.setTitle("?", for: .normal)
        hintButton.setImage(hintImg, for: .normal)
        hintButton.setTitleColor(UIColor.green, for: .normal)
        hintButton.addTarget(self, action: #selector(hinted(sender:)), for: .touchUpInside)
        self.view.addSubview(hintButton)
        
        hintButton.translatesAutoresizingMaskIntoConstraints = false
        hintButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = false
        hintButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05).isActive = true
        hintButton.widthAnchor.constraint(equalTo: self.hintButton.heightAnchor).isActive = true
        hintButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        hintButton.topAnchor.constraint(equalTo: self.customSC.bottomAnchor).isActive = true
        
        font=UIFont(name: defaultFont, size: 16)
        sessionInfoLabel.font = font
        sessionInfoLabel.textAlignment = .center
        sessionInfoLabel.backgroundColor = .lightGray
        sessionInfoLabel.textColor = .black
        //sessionInfoLabel.sizeToFit()
        sessionInfoLabel.adjustsFontSizeToFitWidth = true
        self.view.addSubview(sessionInfoLabel)
        
        sessionInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        sessionInfoLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = false
        sessionInfoLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.025).isActive = true
        sessionInfoLabel.topAnchor.constraint(equalTo: self.customSC.bottomAnchor).isActive = true
        sessionInfoLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        sessionInfoLabel.trailingAnchor.constraint(equalTo: self.hintButton.leadingAnchor).isActive = true
        font=UIFont(name: defaultFont, size: 20)
        banner.font = font
        banner.textAlignment = .center
        banner.backgroundColor = .lightGray
        banner.textColor = .black
        //banner.sizeToFit()
        banner.adjustsFontSizeToFitWidth = true
        self.view.addSubview(banner)
        
        banner.translatesAutoresizingMaskIntoConstraints = false
        banner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = false
        banner.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.025).isActive = true
        banner.topAnchor.constraint(equalTo: self.sessionInfoLabel.bottomAnchor).isActive = true
        banner.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        banner.trailingAnchor.constraint(equalTo: self.hintButton.leadingAnchor).isActive = true
        
        font=UIFont(name: defaultFont, size: 12)
        idLabel.font = font
        idLabel.textAlignment = .center
        idLabel.backgroundColor = .red
        idLabel.textColor = .black
        idLabel.lineBreakMode = .byWordWrapping
        idLabel.text = UIDevice.current.name
        idLabel.sizeToFit()
        idLabel.numberOfLines = 0;
        self.view.addSubview(idLabel)
        
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        idLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = false
        idLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.25).isActive = true
        idLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.015).isActive = true
        idLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        idLabel.topAnchor.constraint(equalTo: self.banner.bottomAnchor).isActive = true
        
        
        
        peerIdLabel.font = font
        peerIdLabel.textAlignment = .center
        //peerIdLabel.backgroundColor = .red
        peerIdLabel.textColor = .black
        peerIdLabel.lineBreakMode = .byWordWrapping
        peerIdLabel.text = ""
        peerIdLabel.sizeToFit()
        self.view.addSubview(peerIdLabel)
        
        peerIdLabel.translatesAutoresizingMaskIntoConstraints = false
        peerIdLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.25).isActive = true
        peerIdLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.015).isActive = true
        peerIdLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        peerIdLabel.topAnchor.constraint(equalTo: self.banner.bottomAnchor).isActive = true
        
        
        
        font=UIFont(name: defaultFont, size: 20)
        
        fenBanner.font = font
        fenBanner.textAlignment = .left
        fenBanner.backgroundColor = .lightGray
        fenBanner.textColor = .black
        fenBanner.lineBreakMode = .byWordWrapping
        fenBanner.text = ""
        fenBanner.sizeToFit()
        self.view.addSubview(fenBanner)
        
        fenBanner.translatesAutoresizingMaskIntoConstraints = false
        fenBanner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        fenBanner.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.025).isActive = true
        fenBanner.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        //fenBanner.trailingAnchor.constraint(equalTo: self.hintButton.leadingAnchor).isActive = true
        fenBanner.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        
        
        recordBanner.font = font
        recordBanner.textAlignment = .left
        recordBanner.backgroundColor = .lightGray
        recordBanner.textColor = .black
        recordBanner.lineBreakMode = .byWordWrapping
        recordBanner.text = ""
        recordBanner.sizeToFit()
        self.view.addSubview(recordBanner)
        
        recordBanner.translatesAutoresizingMaskIntoConstraints = false
        recordBanner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        recordBanner.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05).isActive = true
        recordBanner.bottomAnchor.constraint(equalTo: self.fenBanner.topAnchor).isActive = true
        //recordBanner.trailingAnchor.constraint(equalTo: self.hintButton.leadingAnchor).isActive = true
        recordBanner.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        
        
        
    }
}
