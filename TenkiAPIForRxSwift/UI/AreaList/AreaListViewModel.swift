//
//  AreaListViewModel.swift
//  TenkiAPIForRxSwift
//
//  Created by Isami Odagiri on 2020/12/06.
//

import Foundation
import RxCocoa
import RxSwift

final class AreaListViewModel {
    struct Input {
        let viewWillAppear: Observable<Void>
        let selectItem: Observable<IndexPath>
    }

    struct Output {
        let areaItems: Driver<[ModelAreaData]>
        let showWhetherDataForArea: Driver<(ModelAreaData)>
    }
    
    private let areaItemsRelay = BehaviorRelay<[ModelAreaData]>(value: [])
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        
        let areaDataList = input.viewWillAppear.take(1).flatMap { _ in
            return AreaListUseCase().fetchAreaData()
        }
        
        areaDataList.asDriver(onErrorDriveWith: .empty())
            .drive(areaItemsRelay)
            .disposed(by: disposeBag)
        
        let showWhetherDataForArea = input.selectItem
            .withLatestFrom(areaItemsRelay) { $1[$0.row] }
        
        return Output(areaItems: areaItemsRelay.asDriver(onErrorDriveWith: .empty()),
                      showWhetherDataForArea: showWhetherDataForArea.asDriver(onErrorDriveWith: .empty()))
    }
}
