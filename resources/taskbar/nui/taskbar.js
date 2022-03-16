$(() => {
	window.onload = (e) => { 
		window.addEventListener('message', (event) => {	            
			let data = event.data;               
			if (data.runProgress === true || data.runUpdate === true) {
                $('#taskbar').show();

                let taskId = data.Task;
				let start = new Date();
				let maxTime = data.Length;
				let text = data.name;
				let timeoutVal = Math.floor(maxTime / 100);
				animateUpdate();

				$('#pbar_innertext').text(text);

				function updateProgress(percentage) {
    				$('#pbar_innerdiv').css('width', percentage + '%');
				}

				function animateUpdate() {
					var now = new Date();
					var timeDiff = now.getTime() - start.getTime();
					var perc = Math.round((timeDiff / maxTime) * 100);
					if (perc <= 100) {
						updateProgress(perc);
						setTimeout(animateUpdate, timeoutVal);
					} else {
						$.post('http://art-taskbar/taskEnd', JSON.stringify({
							tasknum: taskId
						}));
						$("#taskbar").hide();
					}
				}
			} else {
                $('#taskbar').hide();
            }
		});
	};
});