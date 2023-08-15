import { Controller } from "stimulus"
import Handsontable from 'handsontable';

export default class extends Controller {
  connect() {
    fetch("/admin/grid/data.json").then(response => {
      response.json().then(data => {
        this.hot = new Handsontable(this.element, {
          data: data.items,
          rowHeaders: false,
          colHeaders: [
            "ID", "Number", "Name", "Status", "Size", "Brand",
          ],
          search: true,
          height: '800',
          filters: true,
          dropdownMenu: true,
          licenseKey: 'non-commercial-and-evaluation',
        });
      });
    });
  }
}
