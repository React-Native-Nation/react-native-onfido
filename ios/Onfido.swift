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

    let onfidoConfig = try! OnfidoConfig.builder()
      .withToken(token)
      .withWelcomeStep()
      .withDocumentStep()
      .withApplicantId(id) 
      // .withDocumentStep(ofType: .drivingLicence, andCountryCode: countryId)
      .withFaceStep(ofVariant: .video(withConfiguration: nil))
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
}