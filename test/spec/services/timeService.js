// Generated by CoffeeScript 1.6.3
'use strict';
describe('Service: timeService', function() {
  var rootScope, timeService;
  beforeEach(module('tiwoApp'));
  timeService = {};
  rootScope = null;
  beforeEach(inject(function(_timeService_, $rootScope) {
    timeService = _timeService_;
    return rootScope = $rootScope;
  }));
  return it('should do something', function() {
    return expect(!!timeService).toBe(true);
  });
});