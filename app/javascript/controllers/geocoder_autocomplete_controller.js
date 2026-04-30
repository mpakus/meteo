import { Controller } from "@hotwired/stimulus"
import { GeocoderAutocomplete } from "@geoapify/geocoder-autocomplete"

export default class extends Controller {
  static targets = ["address", "lat", "lng", "zip"]

  static values = {
    apiKey: String,
    countryCode: { type: String, default: "us" },
    limit: { type: Number, default: 5 }
  }

  connect() {
    if (!this.hasApiKeyValue || this.apiKeyValue.length === 0) {
      alert("Geoapify API key is missing");
      return;
    }

    this.autocomplete = new GeocoderAutocomplete(
      this.element,
      this.apiKeyValue,
      {
        lang: "en",
        limit: this.limitValue,
        filter: {
          countrycode: [this.countryCodeValue]
        }
      }
    )

    this.autocomplete.on("select", (location) => { this.handleSelect(location)})
  }

  disconnect() {
    this.autocomplete = null;
  }

  handleSelect(location) {
    if (!location || !location.properties) {
      return
    }

    const properties = location.properties;

    this.addressTarget.value = properties.formatted || "";
    this.latTarget.value     = properties.lat || "";
    this.lngTarget.value     = properties.lon || "";
    this.zipTarget.value     = properties.postcode || "";
    // @debug
    // document.querySelector("#debug").textContent = JSON.stringify(properties, null, 2);
  }
}
