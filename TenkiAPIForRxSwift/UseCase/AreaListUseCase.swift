//
//  AreaListUseCase.swift
//  TenkiAPIForRxSwift
//
//  Created by Isami Odagiri on 2020/12/06.
//

import Foundation
import RxSwift
import ObjectMapper

final class AreaListUseCase {
    
    func fetchAreaData() -> Single<[ModelAreaData]> {
        let modelAreaDataList = Mapper<ModelAreaData>().mapArray(JSONfile: "cityList.json")?
            .filter { ($0.country?.hasPrefix("JP") ?? false) } ?? []
        return .just(modelAreaDataList)
    }
}
