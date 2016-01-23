# Always Sunny
iOS Weather application that displays current weather information as well as a weekly weather forecast.

## Screenshots

![](https://cloud.githubusercontent.com/assets/13364964/12527679/f1cd2c1e-c14d-11e5-96f5-43e4edfc8a6a.png)

## Features 
* Display current weather data
* Display weekly forecast data

## Code 
Access data for the weather through url

[http://api.openweathermap.org/data/2.5/forecast/daily?q=Atlanta,ga&mode=json&cnt=5&units=imperial&APPID=\(PrivateKeys.sharedKeys.weatherApiKey)](http://api.openweathermap.org/data/2.5/forecast/daily?q=Atlanta,ga&mode=json&cnt=5&units=imperial&APPID=\(PrivateKeys.sharedKeys.weatherApiKey))

Loaded data to main thread as well as parsed data to usable format for the Main View Controller
```Swift
func fetchWeeklyWeatherForecastData(callback: ([Forecast]) -> Void) {
        ....
        // create a session request with given url
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
        ...
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
               ...
                forecast.append(thisForecast)
            }
        }
        
        return forecast
    }
```

## Features To Add
* Load weather data based on device location
* Search for weather data based on address or zip code search

