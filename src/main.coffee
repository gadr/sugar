console.log "How much sugar have you been eating?"

cokeCan = {}
sugarDispenser = {}

preload = ->
  @load.image "coke-can", "img/coke-can.jpeg"
  @load.image "sugar-dispenser", "img/sugar-dispenser.jpg"

create = ->
  cokeCan = @add.sprite 0, 0, "coke-can"
  sugarDispenser = @add.sprite 600, 200, "sugar-dispenser"

  sugarDispenser.anchor.x = 0.5
  sugarDispenser.anchor.y = 0.5
  sugarDispenser.scale.x = - 0.5
  sugarDispenser.scale.y = 0.5
  sugarDispenser.angle = -45
      
  sugarDispenser.inputEnabled = true
  sugarDispenser.events.onInputDown.add ->
    console.log "down", sugarDispenser.angle
    sugarDispenser.isDown = true
  
  sugarDispenser.events.onInputUp.add ->
    console.log "up", sugarDispenser.angle
    sugarDispenser.isDown = false
  
update = ->
  if sugarDispenser.isDown and 
      sugarDispenser.angle > -90 and
      sugarDispenser.angle <= -45
    sugarDispenser.angle -= 3
  if not sugarDispenser.isDown and 
      sugarDispenser.angle >= -90 and 
      sugarDispenser.angle < -45
    sugarDispenser.angle += 3
    
new Phaser.Game 800, 600, Phaser.AUTO, "canvas",
  preload: preload
  create: create
  update: update
  
