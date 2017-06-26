//
//  ScheduleRideViewController.swift
//  GravityInterfaceViewController.
//
//  Created by Michael Liptuga on 10.05.17.
//  Copyright © 2017 Agilie. All rights reserved.
//
import UIKit
import AGMobileGiftInterface

class GravityInterfaceViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate lazy var scheduleRideService   : ScheduleRideService  =  ScheduleRideService ()
    
    fileprivate lazy var agGravityService   : AGGravityService  =  AGGravityService()

    fileprivate var tableViewData : [TableViewItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.updateConstraintsIfNeeded()
        self.view.layoutIfNeeded()

        self.registerTableViewCells()
        self.configureTableView()
        self.loadScheduleRideData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
        
    @IBAction func startButtonDidTouch(_ sender: Any) {
//        self.agGravityService.startGravityView(view: self.view, duration: 10, collisionMode: .everything)
        self.agGravityService.startGravityViewController(viewController: self, duration: 10, collisionMode: .everything)
    }
}

extension GravityInterfaceViewController
{
    fileprivate func registerTableViewCells()
    {
        self.tableView.register(ChildrenTableViewCell.cellNib, forCellReuseIdentifier: ChildrenTableViewCell.id)
        self.tableView.register(ScheduleTableViewCell.cellNib, forCellReuseIdentifier: ScheduleTableViewCell.id)
        self.tableView.register(TripOptionTableViewCell.cellNib, forCellReuseIdentifier: TripOptionTableViewCell.id)
    }
    
    fileprivate func configureTableView()
    {
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 200
        self.tableView.tableFooterView = ScheduleRideTableViewFooter.create()
    }
    
    fileprivate func loadScheduleRideData ()
    {
        self.scheduleRideService.loadScheduleRideDataWithCompletion {[weak self] (scheduleRideData) in
            guard let `self` = self else { return }
            self.tableViewData = scheduleRideData
            self.tableView.reloadData()
        }
    }
}

extension GravityInterfaceViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellIdentifier = self.tableViewData[indexPath.row].cellId
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }
        cell.configureForObject(object: self.tableViewData[indexPath.row].object)        
        return cell
    }
}
