'use strict';

angular.module('tiwoApp')
  .service 'timeService', ($q,$http) ->
    rexp = new RegExp("^" + "(?:" + "(1[0-2]|0?[1-9])" + "[/-]" + "(3[0,1]|[1,2][0-9]|0?[1-9])" + "(?:[/-]" + "(19[7-9][0-9]|2[0-9]{3}|[0-9]{2})" + ")?" + "\\s?" + ")?" + "(?:" + "(2[0-3]|1[0-9]|[1-9])" + "(?:[:]" + "([0-5][0-9])" + "(?:[:]" + "([0-5][0-9])" + ")?" + ")?" + "\\s?" + "(?:([aApP])[mM]?)?" + ")?$")
    i =
      Month: 1
      Day: 2
      Year: 3
      Hour: 4
      Min: 5
      Sec: 6
      AMPM: 7

    trim = (s) ->
      s.replace /^\s+|\s+$/g, ""

    parseDate = (strDate) ->
      if angular.isDate(strDate)
        return strDate
        
      strDate = trim(strDate)
      parsed = rexp.exec(strDate)
      return null  if not strDate or not parsed
      ret = new Date()
      year = ret.getFullYear()
      if parsed[i.Year]
        switch parsed[i.Year].length
          when 4
            year = parseInt(parsed[i.Year], 10)
          when 2
            year = year - (year % 100) + parseInt(parsed[i.Year], 10)
      month = ((if parsed[i.Month] then parseInt(parsed[i.Month], 10) - 1 else ret.getMonth()))
      day = ((if parsed[i.Day] then parseInt(parsed[i.Day], 10) else ret.getDate()))
      hour = ((if parsed[i.Hour] then parseInt(parsed[i.Hour], 10) else 0))
      min = ((if parsed[i.Min] then parseInt(parsed[i.Min], 10) else 0))
      sec = ((if parsed[i.Sec] then parseInt(parsed[i.Sec], 10) else 0))
      ms = 0
      ret.setFullYear year, month, day
      ret.setHours hour, min, sec, ms
      return ret  unless parsed[i.AMPM]
      if hour > 12 and parsed[i.AMPM].toLowerCase() is "p"
        ret.setHours ret.getHours() + 12
      else if hour < 12 and parsed[i.AMPM].toLowerCase() is "p"
        ret.setHours ret.getHours() + 12
      else ret.setHours ret.getHours() - 12  if hour is 12 and parsed[i.AMPM].toLowerCase() is "a"
      return ret
  	

    class timeService
      parseDate: (inputTime) ->
        #deferred = $q.defer()
        result = inputTime
        result = parseDate(inputTime) unless !inputTime?
        #deferred.resolve(result)
        #return deferred.promise
      dateDiff: (startTime,endTime,format = "h") ->
        DAY = 1000 * 60 * 60  * 24
        HOUR = 1000 * 60 * 60
        MIN = 1000 * 60
        
        switch format
          when "h" then mod = HOUR
          when "m" then mod = MIN
          when "d" then mod = DAY
          else mod = 100

        #deferred = $q.defer()
        diff = (endTime.getTime() - startTime.getTime()) / mod 
        #deferred.resolve(diff)
        #return deferred.promise
    return new timeService()
    # AngularJS will instantiate a singleton by calling "new" on this function

