//
//  NetworkService.swift
//  FitnessKit
//
//  Created by Oleg Sitnikov on 28.02.2020.
//  Copyright © 2020 Oleg Sitnikov. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import CoreData

final class NetworkingService  {
    // MARK: - Properties
    static let shared = NetworkingService()
    
    let baseUrl = "https://sample.fitnesskit-admin.ru/schedule/get_group_lessons_v2/1"
    typealias responseAPIResult = Result<[SchedulerItem], AFError>
    typealias responseAPIImageResult = Result<UIImage, AFError>


    // MARK: - Init
    
    private init() {}
    
    // MARK: - Handlers
    
    func getScheduler(context: NSManagedObjectContext, result: @escaping ((responseAPIResult) -> Void))  {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        decoder.userInfo[CodingUserInfoKey.context!] = context

        AF.request(URL(string: baseUrl)!).validate().responseDecodable(of: [SchedulerItem].self, decoder: decoder) { (response) in
            if let error = response.error {
                result(.failure(error))
            } else  if let scheduler = response.value {
                result(.success(scheduler))
            }
        }
    }
 
}
