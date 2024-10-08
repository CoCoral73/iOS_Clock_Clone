//
//  WorldClockViewController.swift
//  iOS_Clock_Clone
//
//  Created by 김정원 on 8/26/24.
//

import UIKit

class WorldClockViewController: UIViewController {
    
    @IBOutlet weak var worldClockTableView: UITableView!
    
    var list = [
        TimeZone(identifier: "Asia/Seoul")!,
        TimeZone(identifier: "Europe/Paris")!,
        TimeZone(identifier: "America/New_York")!,
        TimeZone(identifier: "Asia/Tehran")!,
        TimeZone(identifier: "Asia/Vladivostok")!
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: .timeZoneDidSelect, object: nil, queue: .main) { [weak self] noti in 
            guard let self, let timeZone = noti.userInfo?["timeZone"] as? TimeZone else { return }
            
            guard !self.list.contains(where: { $0.identifier == timeZone.identifier }) else { return }
            
            self.list.append(timeZone)
            self.worldClockTableView.reloadData()
        }
    }
    
}

extension WorldClockViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //지정된 인덱스 경로(indexPath)에 해당하는 셀을 반환한다. 해당 셀은 화면에 표시된다.
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WorldClockTableViewCell.self), for: indexPath) as! WorldClockTableViewCell
        
        let target = list[indexPath.row]
        cell.timeLabel.text = target.currentTime
        cell.timePeriodLabel.text = target.timePeriod
        cell.timeZoneLabel.text = target.city
        cell.timeOffsetLabel.text = target.timeOffset
        
        return cell
    }
}
