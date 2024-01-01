---
marp: true
theme: rose-pine-moon
paginate: true
---

# Project 1: Server/Client Side Rendering

Fei Wang (Michael) :heart: AI

HyperGI

Github: [oceanumeric](https://github.com/oceanumeric)


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
```


---

## Prompt for HTML

> Create an HTML document with a div element that serves as a container for posts. Write JavaScript code to dynamically add posts to this container. Use an array to store at least three posts, where each post should have a title, created date, and summary. The posts should be displayed with appropriate styling within the container Feel free to include any necessary styling in the HTML or use inline styles. Use example data for the posts, and demonstrate how to add the posts to the container using JavaScript.
