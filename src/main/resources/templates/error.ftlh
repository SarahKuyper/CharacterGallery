<#import "layout.ftlh" as layout>
<@layout.page title="Not Found">
<header><h1>We couldn't find that</h1></header>
<div class="empty">
    <p>${errorMessage!message!'That page or character does not exist.'}</p>
    <p><a href="/">Take me back to the gallery</a></p>
</div>
</@layout.page>
