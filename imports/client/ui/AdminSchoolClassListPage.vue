<template lang="pug">
Guard(role="admin")
  .content-no-box
    .right
      Button(type="primary" shape="circle" icon="md-add" @click="adding = true")
    adminSchoolClassListItem(v-if="adding" v-bind:schoolClass="newSchoolClass" @closeEdit="adding = false")
    h1.heading AdminSchoolClassListPage
    admin-school-class-list-item(
      v-for="schoolClass in schoolClasses"
      v-bind:schoolClass="schoolClass"
      v-bind:key="schoolClass._id"
    )
</template>

<script lang="coffee">
import { SchoolClasses } from "/imports/api/schoolClasses.coffee"
import AdminSchoolClassListItem from "./AdminSchoolClastListItem.vue"
export default
  data : ->
    adding : false
    schoolClasses : []
  computed :
    newSchoolClass : ->
      name : ""
      teacherId : ""
  meteor :
    schoolClasses : ->
      SchoolClasses.find {},
        sort :
          name : 1
      .fetch()
  components : { AdminSchoolClassListItem }
</script>

<style scoped lang="sass">
.right
  display: flex
  justify-content: flex-end
</style>
