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

    // default action
	// default: async (event) => {
	// 	// TODO log the user in
    //     const formData = event.request.formData();
    //     console.log(formData);
	// },
    
    // create action
    create: async ({ request }) => {
        const formData = await request.formData();

        const name = formData.get('name');
        const email = formData.get('email');
        const company = formData.get('company');
        const job = formData.get('jobTitle');

        const id = crypto.randomUUID()
        const contact = {
        id,
        name,
        email,
        company,
        job
        }

        contacts.push(contact);

        return {success: true, contact};
    },

    // delete action
    delete: async ({ request }) => {
        const formData = await request.formData();
        const id = formData.get('id');

        contacts = contacts.filter(contact => contact.id !== id);

        return {success: true};
    }
}