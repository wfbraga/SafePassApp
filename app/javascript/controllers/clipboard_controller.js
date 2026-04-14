import { Controller } from "@hotwired/stimulus"

class ClipboardController extends Controller {
    async copy( { params: { content } } ){
        try {
            await navigator.clipboard.writeText(content)
        }catch(e){
            console.error(e)
        }
    }
}

export default ClipboardController
