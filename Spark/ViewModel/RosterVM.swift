//
//  RosterVM.swift
//  Spark
//
//  Created by rayhaanalykhan on 27/06/2024.
//

import Foundation
import Moya

class RosterVM {
    
    var rosterWithContactList: BaseDM<[RosterDM]>?
    
    @discardableResult
    func requestRosterWithContactList(isSuccess: @escaping(_ isSuccess: Bool)->()) -> Cancellable {
        
        NetworkRequest.shared.request(target: .getRosterWithContactList) { [weak self] (result: Result<BaseDM<[RosterDM]>, Error>) in
            
            guard let self else {
                isSuccess(false)
                return
            }
            
            switch result {
                
            case .success(let apiResponse):
                
                rosterWithContactList = apiResponse
                
                isSuccess(!(apiResponse.hasErrors ?? true))
                
            case .failure(let error):
                
                rosterWithContactList = BaseDM(message: error.localizedDescription)
                
                isSuccess(false)
            }
        }
    }
}
