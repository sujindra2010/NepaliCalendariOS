//
//  ModelController.swift
//  Nepali calendar
//
//  Created by Sujindra Maharjan on 5/8/18.
//  Copyright © 2018 Sujindra Maharjan. All rights reserved.
//

import Foundation
import UIKit
/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */

struct PageData{
    var month:Int
    var year:Int
    var startDayOfMonth:Int
    var endDayOfMonth:Int
    var numberOfDaysInMonth:Int
    var current:Bool
}

class ModelController: NSObject, UIPageViewControllerDataSource {
    
    var pageObjectData:[PageData]!
    
    public var delegate : ModelControllerDelegate!
    
    override init() {
        super.init()
        
    }
    
    
    func viewControllerAtIndex(_ index: Int, storyboard: UIStoryboard) -> DataViewController? {
        // Return the data view controller for the given index.
        if (self.pageObjectData.count == 0) || (index >= self.pageObjectData.count) {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        let dataViewController = storyboard.instantiateViewController(withIdentifier: "DataViewController") as! DataViewController
       
        dataViewController.dataObject = self.pageObjectData[index]
        return dataViewController
    }
    
    func indexOfViewController(_ viewController: DataViewController) -> Int {
        // Return the index of the given data view controller.
        // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
        return getIndex(data: viewController.dataObject)
        //return pageObjectData.index(of: viewController.dataObject) ?? NSNotFound
    }
    
    private func getIndex(data:PageData)->Int{
        for i in 0..<pageObjectData.count {
            if pageObjectData[i].year == data.year && pageObjectData[i].month == data.month {
                return i
            }
        }
        return 0
    }
    
    // MARK: - Page View Controller Data Source
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! DataViewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index -= 1
        
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! DataViewController)
        if index == NSNotFound {
            return nil
        }
        
        index += 1
        if index == self.pageObjectData.count {
            return nil
        }
        
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
    
    
}
protocol ModelControllerDelegate {
    func didUpdateIndex(to:Int)
}


