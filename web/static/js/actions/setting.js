/* action creators */
import { store } from "../stores/store"
import $ from "jquery"

export function saveDefaultWorkflow(id) {
  $.ajax({
    method: "PUT",
    url: "/api/settings/default_workflow_id",
    data: { setting: { value: id } },
    success: response => {
      store.dispatch({ type: "UPDATE_DEFAULT_WORKFLOW_ID" })
    },
    error: response => {
      console.error(response)
    }
  })
}
