//
//  MakeReservationView.swift
//  BCLounge
//
//  Created by admin on 8/6/24.
//




import SwiftUI

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
    
    @State var showMail = false
        
    
    var body: some View {
        ZStack {
            CustomBackgroundView()
            
            VStack {
                
                Text("Reservation")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                
                HStack {
                    Text(club.name ?? "")
                        .padding(.top, 10)
                        
                    
                    Spacer()
                    
                    Text(club.hours ?? "")
                }
                .foregroundColor(.white)
                .padding(.bottom)
                
                DividerView()
                
                ScrollView {
                    DatePicker("Date", selection: $date, in: Date()..., displayedComponents: [.date])
                        .datePickerStyle(.compact)
                        .tint(.white)
                        .foregroundColor(.white)
                        .colorMultiply(.white)
                        .accentColor(.white)
                        .padding(.vertical)
                        .colorScheme(.dark)
                    
                    DividerView()
                    
                    DatePicker("Start time", selection: $time, displayedComponents: [.hourAndMinute])
                        .datePickerStyle(.compact)
                        .tint(.white)
                        .foregroundColor(.white)
                        .colorMultiply(.white)
                        .accentColor(.white)
                        .padding(.vertical)
                        .colorScheme(.dark)
                    
                    DividerView()
                    
                    
                    HStack {
                        Text("Duration")
                            .foregroundColor(.white)
                        Spacer()
                        
                        Picker("Hour", selection: $selectedHour) {
                            ForEach(1..<13, id: \.self) { hour in
                                Text("\(hour)")
                            }
                        }
                        .tint(.white)
                        
                    }
                    .padding(.vertical)
                    
                    DividerView()
                    
                    HStack {
                        Text("Players")
                            .foregroundColor(.white)
                        Spacer()
                        
                        Picker("Players", selection: $players) {
                            ForEach(1..<9, id: \.self) { player in
                                Text("\(player)")
                            }
                        }
                        .tint(.white)
                        
                    }
                    .padding(.vertical)

                    
                    DividerView()
                    
                    HStack {
                        Text("Name")
                            .foregroundColor(.white)
                        Spacer()
                        
                        TextField("", text: $name)
                            .frame(width: 100)
                            .placeholder(when: name.isEmpty) {
                                Text("Enter your name").foregroundColor(.gray)
                            }
                            .foregroundColor(.white)
                            .tint(.white)
                        
                    }
                    .padding(.vertical)
                    
                    DividerView()
                    
                    HStack {
                        Text("Phone")
                            .foregroundColor(.white)
                        Spacer()
                        
                        TextField("", text: $number)
                            .frame(width: 100)
                            .placeholder(when: number.isEmpty) {
                                Text("Phone Number").foregroundColor(.gray)
                            }
                            .foregroundColor(.white)
                            .tint(.white)
                        
                    }
                    .padding(.vertical)
                    
                    DividerView()
                    
                    HStack {
                        Text("Email")
                            .foregroundColor(.white)
                        Spacer()
                        
                        TextField("", text: $email)
                            .frame(width: 100)
                            .placeholder(when: email.isEmpty) {
                                Text("Your email").foregroundColor(.gray)
                            }
                            .foregroundColor(.white)
                            .tint(.white)
                        
                    }
                    .padding(.vertical)
                    
                    DividerView()
                    
                    VStack {
                        HStack {
                            Text("Preferred games | Addition Info")
                                .foregroundColor(.white)
                            Spacer()
                        }
                        
                        TextEditor(text: $games)
                            .foregroundStyle(.white)
                            .padding(.horizontal)
                            .frame(height: 200)
                            .scrollContentBackgroundHidden()
                            .background(Color.softBlue.cornerRadius(12))
                            .tint(.white)
                        
                        Button {
                         //   saveReserv()
                            showMail.toggle()
                        } label: {
                            Text("Make a Reserve")
                                .frame(width: 200, height: 40)
                        }
                        .tint(.lightPink)
                        .buttonStyle(.borderedProminent)
                        .padding(.vertical)
                        
                        VStack {
                            
                        }.frame(height: 300)
                    }
                    .padding(.vertical)
                    
                }
                .hideScrollIndicator()
            }
            .padding(.horizontal)
        }
        .overlay {
            VStack {
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
                Spacer()
            }
            .padding(.top, 9)
            .padding(.leading)
        }
        .sheet(isPresented: $showMail) {
            MailComposeView(isShowing: $showMail, subject: "Reservation message", recipientEmail: "agnesschulz06@gmail.com", textBody: makeMessage()) { result, error in
                switch result {
                case .cancelled:
                    print("Mail cancelled")
                case .saved:
                    print("Mail saved")
                case .sent:
                    print("Mail sent")
                    dismiss()
                case .failed:
                    print("Mail failed: \(error?.localizedDescription ?? "Unknown error")")
                @unknown default:
                    print("Unknown result")
                }
            }
        }
        .onAppear {
            user = StorageManager.shared.getUser()
            
            name = user.name
            number = user.phone
            email = user.email
        }
    }
    
    func prepareDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd"
        
        return dateFormatter.string(from: date)
    }
    
    func prepareTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: time)
    }
    
    func makeMessage() -> String {
        
        return """
Club: \(club.name ?? "")
Date: \(prepareDate())
Start time: \(prepareTime())
Durtation: \(selectedHour)
Players: \(players)
Name: \(name)
Phone:  \(number)
Email: \(email)
Addition Info: \(games)
"""
    }
}

#Preview {
    MakeReservationView(club: .example)
}
