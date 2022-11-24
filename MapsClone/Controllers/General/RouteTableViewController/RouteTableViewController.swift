//
//  RootTableViewController.swift
//  MapsClone
//
//  Created by Abdurrahman Gazi Yavuz on 10/25/22.
//

import UIKit

class RouteTableViewController: UITableViewController {
    
    internal lazy var showNavigationButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(weight: .bold)
        let image = UIImage(systemName: "arrow.triangle.turn.up.right.diamond.fill", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(startStopButtonTapped), for: .touchUpInside)
        button.backgroundColor = .yellow
        return button
    }()
    
    internal lazy var startNavigationButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(weight: .bold)
        let image = UIImage(systemName: "location.north.fill", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(testMethod), for: .touchUpInside)
        button.backgroundColor = .yellow
        return button
    }()
    
    internal lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [showNavigationButton, startNavigationButton])
        view.axis = .horizontal
        view.distribution = .equalSpacing
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc private func startStopButtonTapped(){
        
        print("startStopButtonTapped")
        
    }
    
    @objc private func testMethod(){
        
        print("testMethod")
        
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let stackView = UIStackView(arrangedSubviews: [showNavigationButton, startNavigationButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        stackView.isLayoutMarginsRelativeArrangement = true
//        stackView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor).isActive = true
//        stackView.topAnchor.constraint(equalTo: tableView.topAnchor).isActive = true
//        stackView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor).isActive = true
        stackView.translatesAutoresizingMaskIntoConstraints = true
        return stackView
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        
        var content = cell.defaultContentConfiguration()
        content.text = "test"
        cell.contentConfiguration = content

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
