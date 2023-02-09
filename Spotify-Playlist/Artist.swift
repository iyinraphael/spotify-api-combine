//
//  Artist.swift
//  Spotify-Playlist
//
//  Created by Iyin Raphael on 2/7/23.
//

import Foundation

struct Spotify: Decodable {

    var albums: SpotifyEntity

    struct SpotifyEntity: Decodable {
        var items: [Item]

        struct Item: Decodable {
            let name: String
            var images: [ArtistImage]

            struct ArtistImage: Decodable {
                let url: String
            }
        }
    }
}

enum EntityType: String {
    case album
    case artist
}
