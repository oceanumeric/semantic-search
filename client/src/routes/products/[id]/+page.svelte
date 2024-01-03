<script lang="ts">
    import type { PageData } from './$types';
    export let data: PageData;  
</script>

<div class="flex flex-col items-center bg-white border border-gray-200 rounded-lg shadow md:flex-row md:max-w-xl hover:bg-gray-100 dark:border-gray-700 dark:bg-gray-800 dark:hover:bg-gray-700">
    <img class="object-cover w-full rounded-t-lg h-96 md:h-auto md:w-48 md:rounded-none md:rounded-s-lg" src="{data.serverData.thumbnail}" alt="product image">
    <div class="flex flex-col justify-between p-4 leading-normal">
        <h5 class="mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white">
            {data.serverData.title}
        </h5>
        <p class="mb-3 font-normal text-gray-700 dark:text-gray-400">
            {data.serverData.description}
        </p>
        <p>
            <span class="text-gray-900 dark:text-white">
                ${data.serverData.price}
            </span>
        </p>
        <p>
            <span class="text-gray-900 dark:text-white">
                Stock: {data.serverData.stock}
            </span>
        </p>
    </div>
</div>



