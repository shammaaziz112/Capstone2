//
//  ModelApiImage.swift
//  capStone-2
//
//  Created by AlenaziHazal on 13/02/1444 AH.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let photos: Photos
    let stat: String
}

// MARK: - Photos
struct Photos: Codable {
    let page, pages, perpage, total: Int
    let photo: [Photo]
}

// MARK: - Photo
struct Photo: Codable {
    let id: String
    let owner: Owner
    let secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
}

enum Owner: String, Codable {
    case the196442524N08 = "196442524@N08"
    case the22258272N08 = "22258272@N08"
    case the67226407N03 = "67226407@N03"
}
