<template>
  <div id="app" class="container">
    <UsersList/>
  </div>
</template>

<script>
import UsersList from './components/UsersList.vue'
export default {
  name: 'app',
  components: {
    UsersList
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>