'use strict'

angular.module('tiwoApp')
    .controller 'MainCtrl', ['$scope','taskService', 'timeService','$filter', ($scope,taskService,timeService,$filter) ->
        $scope.model = {}       
        $scope.model.curTask = {}
        
        
        getTasks = () ->
            taskService.get().then (data) ->
                $scope.model.tasks = data

        getTaskNames = () ->
            taskService.getTaskNames().then (data) ->
                $scope.model.taskNames = data

        getTasks()
        getTaskNames()
        
        $scope.clearAll = () -> 
            taskService.clearAll()
            getTasks()
            getTaskNames()
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
                return timeService.parseDate(item.taskDate)
            .then (data) ->
                item.taskDate = data
                taskService.add(item)
                $scope.model.curTask =  taskDate : $filter('date')(angular.copy(item.taskDate),'MM/dd/yyyy')
                getTasks()
                getTaskNames()

        $scope.$watch 'model.tasks', (newValue,oldValue) ->
            if !angular.equals(newValue,oldValue) and newValue
                taskService.update(item) for item in newValue
                getTaskNames()

        ,true


  ]
