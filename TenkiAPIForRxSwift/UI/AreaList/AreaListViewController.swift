//
//  AreaListViewController.swift
//  TenkiAPIForRxSwift
//
//  Created by Isami Odagiri on 2020/12/06.
//

import UIKit
import RxCocoa
import RxSwift

final class AreaListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private let selectItemSubject = PublishSubject<IndexPath>()
    private let viewWillAppearSubject = PublishSubject<Void>()

    private var viewModel: AreaListViewModel!
    private let disposeBag = DisposeBag()
    
    static func instantiate() -> AreaListViewController {
        let storyboard = UIStoryboard(name: "AreaList", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AreaListView") as! AreaListViewController
        vc.viewModel = AreaListViewModel()
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "地名"
        setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewWillAppearSubject.onNext(())
    }
    
    private func setupViewModel() {
        let input = AreaListViewModel.Input(viewWillAppear: viewWillAppearSubject,
                                            selectItem: tableView.rx.itemSelected.asObservable())
        
        let output = viewModel.transform(input: input)
    
        output.areaItems.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "AreaCell")) { row, item, cell in
                cell.textLabel?.text = item.name
            }
            .disposed(by: disposeBag)
        
        output.showWhetherDataForArea
            .drive(onNext: { [unowned self] item in
                // 画面遷移処理
                print(item)
            })
            .disposed(by: disposeBag)
    }
}
