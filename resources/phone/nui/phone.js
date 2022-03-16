$(() => {
	const d = new Date();
	const h = (d.getHours() < 10 ? '0': '') + d.getHours();
	const m = (d.getMinutes() < 10 ? '0': '') + d.getMinutes();

	$('.time').html(h + ':' + m);

	window.addEventListener('message', (event) => {
		var data = event.data;
		if (data.showphone) {
	        showPhone();
		} else if (data.app_yellowpages) {
			loadPosts(data.posts);
		} else if (data.app_bank) {
			loadBalance(data.balance);
		}
	});

	document.onkeydown = (data) => {
		if (data.which == 27) {
			$.post('http://art-phone/nuifocusoff', JSON.stringify({}));
			hidePhone();
		}
	};

	/* ### MOUSE ACTIONS */
	$('.call').mouseover((event, pos, item) => {
		showTooltip(event.pageX, event.pageY, 'Ligar', 'call-t');
	});

	$('.call').mouseleave(() => {
		removeTooltip('call-t');
	});

	$('.message').mouseover((event, pos, item) => {
		showTooltip(event.pageX, event.pageY, 'Mensagens', 'message-t');
	});

	$('.message').mouseleave(() => {
		removeTooltip('message-t');
	});

	$('.contacts').mouseover((event, pos, item) => {
		showTooltip(event.pageX, event.pageY, 'Contatos', 'contacts-t');
	});

	$('.contacts').mouseleave(() => {
		removeTooltip('contacts-t');
	});

	$('.yellow-pages').mouseover((event, pos, item) => {
		showTooltip(event.pageX, event.pageY, 'Lista Telefônica', 'yellow-pages-t');
	});

	$('.yellow-pages').mouseleave(() => {
		removeTooltip('yellow-pages-t');
	});

	$('.bank').mouseover((event, pos, item) => {
		showTooltip(event.pageX, event.pageY, 'Banco', 'bank-t');
	});

	$('.bank').mouseleave(() => {
		removeTooltip('bank-t');
	});

	$('.camera').mouseover((event, pos, item) => {
		showTooltip(event.pageX, event.pageY, 'Câmera', 'camera-t');
	});

	$('.camera').mouseleave(() => {
		removeTooltip('camera-t');
	});

	$('.police').mouseover((event, pos, item) => {
		showTooltip(event.pageX, event.pageY, 'Chamar Polícia', 'police-t');
	});

	$('.police').mouseleave(() => {
		removeTooltip('police-t');
	});

	$('.hospital').mouseover((event, pos, item) => {
		showTooltip(event.pageX, event.pageY, 'Chamar Hospital', 'hospital-t');
	});

	$('.hospital').mouseleave(() => {
		removeTooltip('hospital-t');
	});

	/* ### CLICK ACTIONS */
    $('.call').click(() => {
        $('#callUI').show();
    });

    $('.yellow-pages').click(() => {
        callAppYellowPages();
    });

    $('.bank').click(() => {
        callAppBank();
    });

    /* ### KEY ACTIONS */
    $('#new-post-message').keypress((e) => {
        if (e.which == 13) {
            $('form#new-post').submit();
            return false;
        }
    });

    /* ### SUBMIT ACTIONS */
	$('form#new-post').submit((e) => {
        e.preventDefault();
        $.post('http://art-phone/savepost', JSON.stringify({
            message: $('#new-post-message').val()
        }));
        $('#new-post-message').val('');
    });
});

function loadPosts(posts) {
	$('#posts').empty();
	for (var i = 0; i < posts.length; i++) {
		$('#posts').append('<div class="cloud">' + posts[i].message + '</div>' +
			'<div class="cloud-footer"><p class="phone nm"><label>Tel: </label>' + posts[i].phone + '</p>' +
			'<p class="name nm"><label>Postado por: </label>' + posts[i].character_name + '</p>' +
		'</div>');
	}
	$('#yellowMainUI').show();
}

function loadBalance(balance) {
	$('#bankBallanceUI .money, #bankBallanceUI .name').empty();
	$('#bankBallanceUI .money').html('$ ' + balance.money);
	$('#bankBallanceUI .name').append('<p>' + balance.character_name + '</p>');
	$('#bankBallanceUI').show();
}

function callAppYellowPages() {
	$.post('http://art-phone/posts', JSON.stringify({}));
}

function callAppBank() {
	$.post('http://art-phone/mybalance', JSON.stringify({}));
}

function showPhone() {
	$('#mainUI').show('slide', { direction: 'down' }, 1000);
}

function hidePhone() {
	$('.tooltip, #yellowMainUI, #bankBallanceUI').hide();
	$('#mockUI, #mainUI').hide('slide', { direction: 'down' }, 1000);
}

function showTooltip(x, y, content, id) {
	if ($('.tooltip').hasClass(id) === false) {
		$('<div class="tooltip ' + id + '">' + content + '</div>').css({
		    position: 'absolute',
		    display: 'none',
		    top: y + 2,
		    left: x + 2,
		    padding: '2px',
		    color: 'white',
		    'z-index': '5',
		    'background-color': 'black'
		}).appendTo('body').delay(2000).fadeIn(200);
	}
}

function removeTooltip(id) {
	$('.' + id).remove();
}