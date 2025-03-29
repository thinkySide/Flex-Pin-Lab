//
//  FirstViewController.swift
//  Flex-Pin-Lab
//
//  Created by 김민준 on 3/29/25.
//

import UIKit
import FlexLayout
import PinLayout

/// Flex >> Container 안의 자식 View들 조정할 때 사용(전체적인 레이아웃)
/// Pin >> 상위 개별 View들 미세 조정할 때 사용(개별 View의 크기, 위치 조정)
final class FirstViewController: UIViewController {
    
    private let containerView = UIView()
    
    private let label1: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemOrange
        label.text = "FlexLayout"
        return label
    }()
    
    private let label2: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBlue
        label.text = "PinLayout"
        return label
    }()
    
    private let label3: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBrown
        label.text = "공부하기"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addSubView()
    }
    
    /// 드로잉 사이클에서 내부 레이아웃이 배치된 시점
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        containerView.pin.all(view.pin.safeArea)
        
        /// layout 함수: ContainerView 안의 자식 요소들 배치
        /// layout 함수는 꼭 마지막에 써줘야 한다고 함!
        /// fitContaine: Container 사이즈에 맞게
        /// adjustWidth: Container 너비 사이즈에 맞게
        /// adjustHeight: Container 높이 사이즈에 맞게
        containerView.flex.layout(mode: .fitContainer)
    }
}

// MARK: - 메서드

extension FirstViewController {
    
    func setupUI(){
        view.backgroundColor = .white
        containerView.backgroundColor = .lightGray
    }
    
    func addSubView() {
        view.addSubview(containerView)
        
        /// define 함수는 FlexBox에 코드를 구조적으로 넣는 것
        ///
        /// addItem 함수는 UIStackView를 생각했을 때
        /// arrangedSubViews와 동일한 역할!
        ///
        /// addItem() 이렇게 아무것도 안넣으면 ContainerView를 생성한다고 생각하면 됨!
        containerView.flex
        
            /// direction 함수는 StackView의 axis와 비슷하게 동작함!
            .direction(.column)
        
            /// 아이템끼리의 정렬 방향
            /// 기본값이 Stretch이기 때문에 늘어나지만, 요렇게 하면 각 View의 사이즈를 유지할 수 있게 됨!
            .alignItems(.center)
            .define { flex in
                
                /// JustifyContent: 정렬 함수
                /// start / center / end / spaceAround / spaceBetween / spaceEvenly
                flex.addItem().direction(.row).justifyContent(.center).define {
                    $0.addItem(label1)
                    $0.addItem(label2)
                }
                
                flex.addItem(label3)
            }
    }
}
