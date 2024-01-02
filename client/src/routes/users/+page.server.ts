import type { PageServerLoad } from './$types';
import { error } from '@sveltejs/kit';

export const load: PageServerLoad = async ({ url }) => {
	// in case user enters a string instead of a number
	const limit = Number(url.searchParams.get('limit')) || 10;
	const skip = Number(url.searchParams.get('skip')) || 0;

	if (limit > 100) {
		throw error(404, 'limit must be less than 100');
	}

	// console.log('page.server.ts load', url);
	// console.log('URL search params', url.searchParams);

	// function to get data from API
	async function getUsers(limit: number = 10, skip: number = 0) {
		const res = await fetch(`https://dummyjson.com/users?limit=${limit}&skip=${skip}`);
		const data = await res.json();
		return data;
	}

	// console.log('data from API', await getUsers(limit, skip));

	return {
		severData: await getUsers(limit, skip)
	};
};
