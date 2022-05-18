//
//  ViewController.swift
//  ListaTareaCD
//
//  Created by Mac13 on 11/05/22.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var listaTareas = [Tarea]()
    
    var tareaEnviar: Tarea?
    
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var tablaTareas: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Delegado
        tablaTareas.delegate = self
        tablaTareas.dataSource = self
        
        //leer info de bd
        leerTareas()
    }
    
    override func viewWillAppear(_ animated: Bool){
        leerTareas()
    }
    
    func leerTareas(){
        let solicitud : NSFetchRequest<Tarea> = Tarea.fetchRequest()
        
        do {
            //Guardar todos los datos de la entidad tarea en el arreglo
            listaTareas = try contexto.fetch(solicitud)
        } catch  {
            print(error.localizedDescription)
        }
        tablaTareas.reloadData()
    }

    @IBAction func agragarTareaBtn(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "nuevo", sender: self)
    }
    
    //MARK: - Tabla metodos
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Guardar tarea a mandar
        tareaEnviar = listaTareas[indexPath.row]
        //Habilita navegacion si hay un segue llamado editar
        performSegue(withIdentifier: "editar", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editar"{
            let objDestino = segue.destination as! EditarTareaViewController
            objDestino.recibirTarea = tareaEnviar
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaTareas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaTareas.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        celda.textLabel?.text = listaTareas[indexPath.row].titulo
        celda.detailTextLabel?.text = "\(listaTareas[indexPath.row].fecha!)"
        
        //let imagenCD = UIImage(data: listaTareas[indexPath.row].imagen!)
        //celda.imageView?.image = imagenCD
        return celda
    }
    
    
    
}

