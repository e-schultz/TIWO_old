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

	it 'should return a list of unique task names in the collection',()->
		taskService.clearAll()
				
		taskService.add({taskName: 'Phoenix 1', taskDate: '01/01/2012', startTime: '3am', endTime: '4am '})
		taskService.add({taskName: 'Phoenix 1', taskDate: '01/01/2012', startTime: '3am', endTime: '4am '})
		taskService.add({taskName: 'Phoenix 2', taskDate: '01/01/2012', startTime: '3am', endTime: '4am '})
		taskService.add({taskName: 'Phoenix 3', taskDate: '01/01/2012', startTime: '3am', endTime: '4am '})
		taskService.add({taskName: 'Phoenix 3', taskDate: '01/01/2012', startTime: '3am', endTime: '4am '})

		rootScope.$apply()
		
		result = taskService.getTaskNames().then (data) ->
			result = data

		rootScope.$apply()
		expect(result.length).toEqual(3)

	it 'should convert the taskDate to a date when adding a value', ->
		task = {taskName: 'Phoenix 1',taskDate: '01/01/2012', startTime: '3am', endTime: '5pm'}
		taskService.add(task).then (data) ->
			task = data
		rootScope.$apply()
		expect(angular.isDate(task.taskDate)).toEqual(true)

	describe 'the task grouping functionality', () ->
		beforeEach () ->
			taskService.clearAll()
			taskService.add({taskName: 'Phoenix 1', taskDate: '01/01/2012', startTime: '3am', endTime: '4am '})
			taskService.add({taskName: 'Phoenix 2', taskDate: '01/01/2012', startTime: '3am', endTime: '4am '})
			taskService.add({taskName: 'Phoenix 3', taskDate: '01/01/2012', startTime: '3am', endTime: '4am '})
			taskService.add({taskName: 'Phoenix 3', taskDate: '01/01/2012', startTime: '3am', endTime: '4am '})
			taskService.add({taskName: 'Phoenix 3', taskDate: '01/01/2012', startTime: '6am', endTime: '7am '})

			taskService.add({taskName: 'Phoenix 1', taskDate: '01/02/2012', startTime: '3am', endTime: '4am '})
			taskService.add({taskName: 'Phoenix 2', taskDate: '01/02/2012', startTime: '3am', endTime: '4am '})
			
			taskService.add({taskName: 'Phoenix 3', taskDate: '01/03/2012', startTime: '3am', endTime: '4am '})
			taskService.add({taskName: 'Phoenix 3', taskDate: '01/03/2012', startTime: '1am', endTime: '10am '})

		
		it 'should group tasks by date, return 3 groups of dates',()->
			# task data is setup in before each for this group	
			groups = taskService.groupBy('d').then (data) ->
					groups = data
			rootScope.$apply()
			
			expect(_.toArray(groups).length).toBe(3)


		it 'should group tasks within the date', () ->
			groups = taskService.groupBy('d').then (data) ->
					groups = data
			rootScope.$apply()

			expect(groups['1/1/2012'].length).toBe(3)
			expect(groups['1/2/2012'].length).toBe(2)
			expect(groups['1/3/2012'].length).toBe(1)

		it 'should sum the duration within the task groups', () ->
			groups = taskService.groupBy('d').then (data) ->
					groups = data
			rootScope.$apply()

			expect(_.findWhere(groups['1/1/2012'],{taskName: 'Phoenix 1'}).total).toBe(1)
			expect(_.findWhere(groups['1/1/2012'],{taskName: 'Phoenix 2'}).total).toBe(1)
			expect(_.findWhere(groups['1/1/2012'],{taskName: 'Phoenix 3'}).total).toBe(3)

			expect(_.findWhere(groups['1/2/2012'],{taskName: 'Phoenix 1'}).total).toBe(1)
			expect(_.findWhere(groups['1/2/2012'],{taskName: 'Phoenix 2'}).total).toBe(1)

			expect(_.findWhere(groups['1/3/2012'],{taskName: 'Phoenix 3'}).total).toBe(10)
			
			
			
			
			











    



