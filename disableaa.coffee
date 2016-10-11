{CompositeDisposable} = require 'atom'

module.exports =
  config:
    disableAntialiasingInEditor:
      type: 'boolean'
      default: true
    disableAntialiasingInDirectory:
      type: 'boolean'
      default: false

  getRules: ->
    rules = ''
    if atom.config.get 'disable-aa.disableAntialiasingInEditor'
      rules += '.editor { -webkit-font-smoothing: none; }\n'
    if atom.config.get 'disable-aa.disableAntialiasingInDirectory'
      rules += '.directory { -webkit-font-smoothing: none; }\n'
    rules

  activate: (state) ->
    this.style = atom.document.createElement 'style'
    this.style.innerHTML = this.getRules()
    atom.document.head.appendChild this.style
    console.log this.style
    this.subscriptions = new CompositeDisposable()

    getRules = this.getRules
    style = this.style
    this.subscriptions.add atom.config.observe 'disable-aa', (value) ->
      style.innerHTML = getRules()

  deactivate: ->
    this.style.innerHTML = ''
    this.subscriptions.dispose()
