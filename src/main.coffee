console.log "How much sugar have you been eating?"

cokeCan = {}
sugarDispenser = {}
emitter = {}

preload = ->
  @load.image "coke-can", "img/coke-can.jpeg"
  @load.image "sugar-dispenser", "img/sugar-dispenser.jpg"
  @load.image "sugar", "img/sugarcube.png"

create = ->
  @physics.startSystem Phaser.Physics.ARCADE
  
  @stage.backgroundColor = 0xFAFAFA;
  
  cokeCan = @add.sprite 0, 0, "coke-can"
  sugarDispenser = @add.sprite 600, 200, "sugar-dispenser"
  emitter = @add.emitter -50, 0, 10000
  [emitter.x, emitter.y] = [513, 197]
  emitter.makeParticles 'sugar'
  emitter.minParticleScale = 0.1
  emitter.maxParticleScale = 0.5
  emitter.particleDrag.setTo 50, 50
  emitter.height = 5
  emitter.width = 5
  emitter.enableBody = true
  emitter.setYSpeed 300, 500
  emitter.setXSpeed 20, -100
  emitter.minRotation = 0
  emitter.maxRotation = 0.2
  emitter.lifespan = 600
  
  sugarDispenser.anchor.x = 0.5
  sugarDispenser.anchor.y = 0.5
  sugarDispenser.scale.x = - 0.5
  sugarDispenser.scale.y = 0.5
  sugarDispenser.angle = -45
      
  sugarDispenser.inputEnabled = true
  sugarDispenser.events.onInputDown.add ->
    sugarDispenser.isDown = true
  
  sugarDispenser.events.onInputUp.add ->
    sugarDispenser.isDown = false
  
update = ->
  if sugarDispenser.isDown and 
      sugarDispenser.angle is -90
    emitter.emitParticle() for i in [0..30]
    
  if sugarDispenser.isDown and 
      sugarDispenser.angle > -90 and
      sugarDispenser.angle <= -45
    sugarDispenser.angle -= 3
  
  if not sugarDispenser.isDown and 
      sugarDispenser.angle >= -90 and 
      sugarDispenser.angle < -45
    sugarDispenser.angle += 3
    
new Phaser.Game 800, 400, Phaser.AUTO, "canvas",
  preload: preload
  create: create
  update: update
  
