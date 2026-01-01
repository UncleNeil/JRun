<template>
  <div :class="['rounded-lg border bg-card text-card-foreground shadow-sm p-6', cardClass]">
    <slot />
  </div>
</template>

<script>
export default {
  name: 'Card',
  props: {
    cardClass: {
      type: String,
      default: ''
    }
  }
}
</script>