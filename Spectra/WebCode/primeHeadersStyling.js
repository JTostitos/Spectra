var navBarMain = document.getElementById('navbar-main');
if (navBarMain) {
    navBarMain.style.display = 'none';
} else {
    console.log("navBarMain element not found.");
};

var pvNavigationBar = document.getElementById('pv-navigation-bar');
if (pvNavigationBar) {
    pvNavigationBar.style.display = 'none';
} else {
    console.log("pvNavigationBar element not found.");
};

//get the dynamin-type-ramp which is the parent that has the show carosuel and the page bc color
var dynamicTypeRamp = document.getElementsByClassName('dynamic-type-ramp');
if (dynamicTypeRamp) {
    
    //move the carosuel down by 5%
    for (var i = 0; i < dynamicTypeRamp.length; i++) {
        //change the bg color on the div to transperant
        dynamicTypeRamp[1].style['background-color'] = 'transparent';
        
        var carosel = dynamicTypeRamp[i].querySelector('div:nth-child(2)');
        
        if (carosel) {
            carosel.style['padding-top'] = '5%';
        }
    }
} else {
    console.log("dynamicTypeRamp element not found.");
};

var landingPage = document.querySelector("main[data-testid='landingpage']");

if (landingPage) {
    landingPage.style['background-color'] = 'transparent';
} else {
    console.log("Target element not found.");
}
