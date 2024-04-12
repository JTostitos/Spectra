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
    
    //set the bg to transperant (OLD: move the carosuel down by 5%)
    for (var i = 0; i < dynamicTypeRamp.length; i++) {
        //change the bg color on the div to transperant
        dynamicTypeRamp[1].style['background-color'] = 'transparent';
        
//        (OLD: move the carosuel down by 5%)
//        var carosel = dynamicTypeRamp[i].querySelector('div:nth-child(2)');
//        
//        if (carosel) {
//            carosel.style['padding-top'] = '5%';
//        }
    }
} else {
    console.log("dynamicTypeRamp element not found.");
};

//var tentpoleHero = document.querySelector("section[data-testid='tentpole-hero']");
//if (tentpoleHero) {
//    tentpoleHero.style['padding-bottom'] = '15%';
//} else {
//    console.log("Target element not found.");
//}

var tentpoleHero = document.querySelector("div[data-testid='tentpole-hero-content']");
if (tentpoleHero) {
    tentpoleHero.style['height'] = '55vw';
    
    for (var i = 0; i < tentpoleHero.length; i++) {
        //change the bg on the div to none so there is no gradient
        tentpoleHero[4].style['background'] = 'none';
    }
    
} else {
    console.log("Target element not found.");
}

var landingPage = document.querySelector("main[data-testid='landingpage']");

if (landingPage) {
    landingPage.style['background-color'] = 'transparent';
} else {
    console.log("Target element not found.");
}
