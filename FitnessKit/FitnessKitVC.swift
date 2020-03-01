//
//  FitnessKItVC.swift
//  FitnessKit
//
//  Created by Oleg Sitnikov on 27.02.2020.
//  Copyright © 2020 Oleg Sitnikov. All rights reserved.
//

import UIKit
import CoreData

class FitnessKitVC: UITableViewController, NSFetchedResultsControllerDelegate {
    // MARK: - Properties
    let sectionHeaderSize:CGFloat = 60
    let estimatedRowHeight:CGFloat = 150
    var container: NSPersistentContainer!
    var fetchedResultsController: NSFetchedResultsController<SchedulerItem>!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var selectedItem: Displayable?
    
    
    // MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        container = NSPersistentContainer(name: "FitnessKit")
        container.loadPersistentStores { storeDescription, error in
            self.container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
        
        title = "Fitness Kit"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureTableView()
        
        performSelector(inBackground: #selector(fetchScheduler), with: nil)
        loadSavedData()
    }
    
    
    
    // MARK: - Handlers
    
    func configureTableView() {
        tableView.register(SchedulerCell.self, forCellReuseIdentifier: SchedulerCell.reuseIdentifer)
        tableView.separatorStyle = .none
        tableView.rowHeight = 130
        tableView.estimatedRowHeight = self.estimatedRowHeight
        tableView.clipsToBounds = true
        tableView.isOpaque = true
    }
    @objc func fetchScheduler() {
        loadFromApi()
        //        loadFromBundle()
    }
    
    func loadFromBundle() {
        DispatchQueue.main.async {
            _ = Bundle.main.decode([SchedulerItem].self, from: "fitnesskit.json", context: self.container.viewContext)
            self.saveContext()
            self.loadSavedData()
        }
    }
    
    func loadFromApi() {
        NetworkingService.shared.getScheduler(context: container.viewContext ) {
            result in
            switch result {
            case .success(_):
                self.saveContext()
                self.loadSavedData()
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    
    func loadSavedData() {
        if fetchedResultsController == nil {
            let request = SchedulerItem.createFetchRequest()
            let sort = NSSortDescriptor(key: "weekDay", ascending: true)
            request.sortDescriptors = [sort]
            request.fetchBatchSize = 20
            
            fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: container.viewContext, sectionNameKeyPath: "weekDay", cacheName: nil)
            fetchedResultsController.delegate = self
        }
        
        
        do {
            try fetchedResultsController.performFetch()
            tableView.reloadData()
        } catch {
            print("Fetch failed")
        }
    }
    
    func saveContext() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print("An error occurred while saving: \(error)")
            }
        }
    }
}


extension FitnessKitVC  {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.sectionHeaderSize
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionLabel = BaseItemText()
        sectionLabel.font = .preferredFont(forTextStyle: .title2)
        
        let sectionInfo = fetchedResultsController.sections![section].name
        sectionLabel.text = WeekDays(rawValue: Int(sectionInfo)!)?.description
        sectionLabel.textAlignment = .center
        
        let sectionView = BaseView()
        let sectionContainerView = BaseView(backgroundColor: #colorLiteral(red: 0.7176470588, green: 0.7176470588, blue: 0.7176470588, alpha: 1), borderWidth: 1)
        sectionContainerView.addSubview(sectionLabel)
        NSLayoutConstraint.activate([
            sectionLabel.centerXAnchor.constraint(equalTo: sectionContainerView.centerXAnchor),
            sectionLabel.centerYAnchor.constraint(equalTo: sectionContainerView.centerYAnchor)
        ])
        
        sectionView.addSubview(sectionContainerView)
        
        
        NSLayoutConstraint.activate([
            sectionContainerView.topAnchor.constraint(equalTo: sectionView.topAnchor, constant: 8),
            sectionContainerView.leadingAnchor.constraint(equalTo: sectionView.leadingAnchor, constant: 8),
            sectionContainerView.bottomAnchor.constraint(equalTo: sectionView.bottomAnchor, constant: 8),
            sectionContainerView.trailingAnchor.constraint(equalTo: sectionView.trailingAnchor, constant: -8)
        ])
        
        return sectionView
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return WeekDays(rawValue: section + 1)?.description
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SchedulerCell.reuseIdentifer, for: indexPath) as? SchedulerCell else {
            fatalError("""
                Expected \(SchedulerCell.self) type for reuseIdentifier \(SchedulerCell.reuseIdentifer).
                """)
        }
        cell.schedulerItem = fetchedResultsController.object(at: indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedItem = fetchedResultsController.object(at: indexPath)
        return indexPath
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let teacherDetailVC = TeacherDetailVC()
        teacherDetailVC.data = selectedItem
        navigationController?.pushViewController(teacherDetailVC, animated: true)
    }
}

