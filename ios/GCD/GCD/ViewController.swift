//
//  ViewController.swift
//  GCD
//
//  Created by Tommy-a on 14/06/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loading: UILabel!
    
    @IBOutlet weak var imageViewShow: UIImageView!
    let dispatch = DispatchQueue(label: "loading",qos: .userInitiated)
    let semaphore = DispatchSemaphore(value: 0)
    
    let urlImage = "https://images.unsplash.com/photo-1605701250441-2bfa95839417?q=80&w=2972&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: urlImage)
        var data: Data?
        print("OKE1")

        self.dispatch.asyncAfter(deadline: .now(), execute: {
            for i in 0...5 {
                print(i)
                if i == 5 {
                    data = try! Data(contentsOf: url!)
                }
                sleep(UInt32(1.5))

                DispatchQueue.main.async {
                    if let datas = data {
                        self.imageViewShow.image = UIImage(data: datas)
                    }
                    
                    self.loading.text = "\(i)"
                }
            }
        })
       
        DispatchQueue.main.async {
            print("OKE5")
        }
        
        print("OKE")

    }
    
    
    
}

