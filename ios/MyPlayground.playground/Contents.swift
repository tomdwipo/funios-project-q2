//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport






class MyViewController : UIViewController {
    let label = UILabel()

    let dispatchQueue = DispatchQueue(label: "oke")

    lazy var dispatch1 = DispatchWorkItem {
        print("test1")
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        let test = URLRequest(url: URL(string: "https://www.google.com/")!)
        let ses = URLSession.shared.dataTask(with: test) { data, urlSession, error in
            print(data!)
            self.label.text = "\(data)"
            dispatchGroup.leave()
        }
        ses.resume()
        dispatchGroup.wait()
    }
    let dispatch2 = DispatchWorkItem {
        print("test2")
        #colorLiteral(red: 0.981832087, green: 0.8541728854, blue: 0.7299938798, alpha: 1)
    }


    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
        
        view.addSubview(label)
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dispatchQueue.async {
            self.dispatch1.perform()
            self.dispatch2.perform()
        }
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
