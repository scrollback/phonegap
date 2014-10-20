/* jshint browser:true */

function fetchData(url, success, failure) {
	var req = new XMLHttpRequest();

	req.onreadystatechange = function() {
		var res;

		if (req.readyState === 4) {
			// Older versions of webkit return req.status as 0
			if (req.status < 400 && req.responseText) {
				res = req.responseText;

				if (res) {
					localStorage.setItem(url, res);
				} else {
					console.error("Got empty response for " + url + ".");
				}
			} else {
				console.error("AJAX request failed for " + url + ".");
			}

			if (!res) {
				res = localStorage.getItem(url);

				if (res) {
					console.warn("Using cached copy for " + url + ".");
				}
			}

			if (res && success && typeof success === "function") {
				success(res);
			} else if (failure && typeof failure === "function") {
				failure();
			}
		}
	};

	req.open("GET", url, true);
	req.send();
}

function onDeviceReady() {
	var url = "https://stage.scrollback.io/client.html";

	fetchData(url, function(res) {
		var script = "<script>window.jQuery && jQuery.ready(); window.app && app.initialize();<\/script>";

		res = res.replace("<!-- phonegap scripts -->", script);

		var matches = /((?:\r|\n|.)+)(<body.*class=['"])(.*)(["'].*>)((?:\r|\n|.)+)/.exec(res);

		matches.splice(0, 1);

		matches[2] += " media-phonegap state-offline";

		document.write(matches.join(""));
	}, function() {
		console.error("An error occured.");
	});
}

document.addEventListener("deviceready", onDeviceReady, false);