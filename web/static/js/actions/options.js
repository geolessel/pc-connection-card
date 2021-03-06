/* action creators */
import { store } from "../stores/store"
import $ from "jquery"

export function load(options) {
  store.dispatch({ type: "LOAD_OPTIONS", options })
}

export function newOption() {
  store.dispatch({ type: "NEW_OPTION" })
}

export function removeOption(option) {
  store.dispatch({ type: "REMOVE_OPTION", option })
}

export function deleteOption(id) {
  $.ajax({
    method: "DELETE",
    url: `/api/options/${id}`,
    success: response => {
      store.dispatch({ type: "DELETE_OPTION", id })
    },
    error: response => {
      console.error(response)
    }
  })
}

export function createOption(option) {
  $.ajax({
    method: "POST",
    url: "/api/options",
    data: { option },
    success: response => {
      store.dispatch({ type: "CREATE_OPTION", option: response.data })
    },
    error: response => {
      console.error(response)
    }
  })
}
