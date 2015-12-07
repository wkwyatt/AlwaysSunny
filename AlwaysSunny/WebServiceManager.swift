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
            if error == nil {
                var forecastData = [Forecast]()
                do {
                    if let jsonObject: [String:AnyObject] = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)as? [String:AnyObject] {
                        dispatch_async(dispatch_get_main_queue()) {
                            let weeklyForecast = self.parseWeeklyForecast(jsonObject)
                            forecastData = weeklyForecast
                            callback(forecastData)
                        }
                    }
                } catch {
                    //  We have an error parsing the forecast data from json
                    callback([])
                }
                //  We have a data error
                print("There is a error with the data")
            }
        }
        
        task.resume()
    }
    
    func parseWeeklyForecast(jsonDictionary:[String:AnyObject]) -> [Forecast] {
        var forecast = [Forecast]()
        
        
        if let weeklyWeatherDictionary = jsonDictionary["list"] as? [AnyObject] {
            for day in weeklyWeatherDictionary {
                let thisForecast = Forecast()
                if let tempDictionary = day["temp"] as? [String: AnyObject] {
                    thisForecast.minTemp = tempDictionary["min"] as? Int
                    thisForecast.maxTemp = tempDictionary["max"] as? Int
                }
                if let weatherDictionary = day["weather"] as? [AnyObject] {
                    for element in weatherDictionary {
                        thisForecast.forecast = element["main"] as? String
                        thisForecast.thumbnail = element["icon"] as? String
                    }
                }
                forecast.append(thisForecast)
            }
        }
        
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
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            let currentForecast = self.parseDailyForecast(jsonObject)
                            forecastData = currentForecast
                            callback(forecastData)
                        }
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