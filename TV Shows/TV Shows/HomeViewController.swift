import UIKit
import MBProgressHUD
import Alamofire

final class HomeViewController: UIViewController {
    // MARK: - Private UI
    @IBOutlet private weak var tableView: UITableView!
    
    var authInfo: AuthInfo?
    var shows: [Show] = []
 
    private let items = [
           TVShowItem(name: "Fringe", image: nil),
           TVShowItem(name: "Dexter", image: nil),
           TVShowItem(name: "The X-Files", image: nil),
           TVShowItem(name: "The Office", image: nil),
           TVShowItem(name: "Fringe", image: nil),
           TVShowItem(name: "Dexter", image: nil),
           TVShowItem(name: "The X-Files", image: nil),
           TVShowItem(name: "The Office", image: nil)
       ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        title = "Shows"
        
    }
}

// MARK: - UITableView
extension HomeViewController: UITableViewDelegate {
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        print("Selected Item: \(item)")
    }
}



extension HomeViewController: UITableViewDataSource {

    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        print("CURRENT INDEX PATH BEING CONFIGURED: \(indexPath)")

        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: TitleTableViewCell.self),
            for: indexPath
        ) as! TitleTableViewCell
            
            cell.configure(with: items[indexPath.row])
        return cell
    }
}

// MARK: - Private
private extension HomeViewController {
    func setupTableView() {
        tableView.estimatedRowHeight = 110
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
    }
}



extension HomeViewController{
    func onceLoginned(){
        MBProgressHUD.showAdded(to: view, animated: true)
        AF
            .request(
                "https://tv-shows.infinum.academy/shows",
                method: .get,
                parameters: ["count": 5,
                             "page": 1,
                             "items": 20,
                             "pages": 1], // pagination arguments
                headers: HTTPHeaders(self.authInfo?.headers ?? [:])
            )
            .validate()
            .responseDecodable(of: ShowsResponse.self) { dataResponse in
                
                switch dataResponse.result {
                case .success(let response):
                    self.shows = response.shows
                case .failure(let error):
                    let alertController = UIAlertController(title: "Login Failed", message: "Something happened try again", preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default)
                    alertController.addAction(OKAction)
                    self.present(alertController, animated: true)
                    print("Failure: \(error)")
                }
                
            }
        
    }
    
    
}

struct Show: Decodable {
    let id: String
    let title: String
    let average_rating: Double
    let description: String
    let image_url: String
    let no_of_reviews: Int
    
}

struct ShowsResponse: Decodable {
    let shows: [Show]
    let count: Int
    let page: Int
    let items: Int
    let pages: Int// pagination metadata (optional, only needed for extra)
}
func handleSuccesfulLogin(for user: User, headers: [String: String]) {
    
    guard let authInfo = try? AuthInfo(headers: headers) else {
        return
    }
}

