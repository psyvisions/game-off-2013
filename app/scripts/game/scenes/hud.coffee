Q = Game.Q

Q.scene "hud", (stage) ->

  # stage.insert new Q.UI.RadialGradient()

  # doctor's comments
  playerAvatar = stage.insert new Q.UI.PlayerAvatar()

  infoContainer = stage.insert new Q.UI.Container
    y: 40
    fill: "#fff"

  Game.infoLabel = infoContainer.insert new Q.UI.InfoLabel
    container: infoContainer
    offsetLeft: playerAvatar.p.w

  # enemies counter
  enemiesContainer = stage.insert new Q.UI.Container
    y: 40
    fill: "#232322"

  enemiesContainer.insert new Q.UI.EnemiesCounter()
  enemiesContainer.fit(0, 8)
  enemiesContainer.p.x = Q.width - enemiesContainer.p.w/2 - 60

  stage.insert new Q.UI.EnemiesAvatar()

  # bullets counter
  bulletsContainer = stage.insert new Q.UI.Container
    y: 40
    fill: "#232322"

  bulletsImg = bulletsContainer.insert new Q.UI.BulletsImg()
  bulletsContainer.insert new Q.UI.BulletsCounter
    img: bulletsImg.p

  bulletsContainer.fit(0, 8)
  bulletsContainer.p.x = enemiesContainer.p.x - enemiesContainer.p.w/2 - bulletsContainer.p.w/2 - 20 + 30

  # health counter
  healthContainer = stage.insert new Q.UI.Container
    y: 40
    fill: "#232322"
    # radius: 0

  healthImg = healthContainer.insert new Q.UI.HealthImg()
  healthContainer.insert new Q.UI.HealthCounter
    img: healthImg.p

  healthContainer.fit(0, 8)
  healthContainer.p.x = bulletsContainer.p.x - bulletsContainer.p.w/2 - healthContainer.p.w/2 - 20




  # pause button
  # pauseButton = stage.insert new Q.UI.PauseButton
  # pauseButton.p.x = container.p.w/2 - 80

  # # audio button
  # audioButton = stage.insert new Q.UI.AudioButton
  # audioButton.p.x = container.p.w/2 - 80
