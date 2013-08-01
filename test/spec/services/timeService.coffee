'use strict'

describe 'Service: timeService', () ->

  # load the service's module
  beforeEach module 'tiwoApp'

  # instantiate service
  timeService = {}
  rootScope = null
  beforeEach inject (_timeService_,$rootScope) ->
    timeService = _timeService_
    rootScope = $rootScope

  it 'should do something', () ->
    expect(!!timeService).toBe true;

  it 'should expect 3a to be parsed as a date at 3am', () ->
    result = timeService.parseDate('3a').then (data) ->
      result = data
    rootScope.$apply()
    expect(result.getHours()).toBe 3

  it 'should expect 3p to be parsed as a date at 3pm', () ->
    result = timeService.parseDate('3p').then (data) ->
      result = data
    rootScope.$apply()
    expect(result.getHours()).toBe 15

  it 'should expect 3pm to be parsed as a date at 3pm', () ->
    result = timeService.parseDate('3p').then (data) ->
      result = data
    rootScope.$apply()
    expect(result.getHours()).toBe 15

  it 'should expect 3a to be parsed as a date at 3am', () ->
    result = timeService.parseDate('3a').then (data) ->
      result = data
    rootScope.$apply()
    expect(result.getHours()).toBe 3

  it 'should expect 01/01/2012 to be parsed as a date at of Jan 1st, 2012', () ->
    result = timeService.parseDate('01/01/2012').then (data) ->
      result = data
    rootScope.$apply()
    expect(result.getMonth()).toBe 0
    expect(result.getFullYear()).toBe 2012
    expect(result.getDate()).toBe 1

  it 'should expect 01/01/2012 3am to be parsed as a date at of Jan 1st, 2012 at 3am', () ->
    result = timeService.parseDate('01/01/2012 3am').then (data) ->
      result = data
    rootScope.$apply()
    expect(result.getMonth()).toBe 0
    expect(result.getFullYear()).toBe 2012
    expect(result.getDate()).toBe 1
    expect(result.getHours()).toBe 3

  it 'should expect 9am-10am to have a time difference of 1 hour', () ->
    startDate = new Date()
    startDate.setHours(9)
    startDate.setMinutes(0)
    startDate.setSeconds(0)
    endDate = new Date()
    endDate.setHours(10)
    endDate.setMinutes(0)
    endDate.setSeconds(0)
    result = timeService.dateDiff(startDate,endDate).then (data) ->
      result = data
    rootScope.$apply()
    expect(result).toBe(1)

   
