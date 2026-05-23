//
//  PropertyListViewState.swift
//  homegate
//
//  Created by Phai Hoang on 22/5/26.
//

enum PropertyListViewState {
    case idle
    case loading
    case loaded([Property])
    case error(ViewError)
}
