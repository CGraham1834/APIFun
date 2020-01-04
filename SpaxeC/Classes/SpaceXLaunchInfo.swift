//
//  SpaceXLaunchInfo.swift
//  SpaxeC
//
//  Created by Cory Graham on 1/3/20.
//  Copyright © 2020 Cory Graham. All rights reserved.
//

import UIKit

class SpaceXLaunchInfo {

    var missionName:String
    var rocketName:String
    var launchSiteName:String
    var dateOfLaunch:String
    var launchImage: String
    var missionId:String
    init(myMissionName:String, myRocketName: String, myLaunchSiteName:String, myDateOfLaunch: String, myLaunchImage:String, missionID:String)
    {
        missionName = myMissionName
        rocketName = myRocketName
        launchSiteName = myLaunchSiteName
        dateOfLaunch = myDateOfLaunch
        launchImage = myLaunchImage
        missionId = missionID
    }
}
