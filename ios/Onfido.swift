import Foundation
import Onfido

@objc(Onfido)
class Onfido: NSObject {
  @objc func startSDK(_ token: String,
                      applicantId: String,
                      countryId: String,
                      resolver resolve: @escaping RCTResponseSenderBlock,
                      rejecter reject: @escaping RCTResponseSenderBlock) -> Void {
    DispatchQueue.main.async {
      self.run(withToken: token,  andApplicantId: applicantId, andCountryCode: countryId, resolver: resolve, rejecter: reject)
    }
  }
  
  private func run(withToken token: String,
                   andApplicantId id: String,
                   andCountryCode countryId: String,
                   resolver resolve: @escaping RCTResponseSenderBlock,
                   rejecter reject: @escaping RCTResponseSenderBlock) {

    let appearance = Appearance(
      primaryColor: colorWithHexString(hexString: "#FF6B00"),
      primaryTitleColor: colorWithHexString(hexString: "#FFFFFF"),
      primaryBackgroundPressedColor: colorWithHexString(hexString: "#111222"),
      secondaryBackgroundPressedColor:colorWithHexString(hexString: "#333444")
    )

    let onfidoConfig = try! OnfidoConfig.builder()
      .withToken(token)
      .withApplicantId(id) 
      .withAppearance(appearance)
      .withDocumentStep(ofType: .nationalIdentityCard, andCountryCode: countryId)
      .withFaceStep(ofVariant: .video(withConfiguration: nil))
      .withCustomLocalization()
      .build()
       
    let onfidoFlow = OnfidoFlow(withConfiguration: onfidoConfig)
      .with(responseHandler: { [weak self] response in
        switch response {
        case let .error(error):
          self?.dismiss()
          reject([error.localizedDescription])
        case .success(_):
          self?.dismiss()
          resolve([id])
        case .cancel:
          reject(["USER_LEFT_ACTIVITY"])
          self?.dismiss()
        }
      })
    
    do {
      let onfidoRun = try onfidoFlow.run()
      onfidoRun.modalPresentationStyle = .fullScreen
      UIApplication.shared.windows.first?.rootViewController?.present(onfidoRun, animated: true)
    } catch {
      // iOS simulator does not work because of camera
      showAlert(message: "Couldn't start Onfido flow...(iOS Simultor does not work)")
    }
  }
  
  private func showAlert(message: String) {
    let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default) { [weak self] action in
      self?.dismiss()
    }
    alert.addAction(action)
    if let vc = UIApplication.shared.windows.first?.rootViewController?.presentedViewController {
      vc.present(alert, animated: true)
    } else if let vc = UIApplication.shared.windows.first?.rootViewController {
      vc.present(alert, animated: true)
    }
  }
  
  private func dismiss() {
    UIApplication.shared.windows.first?.rootViewController?.presentedViewController?.dismiss(animated: true)
  }

  func colorWithHexString(hexString: String, alpha:CGFloat = 1.0) -> UIColor {
      let hexint = Int(self.intFromHexString(hexStr: hexString))
      let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
      let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
      let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
      let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
      return color
  }

  func intFromHexString(hexStr: String) -> UInt32 {
      var hexInt: UInt32 = 0
      let scanner: Scanner = Scanner(string: hexStr)
      scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
      scanner.scanHexInt32(&hexInt)
      return hexInt
  }
}