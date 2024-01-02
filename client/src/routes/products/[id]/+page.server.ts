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