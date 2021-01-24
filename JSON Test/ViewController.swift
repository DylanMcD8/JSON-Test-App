//
//  ViewController.swift
//  JSON Test
//
//  Created by Dylan McDonald on 11/1/20.
//

import UIKit

var generalMessage: String = ""
var oakbrookMessage: String = ""
var generalShouldShow: String = "No"
var oakbrookShouldShow: String = "No"
var generalID: Int = 0

class JSONTestTableViewController: UITableViewController {

   
    @IBOutlet weak var generalShouldShowLabel: UILabel!
    @IBOutlet weak var generalMessageLabel: UILabel!
    @IBOutlet weak var generalIDLabel: UILabel!
    
    @IBOutlet weak var oakbrookShouldShowLabel: UILabel!
    @IBOutlet weak var oakbrookMessageLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        blurView.layer.cornerCurve = .continuous
        getMessage()
    }
    
    @IBAction func refreshButton(_ sender: Any) {
        getMessage()
        lightHaptics()
    }
    
    func getMessage() {
        struct GeneralResponse: Codable { // or Decodable
            let message: String
            let shouldShow: String
            let id: Int
        }
        
        struct OakbrookResponse: Codable { // or Decodable
            let message: String
            let shouldShow: String
        }

        if let url = URL(string: "https://dylanmcd8.github.io/SchoolAssistantAnnouncements/general.json") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let res = try JSONDecoder().decode(GeneralResponse.self, from: data)
                        generalShouldShow = res.shouldShow
                        generalMessage = res.message
                        generalID = res.id
                    } catch let error {
                        print(error)
                    }
                }
            }.resume()
        }
        
        if let url = URL(string: "https://dylanmcd8.github.io/SchoolAssistantAnnouncements/oakbrook.json") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let res = try JSONDecoder().decode(OakbrookResponse.self, from: data)
                        oakbrookShouldShow = res.shouldShow
                        oakbrookMessage = res.message
                    } catch let error {
                        print(error)
                    }
                }
            }.resume()
        }
        
        self.setLabel()
    }
    
    
    func setLabel() {
        DispatchQueue.main.async {
            self.generalShouldShowLabel.text = generalShouldShow
            self.generalMessageLabel.text = generalMessage
            self.generalIDLabel.text = "\(generalID)"
            
            self.oakbrookShouldShowLabel.text = oakbrookShouldShow
            self.oakbrookMessageLabel.text = oakbrookMessage
            
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }
    
}

