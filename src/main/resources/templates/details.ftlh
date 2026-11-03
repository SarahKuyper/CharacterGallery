<#import "layout.ftlh" as layout>
<@layout.page title=character.name>

<header><h1>${character.name}</h1></header>

<#if character.imageUrl?has_content>
    <img class="detail-img" src="${character.imageUrl}" alt="${character.name}">
<#else>
    <img class="detail-img" src="/images/placeholder.svg" alt="No image available">
</#if>

<dl>
    <dt>Species</dt><dd>${character.species}</dd>
    <dt>Occupancy</dt><dd>${(character.occupancy)!'-'}</dd>
    <dt>Abilities</dt><dd>${(character.abilities)!'-'}</dd>
    <dt>Interests</dt><dd>${(character.interests)!'-'}</dd>
    <#if (character.activeDate)?has_content>
        <dt>Active since</dt><dd>${character.activeDate}</dd>
    </#if>
    <dt>Backstory</dt><dd>${character.description}</dd>
</dl>

<div class="actions">
    <a class="button" href="/characters/${character.characterId?c}/edit">Edit</a>

    <form method="post" action="/characters/${character.characterId?c}/delete"
          onsubmit="return confirm('Delete this character? This cannot be undone.');"
          style="display:inline;">
        <button type="submit" class="danger">Delete</button>
    </form>

    <a href="/" style="color: var(--text);">&larr; Back to gallery</a>
</div>

</@layout.page>
