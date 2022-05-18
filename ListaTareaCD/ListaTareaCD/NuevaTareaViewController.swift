//
//  NuevaTareaViewController.swift
//  ListaTareaCD
//
//  Created by Mac13 on 11/05/22.
//

import UIKit
import CoreData

class NuevaTareaViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textoTareaLbl: UITextField!
    @IBOutlet weak var fechaTareaPicker: UIDatePicker!
    @IBOutlet weak var imagenTarea: UIImageView!
    
    //MARK: - Conexion a la bd  o al contexto
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Habilita escritura para agregar nueva tarea
        textoTareaLbl.delegate = self
        textoTareaLbl.becomeFirstResponder()
    }
    

    @IBAction func guardarTareaBtn(_ sender: UIBarButtonItem) {
        //Validar que no este vacio
        if let tituloTarea = textoTareaLbl.text, !tituloTarea.isEmpty{
            let fechaTarea = fechaTareaPicker.date
            //Crear nuevo objeto
            let nuevoElemento = Tarea(context: self.contexto)
            nuevoElemento.titulo = tituloTarea
            nuevoElemento.fecha = fechaTarea
            
            do{
                try contexto.save()
                print("se guardo coore data")
            }catch{
                print(error.localizedDescription)
            }
            //Regresar a la pantalla anterior
            navigationController?.popToRootViewController(animated: true)
        } else {
            print("escribir algo")
            textoTareaLbl.placeholder = "Necesitas escribir una nota para guardarla"
        }
    }
    

}
