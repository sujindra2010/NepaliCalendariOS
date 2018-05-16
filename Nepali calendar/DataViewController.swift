//
//  DataViewController.swift
//  Nepali calendar
//
//  Created by Sujindra Maharjan on 5/8/18.
//  Copyright © 2018 Sujindra Maharjan. All rights reserved.
//

import UIKit
class DataViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    var dataObject:PageData!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    struct Data{
        var day:Int
        var englishDay:Int
        var today:Bool
    }
    var data:[Data] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewHeight.constant = (UIScreen.main.bounds.width - 40)
        let currentDate = Calendar.current.dateComponents([.year,.month,.day], from: Date.init())
        let currentDateConverter = DateConverterHelper.init()
        let dateConverter = DateConverterHelper.init()

        currentDateConverter.engToNep(yy: currentDate.year!, mm: currentDate.month!, dd: currentDate.day!)
        dateConverter.engToNep(yy: currentDate.year!, mm: currentDate.month!, dd: currentDate.day!)
        let current_year = currentDateConverter.getConvertedYear()
        let current_month = currentDateConverter.getConvertedMonth()
        let current_day = currentDateConverter.getConvertedDays()
//        let current_dayOfWeek = currentDateConverter.getConvertedDayOfWeek()
//        let current_dayOfWeekNumber = currentDateConverter.getConvertedDayOfWeekNumber()
//        
//        let numberOfDaysInMonth = currentDateConverter.getNumberOfDaysInMonth(year: current_year, month: current_month)
//        
        //print("current date\(current_year)/\(current_month)/\(current_day) \(current_dayOfWeek) \(current_dayOfWeekNumber)")
        //print("current date month 1:: numberofDaysInMonth\(numberOfDaysInMonth)")
        
        var day = 0
        var extraDays = 0
        let converter = DateConverterHelper.init()
        for i in 0..<42{
            
            if(i>=dataObject.startDayOfMonth && i<dataObject.numberOfDaysInMonth+extraDays){
                day+=1

               converter.nepToEng(yy: dataObject.year, mm: dataObject.month, dd: day)
                //print("day:\(day)")
                //print("dateobject::\(dataObject)")
                 let englishDay = converter.getConvertedDays()
                //print("english Date\(englishDay)")
                data.append(Data.init(day:day,englishDay: englishDay,today: (day == current_day)))

            }else if i<dataObject.startDayOfMonth{
                //print("dateobject::\(dataObject)")
                data.append(Data.init(day: 0,englishDay: 0, today: false))
                extraDays+=1
            }
        }
        if extraDays == 7 {
            data.removeSubrange(0...6)
            print("data count:\(data.count)")
        }
    
        collectionView.reloadData()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dataCell", for: indexPath) as! DataCollectionViewCell
        
        if data[indexPath.row].day>0{
            
//            cell.dayLabel.text = String(format:"%d",data[indexPath.row].day)
            cell.dayLabel.text = NepaliTranslator.getNumber(english: String(format:"%d",data[indexPath.row].day))
            
        }else{
            cell.dayLabel.text = ""
        }
        if data[indexPath.row].englishDay>0{
            cell.englishDateLabel.text = String(format:"%d",data[indexPath.row].englishDay)
        }else{
            cell.englishDateLabel.text = ""
        }
        if data[indexPath.row].today && dataObject.current{
            cell.contentView.backgroundColor = UIColor.green
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size.width/7
        return CGSize(width:size
            , height: size)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let message = MDCSnackbarMessage()
//        message.text = "\(dataObject.year)/\(dataObject.month)/\(data[indexPath.row].day)"
//        MDCSnackbarManager.show(message)
    }
}


class DataCollectionViewCell:UICollectionViewCell{
    @IBOutlet weak var dayLabel: UILabel!
    
    @IBOutlet weak var englishDateLabel: UILabel!
}
