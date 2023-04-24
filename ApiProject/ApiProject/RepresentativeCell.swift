import UIKit

class RepresentativeCell: UITableViewCell {
    
    @IBOutlet var RepName: UILabel!
    @IBOutlet var PartyName: UILabel!
    @IBOutlet var RepLink: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
