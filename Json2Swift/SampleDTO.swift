//
//  SampleDTO.swift
//  Json2Swift
//
//  Created by Husnain ALi on 01/03/2022.
//

/// DTO for SampleDTO, containes Data Member, Coding Key and Decoding for JSON
struct SampleDTO: Codable {

    // MARK: - Data Member
    let glossary: Glossary?

    // MARK: - Coding Key
    enum CodingKeys: String, CodingKey {
       case glossary = "glossary"
    }

    // MARK: - Stuct Initializer
    init() {
        self.glossary = Glossary()
    }

    // MARK: - Decoding
    /// Creates a new instance by decoding from the given decoder.
    /// - Parameter decoder: the decoder to read data from.
    /// - Throws: This initializer throws an error if reading from the decoder fails, or if the data read is corrupted or otherwise invalid.
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        glossary = try values.decodeIfPresent(Glossary.self, forKey: .glossary)
    }
}

/// DTO for Glossary, containes Data Member, Coding Key and Decoding for JSON
struct Glossary: Codable {

    // MARK: - Data Member
    let glossdiv: Glossdiv?
    let title: String?

    // MARK: - Coding Key
    enum CodingKeys: String, CodingKey {
       case glossdiv = "GlossDiv"
       case title = "title"
    }

    // MARK: - Stuct Initializer
    init() {
        self.glossdiv = Glossdiv()
        self.title = ""
    }

    // MARK: - Decoding
    /// Creates a new instance by decoding from the given decoder.
    /// - Parameter decoder: the decoder to read data from.
    /// - Throws: This initializer throws an error if reading from the decoder fails, or if the data read is corrupted or otherwise invalid.
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        glossdiv = try values.decodeIfPresent(Glossdiv.self, forKey: .glossdiv)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }
}

/// DTO for Glossdiv, containes Data Member, Coding Key and Decoding for JSON
struct Glossdiv: Codable {

    // MARK: - Data Member
    let title: String?
    let glosslist: Glosslist?

    // MARK: - Coding Key
    enum CodingKeys: String, CodingKey {
       case title = "title"
       case glosslist = "GlossList"
    }

    // MARK: - Stuct Initializer
    init() {
        self.title = ""
        self.glosslist = Glosslist()
    }

    // MARK: - Decoding
    /// Creates a new instance by decoding from the given decoder.
    /// - Parameter decoder: the decoder to read data from.
    /// - Throws: This initializer throws an error if reading from the decoder fails, or if the data read is corrupted or otherwise invalid.
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        glosslist = try values.decodeIfPresent(Glosslist.self, forKey: .glosslist)
    }
}

/// DTO for Glosslist, containes Data Member, Coding Key and Decoding for JSON
struct Glosslist: Codable {

    // MARK: - Data Member
    let glossentry: Glossentry?

    // MARK: - Coding Key
    enum CodingKeys: String, CodingKey {
       case glossentry = "GlossEntry"
    }

    // MARK: - Stuct Initializer
    init() {
        self.glossentry = Glossentry()
    }

    // MARK: - Decoding
    /// Creates a new instance by decoding from the given decoder.
    /// - Parameter decoder: the decoder to read data from.
    /// - Throws: This initializer throws an error if reading from the decoder fails, or if the data read is corrupted or otherwise invalid.
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        glossentry = try values.decodeIfPresent(Glossentry.self, forKey: .glossentry)
    }
}

/// DTO for Glossentry, containes Data Member, Coding Key and Decoding for JSON
struct Glossentry: Codable {

    // MARK: - Data Member
    let sortas: String?
    let glossterm: String?
    let abbrev: String?
    let id: String?
    let glosssee: String?
    let acronym: String?
    let glossdef: Glossdef?

    // MARK: - Coding Key
    enum CodingKeys: String, CodingKey {
       case sortas = "SortAs"
       case glossterm = "GlossTerm"
       case abbrev = "Abbrev"
       case id = "ID"
       case glosssee = "GlossSee"
       case acronym = "Acronym"
       case glossdef = "GlossDef"
    }

    // MARK: - Stuct Initializer
    init() {
        self.sortas = ""
        self.glossterm = ""
        self.abbrev = ""
        self.id = ""
        self.glosssee = ""
        self.acronym = ""
        self.glossdef = Glossdef()
    }

    // MARK: - Decoding
    /// Creates a new instance by decoding from the given decoder.
    /// - Parameter decoder: the decoder to read data from.
    /// - Throws: This initializer throws an error if reading from the decoder fails, or if the data read is corrupted or otherwise invalid.
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        sortas = try values.decodeIfPresent(String.self, forKey: .sortas)
        glossterm = try values.decodeIfPresent(String.self, forKey: .glossterm)
        abbrev = try values.decodeIfPresent(String.self, forKey: .abbrev)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        glosssee = try values.decodeIfPresent(String.self, forKey: .glosssee)
        acronym = try values.decodeIfPresent(String.self, forKey: .acronym)
        glossdef = try values.decodeIfPresent(Glossdef.self, forKey: .glossdef)
    }
}

/// DTO for Glossdef, containes Data Member, Coding Key and Decoding for JSON
struct Glossdef: Codable {

    // MARK: - Data Member
    let para: String?
    let glossseealso: [String]?

    // MARK: - Coding Key
    enum CodingKeys: String, CodingKey {
       case para = "para"
       case glossseealso = "GlossSeeAlso"
    }

    // MARK: - Stuct Initializer
    init() {
        self.para = ""
        self.glossseealso = []
    }

    // MARK: - Decoding
    /// Creates a new instance by decoding from the given decoder.
    /// - Parameter decoder: the decoder to read data from.
    /// - Throws: This initializer throws an error if reading from the decoder fails, or if the data read is corrupted or otherwise invalid.
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        para = try values.decodeIfPresent(String.self, forKey: .para)
        glossseealso = try values.decodeIfPresent([String].self, forKey: .glossseealso)
    }
}
