//
//  NewsResponse.swift
//  tms-25-project
//
//  Created by Daria Sechko on 18.09.22.
//

import Foundation

// MARK: - PostResponse
struct PostResponse: Codable {
    let response: PostItems
}

// MARK: - Response
struct PostItems: Codable {
    let items: [Post]
    let groups: [Group]?
    let profiles: [Profile]?
    
    enum CodingKeys: String, CodingKey {
        case items, groups, profiles
    }
}

// MARK: - ResponseItem
struct Post: Codable {
    let isFavorite, canSetCategory: Bool?
    let shortTextRate: Double?
    let likes: PurpleLikes?
    let type: String
    let postType: String?
    let date, sourceID: Int
    let text: String?
    let canDoubtCategory: Bool?
    let attachments: [Attachment]?
    let markedAsAds: Int?
    let postID: Int?
    let photos: Photos?
    let carouselOffset: Int?
    
    enum CodingKeys: String, CodingKey {
        case isFavorite = "is_favorite"
        case canSetCategory = "can_set_category"
        case shortTextRate = "short_text_rate"
        case likes, type
        case postType = "post_type"
        case date
        case sourceID = "source_id"
        case text
        case canDoubtCategory = "can_doubt_category"
        case attachments
        case markedAsAds = "marked_as_ads"
        case postID = "post_id"
        case photos
        case carouselOffset = "carousel_offset"
    }
}

// MARK: - Attachment
struct Attachment: Codable {
    let type: String
    let photo: Photo?
}

// MARK: - Photo
struct Photo: Codable {
    let albumID: Int
    let postID: Int?
    let id, date: Int
    let text: String
    let userID: Int?
    let sizes: [Size]
    let hasTags: Bool
    let ownerID: Int
    let accessKey: String
    
    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case postID = "post_id"
        case id, date, text
        case userID = "user_id"
        case sizes
        case hasTags = "has_tags"
        case ownerID = "owner_id"
        case accessKey = "access_key"
    }
}

// MARK: - Size
struct Size: Codable {
    let width, height: Int
    let url: String
    let type: String
}

// MARK: - PurpleLikes
struct PurpleLikes: Codable {
    let canLike, canPublish, count, userLikes: Int
    
    enum CodingKeys: String, CodingKey {
        case canLike = "can_like"
        case canPublish = "can_publish"
        case count
        case userLikes = "user_likes"
    }
}

// MARK: - Photos
struct Photos: Codable {
    let count: Int
    let items: [PhotosItem]
}

// MARK: - PhotosItem
struct PhotosItem: Codable {
    let id: Int
    let likes: FluffyLikes
    let accessKey: String
    let userID: Int?
    
    let date, ownerID: Int
    let postID: Int?
    let text: String
    let canRepost: Int
    let sizes: [Size]
    let hasTags: Bool
    let albumID, canComment: Int
    
    enum CodingKeys: String, CodingKey {
        case id, likes
        case accessKey = "access_key"
        case userID = "user_id"
        case date
        case ownerID = "owner_id"
        case postID = "post_id"
        case text
        case canRepost = "can_repost"
        case sizes
        case hasTags = "has_tags"
        case albumID = "album_id"
        case canComment = "can_comment"
    }
}

// MARK: - FluffyLikes
struct FluffyLikes: Codable {
    let count, userLikes: Int
    
    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
    }
}

// MARK: - Profile
struct Profile: Codable {
    let online: Int?
    let canAccessClosed, isClosed: Bool?
    let id: Int?
    let photo100: String?
    let lastName: String?
    let photo50: String?
    
    let sex: Int?
    let screenName, firstName: String?
    
    enum CodingKeys: String, CodingKey {
        case online
        case canAccessClosed = "can_access_closed"
        case isClosed = "is_closed"
        case id
        case photo100 = "photo_100"
        case lastName = "last_name"
        case photo50 = "photo_50"
        
        case sex
        case screenName = "screen_name"
        case firstName = "first_name"
    }
}

