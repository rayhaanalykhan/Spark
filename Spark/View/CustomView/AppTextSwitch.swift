//
//  AppTextSwitch.swift
//  Spark
//
//  Created by rayhaanalykhan on 26/06/2024.
//

import UIKit

@IBDesignable
class AppTextSwitch: UIControl {
    
    private var backgroundView: UIView!
    private var toggleView: UIView!
    private var stateLabel: UILabel!
    
    @IBInspectable var onText: String = "ON" {
        didSet {
            if isOn {
                stateLabel.text = onText
            }
        }
    }
    
    @IBInspectable var offText: String = "OFF" {
        didSet {
            if !isOn {
                stateLabel.text = offText
            }
        }
    }
    
    @IBInspectable var onFGColor: UIColor = .white {
        didSet {
            if isOn {
                toggleView.backgroundColor = onFGColor
                stateLabel.textColor = onFGColor
            }
        }
    }
    
    @IBInspectable var offFGColor: UIColor = .white {
        didSet {
            if !isOn {
                toggleView.backgroundColor = offFGColor
                stateLabel.textColor = offFGColor
            }
        }
    }
    
    @IBInspectable var onBGColor: UIColor = .green {
        didSet {
            if isOn {
                backgroundView.backgroundColor = onBGColor
            }
        }
    }
    
    @IBInspectable var offBGColor: UIColor = .gray {
        didSet {
            if !isOn {
                backgroundView.backgroundColor = offBGColor
            }
        }
    }
    
    private var isOn: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        
        self.backgroundColor = .clear
        
        // Background view
        backgroundView = UIView(frame: self.bounds)
        backgroundView.layer.cornerRadius = self.bounds.height / 2
        backgroundView.backgroundColor = offBGColor
        self.addSubview(backgroundView)
        
        // Toggle view
        let toggleWidth = self.bounds.height
        toggleView = UIView(frame: CGRect(x: 0, y: 0, width: toggleWidth, height: toggleWidth))
        toggleView.layer.cornerRadius = toggleWidth / 2
        toggleView.backgroundColor = offFGColor
        self.addSubview(toggleView)
        
        // State label
        stateLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
        stateLabel.textAlignment = .center
        stateLabel.textColor = offFGColor
        stateLabel.text = offText
        self.addSubview(stateLabel)
        
        // Tap Gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleSwitch))
        self.addGestureRecognizer(tapGesture)
        
        // Drag Gesture
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        toggleView.addGestureRecognizer(panGesture)
    }
    
    @objc private func toggleSwitch() {
        
        self.isOn.toggle()
        animateToggle()
        sendActions(for: .valueChanged)
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: self)
        let toggleWidth = self.bounds.height
        let newX = toggleView.frame.origin.x + translation.x
        
        if newX >= 0 && newX <= self.bounds.width - toggleWidth {
            toggleView.frame.origin.x = newX
            gesture.setTranslation(.zero, in: self)
        }
        
        if gesture.state == .ended {
            
            let midPoint = (self.bounds.width - toggleWidth) / 2
            let originX = toggleView.frame.origin.x
            
            if originX > midPoint && self.isOn == false { // on
                
                self.isOn = true
                sendActions(for: .valueChanged)
                
            } else if originX < midPoint && self.isOn == true { // off
                
                self.isOn = false
                sendActions(for: .valueChanged)
            }
            animateToggle()
        }
    }
    
    private func animateToggle() {
        
        let toggleWidth = self.bounds.height
        
        UIView.animate(withDuration: 0.3) { [self] in
            
            if self.isOn {
                
                self.toggleView.frame.origin.x = self.bounds.width - toggleWidth
                self.backgroundView.backgroundColor = onBGColor
                self.toggleView.backgroundColor = onFGColor
                self.stateLabel.textColor = onFGColor
                self.stateLabel.text = onText
                
            } else {
                
                self.toggleView.frame.origin.x = 0
                self.backgroundView.backgroundColor = offBGColor
                self.toggleView.backgroundColor = offFGColor
                self.stateLabel.textColor = offFGColor
                self.stateLabel.text = offText
            }
        }
    }
    
    func getIsOn() -> Bool {
        return self.isOn
    }
}
