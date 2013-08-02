'use strict'

describe 'Controller: MainCtrl', () ->
  # load the controller's module
  beforeEach module 'tiwoApp'

  MainCtrl = {}
  scope = {}
  rootScope = {}

 # Initialize the controller and a mock scope
  beforeEach inject ($controller, _$rootScope_,_taskService_,_timeService_,$filter) ->
    scope = _$rootScope_.$new()
    _taskService_.clearAll()
    rootScope = _$rootScope_
    MainCtrl = $controller 'MainCtrl', {
      $scope: scope
      ,taskService: _taskService_
      ,timeService: _timeService_
      ,$filter: $filter
    }

  it 'should start with no tasks', ->
     scope.$apply()
     expect(scope.model.tasks.length).toBeFalsy()

   it 'should add a new task to the list when calling add item', ->
     task =
       taskDate: '01/01/2012'
       ,taskName: 'Phoenix'
       ,startTime: '3am'
       ,endTime: '4am'

     scope.addItem task
     scope.$apply()
     expect(scope.model.tasks.length).toEqual(1)

  it 'should have the next task default the date of the task you just entered', ->
    task =
       taskDate: '01/01/2012'
       ,taskName: 'Phoenix'
       ,startTime: '3am'
       ,endTime: '4am'

     scope.addItem task
     scope.$apply()
     expect(scope.model.curTask.taskDate).toEqual('01/01/2012')

  it 'should calculate the duration of the added task', ->
    task =
       taskDate: '01/01/2012'
       ,taskName: 'Phoenix'
       ,startTime: '3am'
       ,endTime: '4am'

     scope.addItem task
     scope.$apply()
     expect(scope.model.tasks[0].duration).toEqual(1)

  it 'should have the task name added to the taskName collection on the screen', ->
    task =
       taskDate: '01/01/2012'
       ,taskName: 'Phoenix'
       ,startTime: '3am'
       ,endTime: '4am'

     scope.addItem task
     scope.$apply()
     expect(scope.model.taskNames.length).toEqual(1)
     expect(scope.model.taskNames[0]).toEqual("Phoenix")
     







  
