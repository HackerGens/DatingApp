//
//  ContentView.swift
//  DatingApp
//
//  Created by User on 20/08/2020.
//  Copyright © 2020 User. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View {
    
    @State var profiles = [
        
        Profile(id: 0, name: "Annie Watson", image: "p0", description: "Profectional Artest", offset: 0),
        Profile(id: 1, name: "Clarie", image: "p1", description: "Profectional Artest", offset: 0),
        Profile(id: 2, name: "Catherine", image: "p2", description: "Profectional Artest", offset: 0),
        Profile(id: 3, name: "Emma", image: "p3", description: "Profectional Artest", offset: 0),
        Profile(id: 4, name: "Juliana", image: "p4", description: "Profectional Artest", offset: 0),
        Profile(id: 5, name: "Kaviya", image: "p5", description: "Profectional Artest", offset: 0),
        Profile(id: 6, name: "Jill", image: "p6", description: "Profectional Artest", offset: 0),
        Profile(id: 7, name: "Terasa", image: "p7", description: "Profectional Artest", offset: 0),
    ]
    
    var body: some View{
        
        VStack{
            
            HStack(spacing: 15){
                
                Button(action: {}, label: {
                    
                    Image("menu")
                        .renderingMode(.template)
                })
                
                Text("Dating App")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer(minLength: 0)
                
                Button(action: {}, label: {
                    
                    Image("noti")
                        .renderingMode(.template)
                })
            }
            .foregroundColor(.black)
            .padding()

            GeometryReader{g in
                
                ZStack{
                    
                    ForEach(self.profiles.reversed()){profile in
                        
                        ProfileView(profile: profile,frame: g.frame(in: .global))
                    }
                }
            }
            .padding([.horizontal,.bottom])
        }
        .background(Color.black.opacity(0.06).edgesIgnoringSafeArea(.all))
    }
}


struct ProfileView : View {
    
    @State var profile : Profile
    var frame : CGRect
    
    var body: some View{

        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom), content: {
            
            Image(profile.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: frame.width,height: frame.height)
           
            ZStack(alignment: Alignment(horizontal: .center, vertical: .top), content: {
                
                (profile.offset > 0 ? Color.green : Color("Color"))
                    .opacity(profile.offset != 0 ? 0.7 : 0)
                
                HStack{
                    
                    if profile.offset < 0{
                        
                        Spacer()
                    }
                    
                    Text(profile.offset == 0 ? "" : (profile.offset > 0 ? "Like" : "Dislike"))
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 25)
                        .padding(.horizontal)
                    
                    if profile.offset > 0 {
                        
                        Spacer()
                    }
                }
            })

            LinearGradient(gradient: .init(colors: [Color.black.opacity(0),Color.black.opacity(0.4)]), startPoint: .center, endPoint: .bottom)
            
            VStack(spacing: 20){
                
                HStack{
                    
                    VStack(alignment: .leading,spacing: 12){
                        
                        Text(profile.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(profile.description)
                            .fontWeight(.thin)
                    }
                    .foregroundColor(.white)
                    
                    Spacer(minLength: 0)
                }
                
                HStack(spacing: 35){
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        
                        withAnimation(Animation.easeIn(duration: 0.8)){
                            
                            self.profile.offset = -500
                        }
                        
                    }, label: {
                        
                        Image(systemName: "xmark")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.all,20)
                            .background(Color("Color"))
                            .clipShape(Circle())
                    })
                    
                    Button(action: {
                        
                        withAnimation(Animation.easeIn(duration: 0.8)){
                            
                            self.profile.offset = 500
                        }
                        
                    }, label: {
                        
                        Image(systemName: "heart")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            .padding(.all,20)
                            .background(Color.red)
                            .clipShape(Circle())
                    })
                    
                    Button(action: {
                        
                        withAnimation(Animation.easeIn(duration: 0.8)){
                            
                            self.profile.offset = -500
                        }
                        
                    }, label: {
                        
                        Image(systemName: "checkmark")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.all,20)
                            .background(Color.green)
                            .clipShape(Circle())
                    })
                    
                    Spacer(minLength: 0)
                }
            }
            .padding(.all)
        })
        .cornerRadius(20)
        .offset(x: profile.offset)
        .rotationEffect(.init(degrees: profile.offset == 0 ? 0 : (profile.offset > 0 ? 12 : -12)))
        .gesture(
        
            DragGesture()
                .onChanged({ (value) in
                    
                    withAnimation(.default){
                    
                        self.profile.offset = value.translation.width
                    }
                })
                .onEnded({ (value) in
                    
                    withAnimation(.easeIn){
                    
                        if self.profile.offset > 150{
                            
                            self.profile.offset = 500
                        }
                        else if self.profile.offset < -150{
                            
                            self.profile.offset = -500
                        }
                        else{
                            
                            self.profile.offset = 0
                        }
                    }
                })
        )
    }
}

struct Profile : Identifiable {
    
    var id : Int
    var name : String
    var image : String
    var description : String
    var offset : CGFloat
}

