//
//  ViewController.swift
//  practica4
//
//  Created by Noe Romano Vazquez on 14/01/22.
//  Copyright © 2022 noeromano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var empleados = [Empleado]()
    
    @IBOutlet weak var tableViewm: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableViewm.dataSource = self
        tableViewm.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
    var request = URLRequest(url: URL(string: "https://netec-swift.herokuapp.com/empleados.php")!)
    request.httpMethod="GET"
    let task = URLSession.shared.dataTask(with: request){
        data,response,error in
        if error != nil {
            print("Error en al peticion\(String(describing: error))")
        }
        do {
            let objs = try JSONDecoder().decode([Empleado].self, from: data!)
            print(objs)
            objs.forEach { (emp) in
                print(emp.name)
            }
            self.empleados = objs
        }catch{
            
        }
    }
    
    task.resume()
    
        DispatchQueue.main.async {
            print("Hola - \(self.empleados.count)")
        }
    }
    
    @IBAction func actualizarInfo(_ sender: Any) {
        tableViewm.reloadData();
    }
}
extension ViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("1 - \(empleados.count)");
        return empleados.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = "\(empleados[indexPath.row].employeeNumber!)"
        cell.detailTextLabel?.text = "\(empleados[indexPath.row].name!)"
        print("2 - \(empleados[indexPath.row].employeeNumber!) - \(empleados[indexPath.row].name!)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vcd = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VC2") as? ViewController2{
            vcd.Empleados = empleados[indexPath.row]
            vcd.indice = indexPath.row
            
            vcd.callBack = {
                (nombre,email,contraseña,fecha,telefono,number,indice)in
                print("Data \(nombre) - \(email) - \(contraseña) - \(fecha) - \(telefono) - \(number) - \(indice)")
                
                self.empleados[indice].name = nombre
                self.empleados[indice].birthDate = fecha
                self.empleados[indice].email = email
                self.empleados[indice].pass = contraseña
                self.empleados[indice].phoneNumber = telefono
                self.empleados[indice].employeeNumber = number

                print("Done!");
                self.tableViewm.reloadData();
            }
            
            self.present(vcd, animated: true) {
                print("Done!")
            }
        }
    }
}
