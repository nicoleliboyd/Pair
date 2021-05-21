//
//  EntityController.swift
//  PairRandomizer
//
//  Created by David Boyd on 5/21/21.
//

import Foundation

class EntityController {
    
    //MARK: - Properties
    static let sharedInstance = EntityController()
    var entities: [Entity] = []
    
//    //sectioning
//    let
//    var indexPaths = [
//        IndexPath(row: 0, section: 1),
//        IndexPath(arrayLiteral: Entity.)
//    ]
    
    //MARK: - Functions
    func createEntity(fullName: String) {
        let newEntity = Entity(fullName: fullName)
        entities.append(newEntity)
        saveToPersestenceStore()
    }
    
    func deleteEntity(entity: Entity) {
        guard let index = entities.firstIndex(of: entity) else {return}
        entities.remove(at: index)
        print("Successfully deleted \(String(describing: entity.fullName))")
        saveToPersestenceStore()
    }
    
    func updateEntityOrder(entities: [Entity]) {
        let newOrderedEntities = entities
        Self.sharedInstance.entities = newOrderedEntities
        saveToPersestenceStore()
    }
    
    //MARK: - Persistence
    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("PairRandomizer.json")
        return fileURL
    }
    
    func saveToPersestenceStore() {
        do {
            let data = try JSONEncoder().encode(entities)
            try data.write(to: createPersistenceStore())
        } catch {
            print("Error in \(#function) :  \(error.localizedDescription) \n---\n \(error)")
        }
        
    }
    
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            entities = try JSONDecoder().decode([Entity].self, from: data)
        } catch {
            print("Error in \(#function) :  \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
}//End of class
