//
//  CodableManager.swift
//  Json2Swift
//
//  Created by Husnain Ali on 27/02/22.
//

import Foundation

class CodableManager {
    func parse(className: String, data: [String : Any]) -> String {
        let result = """
/// DTO for \(className), containes Data Member, Coding Key and Decoding for JSON
struct \(className): Codable {

    // MARK: - Data Member
\(parseProperties(data))

    // MARK: - Coding Key
\(codingKeys(data))

    // MARK: - Stuct Initializer
\(parserInit(data))

    // MARK: - Decoding
    /// Creates a new instance by decoding from the given decoder.
    /// - Parameter decoder: the decoder to read data from.
    /// - Throws: This initializer throws an error if reading from the decoder fails, or if the data read is corrupted or otherwise invalid.
\(parser(data))
}
"""
        return result
    }
    
    private func parseProperties(_ data: [String : Any]) -> String {
        var result = ""
        
        for item in data.enumerated() {
            result.append(formatProperty(key: item.element.key, value: item.element.value))
            if item.offset != data.count - 1 {
                result.append("\n")
            }
        }
        return result
    }
    
    private func formatProperty(key: String, value: Any) -> String {
        let name = JsonManager.propertyName(fromKey: key)
        let cName = JsonManager.className(fromKey: key)
        
        let type = JsonType(value)
        switch type {
        case .bool:
            return "    let \(name): Bool?"
        case .integer:
            return "    let \(name): Int?"
        case .double:
            return "    let \(name): Double?"
        case .object:
            return "    let \(name): \(cName)?"
        case .array:
            if let arrayValue = (value as? [Any])?.first {
                let arrayValueType = JsonType(arrayValue)
                if let _ = arrayValue as? [String : Any] {
                    return "    let \(name): [\(cName)]?"
                } else if let typeData = arrayValueType.typeData {
                    return "    let \(name): [\(typeData)]?"
                }
            }
            return "    let \(name): [Any]?"
        default:
            return "    let \(name): String?"
        }
    }
    
    private func codingKeys(_ data: [String : Any]) -> String {
        var keys = ""
        for item in data.enumerated() {
            let propertyName = JsonManager.propertyName(fromKey: item.element.key)
            keys.append("       case \(propertyName) = \"\(item.element.key)\"")
            if item.offset != data.count - 1 {
                keys.append("\n")
            }
        }
        return """
    enum CodingKeys: String, CodingKey {
\(keys)
    }
"""
    }
    
    private func parserInit(_ data: [String : Any]) -> String {
        var propertiesParserInitResult = ""
        for item in data.enumerated() {
            propertiesParserInitResult.append(formatPropertyInit(key: item.element.key, value: item.element.value))
            if item.offset != data.count - 1 {
                propertiesParserInitResult.append("\n")
            }
        }
        return """
    init() {
\(propertiesParserInitResult)
    }
"""
    }
    
    private func parser(_ data: [String : Any]) -> String {
        var propertiesParserResult = ""
        
        for item in data.enumerated() {
            propertiesParserResult.append(formatPropertyParser(key: item.element.key, value: item.element.value))
            if item.offset != data.count - 1 {
                propertiesParserResult.append("\n")
            }
        }
        return """
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
\(propertiesParserResult)
    }
"""
    }
    
    private func formatPropertyParser(key: String, value: Any) -> String {
        let name = JsonManager.propertyName(fromKey: key)
        let cName = JsonManager.className(fromKey: key)
        
        let type = JsonType(value)
        switch type {
        case .bool, .integer, .double, .string:
            return "        \(name) = try values.decodeIfPresent(\(type.typeData!).self, forKey: .\(name))"
        case .object:
            return "        \(name) = try values.decodeIfPresent(\(cName).self, forKey: .\(name))"
        case .array:
            if let arrayValue = (value as? [Any])?.first {
                let arrayValueType = JsonType(arrayValue)
                if let _ = arrayValue as? [String : Any] {
                    return "        \(name) = try values.decodeIfPresent([\(cName)].self, forKey: .\(name))"
                } else if let typeData = arrayValueType.typeData {
                    return "        \(name) = try values.decodeIfPresent([\(typeData)].self, forKey: .\(name))"
                }
            }
            return "        \(name) = try values.decodeIfPresent([Any].self, forKey: .\(name))"
        }
    }
    
    private func formatPropertyInit(key: String, value: Any) -> String {
        let name = JsonManager.propertyName(fromKey: key)
        let cName = JsonManager.className(fromKey: key)
        
        let type = JsonType(value)
        switch type {
        case .bool:
            return "        self.\(name) = false"
        case .integer:
            return "        self.\(name) = 0"
        case .double:
            return "        self.\(name) = 0"
        case .string:
            return "        self.\(name) = \"\""
        case .object:
            return "        self.\(name) = \(cName)()"
        case .array:
            return "        self.\(name) = []"
        }
    }
}
