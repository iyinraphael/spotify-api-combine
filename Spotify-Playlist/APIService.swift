//
//  APIService.swift
//  Spotify-Playlist
//
//  Created by Iyin Raphael on 2/7/23.
//

import Foundation
import Combine

protocol SpotifyService {}

protocol APIService: SpotifyService {
    func getSpotifyEntity(for search: String, of type: EntityType)
    func getAccessToken() -> URLRequest

}

struct Authorization: Decodable {
    
}

class NetworkService: APIService {

    // MARK: - Constants
    static let baseUrl = URL(string: "https://api.spotify.com/")!
    static let accountURL = URL(string: "https://accounts.spotify.com/authorize")!
    static let clientID = "d05ac6a0b05045dc9306f617407804bc"
    static let redirectURI = "https://www.iyinraphael.dev"
    static let responseType = "code"
    static let scope = ""
    var request: AnyCancellable?


    // MARK: - Private Methods
    private func createURLRequest(from url: URL, with queryItems: [URLQueryItem]) -> URLRequest {
        var urlComponent = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponent?.queryItems = queryItems

        guard let urlFrom = urlComponent?.url else { fatalError() }
        let urlRequest = URLRequest(url: urlFrom)

        return urlRequest
    }


    private func accountURLComponent() -> [ String: String] {
        return ["client_id" : Self.clientID,
                "response_type" : Self.responseType,
                "redirect_uri" : Self.redirectURI,
                "scope" : Self.scope]
    }


/**
 https://www.iyinraphael.dev/#access_token=BQA8C3jy6UpsBWWPzuDlWhHC4UW67IBVp75pYX3vKLVPQEZ6BPQcvmPnmrO6hbWeiK1uqZmSqgtt0FlQ59WzFCreFSg6eD11fjhjmjuTAJwFfbjrdrmv0CEMtAqzPRxRUD45gd65g3E9jgg5DetyX6hiCHM645zNWo0_9nA2GKH-dQ&token_type=Bearer&expires_in=3600
 **/
}

extension NetworkService {

    func getAccessToken() -> URLRequest {
        let queryItems = accountURLComponent().map { URLQueryItem(name: $0, value: $1)}

        return createURLRequest(from: Self.accountURL, with: queryItems)
    }

    func getSpotifyEntity(for search: String, of type: EntityType)  {
        var urlRequest = URLRequest(url: Self.baseUrl)

        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "q", value: search),
            URLQueryItem(name: "type", value: type.rawValue)]

//        urlRequest.url?.append(queryItems: queryItems)

//        urlRequest.addValue(token, forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map {$0.data}
            .decode(type: Spotify.self, decoder: JSONDecoder())

       request = session.sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("failed with", error)
                }
            } receiveValue: { items in
                print("received value", String(describing: items))
            }
    }
}
