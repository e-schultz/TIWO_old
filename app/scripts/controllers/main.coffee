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
            taskService.add(item).then (data) ->
                $scope.model.curTask =  taskDate : $filter('date')(angular.copy(data.taskDate),'MM/dd/yyyy')
                getTasks()
                getTaskNames()

        $scope.$watch 'model.tasks', (newValue,oldValue) ->
            if !angular.equals(newValue,oldValue) and newValue
                taskService.update(item) for item in newValue
                getTaskNames()

        ,true


  ]
