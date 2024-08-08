import SwiftUI

struct PersonDetailsView: View {
    
    @StateObject private var vm = UserInfoViewModel()
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var surName = ""
    @State private var email = ""
    @State private var birthday = ""
    @State private var number = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                CustomBackgroundView()
                
                ScrollView {
                    VStack(spacing: 25) {
                        formField(title: "Name", text: $name)
                        formField(title: "Surname", text: $surName)
                        formField(title: "Email", text: $email)
                        formField(title: "Birthday", text: $birthday)
                        formField(title: "Phone Number", text: $number)
                        
                        Button(action: saveUser) {
                            Text("Save")
                                .frame(width: 200, height: 50)
                        }
                        .padding(.top, 40)
                        .buttonStyle(.borderedProminent)
                        .tint(.lightPink)
                    }
                    .padding(.horizontal)
                }
                .padding(.top, 50)
            }
            .modifier(NavBarBackground())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 10) {
                        Spacer()
                        Text("User Details")
                            .font(.system(size: 28, weight: .black))
                            .foregroundColor(.white)
                            .padding(.trailing)
                            .frame(width: screenSize().width)
                        Spacer()
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: dismiss.callAsFunction) {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                    }
                    .padding(.leading, 25)
                }
            }
        }
        .onAppear(perform: loadUser)
    }
    
    private func loadUser() {
        vm.fetchUser()
        
        name = vm.user.name
        surName = vm.user.surname
        email = vm.user.email
        birthday = vm.user.birthday
        number = vm.user.phone
    }
    
    private func saveUser() {
        StorageManager.shared.updateUser(name: name, surname: surName, email: email, birthday: birthday, number: number)
        dismiss()
    }
    
    private func formField(title: String, text: Binding<String>) -> some View {
        VStack {
            TextField("", text: text)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.white)
                .placeholder(when: text.wrappedValue.isEmpty) {
                    Text(title).foregroundColor(.gray)
                }
            DividerView()
        }
    }
}

#Preview {
    PersonDetailsView()
}

class UserInfoViewModel: ObservableObject {
    
    @Published var user = User()
    
    func fetchUser() {
        user = StorageManager.shared.getUser()
    }
}
