//
//  ViewController.swift
//  Nepali calendar
//
//  Created by Sujindra Maharjan on 5/8/18.
//  Copyright © 2018 Sujindra Maharjan. All rights reserved.
//

import UIKit
class ViewController:UIViewController, UIPageViewControllerDelegate,ModelControllerDelegate {
    
    var pageViewController: UIPageViewController?
    var pendingIndex:Int!
    var currentIndex:Int!
    var pageObjectData:[PageData]!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        currentIndex = 0
        generateCalendar()

        // Do any additional setup after loading the view, typically from a nib.
        // Configure the page view controller and add it as a child view controller.
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageViewController!.delegate = self
        
        let startingViewController: DataViewController = self.modelController.viewControllerAtIndex(currentIndex, storyboard: self.storyboard!)!
        let viewControllers = [startingViewController]
        self.pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: false, completion: {done in })
        
        self.pageViewController!.delegate = self
        self.pageViewController!.dataSource = self.modelController
        
        self.addChildViewController(self.pageViewController!)
        self.view.addSubview(self.pageViewController!.view)
        self.view.sendSubview(toBack: self.pageViewController!.view)
        
        // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
        var pageViewRect = self.view.bounds
        if UIDevice.current.userInterfaceIdiom == .pad {
            pageViewRect = pageViewRect.insetBy(dx: 40.0, dy: 40.0)
        }
        self.pageViewController!.view.frame = pageViewRect
        self.pageViewController!.didMove(toParentViewController: self)
        
        let currentDate = DateConverterHelper.getCurrentDateAndMonth()
        titleLabel.text = NepaliTranslator.getMonth(month: currentDate.month) + " ("+NepaliTranslator.getNumber(english: "\(currentDate.year)")+")"

    }
    
    private func generateCalendar(){
    
            // Create the data model.
            pageObjectData = []
            let currentDate = Calendar.current.dateComponents([.year,.month,.day], from: Date.init())
            let currentDateConverter = DateConverterHelper.init()
    
            currentDateConverter.engToNep(yy: currentDate.year!, mm: currentDate.month!, dd: currentDate.day!)
    
            let dateConverter = DateConverterHelper.init()
    
            currentDateConverter.engToNep(yy: currentDate.year!, mm: currentDate.month!, dd: currentDate.day!)
            dateConverter.engToNep(yy: currentDate.year!, mm: currentDate.month!, dd: currentDate.day!)
            let current_year = currentDateConverter.getConvertedYear()
            let current_month = currentDateConverter.getConvertedMonth()
            let current_day = currentDateConverter.getConvertedDays()
            let current_dayOfWeek = currentDateConverter.getConvertedDayOfWeek()
            let current_dayOfWeekNumber = currentDateConverter.getConvertedDayOfWeekNumber()
    
            var startDayOfWeek = currentDateConverter.getStartDateOfMonth(dayOfWeek:current_dayOfWeekNumber,day:current_day)
            let currentStartOfWeek = startDayOfWeek
    
            let numberOfDaysInMonth = currentDateConverter.getNumberOfDaysInMonth(year: current_year, month: current_month)
            var endDayOfWeek = currentDateConverter.getEndDateOfCurrentMonth(dayOfWeek: current_dayOfWeekNumber, day: numberOfDaysInMonth - current_day)
            let currentEndOfWeek = endDayOfWeek
    
            //print("current date\(current_year)/\(current_month)/\(current_day) \(current_dayOfWeek) \(current_dayOfWeekNumber)")
            //print("current date month 1:: numberofDaysInMonth\(numberOfDaysInMonth)")
    
    
            for i in (2000...current_year).reversed(){
            for j in (1...12).reversed(){

            if current_year == i && current_month > j {
            let daysInMonth = dateConverter.getNumberOfDaysInMonth(year: i, month: j)
            if startDayOfWeek > 0 {
            endDayOfWeek = startDayOfWeek - 1
            }else{
            endDayOfWeek = 6
            }
            startDayOfWeek = dateConverter.getStartDayOfMonth(dayOfWeek: endDayOfWeek, day: daysInMonth)
            pageObjectData.append(PageData.init(month: j, year: i, startDayOfMonth: startDayOfWeek, endDayOfMonth: endDayOfWeek, numberOfDaysInMonth: daysInMonth, current: false))
            //print("year:: \(i), month:: \(j):: daysInMonth:: \(daysInMonth) startDayOfWeek:: \(startDayOfWeek) endDayOfWeek::\(endDayOfWeek)")
    
            }else if current_year != i{
            let daysInMonth = dateConverter.getNumberOfDaysInMonth(year: i, month: j)
            if startDayOfWeek > 0 {
            endDayOfWeek = startDayOfWeek - 1
            }else{
            endDayOfWeek = 6
            }
    
            startDayOfWeek = dateConverter.getStartDayOfMonth(dayOfWeek: endDayOfWeek, day: daysInMonth)
            pageObjectData.append(PageData.init(month: j, year: i, startDayOfMonth: startDayOfWeek, endDayOfMonth: endDayOfWeek, numberOfDaysInMonth: daysInMonth, current: false))
            //print(" current_year:: != i year:: \(i), month::\(j):: daysInMonth:: \(daysInMonth) startDayOfWeek: \(startDayOfWeek) endDayOfWeek\(endDayOfWeek)")
    
            }
    
            }
            }
            pageObjectData = pageObjectData.reversed()
            startDayOfWeek = currentStartOfWeek
            endDayOfWeek = currentEndOfWeek
    
            for i in current_year...2090{
            for j in 1...12{
    
            if current_year == i && current_month == j {
    
            pageObjectData.append(PageData.init(month: j, year: i, startDayOfMonth: startDayOfWeek, endDayOfMonth: endDayOfWeek, numberOfDaysInMonth: numberOfDaysInMonth, current: true))
            //print(" if current_year == i && current_month == j { pageData::\(i)-\(j)\(pageObjectData)")
                currentIndex = pageObjectData.count - 1
            }else
            if current_year == i && current_month < j {
            let daysInMonth = dateConverter.getNumberOfDaysInMonth(year: i, month: j)
            if endDayOfWeek < 6{
            startDayOfWeek = endDayOfWeek + 1
            }else if endDayOfWeek == 6{
            startDayOfWeek = 0
            }
            endDayOfWeek = dateConverter.getEndDateOfMonth(dayOfWeek: startDayOfWeek, day: daysInMonth)
            pageObjectData.append(PageData.init(month: j, year: i, startDayOfMonth: startDayOfWeek, endDayOfMonth: endDayOfWeek, numberOfDaysInMonth: daysInMonth, current: false))
            //print("current_year == i && current_month < j pageData::\(i)-\(j)\(pageObjectData)")
            }
            else if current_year != i
            {
            let daysInMonth = dateConverter.getNumberOfDaysInMonth(year: i, month: j)
            if endDayOfWeek < 6{
            startDayOfWeek = endDayOfWeek + 1
            }else{
            startDayOfWeek = 0
            }
    
            endDayOfWeek = dateConverter.getEndDateOfMonth(dayOfWeek: startDayOfWeek, day: daysInMonth)
            pageObjectData.append(PageData.init(month: j, year: i, startDayOfMonth: startDayOfWeek, endDayOfMonth: endDayOfWeek, numberOfDaysInMonth: daysInMonth, current: false))
            //print("else pageData::\(i)-\(j)\(pageObjectData)")
    
            }
    
            }
            }
        modelController.pageObjectData = pageObjectData
        //showTodayCalender()
    }
    
    private func showTodayCalender(){
        
        let startingViewController: DataViewController = self.modelController.viewControllerAtIndex(currentIndex, storyboard: self.storyboard!)!
        let viewControllers = [startingViewController]
        self.pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: true, completion: {done in })
//        if self.currentIndex == 2 {
//            skipButton.isHidden = true
//            doneButton.setTitle("Done",for:.normal)
//        }else{
//            skipButton.isHidden=false
//            doneButton.setTitle("Next",for:.normal)
//
//        }
    }
    
    private func goToPage(index:Int){
        let startingViewController: DataViewController = self.modelController.viewControllerAtIndex(index, storyboard: self.storyboard!)!
        let viewControllers = [startingViewController]
        self.pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: true, completion: {done in })
        self.currentIndex = index
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    var modelController: ModelController {
        // Return the model controller object, creating it if necessary.
        // In more complex implementations, the model controller may be passed to the view controller.
        if _modelController == nil {
            _modelController = ModelController()
            self.modelController.delegate = self
        }
        return _modelController!
    }
    
    var _modelController: ModelController? = nil
    
    // MARK: - UIPageViewController delegate methods
    
    func pageViewController(_ pageViewController: UIPageViewController, spineLocationFor orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation {
        if (orientation == .portrait) || (orientation == .portraitUpsideDown) || (UIDevice.current.userInterfaceIdiom == .phone) {
            // In portrait orientation or on iPhone: Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to true, so set it to false here.
            let currentViewController = self.pageViewController!.viewControllers![0]
            let viewControllers = [currentViewController]
            self.pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: true, completion: {done in })
            
            self.pageViewController!.isDoubleSided = false
            return .min
        }
        
        // In landscape orientation: Set set the spine location to "mid" and the page view controller's view controllers array to contain two view controllers. If the current page is even, set it to contain the current and next view controllers; if it is odd, set the array to contain the previous and current view controllers.
        let currentViewController = self.pageViewController!.viewControllers![0] as! DataViewController
        var viewControllers: [UIViewController]
        
        let indexOfCurrentViewController = self.modelController.indexOfViewController(currentViewController)
        if (indexOfCurrentViewController == 0) || (indexOfCurrentViewController % 2 == 0) {
            let nextViewController = self.modelController.pageViewController(self.pageViewController!, viewControllerAfter: currentViewController)
            viewControllers = [currentViewController, nextViewController!]
        } else {
            let previousViewController = self.modelController.pageViewController(self.pageViewController!, viewControllerBefore: currentViewController)
            viewControllers = [previousViewController!, currentViewController]
        }
        self.pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: true, completion: {done in })
        return .mid
    }
    
    //    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
    //        currentIndex = self.pageViewController?.viewControllers?.index(of: viewController)!
    //        if currentIndex == (self.pageViewController?.viewControllers?.count)!-1 {
    //            return nil
    //        }
    //        let nextIndex = abs((currentIndex! + 1) % (self.pageViewController?.viewControllers?.count)!)
    //        return self.pageViewController?.viewControllers?[nextIndex]
    //    }
    //
    //    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
    //        let currentIndex = self.pageViewController?.viewControllers?.index(of: viewController)!
    //        if currentIndex == 0 {
    //            return nil
    //        }
    //        let previousIndex = abs((currentIndex! - 1 + (self.pageViewController?.viewControllers?.count)!) % (self.pageViewController?.viewControllers?.count)!)
    //        return self.pageViewController?.viewControllers![previousIndex]
    //    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        pendingIndex = self.modelController.indexOfViewController(pendingViewControllers.first as! DataViewController)
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        //        if completed && self.pendingIndex != previousViewControllers.first?.view.tag{
        //            currentIndex = pendingIndex
        //            if let index = currentIndex {
        //                uiControl.currentPage = index
        //            }
        //            print("current index::" + String(currentIndex))
        //
        //        }
        //        if let firstViewController = previousViewControllers.first{
        //            let index = self.modelController.indexOfViewController(firstViewController as! DataViewController)
        //            if index != nil{
        //                print(String(describing:index))
        //
        //            uiControl.currentPage = index
        //            }
        //
        //        }
        if completed{
            // 2
            self.currentIndex = self.pendingIndex
            print(String(describing:currentIndex))
            let pageData = self.modelController.pageObjectData[pendingIndex]
            let month = DateConverterHelper.init().getNepaliMonth(month: pageData.month)
            titleLabel.text = month + " ("+NepaliTranslator.getNumber(english: "\(pageData.year)")+")"

//            if self.currentIndex == 2 {
//                skipButton.isHidden = true
//                doneButton.setTitle("Done",for:.normal)
//            }else{
//                skipButton.isHidden=false
//                doneButton.setTitle("Next",for:.normal)
//
//            }
        }
    }
    
    @IBAction func onPreviousButtonPressed(_ sender: UIButton) {
        
        //goToPage(index: currentIndex - 1)
    }
    @IBAction func onNextButtonPressed(_ sender: UIButton) {
        //goToPage(index: currentIndex + 1)
    }
    
    func didUpdateIndex(to: Int) {
        // self.uiControl.currentPage = to
    }
}
