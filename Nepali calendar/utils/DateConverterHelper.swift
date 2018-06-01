//
//  DateConverterHelper.swift
//  Nepali calendar
//
//  Created by Sujindra Maharjan on 5/8/18.
//  Copyright © 2018 Sujindra Maharjan. All rights reserved.
//

import Foundation
class DateConverterHelper {
    
    private static let CLASS_TAG = "DateConverterHelper";
    //private var bs:Dictionary<Int, [Int]>  = [:]
    private var nepaliYear:Int!, nepaliMonth:Int!, nepaliDay:Int!,englishYear:Int!, englishMonth:Int!, englishDay:Int!
    private var convertedNubDay:Int!, convertedYear:Int!, convertedMonth:Int!, convertedDate:Int!
    private var convertedDay:String!, convertedNepMonth:String!
    
    public static let digits = [
    "०", "१", "२", "३", "४", "५", "६", "७","८", "९"]
    
    private var bs:[Int:[Int]] =
        [0: [2000, 30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
              1:[2001, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            2:[2002, 31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
            3:[2003, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
            4:[2004, 30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
            5:[2005, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            6:[2006, 31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
            7:[2007, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
            8:[2008, 31, 31, 31, 32, 31, 31, 29, 30, 30, 29, 29, 31],
            9:[2009, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            10:[2010, 31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
            11:[2011, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
            12:[2013, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            13:[2013, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            14:[2014, 31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
            15:[2015, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
            16:[2016, 31, 31, 31, 32, 31, 31, 29, 30, 30, 29, 30, 30],
            17:[2017, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            18:[2018, 31, 32, 31, 32, 31, 30, 30, 29, 30, 29, 30, 30],
            19:[2019, 31, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
            20:[2020, 31, 31, 31, 32, 31, 31, 30, 29, 30, 29, 30, 30],
            21:[2021, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            22:[2022, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 30],
            23:[2023, 31, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
            24:[2024, 31, 31, 31, 32, 31, 31, 30, 29, 30, 29, 30, 30],
            25:[2025, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            26:[2026, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
            27:[2027, 30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
            28:[2028, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            29:[2029, 31, 31, 32, 31, 32, 30, 30, 29, 30, 29, 30, 30],
            30:[2030, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
            31:[2031, 30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
            32:[2032, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            33:[2033, 31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
            34:[2034, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
            35:[2035, 30, 32, 31, 32, 31, 31, 29, 30, 30, 29, 29, 31],
            36:[2036, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            37:[2037, 31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
            38:[2038, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
            39:[2039, 31, 31, 31, 32, 31, 31, 29, 30, 30, 29, 30, 30],
            40:[2040, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            41:[2041, 31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
            42:[2042, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
            43:[2043, 31, 31, 31, 32, 31, 31, 29, 30, 30, 29, 30, 30],
            44:[2044, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            45:[2045, 31, 32, 31, 32, 31, 30, 30, 29, 30, 29, 30, 30],
            46:[2046, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
            47:[2047, 31, 31, 31, 32, 31, 31, 30, 29, 30, 29, 30, 30],
            48:[2048, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            49:[2049, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 30],
            50:[2050, 31, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
            51:[2051, 31, 31, 31, 32, 31, 31, 30, 29, 30, 29, 30, 30],
            52:[2052, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            53:[2053, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 30],
            54:[2054, 31, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
            55:[2055, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            56:[2056, 31, 31, 32, 31, 32, 30, 30, 29, 30, 29, 30, 30],
            57:[2057, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
            58:[2058, 30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
            59:[2059, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            60:[2060, 31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
            61:[2061, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
            62:[2062, 30, 32, 31, 32, 31, 31, 29, 30, 29, 30, 29, 31],
            63:[2063, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            64:[2064, 31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
            65:[2065, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
            66:[2066, 31, 31, 31, 32, 31, 31, 29, 30, 30, 29, 29, 31],
            67:[2067, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            68:[2068, 31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
            69:[2069, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
            70:[2070, 31, 31, 31, 32, 31, 31, 29, 30, 30, 29, 30, 30],
            71:[2071, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            72:[2072, 31, 32, 31, 32, 31, 30, 30, 29, 30, 29, 30, 30],
            73:[2073, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
            74:[2074, 31, 31, 31, 32, 31, 31, 30, 29, 30, 29, 30, 30],
            75:[2075, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            76:[2076, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 30],
            77:[2077, 31, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
            78:[2078, 31, 31, 31, 32, 31, 31, 30, 29, 30, 29, 30, 30],
            79:[2079, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            80:[2080, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 30],
            81:[2081, 31, 31, 32, 32, 31, 30, 30, 30, 29, 30, 30, 30],
            82:[2082, 30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 30, 30],
            83:[2083, 31, 31, 32, 31, 31, 30, 30, 30, 29, 30, 30, 30],
            84:[2084, 31, 31, 32, 31, 31, 30, 30, 30, 29, 30, 30, 30],
            85:[2085, 31, 32, 31, 32, 30, 31, 30, 30, 29, 30, 30, 30],
            86:[2086, 30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 30, 30],
            87:[2087, 31, 31, 32, 31, 31, 31, 30, 30, 29, 30, 30, 30],
            88:[2088, 30, 31, 32, 32, 30, 31, 30, 30, 29, 30, 30, 30],
            89:[2089, 30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 30, 30],
            90:[2090, 30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 30, 30]]

    public func isLeapYear(year:Int)->Bool {
        if (year % 100 == 0) {
                if (year % 400 == 0) {
                return true;
                } else {
                return false;
                }
        } else {
                if (year % 4 == 0) {
                return true;
                } else {
                return false;
            }
        }
    }
    
//    public func getNepaliMonth(month:Int)->String{
//        var nepaliMonth = ""
//        switch month {
//            case 1:
//            nepaliMonth = "Baishak";
//            break;
//
//            case 2:
//            nepaliMonth = "Jestha";
//            break;
//
//            case 3:
//            nepaliMonth = "Ashad";
//            break;
//
//            case 4:
//            nepaliMonth = "Shrawn";
//            break;
//
//            case 5:
//            nepaliMonth = "Bhadra";
//            break;
//
//            case 6:
//            nepaliMonth = "Ashwin";
//            break;
//
//            case 7:
//            nepaliMonth = "kartik";
//            break;
//
//            case 8:
//            nepaliMonth = "Mangshir";
//            break;
//
//            case 9:
//            nepaliMonth = "Poush";
//            break;
//
//            case 10:
//            nepaliMonth = "Magh";
//            break;
//
//            case 11:
//            nepaliMonth = "Falgun";
//            break;
//
//            case 12:
//            nepaliMonth = "Chaitra";
//            break;
//        default:
//            break
//        }
//        return nepaliMonth;
//    }
    
    public func getEnglishMonth(month:Int)->String {
        var englishMonth = "";
        switch (month) {
            case 1:
            englishMonth = "January";
            break;
            case 2:
            englishMonth = "February";
            break;
            case 3:
            englishMonth = "March";
            break;
            case 4:
            englishMonth = "April";
            break;
            case 5:
            englishMonth = "May";
            break;
            case 6:
            englishMonth = "June";
            break;
            case 7:
            englishMonth = "July";
            break;
            case 8:
            englishMonth = "August";
            break;
            case 9:
            englishMonth = "September";
            break;
            case 10:
            englishMonth = "October";
            break;
            case 11:
            englishMonth = "November";
            break;
            case 12:
            englishMonth = "December";
            break
        default:
            break
        }
        return englishMonth;
    }
    
    public func getNepaliMonth(month:Int)->String{
        var nepaliMonth = ""
        switch month {
        case 1:
            nepaliMonth = "बैशाख";
            break;
            
        case 2:
            nepaliMonth = "जेष्ठ";
            break;
            
        case 3:
            nepaliMonth = "अषाढ";
            break;
            
        case 4:
            nepaliMonth = "श्रावण";
            break;
            
        case 5:
            nepaliMonth = "भाद्र";
            break;
            
        case 6:
            nepaliMonth = "असोज";
            break;
            
        case 7:
            nepaliMonth = "कात्तिक";
            break;
            
        case 8:
            nepaliMonth = "मंसिर";
            break;
            
        case 9:
            nepaliMonth = "पौष";
            break;
            
        case 10:
            nepaliMonth = "माघ";
            break;
            
        case 11:
            nepaliMonth = "फाल्गुन";
            break;
            
        case 12:
            nepaliMonth = "चैत्र";
            break;
        default:
            break
        }
        return nepaliMonth;
    }
    
    
    public func getDayOfWeek(day:Int)->String {
        var dayOfWeek = "";
        switch (day) {
            case 1:
            dayOfWeek = "Sunday";
            break;
            
            case 2:
            dayOfWeek = "Monday";
            break;
            
            case 3:
            dayOfWeek = "Tuesday";
            break;
            
            case 4:
            dayOfWeek = "Wednesday";
            break;
            
            case 5:
            dayOfWeek = "Thursday";
            break;
            
            case 6:
            dayOfWeek = "Friday";
            break;
            
            case 7:
            dayOfWeek = "Saturday";
            break;
        default:break
        }
        return dayOfWeek;
    }
    
    
    
    public func isEngDateInRange(yy:Int, mm:Int, dd:Int) ->Bool{
    return !(yy < 1944 || yy > 2033) && !(mm < 1 || mm > 12) && !(dd < 1 || dd > 31);
    }
    
    public func isNepDateInRange(year:Int, month:Int, day:Int)->Bool {
    return !(year < 2000 || year > 2089) && !(month < 1 || month > 12) && !(day < 1 || day > 32);
    }
    
    public func engToNep(yy:Int, mm:Int, dd:Int) {
        if (!isEngDateInRange(yy:yy, mm:mm, dd:dd)) {
        return;
        }
    
        let month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        let lmonth = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        
        let def_eyy = 1944;
        let def_nyy = 2000;
        let def_nmm = 9;
        let def_ndd = 17 - 1;        //spear head nepali date...
            var total_eDays = 0;
            var total_nDays = 0;
        var a = 0;
        var day = 7 - 1;        //all the initializations...
        var m = 0;
        var y = 0;
        var numDay = 0;
        
        for k in 0..<(yy - def_eyy) {
            if isLeapYear(year: def_eyy + k) {
                for l in 0..<12 {
                    total_eDays += lmonth[l];
                }
            } else {
                for l in 0..<12{
                    total_eDays += month[l];
                }
            }
        }
        
        for i in 0..<(mm - 1){
            if (isLeapYear(year: yy)){
                total_eDays += lmonth[i];
            }
            else{
                total_eDays += month[i];
            }
        }
        
        total_eDays += dd;
        
        total_nDays = def_ndd;
        m = def_nmm;
        y = def_nyy;
            var j = def_nmm;
            var i = 0;
        //count nepali date from array
        while (total_eDays != 0) {
            let bsData = bs[i]
            
            a = bsData![j]
            total_nDays = total_nDays+1
            day = day+1
            if (total_nDays > a) {
                m+=1;
                total_nDays = 1;
                j+=1;
            }
            
            if (day > 7) {
            day = 1;
            }
            
            if (m > 12) {
            y+=1;
            m = 1;
            }
            
            if (j > 12) {
                j = 1;
                i+=1;
            }
            total_eDays-=1;
        }
        
        numDay = day;
        convertedYear = y;
        convertedMonth = m;
        convertedDate = total_nDays;
        convertedDay = getDayOfWeek(day: day);
        convertedNepMonth = getNepaliMonth(month:m);
        convertedNubDay = day
    }
    
    
    public func nepToEng(yy:Int,mm:Int,dd:Int) {
    
    
        let def_eyy = 1943;
        let def_emm = 4;
        let def_edd = 14 - 1;        // init english date.
        let def_nyy = 2000;
        let def_nmm = 1;
        let def_ndd = 1;        // equivalent nepali date.
        var total_eDays = 0;
        var total_nDays = 0;
        var a = 0;
        var day = 4 - 1;        // initializations...
        var m = 0;
        var y = 0;
        var i = 0;
        var k = 0;
        var numDay = 0;
        
        let month = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        let lmonth = [0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        
            if (isNepDateInRange(year:yy, month:mm, day:dd)) {
                // count total days in-terms of year
                for i in 0..<(yy - def_nyy) {
                    for j in 1...12{
                        let bsData = bs[k]!
                        
                        total_nDays += bsData[j]
                    }
                    k+=1
                }
            
            // count total days in-terms of month
            for j in 1..<mm{
                let bsData = bs[k]!

                total_nDays += bsData[j];
            }
            
            // count total days in-terms of dat
            total_nDays += dd;
            
            //calculation of equivalent english date...
            total_eDays = def_edd;
            m = def_emm;
            y = def_eyy;
            while (total_nDays != 0) {
                if (isLeapYear(year: y)) {
                a = lmonth[m];
                } else {
                a = month[m];
                }
                total_eDays+=1;
                day+=1;
                if (total_eDays > a) {
                    m+=1;
                    total_eDays = 1;
                    if (m > 12) {
                    y+=1;
                    m = 1;
                    }
                }
                if (day > 7){
                day = 1;
                }
                total_nDays-=1;
            }
            numDay = day;
            
            convertedYear = y;
            convertedMonth = m;
            convertedDate = total_eDays;
            
            convertedDay = getDayOfWeek(day: day);
            convertedNepMonth = getEnglishMonth(month: m);
            convertedNubDay = day;
            }
    }
    
    
    public func getConvertedYear()->Int {
    return convertedYear;
    }
    
    public func getConvertedMonth()->Int {
    return convertedMonth;
    }
    
    public func getConvertedDays()->Int {
    return convertedDate;
    }
    public func getConvertedDayOfWeek()->String {
        return convertedDay;
    }
    
    public func getConvertedDayOfWeekNumber()->Int{
        return convertedNubDay
    }
    
    public func getNumberOfDaysInMonth(year:Int,month:Int)->Int{
        let year = year-2000
        let bsData = bs[year]!
        
        
        return bsData[month]
    }
    
    
    func getStartDateOfMonth(dayOfWeek:Int,day:Int)->Int{
        //print("dayOfweek::\(dayOfWeek) ,day::\(day)")

        if day == 1{
            return dayOfWeek
        }
        else{
            let remainingDays = day.remainderReportingOverflow(dividingBy: 7)
            //print("remainingDays::\(remainingDays)")
            let remaining = remainingDays.partialValue
            if dayOfWeek>remaining{
                return dayOfWeek-remaining
            }else{
                let temp = 7 + dayOfWeek-remaining
                return temp
            }
        }
    }
    
    func getStartDayOfMonth(dayOfWeek: Int, day: Int)->Int{
        //print("dayOfweek::\(dayOfWeek) ,day::\(day)")
        
        if day == 1{
            return dayOfWeek
        }
        else{
            let remainingDays = (day-1).remainderReportingOverflow(dividingBy: 7)
            //print("remainingDays::\(remainingDays)")
            let remaining = remainingDays.partialValue
            if dayOfWeek>remaining{
                return dayOfWeek-remaining
            }else{
                let temp = 7 + dayOfWeek-remaining
                return temp
            }
        }
    }
    
    
    func getEndDateOfCurrentMonth(dayOfWeek:Int,day:Int)-> Int{
        
        var temp = day.remainderReportingOverflow(dividingBy: 7)
        //print("temp::\(temp)")
        let remaining = temp.partialValue
        temp = (remaining + dayOfWeek-1).remainderReportingOverflow(dividingBy: 7)
        return temp.partialValue
    }
    func getEndDateOfMonth(dayOfWeek:Int,day:Int)->Int{
        //print("dayOfweek::\(dayOfWeek) ,day::\(day)")
        let remainingDays = day.remainderReportingOverflow(dividingBy: 7)
        //print("remainingDays::\(remainingDays)")
        let remaining = remainingDays.partialValue
        let temp = (remaining + dayOfWeek-1).remainderReportingOverflow(dividingBy: 7)
        return temp.partialValue
    }
    
    static func getCurrentDateAndMonth()->(year:Int,month:Int){
        let currentDate = Calendar.current.dateComponents([.year,.month,.day], from: Date.init())
        let currentDateConverter = DateConverterHelper.init()
        let dateConverter = DateConverterHelper.init()
        
        currentDateConverter.engToNep(yy: currentDate.year!, mm: currentDate.month!, dd: currentDate.day!)
        dateConverter.engToNep(yy: currentDate.year!, mm: currentDate.month!, dd: currentDate.day!)
        let current_year = currentDateConverter.getConvertedYear()
        let current_month = currentDateConverter.getConvertedMonth()
        return (year: current_year,month: current_month)
    }

    
}
