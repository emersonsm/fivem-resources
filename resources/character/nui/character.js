let startmenu = false;

$(function () {
	window.onload = function() {
		window.addEventListener('message', (event) => {
			let data = event.data;
			if (data.step == 1) {
				showStartUI();
				startmenu = !startmenu;
			} else if (data.step == 2) {
				hideLoadingUI();
				fillSelectCharUI(data.characters);
			} else if (data.step == 3) {
				showSpawnUI(data.spawns);
			}
		});

		document.onkeydown = (key) => {
			if (key.which == 13) {
				startmenu = !startmenu;
				if (startmenu == false) {
					showLoadingUI();
					$.post('https://art-character/listmychars', {});
					hideStartUI();
				}
			}
		};

		$(document).on('click', 'button.select', (event) => {
			let cid = event.target.dataset.id
			hideSelectCharUI();
			$.post('https://art-character/playwithcharacter', JSON.stringify({
		        id: atob(cid)
			}));
		});

		$(document).on('click', 'button.delete', (event) => {
			let cid = event.target.dataset.id
			$('#characterlist').css('-moz-filter', 'blur(5px) grayscale(70%)');
			$('#characterlist').css('-o-filter', 'blur(5px) grayscale(70%)');
			$('#characterlist').css('-ms-filter', 'blur(5px) grayscale(70%)');
			$('#characterlist').css('filter', 'blur(5px) grayscale(70%)');
			$('#characterlist').css('-webkit-filter', 'blur(5px) grayscale(70%)');
			$('input[name ="cid"]').val(cid);
			$('#confirm-modal').show();
		});

		$(document).on('click', 'button#char-delete-confirm', () => {
			let cid = $('input[name ="cid"]').val();
			hideSelectCharUI();
			showLoadingUI();
			$('#characterlist').css('-moz-filter', '');
			$('#characterlist').css('-o-filter', '');
			$('#characterlist').css('-ms-filter', '');
			$('#characterlist').css('filter', '');
			$('#characterlist').css('-webkit-filter', '');
			$('#confirm-modal').hide();
			$.post('https://art-character/deletecharacter', JSON.stringify({
		        id: atob(cid)
			}));
		});

		$(document).on('click', 'button#char-delete-cancel', () => {
			$('#characterlist').css('-moz-filter', '');
			$('#characterlist').css('-o-filter', '');
			$('#characterlist').css('-ms-filter', '');
			$('#characterlist').css('filter', '');
			$('#characterlist').css('-webkit-filter', '');
			$('#confirm-modal').hide();
		});

		$(document).on('click', 'button.new-char', () => {
			hideSelectCharUI();
			showCreateCharUI();
		});

		$(document).on('click', 'div.back-btn', () => {
			hideCreateCharUI();
			showSelectCharUI();
		});

		$(document).on('click', 'div.spawnoption', (event) => {
			$.post('https://art-character/switchspawn', JSON.stringify({
		        activespawn: event.target.dataset.id
			}));
		});

		$(document).on('click', 'div.spawnheader', (event) => {
			hideSpawnUI();
			$.post('https://art-character/spawnplayer', {});
		});

		$('form#save-char').submit((e) => {
		    e.preventDefault();

		    let obj;
		    let data = $('form#save-char').serializeArray().reduce(function(obj, item) {
			    obj[item.name] = item.value;
				return obj;
			}, {});

		    hideCreateCharUI();
		    showLoadingUI();
		    clearInputsOfSaveChar();

		    $.post('https://art-character/savecharacter', JSON.stringify(
		        data
		    ));
		});
	};
});

window.addEventListener('load', function(event) {
  	$.post('https://art-character/InitAfterNUI', '');
});

function showStartUI() {
	$('#start').show();
}

function hideStartUI() {
	$('#start').hide();
}

function showSpawnUI(spawns) {
    $('#spawnpoints').empty();
    $('#spawnpoints').append('<div class="spawnheader">Spawn Now</div>');
    for (var i = 0; i < spawns.length; i++) {
        $('#spawnpoints').append('<div data-id="' + (i + 1) + '" class="spawnoption">' + spawns[i].info + '</div>');
    }
	$('#spawnpoints').show();
}

function hideSpawnUI() {
	$('#spawnpoints').hide();
}

function showLoadingUI() {
	$('#loading').css('-moz-filter', 'blur(5px) grayscale(70%)');
	$('#loading').css('-o-filter', 'blur(5px) grayscale(70%)');
	$('#loading').css('-ms-filter', 'blur(5px) grayscale(70%)');
	$('#loading').css('filter', 'blur(5px) grayscale(70%)');
	$('#loading').css('-webkit-filter', 'blur(5px) grayscale(70%)');
	$('#loading').show();
}

function hideLoadingUI() {
	$('#loading').css('-moz-filter', '');
	$('#loading').css('-o-filter', '');
	$('#loading').css('-ms-filter', '');
	$('#loading').css('filter', '');
	$('#loading').css('-webkit-filter', '');
	$('#loading').hide();
}

function showCreateCharUI() {
	$('#createchar').removeClass('hide').addClass('flex');
}

function hideCreateCharUI() {
    $('#createchar').removeClass('flex').addClass('hide');
}

function fillSelectCharUI(chars) {
	$('#characterlist .wrap-character-info').empty();
	let total = (chars === false) ? 0 : chars.length;
	for (let i = 0; i < total; i++) {
		$('#characterlist .wrap-character-info').append('<div class="character-info"><div class="bio"><p class="name nm">' + chars[i].character_name + '</p><p><label>Idade:</label> ' + chars[i].character_age + '</p><p><label>Sexo:</label> M</p><div class="actions"><button data-id="' + btoa(chars[i].id) + '" class="select">Selecionar</button><button data-id="' + btoa(chars[i].id) + '" class="delete">Deletar</button></div></div></div>');
	}
	if (total < 3) {
		let remain = 3 - total
		for (let i = 0; i < remain; i++) {
			$('#characterlist .wrap-character-info').append('<div class="character-info"><div class="bio"><p class="name nm">Slot Vazio</p><p class="empty">-</p><div class="actions"><button class="new-char create">Criar Personagem</button></div></div></div>');
		}
	}
	showSelectCharUI();
}

function showSelectCharUI() {
	$('#characterlist').removeClass('hide').addClass('flex');
}

function hideSelectCharUI() {
	$('#characterlist').removeClass('flex').addClass('hide');
}

function clearInputsOfSaveChar() {
	$('input[name ="name"]').val('');
	$('input[name ="age"]').val('');
	$('textarea[name ="bio"]').val('');
}