//
//  TimeZone+Util.swift
//  iOS_Clock_Clone
//
//  Created by 김정원 on 8/28/24.
//

import Foundation

fileprivate let formatter = DateFormatter()
fileprivate let offsetFormatter = DateComponentsFormatter()

extension TimeZone {
    var currentTime: String? {      //현재 시각
        formatter.timeZone = self
        formatter.dateFormat = "h:mm"
        
        return formatter.string(from: .now)
    }
    
    var timePeriod: String? {       //오전, 오후
        formatter.timeZone = self
        formatter.dateFormat = "a"
        
        return formatter.string(from: .now)
    }
    
    var city: String? {
        let id = identifier
        let city = id.components(separatedBy: "/").last
        return city
    }
    
    var timeOffset: String? {
        //Timezone.current.secondsFromGMT(): 디바이스에 설정된 지역의 시간대과 그리니치 표준시의 시차(초 단위로 반환)
        let offset = secondsFromGMT() - TimeZone.current.secondsFromGMT()
        let prefix = offset >= 0 ? "+" : ""
        let comp = DateComponents(second: offset)
        
        if offset.isMultiple(of: 3600) {
            offsetFormatter.allowedUnits = [.hour]
            offsetFormatter.unitsStyle = .full      //~hour ~minutes
        }
        else {
            offsetFormatter.allowedUnits = [.hour, .minute]
            offsetFormatter.unitsStyle = .positional        //h:mm
        }
        
        let offsetStr = offsetFormatter.string(from: comp) ?? "\(offset / 3600)시간"
            
        let time = Date(timeIntervalSinceNow: TimeInterval(offset))
        let cal = Calendar.current
        if cal.isDateInToday(time) {
            return "오늘, \(prefix)\(offsetStr)"
        }
        else if cal.isDateInYesterday(time) {
            return "어제, \(prefix)\(offsetStr)"
        }
        else if cal.isDateInTomorrow(time) {
            return "내일, \(prefix)\(offsetStr)"
        }
        else { return nil }
    }
}
