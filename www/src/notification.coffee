class Notify
  constructor: () ->
    window.Notification.requestPermission (@granted) -> window.console.log @granted

  notify: (data) ->
    new window.Notification data

  notifyOn: (title, message, time, icon) ->
    diff = time - new Date
    callb = -> new window.Notification(title, { body: message, tag: 1, icon: icon})
    setTimeout callb , diff

class AndroidNotify extends Notify
  constructor: ->
    console.log cordova.plugins
    for k,v of cordova.plugins
      console.log k + " is " + v
    cordova.plugins.notification.local.registerPermission (@granted) -> window.console.log @granted

  notify: ->
    alert data
  notifyOn: (title, message, time, icon) ->
    cordova.plugins.notification.local.schedule({
        id: 1,
        title: title,
        message: message,
        icon: icon,
        at: new Date(time)
    });

if navigator.userAgent.indexOf("Android") > 0
    document.addEventListener "deviceready", ->
        # wait until cordova is initialized
        window.notify = new AndroidNotify
else
    window.notify = new Notify
