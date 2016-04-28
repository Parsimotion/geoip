express = require("express")
MMDBReader = require('mmdb-reader')

app = express()

exports.app = app

port = process.env.PORT or 4000

app.use require("body-parser")()
app.use require('request-ip').mw()
app.use require('cors')()

MMDBReader.open 'GeoLite2-Country.mmdb', (err, reader) ->
	app.get '/', (req, res) ->
		return res.send 400, "error loading geoip file" if err
		ip = req.query.ip or req.clientIp
		res.json reader.lookup(ip)

	app.listen port, () ->
	  console.log "listening on port #{port}"
