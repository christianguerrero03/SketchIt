/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A single row to be displayed in a list of landmarks.
*/

import SwiftUI

struct TutorialRow: View {
    var tutorial: Tutorial
    var image: Image {
        ImageStore.shared.image(name: tutorial._id.videoId!)
    }

    var body: some View {
        HStack {
            image
                .resizable()
                .frame(width: 120, height: 90)
//            landmark.image
//                .resizable()
//                .frame(width: 50, height: 50)
            Text(tutorial.snippet.title)
            Spacer()

//            if landmark.isFavorite {
                Image(systemName: "star.fill")
                    .imageScale(.medium)
                    .foregroundColor(.yellow)
//            }
        }
    }
}

struct TutorialRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TutorialRow(tutorial: sample)
//            TutorialRow(tutorial: (tutorialData?.items[1])!)
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
