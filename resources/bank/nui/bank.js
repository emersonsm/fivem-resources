$(() => {
    window.addEventListener('message', (event) => {
    	var data = event.data;
        if (data.openoptions) {
            showOptionsUI(data);
        } else if (data.bankresponse) {
            if (data.status == 'success') {
                $('#result').attr('class', 'alert-green');
            } else {
                $('#result').attr('class', 'alert-orange');
            }
            $('#result').html(data.message).show().delay(5000).fadeOut();
        }
    });

    $('button#close').click(() => {
        $('#container, #optionsUI, #withdrawUI, #depositUI').hide();
        $.post('http://art-bank/nuifocusoff', JSON.stringify({}));
    });

    $('button#withdraw').click(() => {
        $('#optionsUI, #depositUI').hide();
        $('#withdrawUI').show();
    });

    $('button#deposit').click(() => {
        $('#optionsUI, #withdrawUI').hide();
        $('#depositUI').show();
    });

    $('button#quick').click(() => {
        $('#depositUI, #withdrawUI').hide();
        $('#optionsUI').show();
        $.post('http://art-bank/withdraw', JSON.stringify({
            amount: 100
        }));
    });

    $('.back').click(() => {
        $('#withdrawUI, #depositUI').hide();
        $('#optionsUI').show();
    });

    $('form#withdrawR').submit((e) => {
        e.preventDefault();
        $.post('http://art-bank/withdraw', JSON.stringify({
            amount: $('#amountw').val()
        }));
        $('#withdrawUI, #depositUI').hide();
        $('#optionsUI').show();
        $('#amountw').val('');
    });

    $('form#depositR').submit((e) => {
        e.preventDefault();
        $.post('http://art-bank/deposit', JSON.stringify({
            amount: $('#amountd').val()
        }));
        $('#withdrawUI, #depositUI').hide();
        $('#optionsUI').show();
        $('#amountd').val('');
    });
});

function showOptionsUI(data) {
    $('.balance').html('');
    $('.balance').html(data.balance);
    $('.name').html(data.player);
    $('#container, #optionsUI').show();
}