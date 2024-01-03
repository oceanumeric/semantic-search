<script>
	import { enhance } from '$app/forms';
	export let contacts = [];
</script>



<div class="relative overflow-x-auto">
    <table class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
        <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
            <tr>
                <th scope="col" class="px-6 py-3">
                    Name
                </th>
                <th scope="col" class="px-6 py-3">
                    Email
                </th>
                <th scope="col" class="px-6 py-3">
                    Company
                </th>
                <th scope="col" class="px-6 py-3">
                    Job Title
                </th>
				<th scope="col" class="px-6 py-3">
                    Actions
                </th>
            </tr>
        </thead>
        <tbody>
			{#each contacts as contact}
				<tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
					<th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
						<div class="flex items-center space-x-3">
							<div>
								<div class="font-bold">{contact.name}</div>
							</div>
							<div class="avatar">
								<div class="mask mask-squircle w-12 h-12">
									<img src="https://i.pravatar.cc/150?u={contact.name}" alt={contact.name} />
								</div>
							</div>
					</th>
					<td class="px-6 py-4">
						{contact.email}
					</td>
					<td class="px-6 py-4">
						{contact.company}
					</td>
					<td class="px-6 py-4">
						{contact.job}
					</td>
					<td class="px-6 py-4">
						<form method="POST" action="?/delete" use:enhance>
							<input type="hidden" name="id" value={contact.id} />
							<button type="submit" class="text-white bg-pink-700 hover:bg-pink-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center">Delete</button>
						</form>
					</td>
				</tr>
			{/each}
        </tbody>
    </table>
</div>
