import Foundation
import CoreData

extension LessonEntity {
    func fromModel(model: Lesson, context: NSManagedObjectContext) -> LessonEntity {
        let entity = LessonEntity(context: context)
        entity.name = model.name
        entity.daysLeft = Int16(model.daysLeft)
        entity.color = model.color.colorValue.asData
        return entity
    }
}

