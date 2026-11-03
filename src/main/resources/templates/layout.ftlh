<#macro page title>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${title}</title>
    <link rel="stylesheet" href="/css/styles.css">
</head>
<body>
<nav class="nav">
    <a href="/">Home</a>
    <a href="/about">About</a>
    <a href="/characters/new">Add a Character</a>
</nav>
<#if successMessage?has_content>
    <div class="flash">${successMessage}</div>
</#if>
<#nested>
<footer><p>&copy; 2023 My Website. All rights reserved.</p></footer>
</body>
</html>
</#macro>
