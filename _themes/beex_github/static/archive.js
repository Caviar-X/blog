var content = document.getElementsByClassName("archive-content")[0];
var headings = content.getElementsByTagName("h1");
var toc = document.getElementById("archive-toc");
for(var i=0; i<headings.length; i++){
    if(i===0){
        toc.style.display = "block";
        toc.innerHTML = '<div style="font-weight: bold;">目录</div>';
    }
    if(!headings[i].id){
        headings[i].id = 'content-heading-' + (i + 1);
    }
    toc.innerHTML += '<li><a href="#' + headings[i].id + '">' + headings[i].innerText + '</a></li>';
}
var inputs = document.getElementsByClassName("archive-content")[0].getElementsByTagName("input");
for(var i=0; i<inputs.length; i++){
    var el = inputs[i].parentNode;
    if(el.tagName === "LI" && inputs[i].type === "checkbox"){
        el.setAttribute("style", "list-style: none; margin-left: -1em;");
    }
}
