import SwiftUI
import MessageUI

struct MakeReservationView: View {
    var club: Lounge
    
    @Environment(\.dismiss) var dismiss
    @State private var date = Date()
    @State private var time = Date()
    @State private var selectedHour: Int = 1
    @State private var players: Int = 1
    @State private var games = ""
    @State private var name = ""
    @State private var number = ""
    @State private var email = ""

    @State var user = User()
    @State private var showMail = false

    var body: some View {
        ZStack {
            CustomBackgroundView()
            
            VStack {
                headerView
                clubDetailsView
                reservationForm
                submitButton
            }
            .padding(.horizontal)
            .hideScrollIndicator()
        }
        .overlay(closeButton, alignment: .topLeading)
        .sheet(isPresented: $showMail) {
            MailComposeView(isShowing: $showMail, subject: "Reservation message", recipientEmail: "agnesschulz06@gmail.com", textBody: makeMessage()) { result, _  in
                handleMailResult(result: result)
            }
        }
        .onAppear {
            loadUserData()
        }
    }
    
    private var headerView: some View {
        Text("Reservation")
            .font(.system(size: 28, weight: .bold))
            .foregroundColor(.white)
    }
    
    private var clubDetailsView: some View {
        HStack {
            Text(club.name ?? "")
                .padding(.top, 10)
            
            Spacer()
            
            Text(club.hours ?? "")
        }
        .foregroundColor(.white)
        .padding(.bottom)
    }
    
    private var reservationForm: some View {
        ScrollView {
            VStack(spacing: 20) {
                datePicker("Date", selection: $date, displayedComponents: [.date])
                datePicker("Start time", selection: $time, displayedComponents: [.hourAndMinute])
                
                formPicker("Duration", selection: $selectedHour, options: 1..<13)
                formPicker("Players", selection: $players, options: 1..<9)
                
                formTextField("Name", text: $name, placeholder: "Enter your name")
                formTextField("Phone", text: $number, placeholder: "Phone Number")
                formTextField("Email", text: $email, placeholder: "Your email")
                
                VStack(alignment: .leading) {
                    Text("Preferred games | Additional Info")
                        .foregroundColor(.white)
                    
                    TextEditor(text: $games)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .frame(height: 200)
                        .background(Color.softBlue.cornerRadius(12))
                        .scrollContentBackgroundHidden()
                }
                .padding(.vertical)
            }
            .padding(.vertical)
        }
    }
    
    private var submitButton: some View {
        Button {
            showMail.toggle()
        } label: {
            Text("Make a Reserve")
                .frame(width: 200, height: 40)
        }
        .tint(.lightPink)
        .buttonStyle(.borderedProminent)
        .padding(.vertical)
    }
    
    private var closeButton: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
            }
            Spacer()
        }
        .padding(.top, 9)
        .padding(.leading)
    }
    
    private func datePicker(_ title: String, selection: Binding<Date>, displayedComponents: DatePickerComponents) -> some View {
        DatePicker(title, selection: selection, displayedComponents: displayedComponents)
            .datePickerStyle(.compact)
            .tint(.white)
            .foregroundColor(.white)
            .colorMultiply(.white)
            .accentColor(.white)
            .padding(.vertical)
            .colorScheme(.dark)
    }
    
    private func formPicker(_ title: String, selection: Binding<Int>, options: Range<Int>) -> some View {
        HStack {
            Text(title)
                .foregroundColor(.white)
            Spacer()
            Picker(title, selection: selection) {
                ForEach(options, id: \.self) { option in
                    Text("\(option)")
                }
            }
            .tint(.white)
        }
        .padding(.vertical)
    }
    
    private func formTextField(_ title: String, text: Binding<String>, placeholder: String) -> some View {
        HStack {
            Text(title)
                .foregroundColor(.white)
            Spacer()
            TextField("", text: text)
                .frame(width: 100)
                .placeholder(when: text.wrappedValue.isEmpty) {
                    Text(placeholder).foregroundColor(.gray)
                }
                .foregroundColor(.white)
                .tint(.white)
        }
        .padding(.vertical)
    }
    
    private func handleMailResult(result: MFMailComposeResult) {
        switch result {
        case .cancelled:
            print("Mail cancelled")
        case .saved:
            print("Mail saved")
        case .sent:
            print("Mail sent")
            dismiss()
        case .failed:
            print("Mail failed")
        @unknown default:
            print("Unknown result")
        }
    }
    
    private func loadUserData() {
        user = StorageManager.shared.getUser()
        name = user.name
        number = user.phone
        email = user.email
    }
    
    private func makeMessage() -> String {
        """
        Club: \(club.name ?? "")
        Date: \(formatDate(date))
        Start time: \(formatTime(time))
        Duration: \(selectedHour) hour(s)
        Players: \(players)
        Name: \(name)
        Phone: \(number)
        Email: \(email)
        Additional Info: \(games)
        """
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd"
        return formatter.string(from: date)
    }
    
    private func formatTime(_ time: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: time)
    }
}

#Preview {
    MakeReservationView(club: .example)
}
