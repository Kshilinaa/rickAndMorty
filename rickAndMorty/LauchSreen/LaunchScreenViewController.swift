//
//  LaunchScreenViewController.swift
//  rickAndMorty
//
//  Created by Ксения Шилина on 04.11.2023.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.backgroundColor = .white
        
        let nameImageView = UIImageView(image: UIImage(named: "nameR&M"))
        nameImageView.frame = CGRect(x: 50, y: 100, width: 312, height: 104)
        view.addSubview(nameImageView)
        
        let spiralImageView = UIImageView(image: UIImage(named: "spiral"))
        spiralImageView.frame = CGRect(x: 100, y: 300, width: 200, height: 200)
        view.addSubview(spiralImageView)
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
                rotationAnimation.toValue = NSNumber(value: Double.pi * 2.0)
                rotationAnimation.duration = 3.0 
                rotationAnimation.isCumulative = true
                rotationAnimation.repeatCount = .infinity
                spiralImageView.layer.add(rotationAnimation, forKey: "rotationAnimation")
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
