fbLoginSuccess = (userData) -> window.console.log "UserInfo: " + JSON.stringify(userData)
window.console.log "facebookConnectPlugin "
document.addEventListener "deviceready", () ->
  window.console.log "facebookConnectPlugin " + facebookConnectPlugin
  facebookConnectPlugin.login ["public_profile"], fbLoginSuccess, (error) -> window.console.log "" + error
