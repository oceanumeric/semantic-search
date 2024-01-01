<script lang="ts">
    const posts = [
        {
            title: "Post 1",
            date: "January 1, 2024",
            summary: "This is the summary of the first post."
        },
        {
            title: "Post 2",
            date: "January 2, 2024",
            summary: "This is the summary of the second post."
        },
        {
            title: "Post 3",
            date: "January 3, 2024",
            summary: "This is the summary of the third post."
        }
    ];
</script>


<div class="container mx-auto mt-12">
    {#each posts as post}
        <div class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
            <h2 class="text-2xl font-bold mb-2">{post.title}</h2>
            <p class="text-gray-700 text-base">{post.date}</p>
            <p class="text-gray-700 text-base">{post.summary}</p>
        </div>
    {/each}
</div>
