//
//  EditarTareaViewController.swift
//  ListaTareaCD
//
//  Created by Mac13 on 11/05/22.
//

import UIKit
import CoreData

class EditarTareaViewController: UIViewController {
    
    var recibirTarea: Tarea?
    
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var tituloTarea: UITextField!
    @IBOutlet weak var fechaTarea: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tituloTarea.text = recibirTarea?.titulo ?? ""
        fechaTarea.date = (recibirTarea?.fecha)!
    }
    
    @IBAction func guardarBtn(_ sender: UIButton) {
        recibirTarea?.titulo = tituloTarea.text ?? ""
        recibirTarea?.fecha = fechaTarea.date
        
        do {
            try contexto.save()
        } catch {
            print(error.localizedDescription)
        }
        //Regresar al vc Principal
        navigationController?.popToRootViewController(animated: true)
    }
    
    

}
