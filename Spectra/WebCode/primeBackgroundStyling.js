var mainTagLandingPage = document.getElementsByTagName('body');
if (mainTagLandingPage) {
    mainTagLandingPage[0].style['background-color'] = 'transparent';
} else {
    console.log("mainTagLandingPage element not found.");
};

var dvWebNode = document.querySelector(".DVWebNode-web-spa-root-wrapper");

if (dvWebNode) {
    dvWebNode.firstChild.style.background = 'none';
    dvWebNode.firstChild.style['background-size'] = '0px 0px';
} else {
    console.log("Target element not found.");
}
