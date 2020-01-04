//
//  SpaceXAPI.swift
//  SpaxeC
//
//  Created by Cory Graham on 1/3/20.
//  Copyright © 2020 Cory Graham. All rights reserved.
//

import UIKit

class SpaceXAPI {
  
   var delegate : SpaceXAPIDelegate?
    /*
     * Set string that points to our api to get the Launch objects.
     */
    let spaceXLaunchString:String = "https://api.spacexdata.com/v3/launches"
    /*
     * Array to hold the we get back from the get call.
     */
    var spaceXArray = NSMutableArray()
    /*
     * Set string that points to our api to get the mission object
     */
    let spaceXMissionString:String = "https://api.spacexdata.com/v3/missions/"
    /*
     * Start our initiliaztion with the request for launches.
     */
    init()
    {
        startReguestForLaunches()
    }
    
    func startReguestForLaunches()
    {
        let url = URL(string: spaceXLaunchString)!
        
        let session = URLSession.shared
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSArray {
                    let array = json
                
                    self.decipherDataFromLaunch(array: array as NSArray)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        
        task.resume()
       
    }
    
    func startRequestForMission(missionID:String)
    {
        var appendedMissionString = spaceXMissionString
        appendedMissionString.append(missionID)
        let url = URL(string:appendedMissionString)!
        
        let session = URLSession.shared
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    
                    print(json)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        
        task.resume()
    }
    
    func decipherDataFromLaunch(array: NSArray)
    {
        
        for dictionary in (array as? [[String:Any]])!
        {

            
            let rocketdict = dictionary["rocket"] as? [String:Any]
            let launchSiteDict = dictionary["launch_site"] as? [String:Any]
            let truncatedDateString = dictionary["launch_date_local"] as! String
            let linksDict = dictionary["links"] as? [String: Any]
          
            let spacexLaunch = SpaceXLaunchInfo(myMissionName: dictionary["mission_name"] as! String, myRocketName: rocketdict!["rocket_name"] as! String, myLaunchSiteName: launchSiteDict!["site_name"] as! String, myDateOfLaunch:String(truncatedDateString.prefix(10)), myLaunchImage:linksDict!["mission_patch_small"] as? String ?? "test", missionID: dictionary["mission_id"] as? String ?? "N/A")
                
                
            self.spaceXArray.add(spacexLaunch);

        }
       if(spaceXArray.count > 0)
              {
                  print((self.spaceXArray[23] as! SpaceXLaunchInfo).missionName)
                  self.startRequestForMission(missionID: (spaceXArray[23] as! SpaceXLaunchInfo).missionName)
              }
        self.didFinish()
    }
    
    func didFinish() {
        delegate?.didFinishDownloading(self)
    }
}
