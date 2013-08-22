'use strict';
angular.module('tiwoApp.tiTask', [])

angular.module('tiwoApp.tiTask')
  .directive 'tiTask', [->
    templateUrl: 'views/tiTask/tiTask.html'
    restrict: 'A'
    scope: { }
    link: (scope, element, attrs) ->
      # element.text 'this is the tiTask directive'
    controller: 'tiTaskController'
  ]

 angular.module('tiwoApp.tiTask').controller 'tiTaskController',['$scope','timeService','taskService',($scope,timeService,taskService)->
 	$scope.tasks = []
 	generateTask = (span,task) ->
 		start = span.split('-')[0]
 		end = span.split('-')[1]
 		newTask = {
 			startTime : timeService.parseDate(start)
 			endTime : timeService.parseDate(end)
 			taskDate: new Date(timeService.parseDate(task.taskDate))
 			taskName: task.taskName
 		}
 		taskService.add(newTask)

 		
 		

 	$scope.addTask = (task) ->
 		timeSpans = task.timeSpans.split(',')
 		generateTask span,task for span in timeSpans
 		
 ]
