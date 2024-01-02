import type { PageServerLoad } from './$types';
import type { Actions } from './$types';

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


export const actions:Actions = {
	default: async (event) => {
		// TODO log the user in
        const formData = event.request.formData();
        console.log(formData);
	},
}