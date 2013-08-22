'use strict'

angular.module('tiwoApp')
    .controller 'MainCtrl', ['$scope','taskService', 'timeService','$filter','$q', ($scope,taskService,timeService,$filter,$q) ->
        $scope.model = {}       
        $scope.model.curTask = {}
        $scope.model.taskGroups = {}
        
        $scope.getTasks = () ->
            deferred = $q.defer()
            taskService.get().then (data) ->
                $scope.model.tasks = data
                deferred.resolve(data)
            return deferred.promise;

        $scope.getTaskNames = () ->
            taskService.getTaskNames().then (data) ->
                $scope.model.taskNames = data

        $scope.getGroups = () ->
            deferred = $q.defer()
            taskService.groupBy('D').then (data) ->
                $scope.model.taskGroups = data
                deferred.resolve(data)
            return deferred.promise

        $scope.getTasks()
        $scope.getTaskNames()
        $scope.getGroups()

        $scope.clearAll = () -> 
            taskService.clearAll()
            $scope.getTasks()
            $scope.getTaskNames()
    
        $scope.$watch 'model.tasks', (newValue,oldValue) ->
            if !angular.equals(newValue,oldValue) and newValue
                taskService.update(item) for item in newValue
                $scope.getTaskNames()
                $scope.getGroups()
        ,true


  ]
