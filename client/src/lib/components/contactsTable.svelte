<script>
	import { enhance } from '$app/forms';
	export let contacts = [];
</script>

<div class="overflow-x-auto w-full mt-6">
	<table class="table w-full">
		<!-- head -->
		<thead>
			<tr class="bg-gray-200">
				<th>
				</th>
				<th>Name</th>
				<th>Job</th>
				<th>Email</th>
				<th>Delete?</th>
			</tr>
		</thead>
		<tbody>
			{#each contacts as contact}
				<tr class="text-center">
					<th>
						<label>
							<input type="checkbox" class="checkbox" />
						</label>
					</th>
					<td>
						<div class="flex items-center space-x-3 pl-44">
							<div class="avatar">
								<div class="mask mask-squircle w-12 h-12">
									<img src="https://i.pravatar.cc/150?u={contact.name}" alt={contact.name} />
								</div>
							</div>
							<div>
								<div class="font-bold">{contact.name}</div>
							</div>
						</div>
					</td>
					<td>
						{contact.company}
						<br />
						<span class="badge badge-ghost badge-sm">{contact.job}</span>
					</td>
					<td>{contact.email}</td>
					<th>
						<form method="POST" action="?/delete">
							<input type="hidden" name="id" hidden value={contact.id} />
							<button class="bg-pink-700 text-white">Delete</button>
						</form>
					</th>
				</tr>
			{/each}
		</tbody>
	</table>
</div>