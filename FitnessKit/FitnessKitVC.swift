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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")

        performSelector(inBackground: #selector(fetchScheduler), with: nil)
        loadSavedData()
    }
    

    // MARK: - Handlers
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
            case .success(let items):
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
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return WeekDays(rawValue: section + 1)?.description
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "CellID")
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
        
        let  schedulerItem = fetchedResultsController.object(at: indexPath)
        let workout = schedulerItem.name
//        cell.textLabel?.text = " \(schedulerItem.name) : \(indexPath.row + 1)"
        
        cell.textLabel?.text = Workout(rawValue: workout)?.description
        cell.detailTextLabel?.text = schedulerItem.teacher
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

