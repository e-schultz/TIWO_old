'use strict'

describe 'Directive: tiTask', () ->
  beforeEach module 'tiwoApp.tiTask'

  beforeEach inject (($injector) ->
  	$httpBackend = $injector.get('$httpBackend')
  	)
  	


  element = {}

  it 'should make hidden element visible', inject ($rootScope, $compile) ->
  	$httpBackend.expectGET('/views/tiTask/tiTask.html');
    element = angular.element '<ti-task></ti-task>'
    element = $compile(element) $rootScope
    # expect(element.text()).toBe 'this is the tiTask directive'
