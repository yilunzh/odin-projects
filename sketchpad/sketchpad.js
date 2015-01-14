$(document).ready( function() {

	initializeGrid(16)

	$('.grid-element').hover( function() {
		$(this).addClass('grid-hover');
	});

	$('#reset').click( function() {
		$('.grid-hover').removeClass('grid-hover');
		gridPrompt()
	})

}
);

function gridPrompt() {
	var size = prompt("Please enter the grid size", "16");

	if (size != null) {
		initializeGrid(size)
	}
}

function initializeGrid(size) {
	elm = "<div class=\"grid-element\"></div>";
	for ( var i = 0; i < size; i++ ) {
		for ( var j = 0; j < size; j++ ) {
			$(".grid-container").append(elm);
		}
	}

	$(".grid-element").width(800/size)
	$(".grid-element").height(800/size)
}


