import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  submit(event) {
    //let controller = event.srcElement.value;
    //this.element.setAttribute('action', `/${controller}/new`);
    console.log('click', event.srcElement.value);
    this.element.requestSubmit();
  }
}
