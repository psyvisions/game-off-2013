Q = Game.Q

# animations object
Q.animations "enemy",
  stand:
    frames: [4]
    rate: 1
  run:
    frames: [4, 3, 2]
    rate: 1/4
  hit:
    frames: [0]
    loop: false
    rate: 1/2
    next: "run"

# enemy object and logic
Q.Sprite.extend "Enemy",
  init: (p) ->
    @_super p,
      lifePoints: 1
      x: 0
      y: 0
      vx: 0
      z: 20
      sheet: "zombie1"
      sprite: "enemy"
      canSeeThePlayerTimeout: 0
      type: Game.SPRITE_ENEMY
      collisionMask: Game.SPRITE_TILES | Game.SPRITE_PLAYER | Game.SPRITE_BULLET

    Q.state.inc "enemiesCounter", 1

    @add "2d, animation, zombieAI"

    # events
    @on "hit", @, "collision"
    @on "bump.right", @, "hitFromRight"
    @on "bump.left", @, "hitFromLeft"

  collision: (col) ->
    if col.obj.isA("Bullet")
      @play("hit")
      @decreaseLifePoints()

  hitFromRight: (col) ->
    # don't stop after collision
    @p.vx = col.impact

  hitFromLeft: (col) ->
    # don't stop after collision
    @p.vx = -col.impact

  step: (dt) ->
    if @zombieStep?
      @zombieStep(dt)

    if @p.y > Game.map.p.h
      @die()

  decreaseLifePoints: ->
    @p.lifePoints -= 1

    if @p.lifePoints <= 0
      @die()

  die: ->
    @destroy()

    # replace zombie with human
    @stage.insert new Q.Human(x: @p.x, y: @p.y)

    # update enemies counter
    Q.state.dec "enemiesCounter", 1
