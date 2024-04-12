var targetElement = document.querySelector('.dv-dp-node-playback');

if (targetElement) {
    var parent = targetElement.parentNode;
    if (parent) {
        var purchaseOptions = parent.querySelector('div:nth-child(2)');
        if (purchaseOptions) {
            purchaseOptions.style.display = 'none';
        }
        
    }
} else {
    console.log("Target element not found.");
}
