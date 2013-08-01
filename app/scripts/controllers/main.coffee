'use strict'

angular.module('tiwoApp')
    .controller 'MainCtrl', ['$scope','taskService', 'timeService',($scope,taskService,timeService) ->
        $scope.model = {}
        $scope.getTasks = () ->
            taskService.get()
        
        $scope.model.tasks =  $scope.getTasks()
        $scope.model.curTask = {}
        $scope.model.nextTask = {}
        $scope.model.taskNames = taskService.getTaskNames()
        $scope.model.tempTasks = [{ show: true},{ show:true}, {show:false, taskName: 'test'} ]

        
        $scope.clearAll = () -> 
            taskService.clearAll()
            $scope.model.tasks = $scope.getTasks()
            $scope.model.taskNames = taskService.getTaskNames()
        
        
        
        $scope.addItem = (item) ->
            item.startTime = timeService.parseDate(item.startTime)
            .then (data) ->
                item.startTime = data
                return timeService.parseDate(item.endTime)
            .then (data) ->
                item.endTime = data
                return timeService.dateDiff(item.startTime,item.endTime,"h")
            .then (data) ->
                item.duration = data
                taskService.add(item)
                $scope.model.tasks = $scope.getTasks()
                $scope.model.curTask = {}
                $scope.model.taskNames = taskService.getTaskNames()

        $scope.$watch 'model.tasks', (newValue,oldValue) ->
            if !angular.equals(newValue,oldValue) and newValue
                taskService.update(item) for item in newValue
                $scope.model.taskNames = taskService.getTaskNames()

        ,true


  ]
