{spawn} = require 'child_process'

class Dcd_Server
    server_is_running: false
    
    # Please do not do this...
    constructor: () ->
        assert 0
    
    @getInstance: ->
        if @server_is_running
            return @instance
        else
            spawn "dcd-server"
            @server_is_running = true
            @instance = @
            return @instance
    
    printSomething: (something) ->
        console.log something
    
    shutdown: ->
        @server_is_running = false
        spawn("dcd-client", ["--shutdown"])

module.exports =
DcdProvider =
    # Should work for .d and .di files
    selector: '.source.d'

    # This will take priority over the default provider, which has an inclusionPriority of 0
    inclusionPriority: 1

    # Suggestions from this will be suggested before the default provider, which has a suggestionPriority of 1
    suggestionPriority: 2

    getSuggestions: (options) ->
        ###
        The contents of the options object:
        {editor, bufferPosition, scopeDescriptor, prefix, activatedManually}
        ###
        console.log "Called!!!"
        console.log options.bufferPosition
        return null
        ###
        new Promise (resolve) ->
        server = Dcd_Server.getInstance()
        server.printSomething "Hi!"
        # Build suggestions array above and call resolve with them
        resolve [text: "something"]
        ###
        
    dispose: ->
        Dcd_Server.getInstance().shutdown()
