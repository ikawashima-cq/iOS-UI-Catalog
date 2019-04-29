//
//  AudioManager.swift
//  UI-Catalog
//
//  Created by Iichiro Kawashima on 2019/04/29.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import Foundation
import AVFoundation
import RxCocoa

class Audiomanager: NSObject {

    static let shared = Audiomanager()

    private override init() {}

    // MARK: private
    private var audioPlayer: AVAudioPlayer?
    private var finishPlaying: PublishRelay<Void>?

    func setValue(soundData: NSURL) throws {
        try self.audioPlayer = AVAudioPlayer(contentsOf: soundData as URL, fileTypeHint: nil)
        self.audioPlayer?.delegate = self
        self.audioPlayer?.prepareToPlay()
    }

    func play() {
        self.audioPlayer?.play()
        self.finishPlaying = PublishRelay<Void>()
    }

    func isPlaying() -> Bool {
        return self.audioPlayer?.isPlaying ?? false
    }

    func stop() {
        self.audioPlayer?.stop()
        self.audioPlayer = nil
    }
}

extension Audiomanager: AVAudioPlayerDelegate {
    func didFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.finishPlaying?.accept(())
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.finishPlaying?.accept(())
    }
}

