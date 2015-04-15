
monthNames = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"]
createEventItem = (event) ->
  date = new Date(event.start_time)
  options = {weekday: "long", year: "numeric", month: "short", day: "numeric", hour: "2-digit", minute: "2-digit"}
  $("""<div style="position: relative;margin: 5px;" class="clearfix">
<div style="width: 150px; height: 100px;position: relative;overflow: hidden;float: left;margin-right: 12px;" class="imgbkg">
<img src="#{event.cover.source}" 
style="left:-60px;height: 100%;min-height: 100%;position: relative;width: auto;" height="100" width="270"></div>
<div style="left: 12px;position: absolute;top: 12px;z-index: 2;color: #FFF;text-shadow: 0px 1px 4px rgba(0, 0, 0, 0.5);">
<div style="font-size: 10px;font-weight: 600;">#{monthNames[date.getMonth()]}</div>
<div style="font-size: 18px;font-weight: 600;">#{('0' + date.getDate()).slice(-2)}</div>
</div>
<div class="evtname">#{event.name}</div>
<div class="evtdetails">#{date.toLocaleTimeString("en-us", options)}</div>
<div class="evtdetails">#{if event.place then event.place.name else ""}</div>
<input style="margin-top: 10px;" type="button" 
onClick="bringMeThere({name: '#{event.name}', coords: [#{if event.place?.location then event.place.location.latitude else 0}, #{if event.place?.location then event.place.location.longitude else 0}]})" value="Bring me there"\>
</div>""")

gotPicture = (data) ->
  window.console.log data
  $('#profilepic').css('background-image', 'url(' + data.data.url + ') no-repeat');
gotCover = (data) ->
  window.console.log data
  #$('#fish').attr("src",data.cover.source)
eror = (data) ->
  window.console.log data
gotAddress = (data) ->
  window.console.log data
gotPlaces = (data) ->
  window.console.log data
gotEvents = (data) ->
  window.console.log data
  events = data.data
  events.sort (a,b) -> return new Date(a.start_time) - new Date(b.start_time)
  for event in events
     $('#events').append(createEventItem event)

fbLoginSuccess = (userData) -> 
  window.console.log JSON.stringify(userData)
  window.console.log userData
  userID = userData.authResponse.userID;
  window.console.log userID
  facebookConnectPlugin.api "/me/picture", ["public_profile"], gotPicture, eror
  facebookConnectPlugin.api "/me?fields=cover", ["public_profile", "user_photos"], gotCover, eror
  facebookConnectPlugin.api "/me?fields=address", ["public_profile", "user_photos"], gotAddress, eror
  facebookConnectPlugin.api "me/tagged_places", ["public_profile", "user_photos", "user_tagged_places"], gotPlaces, eror 
  facebookConnectPlugin.api "/me/events/attending?fields=cover,name,place&limit=6&since=" + Math.round(+new Date()/1000), ["public_profile", "user_photos", "user_tagged_places"], gotEvents, eror
window.console.log "facebookConnectPlugin"

start = () -> 
  if (window.cordova.platformId == "browser")
    facebookConnectPlugin.browserInit("768653219896880", "v2.3")
  window.console.log "facebookConnectPlugin " + facebookConnectPlugin
  facebookConnectPlugin.login ["public_profile", "user_photos", "user_tagged_places"], fbLoginSuccess, (error) -> window.console.log "" + error

document.addEventListener "deviceready", () ->
	setTimeout start, 1000
  
