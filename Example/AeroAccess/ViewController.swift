//
//  ViewController.swift
//  AeroAccess
//
//  Created by nemanjacvetkovic-syncit on 11/29/2023.
//  Copyright (c) 2023 nemanjacvetkovic-syncit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var startServiceButton: UIButton!
    @IBOutlet weak var syncDataButton: UIButton!
    
    var viewModel: ViewModel?
    private var isStarted = false
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.viewModel = ViewModel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startServiceButtonPressed() {
        isStarted.toggle()
        updateMist()
    }
    
    @IBAction func syncDataButtonPressed() {
    }
    
    private func updateMist() {
        if isStarted {
            viewModel?.start()
            startServiceButton.setTitle("Stop Service", for: .normal)
        } else {
            viewModel?.stop()
            startServiceButton.setTitle("Start Service", for: .normal)
        }
    }
}

