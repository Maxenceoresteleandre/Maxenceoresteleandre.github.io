// header
$(function(){
	var shrinkHeader = 0.0;
	 $(window).scroll(function() {
	   var scroll = getCurrentScroll();
		 if ( scroll >= shrinkHeader ) {
			  $('.header').addClass('shrink');
		   }
		   else {
			   $('.header').removeClass('shrink');
		   }
	 });
   function getCurrentScroll() {
	   return window.scrollY;
	   }
   });