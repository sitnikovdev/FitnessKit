//
//  NetworkService.swift
//  FitnessKit
//
//  Created by Oleg Sitnikov on 28.02.2020.
//  Copyright © 2020 Oleg Sitnikov. All rights reserved.
//

import Foundation
import Alamofire
import CoreData

final class NetworkingService  {
    // MARK: - Properties
    static let shared = NetworkingService()
    
    let baseUrl = "https://sample.fitnesskit-admin.ru/schedule/get_group_lessons_v2/1"
//    typealias schedulerCallBack = (_ scheduerItem: [SchedulerItem]?, _ status: Bool) -> Void
    typealias responseAPIResult = Result<[SchedulerItem], AFError>
    typealias nsContext = NSManagedObjectContext
    

    // MARK: - Init
    
    private init() {}
    
    // MARK: - Handlers
    
    func getScheduler(context: NSManagedObjectContext, result: @escaping ((responseAPIResult, nsContext) -> Void))  {
        let decoder = JSONDecoder()
        decoder.userInfo[CodingUserInfoKey.context!] = context
        decoder.keyDecodingStrategy = .useDefaultKeys

        AF.request(URL(string: baseUrl)!).validate().responseDecodable(of: [SchedulerItem].self, decoder: decoder) { (response) in
            if let error = response.error {
                result(.failure(error), context)
            } else  if let scheduler = response.value {
                result(.success(scheduler), context)
            }
        }
    }
}
