'use strict'

describe 'Service: taskService', () ->

	# load the service's module
	beforeEach module 'tiwoApp'

	# instantiate service
	taskService = {}
	testList = []
	rootScope = null
	getTasks = () ->
		taskList = 
			[{
					id: 1
					taskName: 'Phoenix'
					,taskDate: '2012/01/01'
					, startTime: '9am'
					, endTime: '10am'
					, duration: null
					, calculatedDuraton: null
				},
				{
					id: 2
					taskName: 'Phoenix'
					,taskDate: '2012/01/01'
					, startTime: '3pm'
					, endTime: '5pm'
					, duration: null
					, calculatedDuraton: null
				}]
  
	beforeEach inject (_taskService_,$rootScope) ->
		taskService = _taskService_
		localStorage.taskList = JSON.stringify(angular.copy(getTasks()))
		rootScope = $rootScope


	it 'should do something', () ->
		expect(!!taskService).toBe true;

	it 'should return two tasks',() ->
		result = taskService.get().then (data)->
			result = data
		rootScope.$apply()
		expect(result.length).toEqual(2)

	it 'should return three tasks after adding a new task to the list',() ->
		item = {
					id: 0
					taskName: 'Phoenix'
					,taskDate: '2012/01/01'
					, startTime: '6am'
					, endTime: '7am'
					, duration: null
					, calculatedDuraton: null
				}
		taskService.add(item)
		result = taskService.get().then (data)->
			result = data
		rootScope.$apply()
		expect(result.length).toEqual(3)

	it 'should return one item with the id of 1',()->
		result = taskService.get(1).then (data) ->
			result = data
		rootScope.$apply()
		expect(result[0].id).toEqual(1)




    



