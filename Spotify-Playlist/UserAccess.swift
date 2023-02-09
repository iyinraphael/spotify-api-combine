//
//  UserAccess.swift
//  Spotify-Playlist
//
//  Created by Iyin Raphael on 2/7/23.
//

import Foundation

struct UserAccess: Decodable {
    let accessToken: String
    let tokenType: String
    let scope: String
    let expiresIn: Int
    var refreshToken: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case scope = "scope"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
    }
}
