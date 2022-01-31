//
//  SignupViewController.swift
//  Travel
//
//  Created by Buse Köseoğlu on 26.12.2021.
//

import UIKit
import CoreData

class SignupViewController: UIViewController {

   
    @IBOutlet weak var passwordtext: UITextField!
    @IBOutlet weak var verifyPasswordText: UITextField!
    @IBOutlet weak var mailtext: UITextField!
    
    @IBOutlet weak var middleLabel: UILabel!
    
    var mailArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        middleLabel.layer.masksToBounds = true
        middleLabel.layer.cornerRadius = 8
        
        passwordtext.isSecureTextEntry = true
        verifyPasswordText.isSecureTextEntry = true
        
    }
    
    @IBAction func signupClicked(_ sender: Any) {
        let passwordRegPattern = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let password = NSEntityDescription.insertNewObject(forEntityName: "UserInfo", into: context)
        let mail = NSEntityDescription.insertNewObject(forEntityName: "UserInfo", into: context)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInfo")
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject]{
                if let mail = result.value(forKey: "mail") as? String{
                    self.mailArray.append(mail)
                }
                
            }
        }
        catch{
            print("error")
        }
        
        if(mailArray.contains(mailtext.text!)){
            let alert = UIAlertController(title: "Account Exists", message: "There is an account with this email address.", preferredStyle: .alert)
            // add an action (button)
            //alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    _ = self.navigationController?.popViewController(animated: true)
                }
            alert.addAction(okAction)
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
        }else{
            if ((passwordtext.text?.range(of: passwordRegPattern, options: .regularExpression) != nil)&&(mailtext.text?.range(of: emailRegEx, options: .regularExpression) != nil)){
                if (passwordtext.text == verifyPasswordText.text){
                    
                    // create the alert
                    let alert = UIAlertController(title: "Registration Successful", message: "You are redirected to the login page", preferredStyle: .alert)
                    // add an action (button)
                    //alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                            UIAlertAction in
                        password.setValue(self.passwordtext.text, forKey: "password")
                        mail.setValue(self.mailtext.text, forKey: "mail")
                            _ = self.navigationController?.popViewController(animated: true)
                        }
                    alert.addAction(okAction)
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    // create the alert
                    let alert = UIAlertController(title: "Password Error", message: "Passwords do not match", preferredStyle: .alert)
                    // add an action (button)
                    //alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                            UIAlertAction in
                        }
                    alert.addAction(okAction)
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                }
            }else{
                // create the alert
                let alert = UIAlertController(title: "Invalid Information", message: "Check E-Mail and Password again", preferredStyle: .alert)
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
        
        
        
       
        
    }
    
    


}
