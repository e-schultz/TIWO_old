'use strict'

describe 'Controller: MainCtrl', () ->
  # load the controller's module
  beforeEach module 'tiwoApp'

  MainCtrl = {}
  scope = {}
  

 # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope,_taskService_) ->
    scope = $rootScope.$new()
    MainCtrl = $controller 'MainCtrl', {
      $scope: scope
      ,taskService: _taskService_
    }

    it 'should start with no tasks', ->
      scope.getTasks()
      expect(scope.tasks.length).toEqual(0)



  
