//
//  Restaurant.swift
//  dicoding
//
//  Created by Mochammad Arief Ridwan on 26/01/23.
//

import Foundation
import UIKit

enum DownloadState {
  case new, downloaded, failed
}

// MARK: - ListGame
struct ListGame: Codable {
    var count: Int?
    var next: String?
    var previous: JSONNull?
    var results: [Result]?
    var seoTitle, seoDescription, seoKeywords, seoH1: String?
    var noindex, nofollow: Bool?
    var description: String?
    var filters: Filters?
    var nofollowCollections: [String]?

    enum CodingKeys: String, CodingKey {
        case count, next, previous, results
        case seoTitle = "seo_title"
        case seoDescription = "seo_description"
        case seoKeywords = "seo_keywords"
        case seoH1 = "seo_h1"
        case noindex, nofollow, description, filters
        case nofollowCollections = "nofollow_collections"
    }
}

// MARK: - Filters
struct Filters: Codable {
    var years: [FiltersYear]?
}

// MARK: - FiltersYear
struct FiltersYear: Codable {
    var from, to: Int?
    var filter: String?
    var decade: Int?
    var years: [YearYear]?
    var nofollow: Bool?
    var count: Int?
}

// MARK: - YearYear
struct YearYear: Codable {
    var year, count: Int?
    var nofollow: Bool?
}

// MARK: - Result
class Result: Codable {
    var id: Int?
    var slug, name, released: String?
    var tba: Bool?
    var backgroundImage: String?
    var rating: Double?
    var ratingTop: Int?
    var ratings: [Rating]?
    var ratingsCount, reviewsTextCount, added: Int?
    var addedByStatus: AddedByStatus?
    var metacritic: Int?
    var playtime, suggestionsCount: Int?
    var updated: String?
    var userGame: JSONNull?
    var reviewsCount: Int?
    var saturatedColor, dominantColor: Color?
    var platforms: [PlatformElement]?
    var parentPlatforms: [ParentPlatform]?
    var genres: [Genre]?
    var stores: [Store]?
    var clip: JSONNull?
    var tags: [Genre]?
    var esrbRating: EsrbRating?
    var shortScreenshots: [ShortScreenshot]?
    var description_raw: String?
  
    var state: DownloadState = .new
    var savedImage: Data?
    var image: UIImage?
  
  init(id: Int, name: String, released_date: String, rating: Double, added: Int, esrbRating: String, description_raw: String, savedImage: Data) {
    self.id = id
    self.name = name
    self.released = released_date
    self.rating = rating
    self.added = added
    self.esrbRating = EsrbRating(id: 0, name: Name.init(rawValue: esrbRating), slug: Slug.init(rawValue: esrbRating))
    self.description_raw = description_raw
    self.savedImage = savedImage
  }

    enum CodingKeys: String, CodingKey {
        case id, slug, name, released, tba
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case ratings
        case ratingsCount = "ratings_count"
        case reviewsTextCount = "reviews_text_count"
        case added
        case addedByStatus = "added_by_status"
        case metacritic, playtime
        case suggestionsCount = "suggestions_count"
        case updated
        case userGame = "user_game"
        case reviewsCount = "reviews_count"
        case saturatedColor = "saturated_color"
        case dominantColor = "dominant_color"
        case platforms
        case parentPlatforms = "parent_platforms"
        case genres, stores, clip, tags
        case esrbRating = "esrb_rating"
        case shortScreenshots = "short_screenshots"
    }
}

// MARK: - AddedByStatus
struct AddedByStatus: Codable {
    var yet, owned, beaten, toplay: Int?
    var dropped, playing: Int?
}

enum Color: String, Codable {
    case the0F0F0F = "0f0f0f"
}

// MARK: - EsrbRating
struct EsrbRating: Codable {
    var id: Int?
    var name: Name?
    var slug: Slug?
}

enum Name: String, Codable {
    case adultsOnly = "Adults Only"
    case android = "Android"
    case appleMacintosh = "Apple Macintosh"
    case everyone = "Everyone"
    case everyone10 = "Everyone 10+"
    case iOS = "iOS"
    case linux = "Linux"
    case mature = "Mature"
    case nintendo = "Nintendo"
    case pc = "PC"
    case playStation = "PlayStation"
    case teen = "Teen"
    case web = "Web"
    case xbox = "Xbox"
}

enum Slug: String, Codable {
    case adultsOnly = "adults-only"
    case android = "android"
    case everyone = "everyone"
    case everyone10Plus = "everyone-10-plus"
    case ios = "ios"
    case linux = "linux"
    case mac = "mac"
    case mature = "mature"
    case nintendo = "nintendo"
    case pc = "pc"
    case playstation = "playstation"
    case teen = "teen"
    case web = "web"
    case xbox = "xbox"
}

// MARK: - Genre
struct Genre: Codable {
    var id: Int?
    var name, slug: String?
    var gamesCount: Int?
    var imageBackground: String?
    var domain: Domain?
    var language: Language?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case domain, language
    }
}

enum Domain: String, Codable {
    case appsAppleCOM = "apps.apple.com"
    case epicgamesCOM = "epicgames.com"
    case gogCOM = "gog.com"
    case marketplaceXboxCOM = "marketplace.xbox.com"
    case microsoftCOM = "microsoft.com"
    case nintendoCOM = "nintendo.com"
    case playGoogleCOM = "play.google.com"
    case storePlaystationCOM = "store.playstation.com"
    case storeSteampoweredCOM = "store.steampowered.com"
}

enum Language: String, Codable {
    case eng = "eng"
}

// MARK: - ParentPlatform
struct ParentPlatform: Codable {
    var platform: EsrbRating?
}

// MARK: - PlatformElement
struct PlatformElement: Codable {
    var platform: PlatformPlatform?
    var releasedAt: String?
    var requirementsEn, requirementsRu: Requirements?

    enum CodingKeys: String, CodingKey {
        case platform
        case releasedAt = "released_at"
        case requirementsEn = "requirements_en"
        case requirementsRu = "requirements_ru"
    }
}

// MARK: - PlatformPlatform
struct PlatformPlatform: Codable {
    var id: Int?
    var name, slug: String?
    var image, yearEnd: JSONNull?
    var yearStart: Int?
    var gamesCount: Int?
    var imageBackground: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug, image
        case yearEnd = "year_end"
        case yearStart = "year_start"
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}

// MARK: - Requirements
struct Requirements: Codable {
    var minimum, recommended: String?
}

// MARK: - Rating
struct Rating: Codable {
    var id: Int?
    var title: Title?
    var count: Int?
    var percent: Double?
}

enum Title: String, Codable {
    case exceptional = "exceptional"
    case meh = "meh"
    case recommended = "recommended"
    case skip = "skip"
}

// MARK: - ShortScreenshot
struct ShortScreenshot: Codable {
    var id: Int?
    var image: String?
}

// MARK: - Store
struct Store: Codable {
    var id: Int?
    var store: Genre?
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }
  
    func hash(into hasher: inout Hasher) {
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
