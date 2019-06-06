    @available(iOS 11.0, *)
    func compressVid(videoURL: URL, timeStamp: Double, thumbnail: UIImage, caption: String) {
        // Get source video
        let videoToCompress = videoURL//any valid URL pointing device storage
        print("method called")
        // Declare destination path and remove anything exists in it
        let destinationPath = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("compressed.mp4")
        try? FileManager.default.removeItem(at: destinationPath)
        
        print(destinationPath, "74382190478321947302914789302173891742894032430912")

        // Compress
        compressh264VideoInBackground(
            videoToCompress: videoToCompress,
            destinationPath: destinationPath,
            size: nil,
            compressionTransform: .keepSame,
            compressionConfig: .defaultConfig,
            completionHandler: { [weak self] path in
                print("---------------------------")
                print("Success", path)
                print("---------------------------")
                print("Original video size:")
                
                print("---------------------------")
//                print(URL(withpa: path.absoluteString), " This is teh compressed video url")
                DispatchQueue.main.async {
                    let newUserTakenVid = InterimMediaObject(videoURL: URL(fileURLWithPath: path.path), timeStamp: timeStamp, caption: caption, thumbnail: thumbnail)
                    //                media.append(newUserTakenVid) //has been replaced by below
                    GlobalSharedData.shared.arrayOfCurrentCreateMedia.append(newUserTakenVid) //new may 11, 2019 implenetation of option 1 (realtime) global class stuff...
                    self!.numberMediaIndicatorLabel.text = "\(GlobalSharedData.shared.arrayOfCurrentCreateMedia.count)" //new impletnation of global clas may 11, 2019
                }

            },
            errorHandler: { e in
                print("---------------------------")
                print("Error: ", e)
                print("---------------------------")
        },
            cancelHandler: {
                print("---------------------------")
                print("Cancel")
                print("---------------------------")
        }
        )
        
        // To cancel compression, set cancel flag to true and wait for handler invoke
//        cancelable.cancel = true

    }
