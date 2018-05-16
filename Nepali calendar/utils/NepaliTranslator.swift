//
//  NepaliTranslator.swift
//  Nepali calendar
//
//  Created by Sujindra Maharjan on 5/8/18.
//  Copyright © 2018 Sujindra Maharjan. All rights reserved.
//

import Foundation

class NepaliTranslator{
    
    /// Nepali digits in devanagiri/unicode
    public static let digits = [
        "०", "१", "२", "३", "४", "५", "६", "७","८", "९"]
    
    /// Nepali months in devanagiri/unicode
    public static let months = [
    "बैशाख", "जेष्ठ", "अषाढ", "श्रावण", "भाद्र", "असोज", "कात्तिक", "मंसिर", "पौष", "माघ", "फाल्गुन", "चैत्र"]
    
    /// Nepali days in devanagiri/unicode
    //public static let days = [
   // "आईतबार", "सोमबार", "मंगलबार", "बुधबार", "बिहीबार", "शुक्रबार", "शनिबार"]
    public static let days = [
        "आईत", "सोम", "मंगल", "बुध", "बिही", "शुक्र", "शनि"]
    /**
     * Get nepali month in devanagiri/unicode.
     * @param month Month in the range [1, 12].
     * @return Nepali month in devanagiri/unicode.
     */
    public static func getMonth(month:Int)->String {
    return months[month-1];
    }
    
    /**
     * \Get nepali day as complete name in devanagiri/unicode.
     * @param day Day in range [0, 6].
     * @return Nepali day in devanagiri/unicode.
     */
    public static func getDay(day:Int)->String {
    return days[day];
    }
    
//    /**
//     * Get nepali day as short name (without बार at the end).
//     * @param day Day in range[0, 6].
//     * @return Short nepali day in devanagiri/unicode.
//     */
//    public static func getShortDay(day:Int)->String {
//        let longDay = getDay(day:day);
//        return longDay
////        return longDay.substring(0, longDay.index(before:"बार"));
//    }
    
    /**
     * Convert number to devanagiri/unicode.
     * @param english English number to convert.
     * @return Corresponding nepali number in devanagiri/unicode.
     */
    public static func getNumber(english:String)->String {
        var nepali = ""
        for i in 0..<english.count {
            let c = english[i...i]
            print("c::>>\(c)")
            if c >= "0" && c <= "9"{
                nepali += digits[Int(c)!];
            }
            else{
                nepali += c
            }
        }
        return nepali;
    }
}

extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    subscript (bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ..< end]
    }
    subscript (bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ... end]
    }
    subscript (bounds: CountablePartialRangeFrom<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(endIndex, offsetBy: -1)
        return self[start ... end]
    }
    subscript (bounds: PartialRangeThrough<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ... end]
    }
    subscript (bounds: PartialRangeUpTo<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ..< end]
    }
}
extension Substring {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    subscript (bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ..< end]
    }
    subscript (bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ... end]
    }
    subscript (bounds: CountablePartialRangeFrom<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(endIndex, offsetBy: -1)
        return self[start ... end]
    }
    subscript (bounds: PartialRangeThrough<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ... end]
    }
    subscript (bounds: PartialRangeUpTo<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ..< end]
    }
}
