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

# Big Picture

- `+page.svelte` is the html template
- `+page.server.ts` is the server-side logic (data fetching, form actions)
- `flowbite` is the ui library you can use to build components
- `tauri` is the desktop app framework we will use to build the desktop app: <a href="https://tauri.app/" target="_blank"> Tauri </a>


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

```
FormData {
  [Symbol(state)]: [
    { name: 'name', value: 'Fei Wang' },
    { name: 'email', value: 'numerical.ocean@gmail.com' },
    { name: 'company', value: 'Goethe University Frankfurt' },
    { name: 'jobTitle', value: 'NLP Researcher' }
  ]
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

---

# Logic

```js
create: async ({ request }) => {
    const formData = await request.formData();

    console.log(formData);

    const name = formData.get('name');
    const email = formData.get('email');
    const company = formData.get('company');
    const job = formData.get('jobTitle');

    const id = crypto.randomUUID()
    const contact = { id, name, email, company, job}

    contacts.push(contact);

    return {success: true, contact};
},
```

---

```js
<form method="POST" action="?/delete" use:enhance>
    <input type="hidden" name="id" value={contact.id} />
    <button type="submit">Delete</button>
</form>
```

```js
// +page.server.ts
// delete action
delete: async ({ request }) => {
    const formData = await request.formData();
    const id = formData.get('id');

    contacts = contacts.filter(contact => contact.id !== id);

    return {success: true};
}
```
--- 

# How to build a component

- Using `flowbite` <a href="https://flowbite.com/docs/components/tables/" target="_blank"> Table </a> as an example

- `import` the component

- example: `contactsTable.svelte`



--- 

# There are more we could do with Svelte Forms

- Validation
    - client-side: <a href="https://www.w3schools.com/tags/att_input_pattern.asp" target="_blank"> pattern </a>
    - server-side: we will implement it together

- Error Handling

- Form State Management

- A useful library: <a href="https://superforms.rocks/" target="_blank">Super Forms</a>

- Login and Authentication

---

```js
// validate data
if (name.length < 3) {
    return fail(
        400,
        {
            error: true,
            message: 'Name must be at least 3 characters long.',
            // no need to send the form data back to the client
            email,
            company,
            job
        }
    )
}
```

---

- always use `?` when you pass variables to components or use optional chaining

- `value={form?.company ?? ''}`:  <a href="https://chat.openai.com/share/c168688c-665c-4ad3-bdfb-7c3fab9e0c13" target="_blank">ChatGPT</a>

<br>

```js
{#if form?.error}
      <Alert message={form?.message} />
{/if}
<br>
<ContactsTable contacts={data?.contacts} />
```



---

```js
import type { PageServerLoad } from './$types';
import type { Actions } from './$types';
import { fail } from '@sveltejs/kit'

let contacts = []

// ---------------------------------------------
export const load:PageServerLoad = (async ({url, params}) => {
    return {contacts};
});

//---------------------------------------------
export const actions:Actions = {
    // create action
    create: async ({ request }) => {
        const formData = await request.formData();
        // console.log(formData);
        const name = formData.get('name');
        contacts.push(contact);
        return {success: true, contact};
    },
    // delete action
    delete: async ({ request }) => {
        const formData = await request.formData();
        const id = formData.get('id');
        return {success: true};
    }
}
```