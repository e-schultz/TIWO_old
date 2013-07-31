'use strict'

angular.module('tiwoApp')
    .controller 'MainCtrl', ['$scope','taskService', ($scope,taskService) ->
        $scope.model = {}
        $scope.getTasks = () ->
            taskService.get()
        
        $scope.model.tasks =  $scope.getTasks()
        $scope.model.curTask = {}
        $scope.model.nextTask = {}
        $scope.model.taskNames = taskService.getTaskNames()
        $scope.model.tempTasks = [{ show: true},{ show:true}, {show:false, taskName: 'test'} ]

        $scope.keyHandled = () ->
            console.log('key?')
        $scope.clearAll = () -> 
            taskService.clearAll()
            $scope.model.tasks = $scope.getTasks()
            $scope.model.taskNames = taskService.getTaskNames()
        
        
        
        $scope.addItem = (item) ->
            taskService.add(item)
            $scope.model.tasks = $scope.getTasks()
            $scope.model.curTask = {}
            $scope.model.taskNames = taskService.getTaskNames()

        $scope.$watch 'model.tasks', (newValue,oldValue) ->
            if !angular.equals(newValue,oldValue)
                taskService.update(item) for item in newValue
                $scope.model.taskNames = taskService.getTaskNames()

        ,true


  ]
