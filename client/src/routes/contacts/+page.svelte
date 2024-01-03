<script lang="ts">
  import type { PageData } from './$types';
  import ContactsTable from '$lib/components/contactsTable.svelte';
  import { enhance } from '$app/forms';
	import Alert from '$lib/components/Alert.svelte';
    
  export let data: PageData;  // all about page data
  export let form;  // all about form data
</script>


<div class="pt-10 mx-auto pl-20">
    <form class="max-w-sm mx-auto"
        method="POST"
        action="?/create"
        use:enhance
    >
        <div class="mb-5">
            <label for="name" class="block mb-2 text-sm font-medium text-gray-900"> Name </label>
            <input type="name" name="name" value={form?.name ?? ''} class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500 dark:shadow-sm-light" placeholder="Bob Dylan" required>
        </div>
        <div class="mb-5">
          <label for="email" class="block mb-2 text-sm font-medium text-gray-900">Your email</label>
          <input type="email" name="email" value={form?.email ?? ''} class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500 dark:shadow-sm-light" placeholder="hello@hypergi.com" required>
        </div>
        <div class="mb-5">
          <label for="company" class="block mb-2 text-sm font-medium text-gray-900">Company</label>
          <input type="company" name="company" value={form?.company ?? ''} class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500 dark:shadow-sm-light" required>
        </div>
        <div class="mb-5">
          <label for="jobTitle" class="block mb-2 text-sm font-medium text-gray-900">Job Title</label>
          <input type="jobTitle" name="jobTitle" value={form?.job ?? ''} class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500 dark:shadow-sm-light" required>
        </div>
        <button type="submit" class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">ADD (Create)</button>
    </form>
    <br>
    {#if form?.error}
      <Alert message={form?.message} />
    {/if}
    <br>
    <ContactsTable contacts={data?.contacts} />
</div>