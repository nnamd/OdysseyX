import  SwiftUI
class viewModelProfile: ObservableObject{
    
    @Published private var profileData: ProfileModel = ProfileModel()
    
    
    //MARK: - Access to the Model
    
    func getUserName()->String{
        return profileData.name
    }
    
    func equippedCharacter() -> Character{
        return profileData.equippedCharacter
    }
    
    //change character
    func changeAvatar(to character: Character){
        profileData.changeAvatar(character)
    }
    
    //add to book list
    func addBook(add book: String){
        profileData.addBook(book)
    }
    
    func getImage()-> String
    {
        return profileData.equippedCharacter.nickname
    }
    
    func getTotalTime()-> (min: Int, sec: Int){
        
        return profileData.totalTime
    }
    
    func getCurrency()-> Int{
        
        return profileData.currency
    }
    
    func processTime(min: Int, sec: Int, gain:Int){
        
        profileData.addTime(min,sec)
        profileData.addCurrency(of: gain)
    }
    
    func buyAvatar(option character: Character){
        profileData.buyAvatar(character)
    }
    
    func ownedAvatars() -> [Character]{
        return profileData.ownedAvatars
    }
    
    func numberOfBooks()-> Int{
        return profileData.bookList.count 
    }
    
    
}
