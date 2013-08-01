'use strict';

angular.module('tiwoApp')
  .service 'taskService', ($q) ->
  	unique = (input) ->
      output = {}
      output[input[key]] = input[key] for key in [0...input.length]
      value for key, value of output
    getNextId = () ->
      items = getStorage()
      if items.length == 0
        max = 1
      else
        max = Math.max (item.id for item in items)...
        max++
        
      return max

    
    taskList = []
    initStorage = () ->
      localStorage.taskList = JSON.stringify([])

  	getStorage = () ->
      return JSON.parse(localStorage.taskList)

  	setStorage = (item) ->
      localStorage.taskList = JSON.stringify(item)


  	class taskService
      constructor:()->
        initStorage() if !localStorage.taskList 
        taskList = getStorage() if !taskList or taskList.length == 0
      get: (id) ->
        deferred = $q.defer()
        if !id 
           deferred.resolve taskList 
        else 
          deferred.resolve taskList.filter (x) -> x.id == id
        return deferred.promise

      add:(item) ->
        deferred = $q.defer()
        promise = deferred.promise
        item.id = getNextId()
        taskList.push item
        setStorage taskList
        deferred.resolve(item)
        return deferred.promise

      clearAll:()->
          initStorage()
          taskList = []

      getTaskNames:()->
        deferred = $q.defer()
        promise = deferred.promise
        taskNames = (item.taskName for item in taskList)
        deferred.resolve(unique(taskNames))
        return deferred.promise;

      update:(item)->
        deferred = $q.defer()
        promise = deferred.promise
        taskList = taskList.filter (x) -> x.id != item.id
        taskList.push item
        setStorage(taskList)
        deferred.resolve(item)
        return deferred.promise
  	return new taskService()
    # AngularJS will instantiate a singleton by calling "new" on this function
