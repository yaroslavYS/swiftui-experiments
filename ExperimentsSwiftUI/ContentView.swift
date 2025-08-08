//
//  ContentView.swift
//  ExperimentsSwiftUI
//
//  Created by Yaroslav Skorokhid on 08.08.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoading = true
    @State private var selectedTab = 0
    private let tabs = ["Profile", "Feed", "Settings"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Tab Bar
                HStack(spacing: 0) {
                    ForEach(Array(tabs.enumerated()), id: \.element) { index, tab in
                        Button(action: { selectedTab = index }) {
                            VStack(spacing: 4) {
                                Text(tab).font(.system(size: 14, weight: .medium))
                                    .foregroundColor(selectedTab == index ? .blue : .secondary)
                                Rectangle().frame(height: 2).foregroundColor(selectedTab == index ? .blue : .clear)
                            }
                        }.frame(maxWidth: .infinity)
                    }
                }.padding(.horizontal).padding(.top, 8)
                
                // Content
                TabView(selection: $selectedTab) {
                    ProfileView(isLoading: isLoading).tag(0)
                    FeedView(isLoading: isLoading).tag(1)
                    SettingsView(isLoading: isLoading).tag(2)
                }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                // Controls
                VStack(spacing: 12) {
                    HStack {
                        Button(action: { isLoading.toggle() }) {
                            HStack {
                                Image(systemName: isLoading ? "pause.fill" : "play.fill")
                                Text(isLoading ? "Stop Loading" : "Start Loading")
                            }.foregroundColor(.white).padding(.horizontal, 20).padding(.vertical, 10)
                                .background(Color.blue).cornerRadius(8)
                        }
                        Spacer()
                        Text("Skeleton Loading Demo").font(.caption).foregroundColor(.secondary)
                    }
                    if isLoading {
                        HStack {
                            Text("Loading...").font(.caption).foregroundColor(.secondary)
                            Spacer()
                            ProgressView().scaleEffect(0.8)
                        }
                    }
                }.padding().background(Color(.systemBackground)).shadow(radius: 1, y: -1)
            }.navigationTitle("Skeleton Loading").navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ProfileView: View {
    let isLoading: Bool
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(spacing: 16) {
                    Circle().frame(width: 100, height: 100).skeleton(Circle(), isLoading: isLoading)
                    VStack(spacing: 8) {
                        SkeletonText(width: 200, height: 24, isLoading: isLoading)
                        SkeletonText(width: 300, height: 16, isLoading: isLoading)
                        SkeletonText(width: 250, height: 16, isLoading: isLoading)
                    }
                    HStack(spacing: 40) {
                        ForEach(0..<3, id: \.self) { _ in
                            VStack(spacing: 4) {
                                SkeletonText(width: 60, height: 20, isLoading: isLoading)
                                SkeletonText(width: 40, height: 14, isLoading: isLoading)
                            }
                        }
                    }
                }.padding().background(Color(.systemGray6)).cornerRadius(12)
                
                VStack(alignment: .leading, spacing: 12) {
                    SkeletonText(width: 150, height: 20, isLoading: isLoading)
                    ForEach(0..<3, id: \.self) { _ in
                        HStack(spacing: 12) {
                            RoundedRectangle(cornerRadius: 6).frame(width: 50, height: 50).skeleton(isLoading: isLoading)
                            VStack(alignment: .leading, spacing: 6) {
                                SkeletonText(width: 200, height: 16, isLoading: isLoading)
                                SkeletonText(width: 150, height: 14, isLoading: isLoading)
                            }
                            Spacer()
                        }
                    }
                }.padding().background(Color(.systemGray6)).cornerRadius(12)
            }.padding()
        }
    }
}

struct FeedView: View {
    let isLoading: Bool
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(0..<5, id: \.self) { _ in
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 12) {
                            Circle().frame(width: 40, height: 40).skeleton(Circle(), isLoading: isLoading)
                            VStack(alignment: .leading, spacing: 4) {
                                SkeletonText(width: 120, height: 16, isLoading: isLoading)
                                SkeletonText(width: 80, height: 12, isLoading: isLoading)
                            }
                            Spacer()
                            RoundedRectangle(cornerRadius: 4).frame(width: 20, height: 20).skeleton(isLoading: isLoading)
                        }
                        VStack(alignment: .leading, spacing: 8) {
                            SkeletonText(width: nil, height: 16, isLoading: isLoading)
                            SkeletonText(width: 280, height: 16, isLoading: isLoading)
                            SkeletonText(width: 200, height: 16, isLoading: isLoading)
                        }
                        RoundedRectangle(cornerRadius: 8).frame(height: 200).skeleton(isLoading: isLoading)
                        HStack(spacing: 20) {
                            ForEach(0..<2, id: \.self) { _ in
                                HStack(spacing: 6) {
                                    RoundedRectangle(cornerRadius: 4).frame(width: 16, height: 16).skeleton(isLoading: isLoading)
                                    SkeletonText(width: 30, height: 14, isLoading: isLoading)
                                }
                            }
                            Spacer()
                            RoundedRectangle(cornerRadius: 4).frame(width: 16, height: 16).skeleton(isLoading: isLoading)
                        }
                    }.padding().background(Color(.systemGray6)).cornerRadius(12)
                }
            }.padding()
        }
    }
}

struct SettingsView: View {
    let isLoading: Bool
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(0..<3, id: \.self) { _ in
                    VStack(alignment: .leading, spacing: 12) {
                        SkeletonText(width: 120, height: 18, isLoading: isLoading)
                        VStack(spacing: 0) {
                            ForEach(0..<3, id: \.self) { itemIndex in
                                HStack(spacing: 12) {
                                    RoundedRectangle(cornerRadius: 4).frame(width: 24, height: 24).skeleton(isLoading: isLoading)
                                    VStack(alignment: .leading, spacing: 4) {
                                        SkeletonText(width: 150, height: 16, isLoading: isLoading)
                                        SkeletonText(width: 100, height: 12, isLoading: isLoading)
                                    }
                                    Spacer()
                                    if itemIndex == 0 {
                                        RoundedRectangle(cornerRadius: 12).frame(width: 44, height: 24).skeleton(isLoading: isLoading)
                                    } else {
                                        RoundedRectangle(cornerRadius: 4).frame(width: 16, height: 16).skeleton(isLoading: isLoading)
                                    }
                                }.padding(.vertical, 12).padding(.horizontal, 16)
                                if itemIndex < 2 { Divider().padding(.leading, 52) }
                            }
                        }.background(Color(.systemGray6)).cornerRadius(12)
                    }
                }
                VStack(alignment: .leading, spacing: 12) {
                    SkeletonText(width: 150, height: 18, isLoading: isLoading)
                    HStack(spacing: 20) {
                        Capsule().frame(width: 80, height: 40).skeleton(Capsule(), isLoading: isLoading)
                        Ellipse().frame(width: 60, height: 40).skeleton(Ellipse(), isLoading: isLoading)
                        RoundedRectangle(cornerRadius: 20).frame(width: 100, height: 40).skeleton(RoundedRectangle(cornerRadius: 20), isLoading: isLoading)
                        Spacer()
                    }
                }.padding().background(Color(.systemGray6)).cornerRadius(12)
            }.padding()
        }
    }
}

struct SkeletonText: View {
    let width: CGFloat?
    let height: CGFloat
    let isLoading: Bool
    var body: some View {
        RoundedRectangle(cornerRadius: 4).frame(height: height).frame(maxWidth: width).skeleton(isLoading: isLoading)
    }
}

#Preview { ContentView() }
