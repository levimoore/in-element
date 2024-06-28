import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { action } from "@ember/object";
import { later } from "@ember/runloop";
import { on } from "@ember/modifier";
import Modal from "@frontile/overlays/components/modal";

export default class DemoModal extends Component {
  @tracked isOpen = false;
  @tracked isLoading = false;

  @action toggle() {
    this.isOpen = !this.isOpen;
  }

  @action save() {
    this.isLoading = true;

    later(
      this,
      () => {
        this.isLoading = false;
        this.isOpen = false;
      },
      1000,
    );
  }

  // eslint-disable-next-line prettier/prettier
<template>
  <button
  {{on "click" this.toggle}}
>
  Frontile Modal
</button>

<Modal
  @isOpen={{this.isOpen}}
  @onClose={{this.toggle}}
  as |m|
>
  <m.Header>Title</m.Header>
  <m.Body>
    <p>Some contents...</p>
    <p>Some contents...</p>
    <p>Some contents...</p>
  </m.Body>
  <m.Footer>
    <button
      class="mr-4"
      {{on "click" this.toggle}}
    >
      Cancel
    </button>
    <button
      disabled={{this.isLoading}}
      {{on "click" this.save}}
    >
      {{if this.isLoading "Loading..." "Save"}}
    </button>
  </m.Footer>
</Modal>
</template>
}
