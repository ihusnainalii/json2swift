//
//  SourceEditorCommand.swift
//  Json2SwiftExtension
//
//  Created by Husnain Ali on 23/02/22.
//

import Foundation
import XcodeKit
import AppKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    var buffer: XCSourceTextBuffer!
    
    let manager = JsonManager()
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        
        self.buffer = invocation.buffer
        
        let jsonString = NSPasteboard.general.string(forType: .string)
        if let data = jsonString?.data(using: .utf8) {
            do {
                guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                    completionHandler(nil)
                    return
                }
                let object = ClassObject(data: dict)
                output(object: object, identifier: invocation.commandIdentifier)
            } catch {
                
            }
        }
        
        completionHandler(nil)
    }
    
    func output(object: ClassObject, identifier: String) {
        guard let range = self.buffer.selections.firstObject as? XCSourceTextRange else { return }
        let startLine = range.start.line
        var endLine = range.end.line - range.start.line + 1
        
        let totalLines = self.buffer.lines.count
        if (startLine + endLine) > totalLines {
           endLine = totalLines - startLine
        }
        
        self.buffer.lines.removeObjects(in: NSRange(location: startLine, length: endLine))
        
        let formatType = JsonFormatType(rawValue: identifier)!
        self.buffer.lines.insert(manager.parseJson(object: object, format: formatType), at: range.start.line)
        
        let selection = XCSourceTextRange(start: XCSourceTextPosition(line: 0, column: 0), end: XCSourceTextPosition(line: 0, column: 0))
        self.buffer.selections.removeAllObjects()
        self.buffer.selections.insert(selection, at: 0)
    }
}
