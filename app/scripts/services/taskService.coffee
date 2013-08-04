'use strict';
# http://stackoverflow.com/questions/14430321/underscore-js-sum-of-items-in-a-collection
angular.module('tiwoApp')
  .service 'taskService', ($q,timeService) ->
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
    groupByDate = (input) ->
      input.then (data) ->
        collection = data
        group = _(collection).groupBy (item) ->
          return item.taskDate.toLocaleDateString()

        _.forEach(group,(item,index,collection) ->
          taskGroup = _(item).groupBy (task)->
            return task.taskName
          collection[index] = taskGroup 
          totals = _(collection[index]).map (g,key) ->
            taskName = key
            total = _(g).reduce (m,x) ->
              return m + x.duration
            ,0
            result = 
                taskName: taskName
                ,total: total
              return result
          collection[index] = totals
          )
        return group

    initStorage = () ->
      localStorage.taskList = JSON.stringify([])

  	getStorage = () ->
      return JSON.parse(localStorage.taskList)

  	setStorage = (item) ->
      localStorage.taskList = JSON.stringify(item)

    parseDates = (item) ->
      deferred = $q.defer()
      item.taskDate = timeService.parseDate(item.taskDate)
      item.startTime = timeService.parseDate(item.startTime)
      item.endTime = timeService.parseDate(item.endTime)
      if angular.isDate(item.startTime) and angular.isDate(item.endTime)
        item.duration = timeService.dateDiff(item.startTime,item.endTime)
      return item

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
        item.id = getNextId()
        parseDates(item)
        taskList.push item
        setStorage taskList
        deferred.resolve(item)
        return deferred.promise

      clearAll:()->
          initStorage()
          taskList = []

      getTaskNames:()->
        deferred = $q.defer()
        taskNames = (item.taskName for item in taskList)
        taskNames = unique(taskNames)
        deferred.resolve(taskNames)
        return deferred.promise;

      update:(item)->
        deferred = $q.defer()
        promise = deferred.promise
        taskList = taskList.filter (x) -> x.id != item.id
        taskList.push item
        setStorage(taskList)
        deferred.resolve(item)
        return deferred.promise

      groupBy:(groupType)->
        deferred = $q.defer()
        switch groupType
          when 'd' then result = groupByDate(@get())
          else result = groupByDate(@get())
        result.then (data) ->
          result = data
          deferred.resolve(result)
        return deferred.promise
  	return new taskService()
    # AngularJS will instantiate a singleton by calling "new" on this function
