var itemcounter = 0;
var $container;
var mainmenu;
var submenu;

$(() => {
    init();
    window.addEventListener('message', (event) => {
    	var data = event.data;
        if (data.showmenu) {
            showMenu();
        } else if (data.hidemenu) {
        	hideMenu();
        } else if (data.menuenter) {
            handleSelectedOption();
        } else if (data.menuup) {
            menuItemScroll('up');
        } else if (data.menudown) {
            menuItemScroll('down');
        } else if (data[0] && data[0].submenu) {
            showSubMenu(data[1]);
        } else if (data.menuclose) {
            hideMenu();
        }
    });
});

function init() {
    $container = $('#menucontainer');
    $container.append('<div id="menu-options" class="menu-rows"></div>');
}

function showMenu() {
    $('#menu-options').empty();
    mainmenu = [
        {name: 'Lista de veículos', class: 'menuoption selected', type: 'menu', func: 'getcarsin'},
        {name: 'Veículos perdidos', class: 'menuoption', type: 'menu', func: 'getcarsout'}
    ];
    for (var i = 0; i < mainmenu.length; i++) {
        $('#menu-options').append('<div data-func="' + mainmenu[i].func + '" class="' + mainmenu[i].class + '">' + mainmenu[i].name + '</div>');
    }
    $container.show();
}

function showSubMenu(items) {
    $("#menu-options").empty();
    mainmenu = [];
    mainmenu.push(items)
    for (var i = 0; i < items.length; i++) {
        if (i == 0) {
            $('#menu-options').append('<div data-plate="'+ items[i].plate + '" data-model="'+ items[i].model +'" class="menuoption selected">' + items[i].label + '</div>');
        } else {
            $('#menu-options').append('<div data-plate="'+ items[i].plate + '" data-model="'+ items[i].model +'" class="menuoption">' + items[i].label + '</div>');
        }
    }
    $container.show();
}

function hideMenu() {
    itemcounter = 0;
    $container.hide();
}

function menuItemScroll(dir) {
    $('.menuoption').eq(itemcounter).removeClass('selected');
    var itemamount = mainmenu.length - 1;
    if (dir == 'up') {
        if (itemcounter > 0)
            itemcounter -= 1;
        else
            itemcounter = itemamount;
    } else if (dir == 'down') {
        if (itemcounter < itemamount)
            itemcounter += 1;
        else
            itemcounter = 0;
    }
    $('.menuoption').eq(itemcounter).addClass('selected');
}

function handleSelectedOption() {
    var func = $('.selected').data('func')
    if (func == 'getcarsin') {
        sendData('listin')
    } else if (func == 'getcarsout') {
        sendData('listout')
    } else {
        sendData('getcar')
        hideMenu()
    }
}

function sendData(func) {
    if (func == 'listin') {
        $.post('http://art-garage/getmycarsin', JSON.stringify({}));
    } else if (func == 'listout') {
        $.post('http://art-garage/getmycarsout', JSON.stringify({}));
    } else if (func == 'getcar') {
        $.post('http://art-garage/spawncar', JSON.stringify({
            model: $('.menuoption.selected').data('model'), 
            plate: $('.menuoption.selected').data('plate')
        }));
    }
}