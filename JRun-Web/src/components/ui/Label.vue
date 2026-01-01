<template>
  <label :class="['text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70', labelClass]">
    <slot />
  </label>
</template>

<script>
export default {
  name: 'Label',
  props: {
    labelClass: {
      type: String,
      default: ''
    }
  }
}
</script>