var style = document.createElement('style');
style.innerHTML = '\(css ?? "")';
document.head.appendChild(style);

Object.defineProperty(navigator, 'maxTouchPoints', { get:function() {
    return 1;
    }
});
