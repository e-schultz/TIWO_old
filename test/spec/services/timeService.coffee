'use strict'

describe 'Service: timeService', () ->

  # load the service's module
  beforeEach module 'tiwoApp'

  # instantiate service
  timeService = {}
  rootScope = null
  cleanDate = (hour,min,sec) ->
    date = new Date()
    date.setHours(hour)
    date.setMinutes(min)
    date.setSeconds(sec)
    date.setMilliseconds(0)
    return date
  beforeEach inject (_timeService_,$rootScope) ->
    timeService = _timeService_
    rootScope = $rootScope

  it 'should do something', () ->
    expect(!!timeService).toBe true;

  it 'should expect 3a to be parsed as a date at 3am', () ->
    result = timeService.parseDate('3a')
    expect(result.getHours()).toBe 3

  it 'should expect 3p to be parsed as a date at 3pm', () ->
    result = timeService.parseDate('3p')
    expect(result.getHours()).toBe 15

  it 'should expect 3pm to be parsed as a date at 3pm', () ->
    result = timeService.parseDate('3p')
    expect(result.getHours()).toBe 15

  it 'should expect 3a to be parsed as a date at 3am', () ->
    result = timeService.parseDate('3a')
    expect(result.getHours()).toBe 3

  it 'should expect 01/01/2012 to be parsed as a date at of Jan 1st, 2012', () ->
    result = timeService.parseDate('01/01/2012')
    expect(result.getMonth()).toBe 0
    expect(result.getFullYear()).toBe 2012
    expect(result.getDate()).toBe 1

  it 'should expect 01/01/2012 3am to be parsed as a date at of Jan 1st, 2012 at 3am', () ->
    result = timeService.parseDate('01/01/2012 3am')
    rootScope.$apply()
    expect(result.getMonth()).toBe 0
    expect(result.getFullYear()).toBe 2012
    expect(result.getDate()).toBe 1
    expect(result.getHours()).toBe 3

  it 'should expect times 9am-10am to have a time difference of 1 hour', () ->
    startDate = cleanDate(9,0,0)
    endDate = cleanDate(10,0,0)
    result = timeService.dateDiff(startDate,endDate)
    expect(result).toBe(1)

  it 'should expect times 9am-10am to have a time difference of 60 min', () ->
    startDate = cleanDate(9,0,0)
    endDate = cleanDate(10,0,0)
    
    result = timeService.dateDiff(startDate,endDate,"m")
    expect(result).toBe(60)

  it 'should expect times 9am-10:30am to have a time difference of 90 min', () ->
    startDate = cleanDate(9,0,0)
    endDate = cleanDate(10,30,0)
    
    result = timeService.dateDiff(startDate,endDate,"m")
    expect(result).toBe(90)

  it 'should expect times 9am-10:30am to have a time difference of 1.5h', () ->
    startDate = cleanDate(9,0,0)
    endDate = cleanDate(10,30,0)
    
    result = timeService.dateDiff(startDate,endDate)
    expect(result).toBe(1.5)

   
