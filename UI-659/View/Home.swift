//
//  Home.swift
//  UI-659
//
//  Created by nyannyan0328 on 2022/09/02.
//

import SwiftUI
import SceneKit


struct Home: View {
    @State var scneName : SCNScene? = .init(named: "Nike_Illusion.scn")
    @State var isVerticalLock : Bool = false
    
      @Namespace var animation
    @State var currentSize : String = "9"
    
    @GestureState var offset : CGFloat = 0
    var body: some View {
        VStack{
            
            HeaderView()
            
            CustomSceneView(sceneName: $scneName)
                .frame(height:350)
            
            
            DragView()
                .padding(.top,-15)
                .padding(.bottom,-15)
            
            
            shoeSizeView()
            
            
            
            
        }
        .padding()
    }
    @ViewBuilder
    func shoeSizeView()->some View{
        
        VStack{
            
            VStack(alignment:.leading,spacing: 10){
                
                
                  Text("Nike")
                    .font(.largeTitle.weight(.heavy))
                    .foregroundColor(.white)
                
                
                
                Text("Mens Classic Shoes")
                    .font(.title2.weight(.semibold))
                    .foregroundColor(.gray)
                
                Label {
                      Text("4.5")
                } icon: {
                    
                     Image(systemName: "star.fill")
                    
                }
                .foregroundColor(Color("Gold"))
                
            }
              .frame(maxWidth: .infinity,alignment: .leading)
            
            ScrollView(.horizontal,showsIndicators: false){
                
                HStack(spacing:10){
                    
                    
                    let size = ["9","9.5","10","10.5","11","11.5","12","12.6"]
                    
                    ForEach(size,id:\.self){size in
                        
                          Text(size)
                            .font(.title2)
                            .foregroundColor(currentSize == size ? .black : .white)
                            .padding(15)
                          
                            .background {
                                
                                ZStack{
                                    
                                    RoundedRectangle(cornerRadius: 10,style: .continuous)
                                        .fill(.white.opacity(0.3))
                                    
                                    if currentSize == size{
                                        
                                        RoundedRectangle(cornerRadius: 10,style: .continuous)
                                            .fill(.white)
                                            .matchedGeometryEffect(id: "TAB", in: animation)
                                        
                                    }
                                }
                                
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation{
                                    
                                    currentSize = size
                                }
                            }
                    }
                }
                
                
            }
            .padding(.top,20)
              .frame(maxWidth: .infinity,alignment: .leading)
            
            
            HStack(alignment:.top){
                
                
                 
                    Button {
                        
                    } label: {
                        
                        VStack{
                            
                            
                                Image("Bag")
                                    .resizable()
                                    .renderingMode(.template)
                                    .aspectRatio(contentMode: .fit)
                                 .frame(width: 45,height: 45)
                                
                                
                                  Text("199.6")
                                    .font(.title.weight(.bold))
                        }
                        .foregroundColor(.black)
                        .padding(18)
                        .background{
                         
                            
                            RoundedRectangle(cornerRadius: 20,style: .continuous)
                                .fill(.white)
                        }
                    }
                 
                    

                    
            
            
                
                VStack(alignment:.leading,spacing: 10){
                    
                 
                    Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
                        .font(.callout.weight(.semibold))
                    
                    
                    Button {
                        
                    } label: {
                        
                        Text("MoreDetails")
                           
                    }
                    .padding(.top,10)

                    
                }
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.leading,20)
                
                
                
                
                  
                
            }
            .padding(.top,30)
          
        
             
            
            
            
        }
        .padding(.top,20)
        .frame(maxWidth: .infinity,alignment: .leading)
      
        
    }
    @ViewBuilder
    func DragView()->some View{
        
        GeometryReader{_ in
            
            Rectangle()
                .stroke(
                
                    LinearGradient(colors: [
                        
                        .clear,
                        .clear,
                        .white,
                        .white,
                        .white,
                        .clear,
                        .clear
                        
                    
                    
                    
                    ], startPoint: .leading, endPoint: .trailing),style:StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round, miterLimit: 1, dash: [3], dashPhase: 1)
                
                )
                .offset(x:offset)
                .overlay {
                    
                    HStack{
                        
                        Image(systemName: "arrowtriangle.left.fill")
                        Image(systemName: "arrowtriangle.right.fill")
                    }
                    .padding(.vertical)
                    .padding(.horizontal)
                   
                    .background{
                     
                        RoundedRectangle(cornerRadius: 10,style: .continuous)
                            .fill(.ultraThinMaterial)
                    }
                    .offset(x:offset)
                    .gesture(
                    
                        DragGesture().updating($offset, body: { value, out, _ in
                            out = value.location.x - 20
                        })
                    
                    )

                }
             
            
        
                
        
         
            
            
        }
        .frame(height:2)
        .onChange(of: offset) { newValue in
        
            rotateObjcect(animate: offset == .zero)
            
        }
        .animation(.easeInOut(duration: 0.6), value: offset == .zero)
      
      
        
        
    }
    func rotateObjcect(animate : Bool = false){
        
        
        if animate{
            
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.6
        }
        
        let newValue = Float((offset * .pi) / 180)
        
        
        if isVerticalLock{
            
            scneName?.rootNode.childNode(withName: "Root", recursively: true)?.eulerAngles.x = newValue
            
        }
        else{
            
            scneName?.rootNode.childNode(withName: "Root", recursively: true)?.eulerAngles.y = newValue
        }

        
        if animate{
            
            SCNTransaction.commit()
        }
        
        
        
    }
    @ViewBuilder
    func HeaderView()->some View{
    
        HStack{
            
             Image(systemName: "arrow.left")
                .font(.callout.weight(.semibold))
                .foregroundColor(.white)
                .padding(.vertical,15)
                .padding(.horizontal,10)
                .background{
                 
                    RoundedRectangle(cornerRadius: 10,style: .continuous)
                        .fill(.gray.opacity(0.3))
                }
            
            Spacer()
            
            Button {
                
                isVerticalLock.toggle()
            } label: {
                
                 Image(systemName: "arrow.left.and.right.righttriangle.left.righttriangle.right.fill")
                    .font(.callout.weight(.semibold))
                    .foregroundColor(.white)
                    .padding(.vertical,15)
                    .padding(.horizontal,10)
                    .background{
                     
                        RoundedRectangle(cornerRadius: 10,style: .continuous)
                            .fill(.gray.opacity(0.3))
                    }
                    .rotationEffect(.init(degrees: isVerticalLock ? 0 : 90))
                
            }

        }
        
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
