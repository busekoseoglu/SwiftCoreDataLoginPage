//
//  ViewController.swift
//  Travel
//
//  Created by Buse Köseoğlu on 26.12.2021.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var middleLabel: UILabel!
    @IBOutlet weak var mailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    var mailArray = [String]()
    var passwordArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        middleLabel.layer.masksToBounds = true
        middleLabel.layer.cornerRadius = 8
        
        passwordText.isSecureTextEntry = true
        
    }

    @IBAction func signinClicked(_ sender: Any) {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInfo")
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject]{
                if let mail = result.value(forKey: "mail") as? String{
                    self.mailArray.append(mail)
                }
                if let password = result.value(forKey: "password") as? String{
                    self.passwordArray.append(password)
                }
                
            }
        }
        catch{
            print("error")
        }
        
        if (mailArray.contains(mailText.text!)){
            let mailIndex = mailArray.firstIndex(where: {$0 == mailText.text})
            
            if passwordArray[mailIndex!] == passwordText.text{
                performSegue(withIdentifier: "toMainPageVC", sender: nil)
            }
        }
        else{
            // create the alert
            let alert = UIAlertController(title: "Not Found", message: "No account found for this e-mail address", preferredStyle: .alert)
            // add an action (button)
            //alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                    UIAlertAction in
                }
            alert.addAction(okAction)
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        performSegue(withIdentifier: "toSignupVC", sender: nil)
    }
    
    
}

