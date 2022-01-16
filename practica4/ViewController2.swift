//
//  ViewController2.swift
//  practica4
//
//  Created by Noe Romano Vazquez on 14/01/22.
//  Copyright © 2022 noeromano. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    var Empleados:Empleado!
    var indice:Int!
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var contraseña: UITextField!
    @IBOutlet weak var FechaNacimiento: UITextField!
    @IBOutlet weak var telefono: UITextField!
    @IBOutlet weak var noEmpleado: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        nombre.text = Empleados.name
        email.text = Empleados.email
        contraseña.text = Empleados.pass
        FechaNacimiento.text = Empleados.birthDate
        telefono.text = Empleados.phoneNumber
        noEmpleado.text = "NoEmpleado - \(Empleados.employeeNumber!)"
        // Do any additional setup after loading the view.
    }
    @IBAction func actualizar(_ sender: Any) {
        callBack?(nombre.text!,email.text ?? "",contraseña.text ?? "",FechaNacimiento.text ?? "",telefono.text ?? "",Empleados.employeeNumber ?? "",indice)
            self.dismiss(animated: true, completion: nil)
        }
            
    var callBack:((String,String,String,String,String,String,Int)->Void)?
    
    @IBAction func compartir(_ sender: Any) {
        
        let activityCtrl = UIActivityViewController(activityItems: [NSLocalizedString("Hola  \(Empleados.name!) feliz cumpleaños. Pastela increible.", comment: "PD: Noe Romano")], applicationActivities: nil)
        
        self.present(activityCtrl, animated: true,completion: nil)    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
