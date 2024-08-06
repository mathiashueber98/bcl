

import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var isProfileShown = false
}


struct HomeView: View {
    
    var completion: () -> ()
    @StateObject private var vm = HomeViewModel()
    @State var news: [GamingNews] = []
    
    var body: some View {
        NavigationView {
            ZStack {
                CustomBackgroundView()
                
                VStack(spacing: 20) {
                    UserInfoCardView() {
                        vm.isProfileShown.toggle()
                    }
                    
                    VStack {
                        ScrollView {
                            HStack {
                                Text("Club News:")
                                    .font(.system(size: 28, weight: .black))
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            .padding(.leading, 25)
                            
                            
                            ForEach(news, id: \.self) { news in
                                NavigationLink {
                                    NewsDetailsView(news: news) {
                                        completion()
                                    }
                                        .navigationBarBackButtonHidden()
                                } label: {
                                    GamingNewsCellView(image: news.image, header: news.header)
                                }

                            }
                        }
                        .cornerRadius(34, corners: [.bottomLeft, .bottomRight])
                        .padding(.bottom, screenSize().height > 736 ? 20 : 50)
                        .hideScrollIndicator()
                    }
                    
                    Spacer()
                }
               
            }
            //MARK: - NavBar
            .modifier(NavBarBackground())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        VStack {
                            HStack(spacing: 0) {
                                
                                Image("crown")
                                    .resizable()
                                    .frame(width: 45, height: 45)
                                
                                Text("Bluechip Lounge")
                                    .font(.system(size: 28, weight: .black))
                                    .foregroundColor(Color.white)
                                   
                                Spacer()
                            }
                            
                        }
                        Spacer()
                    }
                    .ignoresSafeArea()
                }
            }
        }
        .fullScreenCover(isPresented: $vm.isProfileShown) {
            PersonDetailsView()
        }
        .onAppear {
           getNews()
        }
    }
    
    func getNews() {
        NetworkManager.shared.fetchNews { result in
            switch result {
            case .success(let data):
                news = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    TabInitialView()
}
