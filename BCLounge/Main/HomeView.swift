

import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var isProfileShown = false
}


struct HomeView: View {
    var completion: () -> ()
    @StateObject private var vm = HomeViewModel()
    @State private var news: [GamingNews] = []
    
    var body: some View {
        NavigationView {
            ZStack {
                CustomBackgroundView()
                
                VStack(spacing: 20) {
                    UserInfoCardView {
                        vm.isProfileShown.toggle()
                    }
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Club News:")
                                .font(.system(size: 28, weight: .black))
                                .foregroundColor(.white)
                                .padding(.leading, 25)
                            
                            ForEach(news, id: \.self) { newsItem in
                                NavigationLink(destination: NewsDetailsView(news: newsItem, completion: completion)
                                    .navigationBarBackButtonHidden()) {
                                    GamingNewsCellView(image: newsItem.image, header: newsItem.header)
                                }
                            }
                        }
                        .hideScrollIndicator()
                    }
                    .padding(.bottom, screenSize().height > 736 ? 40 : 50)
                    
                    Spacer()
                }
            }
            .modifier(NavBarBackground())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 0) {
                        Image("crown")
                            .resizable()
                            .frame(width: 45, height: 45)
                        
                        Text("Bluechip Lounge")
                            .font(.system(size: 28, weight: .black))
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                    .ignoresSafeArea()
                }
            }
        }
        .fullScreenCover(isPresented: $vm.isProfileShown) {
            PersonDetailsView()
        }
        .onAppear(perform: fetch)
    }
    
    private func fetch() {
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
