/* jshint browser:true */
/* global device */

document.addEventListener('deviceready', registerPushNotification, false);

var pushNotification;

function registerPushNotification() {
	pushNotification = window.plugins && window.plugins.pushNotification;
	if (!pushNotification) {
		console.log("pushNotification isn't ready.");
		return;
	}

	if (device.platform == 'android' || device.platform == 'Android') {
		console.log('device ready; android ' + device.platform + " " + pushNotification);
		pushNotification.register(successHandler, errorHandler, {
			"senderID": "996539205720",
			"ecb": "onNotificationGCM"
		});
	}
}

// result contains any message sent from the plugin call
function successHandler(result) {
	console.log('registration success result = ' + result);
}

// result contains any error description text returned from the plugin call
function errorHandler(error) {
	console.log('registration error = ' + error);
}

function onNotificationGCM(e) {
	console.log("Got notification", e.event);

	switch (e.event) {
	case 'registered':
		if (e.regid.length > 0) {
			// Storing regId to be used by GCM to make push notifications.
			console.log("regID = " + e.regid);
			localStorage.phonegapRegId = e.regid;
			console.log("Stored regid to localStorage ", localStorage.phonegapRegId);
		}
		break;

	case 'message':
		console.log(e);
		// e.foreground is true if the notification came in when the user is in the foreground.
		if (e.foreground) {
			console.log(e.payload.message);
		}
		break;

	case 'error':
		console.log(e.msg);
		break;

	default:
		console.log(e);
		break;
	}
}