//
//  PersonDetailsView.swift
//  BCLounge
//
//  Created by admin on 8/6/24.
//




import SwiftUI

struct PersonDetailsView: View {
    
    @StateObject var vm = UserInfoViewModel()
    @Environment(\.dismiss) var dismiss
    
    @State var name = ""
    @State var surName = ""
    @State var email = ""
    @State var birthday = ""
    @State var number = ""
    @State var selectedImage = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                CustomBackgroundView()
                
                ScrollView {
                    VStack(spacing: 25) {
                        
                        TextField("", text: $name)
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                            .placeholder(when: name.isEmpty) {
                                Text("Name").foregroundColor(.gray)
                            }
                        
                        DividerView()
                        
                        TextField("", text: $surName)
                            .foregroundColor(.white)
                            .font(.system(size: 22, weight: .bold))
                            .placeholder(when: surName.isEmpty) {
                                Text("Surname").foregroundColor(.gray)
                            }
                        
                        DividerView()
                        
                        TextField("", text: $email)
                            .foregroundColor(.white)
                            .font(.system(size: 22, weight: .bold))
                            .placeholder(when: email.isEmpty) {
                                Text("Email").foregroundColor(.gray)
                            }
                        
                        DividerView()
                        
                        TextField("", text: $birthday)
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                            .placeholder(when: birthday.isEmpty) {
                                Text("Birthday").foregroundColor(.gray)
                            }
                        
                        DividerView()
                        
                        TextField("", text: $number)
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                            .placeholder(when: number.isEmpty) {
                                Text("Phone Number").foregroundColor(.gray)
                            }
                        
                        DividerView()

                        
                        Button {
                            StorageManager.shared.updateUser(name: name, surname: surName, email: email, birthday: birthday, number: number)
                            dismiss()
                        } label: {
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
            //MARK: - NavBar
            .modifier(NavBarBackground())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 10) {
                        
                        Spacer()
                        
                        Text("User Details")
                            .font(.system(size: 28, weight: .black))
                            .foregroundColor(Color.white)
                            .padding(.trailing)
                            .frame(width: screenSize().width)

                        
                        Spacer()
                    }
                    .overlay {
                        HStack {
                            Button {
                                dismiss()
                            } label: {
                                Image(systemName: "xmark")
                                    .foregroundColor(.white)
                            }
                            .padding(.leading, 25)
                            
                            Spacer()
                        }
                    }
                    .ignoresSafeArea()
                    
                }
            }
        }
        .onAppear {
            vm.fetchUser()
            
            name = vm.user.name
            surName = vm.user.surname
            email = vm.user.email
            birthday = vm.user.birthday
            number = vm.user.phone
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
