//
//  SampleDTO.swift
//  Json2Swift
//
//  Created by Husnain ALi on 01/03/2022.
//

/// DTO for SampleDTO, containes Data Member, Coding Key and Decoding for JSON
struct SampleDTO: Codable {

    // MARK: - Data Member
    let acronym: String?
    let glossary: Glossary?
    let id: Int?
    let glossDef: GlossDef?
    let sortAs: Bool?
    let abbrev: Double?
    let glossTerm: String?
    let glosssee: String?

    // MARK: - Coding Key
    enum CodingKeys: String, CodingKey {
       case acronym = "acronym"
       case glossary = "glossary"
       case id = "id"
       case glossDef = "gloss_def"
       case sortAs = "sort_as"
       case abbrev = "abbrev"
       case glossTerm = "gloss_term"
       case glosssee = "GlossSee"
    }

    // MARK: - Stuct Initializer
    init() {
        self.acronym = ""
        self.glossary = Glossary()
        self.id = 0
        self.glossDef = GlossDef()
        self.sortAs = false
        self.abbrev = 0
        self.glossTerm = ""
        self.glosssee = ""
    }

    // MARK: - Decoding
    /// Creates a new instance by decoding from the given decoder.
    /// - Parameter decoder: the decoder to read data from.
    /// - Throws: This initializer throws an error if reading from the decoder fails, or if the data read is corrupted or otherwise invalid.
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        acronym = try values.decodeIfPresent(String.self, forKey: .acronym)
        glossary = try values.decodeIfPresent(Glossary.self, forKey: .glossary)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        glossDef = try values.decodeIfPresent(GlossDef.self, forKey: .glossDef)
        sortAs = try values.decodeIfPresent(Bool.self, forKey: .sortAs)
        abbrev = try values.decodeIfPresent(Double.self, forKey: .abbrev)
        glossTerm = try values.decodeIfPresent(String.self, forKey: .glossTerm)
        glosssee = try values.decodeIfPresent(String.self, forKey: .glosssee)
    }
}

/// DTO for Glossary, containes Data Member, Coding Key and Decoding for JSON
struct Glossary: Codable {

    // MARK: - Data Member
    let title: String?

    // MARK: - Coding Key
    enum CodingKeys: String, CodingKey {
       case title = "title"
    }

    // MARK: - Stuct Initializer
    init() {
        self.title = ""
    }

    // MARK: - Decoding
    /// Creates a new instance by decoding from the given decoder.
    /// - Parameter decoder: the decoder to read data from.
    /// - Throws: This initializer throws an error if reading from the decoder fails, or if the data read is corrupted or otherwise invalid.
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }
}

/// DTO for GlossDef, containes Data Member, Coding Key and Decoding for JSON
struct GlossDef: Codable {

    // MARK: - Data Member
    let glossSeeAlso: [String]?
    let para: String?

    // MARK: - Coding Key
    enum CodingKeys: String, CodingKey {
       case glossSeeAlso = "gloss_see_also"
       case para = "para"
    }

    // MARK: - Stuct Initializer
    init() {
        self.glossSeeAlso = []
        self.para = ""
    }

    // MARK: - Decoding
    /// Creates a new instance by decoding from the given decoder.
    /// - Parameter decoder: the decoder to read data from.
    /// - Throws: This initializer throws an error if reading from the decoder fails, or if the data read is corrupted or otherwise invalid.
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        glossSeeAlso = try values.decodeIfPresent([String].self, forKey: .glossSeeAlso)
        para = try values.decodeIfPresent(String.self, forKey: .para)
    }
}
