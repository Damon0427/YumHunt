import SwiftUI

struct loginPage: View {
    @Binding var userId: String
    @Binding var isLogIn: Bool
    @State var password: String = ""
    @State private var rememberMe: Bool = false
    @Environment(\.colorScheme) var colorScheme
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showsheet:Bool = false
    @StateObject var coreDataVM = coreDataviewModel()
    
    var body: some View {
            
        VStack(spacing: 20) {
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width: 100, height: 100)
                .clipped()
                .padding(.vertical, 40)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
            
            VStack(spacing: 15) {
                TextField("User Id", text: $userId)
                    .padding()
                    .padding(.leading, 35)
                    .border(Color.gray, width: 2)
                    .cornerRadius(10)
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                    .overlay(HStack {
                        Image(systemName: "person")
                            .foregroundStyle(colorScheme == .dark ? .white : .black)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 15)
                    })
                
                SecureField("Password", text: $password)
                    .padding()
                    .padding(.leading, 35)
                    .border(Color.gray, width: 2)
                    .cornerRadius(10)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .overlay(HStack {
                        Image(systemName: "lock")
                            .foregroundStyle(colorScheme == .dark ? .white : .black)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 15)
                    })
            }
            .padding(.horizontal, 25)
            
            
            VStack{
            Button(action: {
                showsheet.toggle()
            }) {
                Text("Sign up an Account?")
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(.thinMaterial)
                    .cornerRadius(10)
            }
            Button(action: {
                if coreDataVM.isValidLogin(username: userId, password: password){
                    print("login success")
                    isLogIn.toggle()
                    
                }else {
                    showAlert.toggle()
                    alertMessage = "Unmatch username or password to our database"
                }
                
            }) {
                Text("LOG IN")
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(.thinMaterial)
                    .cornerRadius(10)
                
            }
        }
                
                .padding(.horizontal, 25)
                .sheet(isPresented: $showsheet, content: {
                    SignUpPage(showSheet: $showsheet)
                })
                Spacer()
            }
            
            .alert(isPresented: $showAlert) {
                
                Alert(title: Text("Fail to login"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                            }
            .onChange(of: showsheet){
                if !showsheet {
                    coreDataVM.fetchUser()
                }
            }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        loginPage(userId: .constant(""), isLogIn: .constant(false))
    }
}
    
