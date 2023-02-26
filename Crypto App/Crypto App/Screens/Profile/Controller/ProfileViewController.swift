//
//  ProfileViewController.swift
//  Crypto App
//
//  Created by Ömer Faruk Kazar on 2.02.2023.
//

import UIKit
import FirebaseAuth

final class ProfileViewController: CAViewController {

    // MARK: - Properties
    @IBOutlet weak var ppImageView: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    private var imagePicker = UIImagePickerController() // To choose image from gallery.
    private var viewModel: ProfileViewModel
    // MARK: - Lifecycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGesture()
        viewModel.fetchUser()
        viewModel.fetchProfilePhoto()
        viewModel.dataDelegate = self
    }

    // MARK: - Init
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    /// When Sign Out Button tapped, shows an alert. if user is sure or not.
    /// If user press OK tries to sign out from FirebaseAuth and pops to root view controller.
    @IBAction private func didTapSignOutButton(_ sender: UIButton) {
        showAlert(title: "Warning",
                  message: "Are you sure to Sign Out?",
                  addCancelButton: true,
                  handler: { [weak self] (_) in
            do {
                try Auth.auth().signOut()
                self?.navigationController?.popToRootViewController(animated: true)
                UserDefaults.standard.set(false, forKey: "didSignedIn")
            } catch {
                self?.showError(error)
            }
        })
    }

    /// Creates a tap gesture and adds that to ppImageView.
    func addTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action: #selector(pickerTriggered))
        ppImageView.isUserInteractionEnabled = true
        ppImageView.addGestureRecognizer(tapGestureRecognizer)
    }

}

// MARK: - UIImagePickerControllerDelegate
extension ProfileViewController: UIImagePickerControllerDelegate,
                                 UINavigationControllerDelegate {

    /// When tap gesture is triggered, this method runs.
    /// Does some additional settings on imagePicker. Opens gallery  when run.
    @objc func pickerTriggered() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false

            present(imagePicker, animated: true, completion: nil)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        self.dismiss(animated: true) { } // After finishing picking, dismisses picker.
        // unwrap optionals
        guard let image = info[.originalImage] as? UIImage,
              let imageData = image.pngData(),
              let currentImageData = ppImageView.image?.pngData() else { return }
        // if current profile photo is not same with the new chosen one
        // tries to upload profile photo to Firebase and sets the ppImage
        if currentImageData != imageData {
            do {
                try viewModel.uploadProfilePhoto(with: imageData)
                DispatchQueue.main.async {
                    self.ppImageView.image = image
                }
            } catch {
                showAlert(title: "Upload Error", message: "Photo couldn't be upload because of unknown error.")
            }
        } else {
            showAlert(title: "Upload Error", message: "The photo you selected is same with your current profile photo.")
        }
    }

}

extension ProfileViewController: UserDataSetter {
    func didGetUserMail(mail: String) {
        DispatchQueue.main.async {
            self.emailLabel.text = "e-mail: \(mail)"
        }
    }

    func didGetUserImageData(data: Data) {
        DispatchQueue.main.async {
            self.ppImageView.image = UIImage(data: data)
        }
    }

    func didErrorOccured(error: Error) {
        DispatchQueue.main.async {
            self.showAlert(title: "Error", message: error.localizedDescription)
        }
    }
}
