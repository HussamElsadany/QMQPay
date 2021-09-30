//
//  ViewController.swift
//  QMQPay
//
//  Created by hussam.elsadany@gmail.com on 09/30/2021.
//  Copyright (c) 2021 hussam.elsadany@gmail.com. All rights reserved.
//

import UIKit
import QMQPay

class ViewController: UIViewController {

    @IBOutlet weak var tokenField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var projectIdField: UITextField!
    @IBOutlet weak var merchantNameField: UITextField!
    @IBOutlet weak var merchantIDField: UITextField!
    @IBOutlet weak var merchantDefDataField: UITextField!
    @IBOutlet weak var privateKeyField: UITextField!
    @IBOutlet weak var privateKeyIDField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var descField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func process(_ sender: Any) {

        let config = ConfigModel(environment: .QatarPayEnviromentSandBox,
                                 token: self.tokenField.text!,
                                 projectId: self.projectIdField.text!,
                                 merchantName: self.merchantNameField.text!,
                                 merchantDefinedData: self.merchantDefDataField.text!,
                                 merchantId: self.merchantIDField.text!,
                                 merchantEmail: self.emailField.text!,
                                 privateKey: self.privateKeyField.text!,
                                 privateKeyId: self.privateKeyIDField.text!,
                                 amount: Double(self.amountField.text!) ?? 1,
                                 description: self.descField.text!)

        let vc = QatarPaySceneConfigurator.configure(config: config)
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func autoFill(_ sender: Any) {
        self.tokenField.text = "YJ9p-drXPw5gmE9d49WzIO0NTEcCqqAeKwYUEgfN4XpstDkmiYZY5ZDFFUSYfhkea2XWh0ytkqMz4B9E0c6qk0QX1Jif77A-ZSdcEATJutrcYqnNI7X74ixM6mWGKMkmUVOYX9DU5vjyW5QQv9DobKDS8PDixmUWD9niZTOXST-GYQ8OHVPrTdipVzWhMOjtf7f8WB_0-oP49jhteOPNn4HbRr7JquqEUzliTIc7d8j81WIDNxc8SwpQYNvm_vY_73u_7VPGmaR9ndQgeXatXyV73OzrcYG5fphoJqDUt__hC5zOtwa0KgWJXfGWr738e-OIRocyc27HzXTMm8MeTmv1TtqtGOa7px0quMgIJ-X9jraMAA_sVza3N2tmoVnOXHbHPvj-lshk_GAc622YMi4MCsaUW4xJ8LWYfesZh1xW6SYDHYqlDR7X-94X6GbwSPk5avQAoaBn1dImj-WtOMYyILsntS9hTfkZ9gbnPIE_fwRB1E3kilAglpPVYZgH7VEFDZEv3-RZH-JvGJS27A1ANSCKOp9d-xC8wjQrVho0T7rCPVJvH5rcFt7tZO5KAwc3KJ-oa9uCNeyqR4BFfA"
        self.emailField.text = "z.nidal@qmobileme.com"
        self.projectIdField.text = "QmQp1358"
        self.merchantNameField.text = "Merchant Name Bla."
        self.merchantIDField.text = "1"
        self.merchantDefDataField.text = "Tra59835"
        self.privateKeyField.text = "LadaNAyiKAz"
        self.privateKeyIDField.text = "101011"
        self.amountField.text = "1"
        self.descField.text = "Transa45396"
    }
}

extension ViewController: QatarPayDelegate {

    func paymentSuccess(controller: QatarPayViewController, processPayment: ProcessPaymentModel) {
        controller.navigationController?.popViewController(animated: true)
        let message = "Transaction Success \(processPayment.success)"
        let alertView = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alertView, animated: true, completion: nil)
    }

    func paymentFailed(controller: QatarPayViewController, message: String) {
        controller.navigationController?.popViewController(animated: true)
        let alertView = UIAlertController(title: "Failed", message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alertView, animated: true, completion: nil)
    }
}
