var toggle_quick_buttons_button = function(state){
  var
      trigger  = document.getElementById('show-quick-buttons')
    , showText = trigger.dataset.showText
    , hideText = trigger.dataset.hideText
  if (state == 'open')
    trigger.innerText = hideText;
  else
    trigger.innerText = showText;
};

var toggleQuickButtons = function(action){
  var
      quickButtons        = document.getElementById("quick-button-div")
    , quickButtonsClasses = quickButtons.className
    , state               = 'open'
    , classes             = {
                              open   : "quick-button-div open-buttons",
                              closed : "quick-button-div closed-buttons"
                            }

  if (quickButtonsClasses == classes.open || (action && action == 'close')) {
    quickButtons.className = classes.closed;
    state = 'closed'
  }
  else
    quickButtons.className = classes.open;

  toggle_quick_buttons_button(state);
}

var apply_quick_button_functions = function(){
  $('.alarm-button').click(function(){
      $('#intervention_intervention_type_id').val( $(this).attr('target') );
      toggleQuickButtons();
      $('#intervention_address').focus();

      var $self = $(this);
      if( !$self.hasClass('clicked') )
          $self.addClass("clicked").siblings().removeClass('clicked');
  });

  $('#show-quick-buttons').click(function(){
    toggleQuickButtons();
  });

  $('#intervention_intervention_type_id').change(function(){
    toggleQuickButtons('close');
  });
};

var setTooltips = function(){
    $('[rel*=tooltip]').tooltip();
};

var setColorPicker = function(){
    $('.colorpicker').colorpicker().on('changeColor', function(ev){
        $('.add-on i').css('background-color', ev.color.toHex());
    });
};

var allowBackdropToCloseColorpicker = function(){
    $('.modal-backdrop.in').on('click', function(){
    });
};

var cleanModal = function() {
    var $modal = $('#modal');
    $modal.html('');
    $modal.removeAttr('class').removeAttr('aria-hidden').removeAttr('style');
};

var cleanModalOnModalHide = function() {
    $('body').on('hidden', '#modal', cleanModal);
};
var removeColopickerOnModalHide = function() {
    $('body').on('hidden', '#modal', cleanColorpicker);
};

var cleanColorpicker = function() {
  $('.colorpicker.dropdown-menu').remove();
};

//SrBuj ajax gem Related stuff

//modo de uso: id_new_element es el id que tiene el elemento donde se van a
// insertar nuevos elementos, ej: 'new_account', 'edit_account'
//container es el contenedor general donde esta la lista de elementos,
// se recomienda un div general para agregar divs, y usar el tbody de las table
// cuando se quieran resaltar 'tr' de una tabla. Ej: 'accounts_table', 'accounts_list'
//element es el elemento a resaltar (para el caso del edit es)
var highlightItem = function(id_new_element, container, element) {
    var action = id_new_element.split('_')[0];
    var $elementToHighlight = $(element);

    if(action == 'new') {
        var $container = $('#' + container);
        $elementToHighlight = $container.children().last();
        if(container.split('_')[1] == 'table')
            $container.append('<tr id=' + id_new_element + '></tr>');
        else
            $container.append('<div id=' + id_new_element + '></div>');
    }
//todo: el highlight se ejecuta una sola vez por alguna razon
//todo: el color deberia elegirse.
    $elementToHighlight.effect("highlight", {color: '#bce8f1'}, 2500);
};
