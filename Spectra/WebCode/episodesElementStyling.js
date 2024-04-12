var targetElement = document.getElementById('tab-content-episodes');
if (targetElement) {
    
    // targetElement.style['background-color'] = 'rgba(205,25,105, 0.8)';
    targetElement.style.margin = '0';
    
    // Get the checkbox element by its ID
    var checkbox = document.getElementById('av-droplist-sorting-droplist');
    
    // Check if the checkbox element exists
    if (checkbox) {
        // Get the parent element of the checkbox
        var parentElement = checkbox.parentNode;
        
        // Check if the parent element exists
        if (parentElement) {
            // Set the display property of the parent element to 'none'
            parentElement.style.display = 'none';
        } else {
            console.error("Parent element not found.");
        }
    } else {
        console.error("Checkbox element not found.");
    }
    
    var liElements = targetElement.getElementsByTagName('li');
    
    for (var i = 0; i < liElements.length; i++) {
        
        liElements[i].style['max-width'] = '1200px';
        var divElement = liElements[i].querySelector('div');
        
        if (divElement) {
            // divElement.style.padding = '24px';
            //Set the box shadow and background to clear to remove the expanding view (kinda).
            divElement.style['background-color'] = 'rgba(0,0,0, 0.0)';
            divElement.style['box-shadow'] = '0 0px 0px 0px rgba(0,0,0,0)';
            
            // divElement.style.height = '300px';
            
            var downloadDiv = divElement.querySelector('div:nth-child(3)');
            if (downloadDiv) {
                downloadDiv.style.display = 'none';
            }
            
            var episodeTitle = divElement.querySelector('div:nth-child(5)');
            if (episodeTitle) {
                episodeTitle.style.color = 'white';
            }
            
            var episodeDescription = divElement.querySelector('div:nth-child(6)');
            if (episodeDescription) {
                episodeDescription.style.color = 'white';
            }
            
            var episodePrimeButton = divElement.querySelector('div:nth-child(7)');
            if (episodePrimeButton) {
                episodePrimeButton.style.color = 'white';
            }
            
            var offersDiv = divElement.querySelector('div:nth-child(8)');
            if (offersDiv) {
                offersDiv.style.display = 'none';
            }
            
        }
    }
} else {
    console.log("Target element not found.");
}
