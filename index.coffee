request = require 'request'

class FacebookTestUser
    @URL = 'https://graph.facebook.com'

    constructor: (@config) ->
        @testUser = null

    getAccessToken: (cb) ->
        url = "#{FacebookTestUser.URL}/oauth/access_token?client_id=#{@config.appId}&client_secret=#{@config.appSecret}&grant_type=client_credentials"
        request url, (err, res, token) ->
            cb err, token

    getTestUsers: (token, cb) ->
        url = "#{FacebookTestUser.URL}/#{@config.appId}/accounts/test-users?#{token}"
        request url, (err, res, body) ->
            if err then return cb err
            body = JSON.parse body
            cb null, body.data

    createTestUser: (token, cb) ->
        url = "#{FacebookTestUser.URL}/#{@config.appId}/accounts/test-users?permissions=#{@config.permissions}&method=post&#{token}"
        request url, (err, res, body) ->
            if err then return done err
            cb null, JSON.parse body

    getTestUser: (cb) ->
        if @testUser isnt null
            return cb null, @testUser
        @getAccessToken (err, token) =>
            if err then return cb err
            @getTestUsers token, (err, users) =>
                if err then return cb err
                if users.length
                    @testUser = users[0]
                    return cb null, @testUser
                else
                    @createTestUser token, (err, user) ->
                        if err then return cb err
                        @testUser = user
                        return cb null, @testUser

module.exports = FacebookTestUser
