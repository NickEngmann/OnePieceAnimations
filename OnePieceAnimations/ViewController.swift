//
//  ViewController.swift
//  OnePieceAnimations
//
//  Created by developing on 1/25/17.
//  Copyright © 2017 QuodCertamine. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Create and add a colored square
        // Create and add a colored square
        for _ in 0...5 {
            let coloredSquare = UIView()
            var randomYOffset = CGFloat( arc4random_uniform(600))
            // set background color to blue
            coloredSquare.backgroundColor = UIColor.blue
            
            // set frame (position and size) of the square
            // iOS coordinate system starts at the top left of the screen
            // so this square will be at top left of screen, 50x50pt
            // CG in CGRect stands for Core Graphics
            coloredSquare.frame = CGRect(x: 0, y: randomYOffset, width: 50, height: 50)
            
            // finally, add the square to the screen
            self.view.addSubview(coloredSquare)
            
            // lets set the duration to 1.0 seconds
            // and in the animations block change the background color
            // to red and the x-position  of the frame
            var duration = Double(arc4random_uniform(40)+30) / 10
            UIView.animate(withDuration: duration, delay: 0, options: [.repeat, .autoreverse], animations: {
                coloredSquare.backgroundColor = UIColor.red
                
                // for the x-position I entered 320-50 (width of screen - width of the square)
                // if you want, you could just enter 270
                // but I prefer to enter the math as a reminder of what's happenings
                coloredSquare.frame = CGRect(x: 320-50, y: randomYOffset, width: 50, height: 50)},
                completion: { finished in
                    duration = Double(arc4random_uniform(40)+30) / 10
                    randomYOffset = CGFloat( arc4random_uniform(600))
            })
        }
        // first set up an object to animate
        // we'll use a familiar red square
        let square = UIView()
        square.frame = CGRect(x: 55, y: 300, width: 20, height: 20)
        square.backgroundColor = UIColor.green
        
        // add the square to the screen
        self.view.addSubview(square)
        
        // now create a bezier path that defines our curve
        // the animation function needs the curve defined as a CGPath
        // but these are more difficult to work with, so instead
        // we'll create a UIBezierPath, and then create a
        // CGPath from the bezier when we need it
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 16,y: 239))
        path.addCurve(to: CGPoint(x: 301, y: 324), controlPoint1: CGPoint(x: 136, y: 373), controlPoint2: CGPoint(x: 178, y: 239))
        
        // create a new CAKeyframeAnimation that animates the objects position
        let anim = CAKeyframeAnimation(keyPath: "position")
        
        // set the animations path to our bezier curve
        anim.path = path.cgPath
        
        // set some more parameters for the animation
        // this rotation mode means that our object will rotate so that it's parallel to whatever point it is currently on the curve
        anim.rotationMode = kCAAnimationRotateAuto
        anim.repeatCount = Float.infinity
        anim.duration = 5.0
        
        // we add the animation to the squares 'layer' property
        square.layer.add(anim, forKey: "animate position along path")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

