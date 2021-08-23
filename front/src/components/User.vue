<template>
  <div class="User">
    <div class="six columns">
      <div v-if="state">
        <input
          ref="update"
          v-model="updatename"
          v-on:keyup.enter="deactivate"
          v-on:blur="deactivate"
          class="u-full-width"
        />
      </div>
      <div v-else>
        <p v-on:click="activate" class="u-full-width">{{ updatename }}</p>
      </div>
    </div>
    <div class="six columns">
      <button v-on:click="destroy()" key="">DELETE</button>
    </div>
  </div>
</template>

<script>
const axios = require("axios");
const qs = require("qs");
import "skeleton-css/css/normalize.css";
import "skeleton-css/css/skeleton.css";

export default {
  name: "User",
  data: function () {
    return { id: this.user.id, updatename: this.user.name, state: false };
  },
  props: ["user"],
  methods: {
    //input要素有効化
    activate: function () {
      this.state = true;
      this.$nextTick(() => {
        this.$refs["update"].focus();
      });
    },
    //input要素無効化
    deactivate: function () {
      if (this.updatename != this.user.name && this.state) {
        this.update();
      }
      this.state = false;
    },
    //親コンポーネントへの更新要求
    requestIndex: function () {
      this.$emit("requestIndex");
    },
    //railsの/user/:idへPATCH
    update: async function () {
      console.log(`Update:/users/${this.id}`);

      if (this.updatename.length == 0) {
        this.updatename = this.user.name;
        console.error("updatename is empty");
        return;
      }
      self = this;

      await axios
        .patch(`/users/${this.id}`, {
          user: { name: this.updatename },
          paramsSerializer: function (params) {
            return qs.stringify(params, { arrayFormat: "brackets" });
          },
        })
        .then(function (result) {
          console.log(result);
          self.requestIndex();
        })
        .catch(function () {
          self.requestIndex();
        });
    },
    //railsの/user/:idへDELETE
    destroy: async function () {
      console.log(`Destroy:/users/${this.id}`);
      self = this;

      await axios
        .delete(`/users/${this.id}`)
        .catch(() => {})
        .then(function (result) {
          console.log(result);
          self.requestIndex();
        })
        .catch(function () {
          self.requestIndex();
        });
    },
  },
  mounted: function () {
    axios.defaults.headers.common = {
      "X-Requested-With": "XMLHttpRequest",
      "X-CSRF-TOKEN": document
        .querySelector('meta[name="csrf-token"]')
        .getAttribute("content"),
    };
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
input {
  text-align: center;
  border-top: none;
  border-right: none;
  border-left: none;
  outline: none;
}
</style>