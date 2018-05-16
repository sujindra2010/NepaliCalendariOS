//
//  Date.swift
//  Nepali calendar
//
//  Created by Sujindra Maharjan on 5/8/18.
//  Copyright © 2018 Sujindra Maharjan. All rights reserved.
//

import Foundation

/**
 * Simple Date class to store the tuple (year, month, day).
 *
 * Days and months start at index 1. So sunday is 1, Baisakh is 1 and January is 1.
 */
//public class AppDate {
//
//    /// Year this date is contained in.
//    public let year=0;
//
//    /// Month this date in contained in. Starts at index 1.
//    public let month=0;
//
//    // Day of the month this date represents. Starts at index 1.
//    public let day=0;
//
//    /**
//     * Create a new Date instance.
//     * @param year Year this date is contained in.
//     * @param month Month of the year starting at 1.
//     * @param day Day of the month starting at 1.
//     */
//    init(year:Int,month:Int,day:Int){
//        self.day=day
//        self.month=month
//        self.year=year
//    }
//
//    /**
//     * Create a new Date instance from Calendar instance.
//     * @param calendar Calendar whose data is used to figure out year, month and day values.
//     */
//    init(calendar:Calendar) {
//
//        let components = calendar.dateComponents([.year,.month,.day], from:Date.init())
//        year = components.year!
//        month = components.month! + 1;
//        day = components.day!;
//    }
//
//    /**
//     * Get Calendar instance representing this date, considering that this date is in English.
//     * @return Calendar instance corresponding to this English date.
//     */
//    public func getCalendar()->Calendar {
//        var dateComponents = DateComponents()
//        dateComponents.day = day
//        dateComponents.year = year
//        dateComponents.month = month
//        return dateComponents.calendar!
//
//    }
//
//    /**
//     * Convert this date to Nepali date, considering that this one is in English.
//     * @return Corresponding Nepali date for this English date.
//     */
////    public func convertToNepali()->Date {
////        return DateUtils.getNepaliDate(engDate: self);
////    }
//
//    /**
//     * Convert this date to English date, considering that this one is in Nepali.
//     * @return Corresponding English date for this Nepali date.
//     */
////    public func convertToEnglish()->Date { return DateUtils.getEnglishDate(self); }
////
//    /**
//     * Get the number of days from this date to a new date.
//     * @param newDate Last date till which number of days is calculated.
//     * @return (this - newDate) as number of days
//     */
//    public func getDaysTill(newDate:Date)->Int {
//        var dateComponents = DateComponents()
//        dateComponents.day = day
//        dateComponents.year = year
//        dateComponents.month = month
//        return (Int)((newDate.timeIntervalSince1970 - (getCalendar().date(from: dateComponents)?.timeIntervalSince1970)!)
//        / (24*60*60*1000))+1;
//    }
//}
//
//extension Date {
//    var millisecondsSince1970:Int {
//        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
//    }
//
//    init(milliseconds:Int) {
//        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
//    }
//}

