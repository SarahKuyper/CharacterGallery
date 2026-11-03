<#import "layout.ftlh" as layout>
<@layout.page title="Character Index">
<header><h1>Meet my characters!</h1></header>
<form class="search" method="get" action="/">
    <input type="text" name="name" value="${(searchName)!''}" placeholder="Who are you looking for?">
    <select name="species">
        <option value="">All species</option>
        <#list speciesOptions as s>
            <option value="${s}"<#if searchSpecies?has_content && searchSpecies == s> selected</#if>>${s}</option>
        </#list>
    </select>
    <button type="submit">Search</button>
</form>
<#if characters?size == 0>
    <p class="empty">No characters found. Try a different name or species.</p>
<#else>
    <div class="cards">
        <#list characters as c>
            <div class="card">
                <a href="/characters/${c.characterId?c}">
                    <#if c.imageUrl?has_content>
                        <img src="${c.imageUrl}" alt="${c.name}">
                    <#else>
                        <img src="/images/placeholder.svg" alt="No image for ${c.name}">
                    </#if>
                    <h2>${c.name}</h2>
                </a>
                <ul>
                    <li><b>Species:</b> ${c.species}</li>
                    <li><b>Occupancy:</b> ${(c.occupancy)!'Unknown'}</li>
                </ul>
            </div>
        </#list>
    </div>
</#if>
</@layout.page>
