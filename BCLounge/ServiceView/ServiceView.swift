import SwiftUI
import MessageUI

struct ServiceView: View {
    
    var completion: () -> ()
    
    @State private var errorMail = false
    @State private var suggestionMail = false
    private let buttons = ["Loyalty", "Reservations"]
    private let adaptiveColumn = [GridItem(.adaptive(minimum: 150, maximum: 250))]
    
    var body: some View {
        NavigationStack {
            ZStack {
                CustomBackgroundView()
                VStack {
                    buttonGrid
                    supportForm
                }
                .padding(.top, 10)
            }
            .modifier(NavBarBackground())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Service")
                        .font(.system(size: 28, weight: .black))
                        .foregroundColor(.white)
                }
            }
        }
    }
    
    private var buttonGrid: some View {
        LazyVGrid(columns: adaptiveColumn, spacing: 10) {
            ForEach(buttons, id: \.self) { room in
                NavigationLink(destination: destinationView(for: room)) {
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
        }
        .padding(.horizontal, 20)
    }
    
    private var supportForm: some View {
        List {
            supportSection(title: "Support", buttons: [
                ("Report a bug", $errorMail),
                ("Suggest improvement", $suggestionMail)
            ])
            .listRowBackground(Color.semiBlue)
            
            supportSection(title: "Usage", buttons: [
                ("Privacy Policy", Binding.constant(false))
            ])
            .listRowBackground(Color.semiBlue)
        }
        .tint(.white)
        .modifier(FormBackgroundModifier())
    }
    
    private func supportSection(title: String, buttons: [(String, Binding<Bool>)]) -> some View {
        Section(header: Text(title).foregroundColor(.gray)) {
            ForEach(buttons, id: \.0) { button in
                Button(button.0) {
                    if button.0 == "Privacy Policy" {
                        openPrivacyPolicy()
                    } else {
                        button.1.wrappedValue.toggle()
                    }
                }
                .sheet(isPresented: button.1) {
                    if button.0 == "Report a bug" {
                        MailComposeView(isShowing: button.1, subject: "Error message", recipientEmail: "mathiashueber98@gmail.com", textBody: "")
                    } else {
                        MailComposeView(isShowing: button.1, subject: "Improvement suggestion", recipientEmail: "mathiashueber98@gmail.com", textBody: "")
                    }
                }
            }
        }
    }
    
    private func destinationView(for room: String) -> some View {
        switch room {
        case "Loyalty":
            return AnyView(RanksView() { completion() })
        case "Reservations":
            return AnyView(LoungeReservationsView() { completion() })
        default:
            return AnyView(Text(""))
        }
    }
    
    private func openPrivacyPolicy() {
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
            content.scrollContentBackground(.hidden)
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
