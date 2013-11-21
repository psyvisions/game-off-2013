Q = Game.Q

Q.component "zombieAI",
  added: ->
    p = @entity.p

    if p.startLeft == true
      p.vx = 60
    else
      p.vx = -60

    # animations
    @entity.play "run"

  extend:
    zombieStep: (dt) ->
      # some AI - always try to catch player
      @canSeeThePlayer() # create @canSeeThePlayerObj object

      if @canSeeThePlayerObj.status
        # I see the player, I will remember that for X sec
        @p.canSeeThePlayerTimeout = 2

        if (@canSeeThePlayerObj.left and @p.vx > 0) or (@canSeeThePlayerObj.right and @p.vx < 0)
          # enemy goes in wrong direction, change it
          @p.vx = -@p.vx
      else
        # run timeout
        @p.canSeeThePlayerTimeout = Math.max(@p.canSeeThePlayerTimeout - dt, 0)

      # locate gap and turn back
      dirX = @p.vx/Math.abs(@p.vx)
      ground = Q.stage().locate(@p.x, @p.y + @p.h/2 + 1, Game.SPRITE_TILES)
      nextTile = Q.stage().locate(@p.x + dirX * @p.w/2 + dirX, @p.y + @p.h/2 + 1, Game.SPRITE_TILES)

      # if we are on ground and there is a cliff
      if(!nextTile and ground and !@canSeeThePlayerObj.status and @p.canSeeThePlayerTimeout == 0)
        @p.vx = -@p.vx

      # set the correct direction of sprite
      @flip()

      if @p.y > Game.map.p.h
        @die()

    flip: ->
      if(@p.vx > 0)
        @p.flip = "x"
      else
        @p.flip = false

    canSeeThePlayer: ->
      player = Game.player.p
      lineOfSight = 250

      @canSeeThePlayerObj =
        status: false

      if Game.player.isDestroyed?
        return

      # is player on the same level as enemy?
      isTheSameY = player.y > @p.y - 10 and player.y < @p.y + 10

      # is player in the near of the enemy?
      @canSeeThePlayerObj.left = isCloseFromLeft = (player.x > @p.x - lineOfSight) and player.x < @p.x
      @canSeeThePlayerObj.right = isCloseFromRight = (player.x < @p.x + lineOfSight) and player.x > @p.x

      if isTheSameY and (isCloseFromLeft or isCloseFromRight)
        @canSeeThePlayerObj.status = true
      else
        @canSeeThePlayerObj.status = false

      return
