Take "LocalStorage", (LocalStorage)->
  state = null
  callbacks = []
  LSKey = "cart-db"
  
  
  # FUNCTIONS #####################################################################################
  
  
  newState = ()->
    buildCount: 0
    builds: {}
    currency: "CAD"
    quantity: 0
    subtotalCents: 0
  
  recount = ()->
    state.buildCount = 0
    state.quantity = 0
    state.subtotalCents = 0
    for k, item of state.builds
      state.buildCount += 1
      state.quantity += parseInt item.quantity
      state.subtotalCents += item.price_retail * item.quantity
  
  runCallback = (cb)->
    cb state.builds, state.buildCount
    
  runCallbacks = ()->
    runCallback cb for cb in callbacks
  
  save = ()->
    LocalStorage.set LSKey, state
    
  
  # INIT ##########################################################################################
  
  
  state = LocalStorage.get(LSKey) or newState()
  recount()
  
  
  # API ###########################################################################################
  
  
  Make "CartDB", CartDB =
    addCallback: (cb)->
      callbacks.push cb
      runCallback cb
    
    clear: ()->
      state = newState()
      recount()
      save()
      runCallbacks()

    getBuildById: (id)->
      return state.builds[id]
          
    getBuilds: ()->
      return state.builds

    getCount: ()->
      return state.buildCount
    
    getCurrency: ()->
      return state.currency
    
    getQuantity: ()->
      return state.quantity
    
    getSubtotalCents: ()->
      return state.subtotalCents
    
    hasBuild: (build)->
      return state.builds[build.id]?
    
    isEmpty: ()->
      return state.buildCount is 0
    
    setBuild: (build, quantity = 1)->
      b = state.builds[build.id] ?= build
      b.quantity = quantity
      recount()
      save()
      runCallbacks()

    toggleCurrency: ()->
      state.currency = if state.currency == "CAD" then "USD" else "CAD"
      save()
      runCallbacks()
