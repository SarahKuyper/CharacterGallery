<#import "layout.ftlh" as layout>
<@layout.page title="About">

<header>
    <h1>About the Site</h1>
    <img class="banner"
         src="https://i.pinimg.com/1200x/97/c1/01/97c1014d15f7f53a486f4e05142294cb.jpg"
         alt="HolyMoly Pinterest Banner">
</header>

<main>
    <p>Greetings and salutations! This site showcases a small collection of my original characters.</p>

    <p>I chose this color palette because it matches the background colors of my characters'
       profile pictures. The low contrast is deliberate &mdash; high contrast hurts my eyes.
       The card grid on the home page was the easiest way to display everyone with the skills
       I had when I built the original static site.</p>

    <p>As for the banner above &mdash; I like to have fun with my work. LOL.</p>

    <p>Thank you for visiting! I hope you enjoy it.</p>

    <h2>How this app is built</h2>

    <p>This is a three-layer Spring Boot application. The <b>database layer</b> is a Neon
       PostgreSQL database accessed through Spring Data JPA: my <code>OC</code> entity maps to
       the <code>characters</code> table, and <code>OCRepository</code> handles the queries.</p>

    <p>The <b>service layer</b> (<code>OCService</code>) holds all of the business logic &mdash;
       searching by name and species, updating an existing row instead of inserting a new one,
       and throwing a 404 when an ID does not exist. Nothing else in the app talks to the
       repository directly.</p>

    <p>The <b>web layer</b> comes in two flavours that share that same service. My REST
       controller at <code>/api/characters</code> returns JSON for programmatic clients. My page
       controller is a plain <code>@Controller</code> that asks the service for data, puts it in
       the <code>Model</code>, and returns the name of a FreeMarker template.
       <code>layout.ftlh</code> renders the shared head, navigation, and success message for
       every page, so the markup lives in one place. Forms post to the controller, which saves
       and then redirects &mdash; the Post/Redirect/Get pattern &mdash; so a refresh can never
       submit the same character twice. The browser and the database never talk directly;
       everything goes through my back end.</p>
</main>

</@layout.page>
