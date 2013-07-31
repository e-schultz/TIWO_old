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
