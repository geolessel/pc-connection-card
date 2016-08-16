/* action creators */
import { store } from "../stores/store"
import $ from "jquery"

export function updateName(name) {
  $.ajax({
    method: "PUT",
    url: "/api/settings/church_name",
    data: { setting: { value: name } },
    success: response => {
      store.dispatch({ type: "UPDATE_NAME", response.data.name })
    },
    error: response => {
      console.error(response)
    }
  })
}
