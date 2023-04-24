import UIKit

class RepresentativeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var repArray: [Representative] = []

    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepCell", for: indexPath) as! RepresentativeCell
        
        if repArray.isEmpty {
            return cell
        } else {
            
            let represetative = repArray[indexPath.row]
            
            cell.RepName.text = represetative.name
            
            cell.PartyName.text = represetative.party
            
            cell.RepLink.text = represetative.link
            
            return cell
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        Task {
            await performApiRequest()
            tableView.reloadData()
        }
    }
      
    func fetchRepresentatives(zipCode: String) async throws -> [Representative] {
        let urlString = "https://whoismyrepresentative.com/getall_mems.php?zip=\(zipCode)&output=json"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        let jsonDecoder = JSONDecoder()
        guard let response = try? jsonDecoder.decode(RepResults.self, from: data) else {
            throw NSError(domain: "Invalid response", code: -1, userInfo: nil)
        }

        return response.results
    }

    @MainActor
    func performApiRequest() async {
        do {
            let representatives = try await fetchRepresentatives(zipCode: searchBar.text ?? "84045")
            self.repArray = representatives
            print("Representatives: \(representatives)")
        } catch {
            print("Error fetching representatives: \(error)")
        }
    }
}
