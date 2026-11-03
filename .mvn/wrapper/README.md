# Character REST API

A Spring Boot REST API for managing my original characters (OCs)
from my Assignment 2 static website. Built with Spring Boot, Spring Data JPA,
and PostgreSQL (hosted on Neon), and deployed to Render.

Requires Java 25 (LTS) to build and run.

## Entity: `OC`

The `OC` entity maps to the `characters` table in PostgreSQL. It has the
following attributes:

| Attribute | Type | Rules |
|---|---|---|
| `characterId` | `long` | Unique, auto-generated (`@Id`, `@GeneratedValue`) |
| `name` | `String` | Required, not null, not blank |
| `description` | `String` | Required, not null, not blank, max 2000 chars |
| `species` | `String` | Required, not null, not blank |
| `occupancy` | `String` | Optional — the character's role or job |
| `abilities` | `String` | Optional |
| `interests` | `String` | Optional |
| `activeDate` | `LocalDate` | Optional — ISO date (yyyy-MM-dd) |

## Endpoints

Base path: `/api/characters`

| Method | Path | Description | Success |
|---|---|---|---|
| GET | `/api/characters` | Get all characters | 200 |
| GET | `/api/characters?species=X` | Filter by species (exact match, case-insensitive) | 200 |
| GET | `/api/characters?name=X` | Search by name (partial, case-insensitive) | 200 |
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
  "activeDate": "2023-06-01"
}

### My depolyed Render API
https://assignment3-crude-api.onrender.com/