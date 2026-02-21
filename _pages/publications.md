---
title: "Publications"
layout: gridlay
sitemap: false
permalink: /publications/
years: [2016, 2017, 2018, 2019, 2020, 2021]
---

<style>
.jumbotron{
    padding:3%;
    padding-bottom:10px;
    padding-top:10px;
    margin-top:10px;
    margin-bottom:30px;
}

#pub-search {
    width: 100%;
    padding: 10px 15px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 5px;
    margin-bottom: 20px;
    box-sizing: border-box;
}

#pub-search:focus {
    outline: none;
    border-color: #66afe9;
    box-shadow: 0 0 5px rgba(102, 175, 233, 0.6);
}

#no-results-msg {
    display: none;
    text-align: center;
    color: #888;
    padding: 20px;
    font-size: 16px;
}
</style>

<input type="text" id="pub-search" placeholder="Search publications (e.g., year, journal, author, keyword...)" markdown="0">

<div class="jumbotron">
### Preprints
{% bibliography --query @unpublished %}
</div>

<div class="jumbotron">
### Journal Articles
{% bibliography --query @article %}
</div>

<script>
(function() {
    var msg = document.createElement('div');
    msg.id = 'no-results-msg';
    msg.textContent = 'No publications match your search.';
    var searchBox = document.getElementById('pub-search');
    searchBox.parentNode.insertBefore(msg, searchBox.nextSibling);

    searchBox.addEventListener('input', function() {
        var query = this.value.toLowerCase().trim();
        var sections = document.querySelectorAll('.jumbotron');
        var totalVisible = 0;

        sections.forEach(function(section) {
            var items = section.querySelectorAll('ol.bibliography > li');
            if (items.length === 0) return;

            var sectionVisible = 0;
            items.forEach(function(item) {
                var text = item.querySelector('.text-justify');
                var content = text ? text.textContent.toLowerCase() : '';
                if (query === '' || content.indexOf(query) !== -1) {
                    item.style.display = '';
                    sectionVisible++;
                } else {
                    item.style.display = 'none';
                }
            });

            section.style.display = sectionVisible > 0 ? '' : 'none';
            totalVisible += sectionVisible;
        });

        msg.style.display = (query !== '' && totalVisible === 0) ? 'block' : 'none';
    });
})();
</script>
