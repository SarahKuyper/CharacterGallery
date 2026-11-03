# Character Gallery

A full-stack Spring Boot application for managing my original characters (OCs)
from my Assignment 2 static site. It serves both HTML pages (FreeMarker templates,
server-side rendered) and a REST API (JSON), backed by a Neon PostgreSQL database
and deployed to Render.

Requires Java 25 (LTS) to build and run.

**Live site (gallery home page):** https://assignment3-crude-api.onrender.com/

**REST API base path:** https://assignment3-crude-api.onrender.com/api/characters

> The free Render tier sleeps after inactivity. The first request may take up to a
> minute to wake the service.

---

## Pages (HTML)

| Route | Description |
|---|---|
| `GET /` | Gallery — one card per character with image, name, species, occupancy. Includes search by name and species filter (both applied when both are set). |
| `GET /characters/{id}` | Details for a single character: larger image, species, occupancy, abilities, interests, active date, backstory. Edit and Delete buttons. |
| `GET /characters/new` | Add-character form |
| `POST /characters` | Create a character; redirects to the gallery with a success message |
| `GET /characters/{id}/edit` | Prefilled edit form for an existing character |
| `POST /characters/{id}` | Update a character; redirects to its details page with a success message |
| `POST /characters/{id}/delete` | Delete a character (with browser confirmation); redirects to the gallery |
| `GET /about` | About page + a short description of the app's layers |

Unknown character IDs show a friendly "not found" page, not a stack trace or raw JSON.

---

## Entity: `OC`

The `OC` entity maps to the `characters` table in PostgreSQL.

| Attribute | Type | Rules |
|---|---|---|
| `characterId` | `long` | Unique, auto-generated (`@Id`, `@GeneratedValue`) |
| `name` | `String` | Required, not null, not blank |
| `description` | `String` | Required, not null, not blank, max 2000 chars — used as the character's backstory |
| `species` | `String` | Required, not null, not blank |
| `imageUrl` | `String` | Optional — a URL or a root-relative path (`/images/name.png`); blank values fall back to a placeholder image |
| `occupancy` | `String` | Optional — the character's role or job |
| `abilities` | `String` | Optional |
| `interests` | `String` | Optional |
| `activeDate` | `LocalDate` | Optional — ISO date (yyyy-MM-dd) |

---

## API (JSON)

Base path: `/api/characters`

| Method | Path | Description | Success |
|---|---|---|---|
| GET | `/api/characters` | Get all characters | 200 |
| GET | `/api/characters?species=X` | Filter by species (exact match, case-insensitive) | 200 |
| GET | `/api/characters?name=X` | Search by name (partial, case-insensitive) | 200 |
| GET | `/api/characters?name=X&species=Y` | Apply both filters together | 200 |
| GET | `/api/characters/{id}` | Get one character by ID | 200 |
| POST | `/api/characters` | Create a new character | 201 |
| PUT | `/api/characters/{id}` | Update an existing character | 200 |
| DELETE | `/api/characters/{id}` | Delete a character | 204 |

Requests for a non-existent ID return **404**. POST or PUT with a missing
`name`, `description`, or `species` returns **400**.

### Example POST body

```json
{
  "name": "Bellamie",
  "description": "She's inspired by peacock spiders but works as an independent mechanic.",
  "species": "Arachnid (Humanoid)",
  "occupancy": "Mechanic",
  "abilities": "None",
  "interests": "Raves/parties, STEM",
  "imageUrl": "https://images.artfight.net/character/example.png",
  "activeDate": "2023-06-01"
}
```
### Architecture
Three layers, all sharing one service:

Database layer — Neon PostgreSQL accessed through Spring Data JPA. The OC
entity maps to characters; OCRepository provides the queries (by species, by
name substring, both, and a distinct-species query for the dropdown).

Service layer — OCService holds all business logic: search composition,
load-then-copy updates (so an edit never creates a duplicate row), and 404
handling via ResponseStatusException.

Web layer — two flavors sharing the service:

PageController (plain @Controller) loads data from the service, adds it
to the Model, and returns the name of a FreeMarker template under
src/main/resources/templates/. Page controllers call the service directly,
never over HTTP.

OCController (@RestController) serves JSON at /api/characters, unchanged
from the Assignment 3 API.

layout.ftlh renders the shared <head>, navigation (Home / About / Add a
Character), success flash message, and footer for every page — no page duplicates
that markup.

All mutations use Post/Redirect/Get: forms POST to the controller, which saves
and then returns redirect:... so refreshing the browser cannot submit the same
character twice.

The REST exception handler is scoped to com.Sarah.characters.controller, so
unknown page routes hit the friendly FreeMarker error template while the API still
returns JSON errors — each flavor handles its own client type.

### Configuration
Database credentials are provided via environment variables and are never committed:

SPRING_DATASOURCE_URL

SPRING_DATASOURCE_USERNAME

SPRING_DATASOURCE_PASSWORD

The same environment variables are set in the Render dashboard for the deployed
service.