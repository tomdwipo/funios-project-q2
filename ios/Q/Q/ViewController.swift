//
//  ViewController.swift
//  Q
//
//  Created by Tommy-a on 29/05/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageTest: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label1: UILabel!
    var newLabel1 = "loading"
    var newLabel3 = "loading"

    let dispatch = DispatchQueue(label: "test")
    lazy var dispatch1 = DispatchWorkItem {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        let test = URLRequest(url: URL(string: "https://www.google.com/")!)
        let config = URLSessionConfiguration.default
        let urlses = URLSession(configuration: config)
       let test22 = urlses.dataTask(with: test, completionHandler: { data, urlSession, error in
           self.dispatchUpdate(group: dispatchGroup) {
               print("test1")
               self.label1.text = "\(data)"

           }
            dispatchGroup.leave()

           
       })
        test22.resume()
        dispatchGroup.wait()
    }
    
    lazy var dispatch3 = DispatchWorkItem {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        let test = URLRequest(url: URL(string: "https://www.google.com/")!)
        let config = URLSessionConfiguration.default
        let urlses = URLSession(configuration: config)
       let test22 = urlses.dataTask(with: test, completionHandler: { data, urlSession, error in
         
               self.dispatchUpdate {
                   print("test3")
                   self.label3.text = "\(data)"
               }
           dispatchGroup.leave()
          
           
       })
        test22.resume()
        dispatchGroup.wait()
    }
    lazy var dispatch2 = DispatchWorkItem {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        let test = URLRequest(url: URL(string: "https://www.google.com/")!)
        let config = URLSessionConfiguration.default
        let urlses = URLSession(configuration: config)
       let test22 = urlses.dataTask(with: test, completionHandler: { data, urlSession, error in
         
               self.dispatchUpdate(group: dispatchGroup)  {
                   print("test2")
                   self.label2.text = "\(data)"

               }
           dispatchGroup.leave()

           
       })
        test22.resume()
        dispatchGroup.wait()

    }
    
    lazy var dispatch4 = DispatchWorkItem {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        let test = URLRequest(url: URL(string: "https://www.google.com/")!)
        let config = URLSessionConfiguration.default
        let urlses = URLSession(configuration: config)
       let test22 = urlses.dataTask(with: test, completionHandler: { data, urlSession, error in
         
               self.dispatchUpdate {
                   print("test4")
                   self.label4.text = "\(data)"
               }
                dispatchGroup.leave()
          
           
       })
        test22.resume()
        dispatchGroup.wait()

    }
    
    lazy var dispatch5 = DispatchWorkItem {
        for i in 0...100{
            print(i)
            self.label4.text = i.description
        }
    }
    
    let dispatchQu = DispatchQueue(label: "tewsting")
    let dispatchQu2 = DispatchQueue(label: "number", qos: .background)
    let dispatchQu3 = DispatchQueue(label: "imageTest", qos: .userInteractive)

//    let group = DispatchSemaphore(value: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        self.test { data in
            self.imageTest.image = data
            self.activityIndicator.stopAnimating()

            
        }
  
  

//                self.group.signal()
                self.dispatch2.perform()
        self.dispatch5.perform()
           
            self.dispatchQu.async(execute: self.dispatch1)
            
//            group.wait()
            
          
                self.dispatch3.perform()
      

                self.dispatch4.perform()
//                self.group.signal()
         
              self.fetchData { data in
                  self.label4.text = (data?.debugDescription ?? "") + "oke"
              }
            self.dispatchQu2.async(execute: {
                for i in 0...5000 {
                    print(i)
                    DispatchQueue.main.async(execute: {
                        self.label4.text = i.description

                    })
                }

            })
            
        
//            self.group.wait()
        

      
        // Do any additional setup after loading the view.
    }

    
    func dispatchUpdate(_ async:@escaping ()->Void, group : DispatchGroup = DispatchGroup()){
        DispatchQueue.main.async( execute: async)
    }
    
    func fetchData(result:@escaping (_ data: Data?)-> Void){
        let urlSessionConfig = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: urlSessionConfig)
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        let urlRequest = URLRequest(url: url)
        let urlSessionDataTask = urlSession.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                result(data)
            }
        }
        urlSessionDataTask.resume()
    }
    
    func test(result:@escaping (_ data: UIImage?)-> Void) {
        var uiimage: UIImage?
        let link = "https://images.unsplash.com/photo-1605701250441-2bfa95839417?q=80&w=2972&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
        guard let url = URL(string: link) else { return }
        var data: Data?
        dispatchQu3.async {
            data = try? Data(contentsOf: url, options: .uncached)
            if let data = data {
                self.dispatchUpdate({
                    uiimage = UIImage(data: data)
                    result(uiimage)
                })
            }
        }
    }

}

