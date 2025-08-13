#============
# Game Server
#============
output "game_server" {
  description = "Game Server"
  value = {
    name       = module.game_server.vm_name
    ip_address = module.game_server.ip_address
    vm_id      = module.game_server.vm_id
  }
}

#=============
# Media Server
#=============
output "media_server" {
  description = "Media Server"
  value = {
    name       = module.media_server.vm_name
    ip_address = module.media_server.ip_address
    vm_id      = module.media_server.vm_id
  }
}