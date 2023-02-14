//
//  Artist.swift
//  Spotify-Playlist
//
//  Created by Iyin Raphael on 2/7/23.
//

import Foundation

struct Spotify: Decodable {

    var albums: SpotifyEntity
}

struct SpotifyEntity: Decodable {
    var items: [Item]
}


struct Item: Decodable {

    let name: String
    var images: [ArtistImage]

    struct ArtistImage: Decodable, Hashable {
        let url: String
    }
}

extension Item: Hashable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name && lhs.images == rhs.images
    }


}

enum EntityType: String {
    case album
    case artist
}
