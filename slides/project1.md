---
marp: true
theme: rose-pine-moon
paginate: true
---


# Project 1: Server/Client Side Rendering

Fei Wang (Michael) :heart: AI

HyperGI

Github: [oceanumeric](https://github.com/oceanumeric)


<img class="landing-img" src="https://media.giphy.com/media/lUZwWoJfL0c0HCIDRP/giphy.gif">

---

# Key Points

- Why SSR/CSR?
- What is SSR/CSR?
- Examples


--- 

# Why 🦥

- Most of websites are data-driven nowadays
    - Even for a simple blog:
        - you don't want to write HTML for every post
        - you want to store your posts in a database
- Data is dynamic and changes frequently
- Data is stored in database
- Example: <a href="https://oceanumeric.github.io/math/" target="_blank">My Blog</a>

---

<div class="colwrap">
<div class="left">

# What 🐣

- Client Side Rendering with `FastAPI`

<br>

- Server Side Rendering with `SvelteKit`

</div>

<div class="right">

<br>
<br>
<br>


![w:300](https://fastapi.tiangolo.com/img/logo-margin/logo-teal.png)

<br>

&nbsp; &nbsp; ![w:300](https://svelte.dev/svelte-logo-horizontal.svg)

</div>
</div>

--- 

## Client Side Rendering with `FastAPI`

- client send request to server
- server process the request and send back a HTML file
- client render the HTML file

<br>

```bash
# setup
python3 -m venv venv
source venv/bin/activate
pip install fastapi uvicorn jinja2
uvicorn main:app --reload
```


---

## Prompt for HTML

> Create an HTML document with a div element that serves as a container for posts. Write JavaScript code to dynamically add posts to this container. Use an array to store at least three posts, where each post should have a title, created date, and summary. The posts should be displayed with appropriate styling within the container Feel free to include any necessary styling in the HTML or use inline styles. Use example data for the posts, and demonstrate how to add the posts to the container using JavaScript.

<br>

[ChatGPT Link](https://chat.openai.com/share/19bd8c17-1ca4-40f6-98fb-cf495afac847)
[FastAPI Doc](https://fastapi.tiangolo.com/advanced/templates/)


---

```python
from fastapi import FastAPI, Request
from fastapi.responses import HTMLResponse
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates

app = FastAPI()

app.mount("/static", StaticFiles(directory="static"), name="static")

# Templates directory
templates = Jinja2Templates(directory="templates")


@app.get("/", response_class=HTMLResponse)
def home(request: Request):
    return templates.TemplateResponse(
        request=request, name="homePage.html"
    )

@app.get("/api")
def read_root():
    return {"Hello": "World"}
```

---

## Test via terminal

```bash
# test home page
curl http://127.0.0.1:8000
# test api page
curl http://127.0.0.1:8000/api
```

## or via browser

```
# test via /docs

http://127.0.0.1:8000/docs
```

---

## Inspet via browser

```html
<div id="postContainer">
    <div class="post">
        <h2>Post 1</h2>
        <p class="date">January 1, 2024</p>
        <p class="summary">This is the summary of the first post.</p>
    </div>
    <div class="post">
        <h2>Post 2</h2>
        <p class="date">January 2, 2024</p>
        <p class="summary">This is the summary of the second post.</p>
    </div>
    <div class="post">
        <h2>Post 3</h2>
        <p class="date">January 3, 2024</p>
        <p class="summary">This is the summary of the third post.</p>
    </div>
</div>
```

---
```html
<div id="postContainer"></div>

<script>
    // Example data for posts
    const posts = [
        {
            title: "Post 1",
            date: "January 1, 2024",
            summary: "This is the summary of the first post."
        },
        {
            title: "Post 2",
            date: "January 2, 2024",
            summary: "This is the summary of the second post."
        },
        {
            title: "Post 3",
            date: "January 3, 2024",
            summary: "This is the summary of the third post."
        }
    ];
</script>
```

---

```js
 // Function to dynamically add posts to the container
function addPostsToContainer() {
    const postContainer = document.getElementById("postContainer");

    posts.forEach(post => {
        const postElement = document.createElement("div");
        postElement.classList.add("post");

        postElement.innerHTML = `
            <h2>${post.title}</h2>
            <p class="date">${post.date}</p>
            <p class="summary">${post.summary}</p>
        `;

        postContainer.appendChild(postElement);
    });
}

// Call the function to add posts when the page loads
window.onload = addPostsToContainer;
```

---

## Server Side Rendering with `SvelteKit`


```bash
# setup
cd client  # go to client folder
npm create svelte@latest
npm install
npm run dev

.
├── node_modules
├── package.json
├── package-lock.json
├── README.md
├── src
├── static
├── svelte.config.js
├── tsconfig.json
└── vite.config.ts
```

---

## Server Side Rendering with `SvelteKit`

```bash
.
├── app.d.ts
├── app.html
├── lib
│   └── index.ts
└── routes
    └── +page.svelte
```

<a href="https://tailwindcss.com/docs/guides/sveltekit" src="_blank">Tailwind CSS</a>

```bash
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p
```

---

```html
<script lang="ts">
    const posts = [
        {
            title: "Post 1",
            date: "January 1, 2024",
            summary: "This is the summary of the first post."
        },
        {
            title: "Post 2",
            date: "January 2, 2024",
            summary: "This is the summary of the second post."
        },
        {
            title: "Post 3",
            date: "January 3, 2024",
            summary: "This is the summary of the third post."
        }
    ];
</script>


<div class="container mx-auto mt-12">
    {#each posts as post}
        <div class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
            <h2 class="text-2xl font-bold mb-2">{post.title}</h2>
            <p class="text-gray-700 text-base">{post.date}</p>
            <p class="text-gray-700 text-base">{post.summary}</p>
        </div>
    {/each}
</div>
```

---

## SvelteKit Key Concepts

- Routing
    - `+page.svelte`
    - `+layout.svelte`
    - `+sever.ts`
- Loading Data
- Form Actions
- Page Options
- State Management

<img class="landing-img" src="https://media.giphy.com/media/lUZwWoJfL0c0HCIDRP/giphy.gif">