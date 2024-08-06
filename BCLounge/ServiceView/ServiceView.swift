//
//  ServiceView.swift
//  BCLounge
//
//  Created by admin on 8/6/24.
//


import SwiftUI
import MessageUI


struct ServiceView: View {
    
    var completion: () -> ()
    
    @State private var errorMail = false
    @State private var suggestionMail = false
    var buttons = ["Loyalty", "Reservations"]
    private let adaptiveColumn = [
        GridItem(.adaptive(minimum: 150, maximum: 250))
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                CustomBackgroundView()
                VStack {
                        LazyVGrid(
                            columns: adaptiveColumn, spacing: 10, content: {
                                ForEach(buttons, id:\.self) { room in
                                    NavigationLink {
                                        switch room {
                                        case "Loyalty":
                                            RanksView() {
                                                completion()
                                            }
                                            .navigationBarBackButtonHidden()
                                        case "Reservations":
                                            LoungeReservationsView(){
                                                completion()
                                            }
                                            .navigationBarBackButtonHidden()
                                        default:
                                            Text("")
                                        }
                                        
                                    } label: {
                                        ZStack {
                                            Rectangle()
                                                .foregroundColor(.semiBlue)
                                                .frame(width: 180, height: 150)
                                                .cornerRadius(20)
                                                .glow(.semiRed.opacity(0.1), radius: 10)
                                            VStack {
                                                Image(systemName: room == "Loyalty" ? "trophy" : "r.square.on.square.fill")
                                                    .resizable()
                                                    .frame(width: 60, height: 60)
                                                    .foregroundColor(.white.opacity(0.6))
                                                Text(room)
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 18, weight: .medium))
                                                    .padding(.top, 10)
                                            }
                                        }
                                    }
                                }
                            })
                        .padding(.top, 2)
                        .padding(.horizontal, 20)
                    
                    Form {
                        Section {
                            Button {
                                errorMail.toggle()
                            } label: {
                                Text("Report a bug")
                            }
                            .sheet(isPresented: $errorMail) {
                                MailComposeView(isShowing: $errorMail, subject: "Error message", recipientEmail: "mathiashueber98@gmail.com", textBody: "")
                            }
                            
                            Button {
                                suggestionMail.toggle()
                            } label: {
                                Text("Suggest improvement")
                            }
                            .sheet(isPresented: $suggestionMail) {
                                MailComposeView(isShowing: $suggestionMail, subject: "Improvement suggestion", recipientEmail: "mathiashueber98@gmail.com", textBody: "")
                            }
                        } header: {
                            Text("Support")
                                .foregroundColor(Color.gray)
                        }
                        .listRowBackground(Color.semiBlue)
                        
                        Section {
                            Button {
                                openPrivacyPolicy()
                            } label: {
                                Text("Privacy Policy")
                            }
                        } header: {
                            Text("Usage")
                                .foregroundColor(Color.gray)
                        }
                        .listRowBackground(Color.semiBlue)
                        
                    }
                    .tint(.white)
                    .modifier(FormBackgroundModifier())
                }
            }
            //MARK: - NavBar
            .modifier(NavBarBackground())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 10) {
                        Text("Service")
                            .font(.system(size: 28, weight: .black))
                            .foregroundColor(Color.white)
                        
                        Spacer()
                        
                    }
                    .ignoresSafeArea()
                }
            }
        }
      
    }
    
    func openPrivacyPolicy() {
        if let url = URL(string: "https://BCLounge.shop/com.BCLounge/Mathias_Hueber/privacy") {
            UIApplication.shared.open(url)
        }
    }
}

#Preview {
    ServiceView(){}
}

struct FormBackgroundModifier: ViewModifier {
    
    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .scrollContentBackground(.hidden)
        } else {
            content
        }
    }
}


struct MailComposeView: UIViewControllerRepresentable {
    @Binding var isShowing: Bool
    let subject: String
    let recipientEmail: String
    let textBody: String
    var onComplete: ((MFMailComposeResult, Error?) -> Void)?
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mailComposer = MFMailComposeViewController()
        mailComposer.setSubject(subject)
        mailComposer.setToRecipients([recipientEmail])
        mailComposer.setMessageBody(textBody, isHTML: false)
        mailComposer.mailComposeDelegate = context.coordinator
        return mailComposer
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        let parent: MailComposeView
        
        init(_ parent: MailComposeView) {
            self.parent = parent
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            parent.isShowing = false
            parent.onComplete?(result, error)
        }
    }
}
