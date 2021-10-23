<script>
 let count = 0;
  const foo = () => count++
  $: console.log("kir" + count)

</script>
<nav on:click={foo}>
  kir {count}
</nav>
