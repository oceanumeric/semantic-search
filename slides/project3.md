---
marp: true
theme: rose-pine-moon
paginate: true
---


# Project 3: Form Actions and Components

Fei Wang (Michael) :heart: AI

HyperGI

Github: [oceanumeric](https://github.com/oceanumeric)


<img class="landing-img" src="https://media.giphy.com/media/lUZwWoJfL0c0HCIDRP/giphy.gif">

---

# Show Case


--- 

# Forms are everywhere

![formImage](https://internetingishard.netlify.app/form-frontend-and-backend-2a0f80.f3e81924.png)


---

# List of interacting components

- click
    - link: `url`
    - button: `form action`
- select: radio, checkbox, dropdown
- input: text, password, email, number, date, file, hidden


---

# Two ways to submit a form

- via other page: `/login`
- via named action: `?/create`

---

# Example 1

<a href="https://github.com/iswilljr/google-clone" target="_blank">Google Clone</a>

```js
<form
      action="/search"
      method="get"
      use:search
>
```


--- 

# Example 2

```js
<form
      method="POST"
      action="?/create"
      use:enhance
>
```


---

# Things to remember

- In SvelteKit, `input` should have `name` attribute.

```html
<input type="email" name="email" />
```

- Two patterns in `+page.server.ts`

```js
export const actions:Actions = {
    // default action
	default: async (event) => {
        const formData = event.request.formData();
	},
    // WARNING: cannot use default and named action at the same time
    create: async ({ request }) => {
        const formData = await request.formData();
    },
}
```

---

# Logic

```js
// +page.server.ts
import type { PageServerLoad } from './$types';
import type { Actions } from './$types';

// array works as a database
let contacts = [
    {
      id: 'de393e6a-1c08-4e6e-9aad-0994fcf0d981',
      name: 'Saul Goodman',
      email: 'saul@example.com',
      company: 'Saul Goodman & Associates',
      job: 'Attorney'
    }
  ]

export const load:PageServerLoad = (async () => {
    return {contacts};
});
```

---

# Logic

```js
export const actions:Actions = {

    // default action
	// default: async (event) => {
	// 	// TODO log the user in
    //     const formData = event.request.formData();
    //     console.log(formData);
	// },
    
    // create action
    // name: async (event) => {}
    create: async ({ request }) => {
        const formData = await request.formData();
        console.log(formData.get('name'));
        console.log(formData.get('email'));
    },
}
```