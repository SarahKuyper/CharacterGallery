<#import "layout.ftlh" as layout>
<@layout.page title=heading>

<header><h1>${heading}</h1></header>

<#if errors?has_content>
    <ul class="errors">
        <#list errors as e><li>${e}</li></#list>
    </ul>
</#if>

<form class="stack" method="post" action="${formAction}">

    <label for="imageUrl">Image URL</label>
    <input type="text" id="imageUrl" name="imageUrl"
           value="${(character.imageUrl)!''}"
           placeholder="https://... or /images/name.png">

    <label for="name">Name *</label>
    <input type="text" id="name" name="name"
           value="${(character.name)!''}"
           placeholder="What is the name of your character?">

    <label for="species">Species *</label>
    <input type="text" id="species" name="species"
           value="${(character.species)!''}"
           placeholder="What is their species?">

    <label for="occupancy">Occupancy / Role</label>
    <input type="text" id="occupancy" name="occupancy"
           value="${(character.occupancy)!''}"
           placeholder="What is their story role?">

    <label for="abilities">Abilities</label>
    <input type="text" id="abilities" name="abilities"
           value="${(character.abilities)!''}"
           placeholder="Any abilities?">

    <label for="interests">Interests</label>
    <input type="text" id="interests" name="interests"
           value="${(character.interests)!''}"
           placeholder="What are their interests?">

    <label for="activeDate">Active since</label>
    <input type="date" id="activeDate" name="activeDate"
           value="<#if (character.activeDate)?has_content>${character.activeDate}</#if>">

    <label for="description">Backstory *</label>
    <textarea id="description" name="description"
              placeholder="What is their backstory?">${(character.description)!''}</textarea>

    <button type="submit">Save character</button>
</form>

<p><a href="/" style="color: var(--text);">&larr; Back to gallery</a></p>

</@layout.page>
