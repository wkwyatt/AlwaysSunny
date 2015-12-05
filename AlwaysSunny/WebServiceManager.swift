//
//  WebServiceManager.swift
//  AlwaysSunny
//
//  Created by Will Wyatt on 12/5/15.
//  Copyright © 2015 Will Wyatt. All rights reserved.
//

import Foundation

struct WebServiceManager {
    
    func fetchWeeklyWeatherForecastData(callback: ([Forecast]) -> Void) {
        let url = NSURL(string: "http://api.openweathermap.org/data/2.5/forecast/daily?q=Atlanta,ga&mode=json&cnt=5&units=imperial&APPID=\(PrivateKeys.sharedKeys.weatherApiKey)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            
        }
        
        task.resume()
    }
    
    func parseWeeklyForecast(jsonDictionary:[String:AnyObject]) -> Forecast {
        let forecast = Forecast()
        
//        date:String?
//        forecast:String?
//        minTemp:String?
//        maxTemp:String?
//        mainImage:String?
//        thumbnail:String?
        
        return forecast
    }
    
    func fetchCurrentWeatherForecastData(callback: (Forecast) -> Void) {
        let url = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=Atlanta&units=imperial&APPID=\(PrivateKeys.sharedKeys.weatherApiKey)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            // if no errors get the json obj
            if error == nil {
                //  create array of Forecast obj to send to the callback
                var forecastData = Forecast()
                do {
                    if let jsonObject: [String:AnyObject] = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? [String:AnyObject] {
                        let currentForecast = self.parseDailyForecast(jsonObject)
                        forecastData = currentForecast
                        callback(forecastData)
                    }
                } catch {
                    // handle the error
                    print("There is a do / catch error!!!")
                    callback(Forecast())
                }
            } else {
                // we have a data error
                print("We have a data error!!! : \(error)")
            }
        }
        
        task.resume()
    }
    
    func parseDailyForecast(jsonDictionary:[String:AnyObject]) -> Forecast {
        let dailyForecast = Forecast()
        
        // get the current weather description & weather image
        if let weatherDictionary = jsonDictionary["weather"] as? [AnyObject] {
            print("MADE WEATHER DICT:")
            for element in weatherDictionary {
                dailyForecast.forecast = element["main"] as? String
                print("WEATHER DICT MAIN : \(dailyForecast.forecast)")
                dailyForecast.mainImage = element["icon"] as? String
            }
        }
        
        //  get the current min and max temp
        if let tempDictionary = jsonDictionary["main"] as? [String: AnyObject] {
            print("MADE TEMP DICT : ")
            dailyForecast.minTemp = tempDictionary["temp_min"] as? Int
            print("MIN : \(dailyForecast.minTemp)")
            dailyForecast.maxTemp = tempDictionary["temp_max"] as? Int
        }
        
        return dailyForecast
    }
    

}