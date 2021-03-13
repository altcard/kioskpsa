var recordingInProgress = false;
var mediaRecorder = null;

function stopRecording() {
	recordingInProgress = false;

	mediaRecorder.stop();
	mediaRecorder = null;

	document.getElementById('contextual').innerHTML = 'Start recording';
}

function updateImage() {
        document.getElementById('image').src = '/cam/' + (new Date()).getTime() + '.jpeg';
}

function pushIntoLive(recordingData) {
	let xhr = new XMLHttpRequest();
	xhr.open('POST', '/record', true);

	xhr.setRequestHeader('Content-type', 'audio/wav');

	xhr.onclick = function() {
		console.log(xhr.statusText);
	}

	xhr.send(recordingData);
}

function startRecording() {
	recordingInProgress = true;
	document.getElementById('contextual').innerHTML = 'Stop recording';

	if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
		navigator.mediaDevices.getUserMedia({ audio: true }).then(function(stream) {
			mediaRecorder = new MediaRecorder(stream);
			mediaRecorder.start();

			mediaRecorder.ondataavailable = function(stream) {
				pushIntoLive(stream.data);
			}
		}).catch(function(errorMessage) {
			alert('Initialization error: ' + errorMessage);
		});
	}
}

function triggerRecording() {
	if (recordingInProgress)
		stopRecording();
	else
		startRecording();
}

window.setInterval(updateImage, 1200);
