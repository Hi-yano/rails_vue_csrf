<template>
  <div class="UsersList">
    <h2>USER LIST</h2>
    <div class="row">
      <div class="">Users</div>
    </div>
    <div
      class="row"
      v-for="user of users"
      :key="user.id + user.name + new Date().getTime()"
    >
      <User v-bind:user="user" @requestIndex="index" />
    </div>
    <div class="row">
      <div class="">ADD User</div>
    </div>
    <div class="row">
      <div class="six columns">
        <input
          v-model="addusername"
          v-on:keyup.enter="create"
          class="u-full-width"
          placeholder="UserName (1 character minimum)"
        />
      </div>
      <div class="six columns">
        <button v-on:click="create">ADD</button>
      </div>
    </div>
  </div>
</template>

<script>
const axios = require("axios");
const qs = require("qs");
import "skeleton-css/css/normalize.css";
import "skeleton-css/css/skeleton.css";
import User from "./User.vue";

export default {
  name: "UsersList",
  components: {
    User,
  },
  data: function () {
    return {
      users: [],
      addusername: "",
      sendstate: false,
    };
  },
  methods: {
    //railsの/userへGET
    index: async function () {
      console.log("Get:/users");
      self = this;
      await axios.get("/users.json").then(function (result) {
        console.log("[result]", result);
        self.users = result.data;
      });
    },
    //railsの/userへPOST
    create: async function () {
      //多重送信防止
      if (this.sendstate) {
        console.error("Post Sending Now");
        return;
      }
      if (this.addusername.length == 0) {
        console.error("Addusername is empty");
        return;
      }

      this.sendstate = true;
      console.log("Post:/users");
      self = this;
      await axios
        .post("/users", {
          user: { name: this.addusername },
          paramsSerializer: function (params) {
            return qs.stringify(params, { arrayFormat: "brackets" });
          },
        })
        .then(function (result) {
          console.log(result);
          self.addusername = "";
          self.sendstate = false;
        })
        .catch(function () {
          self.addusername = "";
          self.sendstate = false;
        });
      this.index();
    },
  },
  mounted: function () {
    axios.defaults.headers.common = {
      "X-Requested-With": "XMLHttpRequest",
      "X-CSRF-TOKEN": document
        .querySelector('meta[name="csrf-token"]')
        .getAttribute("content"),
    };
    this.index();
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
input {
  text-align: center;
}
</style>