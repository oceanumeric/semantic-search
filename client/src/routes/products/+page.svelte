<script lang="ts">
    import { page } from '$app/stores';
	import type { PageData } from './$types';
	export let data: PageData;

	let pageSize = 10;
	let totalItems = data.severData.total;
	let totalPages = Math.ceil(totalItems / pageSize);
    $: currentPage = (Number($page.url.searchParams.get('skip')) || 0) / pageSize;
</script>

<div class="mx-10">
	<h1 class="my-5">Products</h1>
	{#each data.severData.products as product}
		<p>{product.id} - {product.title} - <a class="underline" href="/products/{product.id}">Link</a></p> 
	{/each}

	<nav aria-label="Page navigation example">
		<ul class="inline-flex -space-x-px pt-3 text-sm">
			{#each Array(totalPages) as _, idx}
				<li>
					<a
						href="/products?limit={pageSize}&skip={pageSize * idx}"
						class="{currentPage === idx ? 'text-[#D34052] font-bold dark:text-[#42BA97]' : ''} flex items-center justify-center px-3 h-8 leading-tight text-gray-500 bg-white border border-gray-300 hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white"
					>
						{idx + 1}
					</a>
				</li>
			{/each}
		</ul>
	</nav>
</div>
