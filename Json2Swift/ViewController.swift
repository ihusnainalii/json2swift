//
//  ViewController.swift
//  Json2Swift
//
//  Created by Husnain Ali on 23/02/22.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var rootClassNameFld: NSTextField!
    @IBOutlet weak var saveRootClassNameBtn: NSButton!
    @IBOutlet weak var jsonFormatParserBtn: NSPopUpButton!
    @IBOutlet weak var jsonView: NSTextView!
    @IBOutlet weak var resultView: NSTextView!
    @IBOutlet weak var convertBtn: NSButton!
    
    let manager = JsonManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootClassNameFld.stringValue = JsonManager.rootClassName ?? ""
        saveRootClassNameBtn.target = self
        saveRootClassNameBtn.action = #selector(saveRootClassName)
        convertBtn.target = self
        convertBtn.action = #selector(convertJson)
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    @objc func saveRootClassName() {
        manager.saveRootClassName(rootClassNameFld.stringValue)
    }
    
    @objc func convertJson() {
        let jsonString = jsonView.string
        let format = jsonFormatParserBtn.selectedItem?.identifier?.rawValue ?? ""
        if jsonString.isEmpty {
            alertView(message: "Please insert JSON")
            return
        }
        
        do {
            guard let data = jsonString.data(using: .utf8) else { return }
            guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                return
            }
            
            let object = ClassObject(data: dict)
            resultView.string = manager.parseJson(object: object, format: JsonFormatType(rawValue: format)!)
        } catch {
            print("Error:", error.localizedDescription)
            self.alertView(message: error.localizedDescription)
        }
    }
    
    func alertView(message: String) {
        let alert = NSAlert()
        alert.messageText = message
        alert.alertStyle = .warning
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
}
