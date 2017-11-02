//
//  LoadingViewPresenter.swift
//  Drone Safely
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 02/11/17.
//  Copyright © 2017 Leonardo Vinicius Kaminski Ferreira. All rights reserved.
//

import UIKit

class LoadingViewPresenter: UIView {
    
    static func newInstance() -> LoadingViewPresenter {
        return Bundle(for: self).loadNibNamed("LoadingView", owner: self, options: nil)![0] as! LoadingViewPresenter
    }
    
}
