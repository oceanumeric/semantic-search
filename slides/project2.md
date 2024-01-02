---
marp: true
theme: rose-pine-moon
paginate: true
---


# Project 2: Routing 

Fei Wang (Michael) :heart: AI

HyperGI

Github: [oceanumeric](https://github.com/oceanumeric)


<img class="landing-img" src="https://media.giphy.com/media/lUZwWoJfL0c0HCIDRP/giphy.gif">

---


# Show Cases 



---

# Inspiration

<iframe width="560" height="315" src="https://www.youtube.com/embed/G-tafjJzfQo?si=94-mOj-lTAo1PxcT&amp;start=64" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

<br>

<a href="https://youtu.be/G-tafjJzfQo?si=kcouIhrSswZfAq5q" target="_blank">YouTube Link</a>


--- 

# Key Concepts

Our website needs to respond to different URLs and render different content based on the URL dynamically.

- `/` : Home Page
- `/about` : About Page
- `/users` : Users Page
- `/products` : Products Page
- `/songs` : Songs Page


---

# Key Concepts

- `+page.svelte` : Page Component
- `+page.ts` : load some data before it can be rendered
- `+page.server.ts` : server-side rendering (without exposing the endpoint to the client)
- `+layout.svelte` : Layout Component (e.g. Navbar, Footer) via `slot`

<br>

<a href="https://kit.svelte.dev/docs/routing" target="_blank"> SvelteKit Docs </a>