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
    async function getProducts(limit: number=10, skip: number=0) {
        const res = await fetch(`https://dummyjson.com/products?limit=${limit}&skip=${skip}`);
        const data = await res.json();
        return data;
    }

    return {
        severData: await getProducts(limit, skip)
    };
});