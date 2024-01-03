---
marp: true
theme: rose-pine-moon
paginate: true
---


# Project 2: Routing and Loading Data

Fei Wang (Michael) :heart: AI

HyperGI

Github: [oceanumeric](https://github.com/oceanumeric)


<img class="landing-img" src="https://media.giphy.com/media/lUZwWoJfL0c0HCIDRP/giphy.gif">

---


# Show Cases 


---

# Inspiration

![bg right:40% 80%](https://logos.flamingtext.com/Word-Logos/more-design-china-name.png)

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
    - `html` : what the user sees
- `+page.ts` : load some data before it can be rendered
- `+page.server.ts` : server-side rendering (without exposing the endpoint to the client)
    - `data` and `logics` are hidden from the client
- `+layout.svelte` : Layout Component (e.g. Navbar, Footer) via `slot`

<br>

<a href="https://kit.svelte.dev/docs/routing" target="_blank"> SvelteKit Docs </a>


---

# All requests are done by URL

- `http://localhost:5173/`: Home Page
- `http://localhost:5173/about`: slug = `about`
- `http://localhost:5173/?page=2`: query = `page=2` (search, searchParams)

<img width="78%" src="https://static.semrush.com/blog/uploads/media/fa/fe/fafe931ac85fc1c5b628299e399a2870/yqyhmdwqsDzxONy4U6FyLwK_LN_hl36xIGyfon2xWiopIuhrhR4w08c-NbWe2EnJXUh0RWDOCtMrlVNhqlBVmWRjKI3freLX4X_1Ugk7_9FwqgquwBsNqfaOnJZQ6xJJnGRKowrKhSBr_xVQZGI6gCg.png">


---

# Example: DummyJSON

- Users send the following request to the server

```
# query with params (limit, skip)
https://dummyjson.com/products?limit=10&skip=10
# url params
http://localhost:5173/products/6
```

- How could we map the request to the data?

<br>

<a href="https://dummyjson.com/products?limit=10&skip=10" target="_blank"> DummyJSON </a>

<br>

> Application Development = User Interface + Data + Logic

---

![bg h:80%](https://media.giphy.com/media/aNbGyHcDYphNbhe4EE/giphy.gif)


---

# URL in SvelteKit

```js
// +page.server.ts
import type { PageServerLoad } from './$types';

export const load:PageServerLoad = (async ({ url }) => {
    console.log('page.server.ts load', url);
    console.log('URL search params', url.searchParams);
    return {};
});
```


---

```bash
2:33:47 PM [vite] page reload src/routes/+page.server.ts (x3)
page.server.ts load URL {
  href: 'http://localhost:5173/',
  origin: 'http://localhost:5173',
  protocol: 'http:',
  username: '',
  password: '',
  host: 'localhost:5173',
  hostname: 'localhost',
  port: '5173',
  pathname: '/',
  search: '',  # search is set as default for query
  searchParams: URLSearchParams {},
  hash: ''
}
```

---
```js
This is url.searchParams bound URLSearchParams { 'limit' => '10', 'skip' => '60' }
This is url URL {
  href: 'http://localhost:5173/users?limit=10&skip=60&select=3',
  origin: 'http://localhost:5173',
  protocol: 'http:',
  username: '',
  password: '',
  host: 'localhost:5173',
  hostname: 'localhost',
  port: '5173',
  pathname: '/users',
  search: '?limit=10&skip=60&select=3',
  searchParams: URLSearchParams { 'limit' => '10', 'skip' => '60', 'select' => '3' },
  hash: ''
}
This is url.searchParams bound URLSearchParams { 'limit' => '10', 'skip' => '60', 'select' => '3' }
```

---

```js
export const load:PageServerLoad = (async ({ url }) => {
    // in case user enters a string instead of a number
    const limit = Number(url.searchParams.get('limit')) || 10;
	const skip = Number(url.searchParams.get('skip')) || 0;

    // function to get data from API
    async function getUsers(limit: number=10, skip: number=0) {
        const res = await fetch(`https://dummyjson.com/users?limit=${limit}&skip=${skip}`);
        const data = await res.json();
        return data;
    }

    return {
        severData: await getUsers(limit, skip)
    };
});
```

---

# Knowing Json Keys is Important

- many `json` files are nested
- keep track of the keys
- keys have to be consistent
- `json` keys are case-sensitive
- `json` keys are like `dict` keys in Python


---

![bg](https://media.giphy.com/media/EmkBfdGYTCwmXMnf3A/giphy.gif)


--- 

## Tips

```js
// +page.server.ts
console.log(data)
// +page.svelte
{JSON.stringify(data, null, 2)}
```

---

```js
import type { PageServerLoad } from './$types';
import { error } from '@sveltejs/kit';

export const load:PageServerLoad = (async ({ url }) => {

    // in case user enters a string instead of a number
    const limit = Number(url.searchParams.get('limit')) || 10;
	const skip = Number(url.searchParams.get('skip')) || 0;

    if (limit > 100) {
        throw error(404, 'limit must be less than 100')
    }
    
    // function to get data from API
    async function getUsers(limit: number=10, skip: number=0) {
        const res = await fetch(`https://dummyjson.com/users?limit=${limit}&skip=${skip}`);
        const data = await res.json();
        return data;
    }

    return {
        severData: await getUsers(limit, skip)
    };
});
```


---

```js
<script lang="ts">
    import type { PageData } from './$types';
    export let data: PageData;

    let pageSize = 10;
    let totalItems = data.severData.total;
    let totalPages = Math.ceil(totalItems / pageSize);
</script>

{#each data.severData.users as user}
    <p>{user.id} - {user.email}</p>
{/each}
```


---

![pattern](./images/dynamic-pattern.png)


---

# Loading Data

- One page for each product
- `+page.svelte` is dynamicallly rendered
- `<a class="underline" href="/products/{product.id}">Link</a></p>`

<br>

<a href="https://kit.svelte.dev/docs/load#using-url-data" target="_blank">SvelteKit Docs</a>

---

# Loading Data

```bash
# within the src folder
.
├── app.css
├── app.d.ts
├── app.html
├── lib
│   └── index.ts
└── routes
    ├── +layout.svelte
    ├── +page.svelte
    ├── products
    │   ├── [id] # could be any name, e.g. [slug] or [productId]
    │   ├── +page.server.ts
    │   └── +page.svelte
    └── users
        ├── +page.server.ts
        └── +page.svelte
```

> `[id]` again is the key of an object


---

# Loading Data

```bash
.
├── app.css
├── app.d.ts
├── app.html
├── lib
│   └── index.ts
└── routes
    ├── +layout.svelte
    ├── +page.svelte
    ├── products
    │   ├── [id]
    │   │   ├── +page.server.ts  # talk to database and load data
    │   │   └── +page.svelte   # render the page
    │   ├── +page.server.ts
    │   └── +page.svelte
    └── users
```

---

# URL Data and Page Data

```js
import type { PageServerLoad } from './$types';
import { error } from '@sveltejs/kit';


export const load:PageServerLoad = (async ({ url, params }) => {
    console.log(url);  // URL object
    console.log(params);  // page data
})
```

<br>

<a href="https://kit.svelte.dev/docs/load#page-data" target="_blank"> SvelteKit Docs </a>


---

```bash
# url data via url
URL {
  href: 'http://localhost:5173/products/2',
  origin: 'http://localhost:5173',
  protocol: 'http:',
  username: '',
  password: '',
  host: 'localhost:5173',
  hostname: 'localhost',
  port: '5173',
  pathname: '/products/2',
  search: '',
  searchParams: URLSearchParams {},
  hash: ''
}
# page data via params
{ id: '2' }
```

---

```js
import type { PageServerLoad } from './$types';
import { error } from '@sveltejs/kit';


export const load:PageServerLoad = (async ({ url, params }) => {
    
    // console.log(url);
    // console.log(params);

    const productId = params.id;
    const productRsp = await fetch(`https://dummyjson.com/products/${params.id}`);
    const productData = await productRsp.json();

    return {serverData: productData}
})
```


---

# Takeaways

- SvelteKit Docs is your best friend
- Routing is the key to a dynamic website
    - *filesystem-based router*
    - `src/routes` is the root
    - `src/routes/users` is a subfolder
    - `src/routes/product/[id]` creates a route with a parameter, `id`
    - `src/routes/product/[keyName]` creates a route with a parameter, `keyName`
- Loading data from `+server.page.ts`
    - `url` data
    - `form` data


---


```js
<script lang="ts">
    import { page } from '$app/stores';
	import type { PageData } from './$types';
	export let data: PageData;  // after the page is loaded
</script>
```

---

# Why do we need FastAPI?

- <a href="https://dummyjson.com/docs" target="_blank">DummyJSON</a> is a mock API
- We can use <a href="https://fastapi.tiangolo.com/#create-it" target="_blank">FastAPI</a> to create our own API
- Reflections: <a href="https://chat.openai.com/share/19bd8c17-1ca4-40f6-98fb-cf495afac847" target="_blank">Review of Project 1</a>

<img class="landing-img" src="https://media.giphy.com/media/lUZwWoJfL0c0HCIDRP/giphy.gif">


---

![bg](https://media.giphy.com/media/f8CXXtWWt2RZfwUkXO/giphy.gif)