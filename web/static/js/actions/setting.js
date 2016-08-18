/* action creators */
import { store } from "../stores/store"
import $ from "jquery"

export function load(name) {
  store.dispatch({ type: "LOAD_NAME", name })
}

export function updateName(name) {
  $.ajax({
    method: "PUT",
    url: "/api/settings/church_name",
    data: { setting: { value: name } },
    success: response => {
      store.dispatch({ type: "UPDATE_NAME", name: response.data.value })
    },
    error: response => {
      console.error(response)
    }
  })
}
