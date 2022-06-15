//
//  LoginView.swift
//  IssueTracker
//
//  Created by 김동준 on 2022/06/14.
//

import SnapKit
import Then

final class LoginView: UIView {
    
    let titleLabel = UILabel().then {
        $0.text = "Issue Tracker"
        $0.font = UIFont.systemFont(ofSize: 48)
        $0.textAlignment = .center
    }
    
    let idInputBaseView = UIView().then {
        $0.backgroundColor = .white
    }
    
    let idLabel = UILabel().then {
        $0.text = "아이디"
        $0.font = UIFont.systemFont(ofSize: 18)
        $0.textAlignment = .left
    }
    
    let idTextField = UITextField().then {
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 18)
    }
    
    let grayLine = UIView().then {
        $0.backgroundColor = .gray
    }
    
    let passwordLabel = UILabel().then {
        $0.text = "비밀번호"
        $0.font = UIFont.systemFont(ofSize: 18)
        $0.textAlignment = .left
    }
    
    let passwordTextField = UITextField().then {
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 18)
    }
    
    let loginButton = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(.blue, for: .normal)
    }
    
    let signupButton = UIButton().then {
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(.blue, for: .normal)
    }
    
    lazy var githubLoginButton = UIButton().then {
        $0.setImage(UIImage(named: "githublogin"), for: .normal)
    }
    
    let appleLoginButton = UIButton().then {
        $0.setImage(UIImage(named: "applelogin"), for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("\(#function) init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        backgroundColor = .systemGray5
        
        addSubviews(titleLabel, idInputBaseView, loginButton, githubLoginButton, appleLoginButton)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(170)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
        }
        
        idInputBaseView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(75)
            make.width.equalToSuperview()
            make.height.equalTo(90)
        }
        
        idInputBaseView.addSubviews(idLabel, idTextField, grayLine, passwordLabel, passwordTextField, signupButton)
        
        idLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(70)
            make.height.equalTo(45)
        }
        
        idTextField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(idLabel.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(45)
        }
        
        grayLine.snp.makeConstraints { make in
            make.top.equalTo(idLabel.snp.bottom)
            make.width.equalTo(355)
            make.trailing.equalToSuperview()
            make.height.equalTo(0.5)
        }
    
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(grayLine.snp.bottom)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(70)
            make.height.equalTo(45)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(grayLine.snp.bottom)
            make.leading.equalTo(idLabel.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(45)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(idInputBaseView.snp.bottom).offset(32)
            make.width.equalTo(65)
            make.height.equalTo(50)
            make.leading.equalToSuperview().offset(90)
        }
        
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(idInputBaseView.snp.bottom).offset(32)
            make.width.equalTo(65)
            make.height.equalTo(50)
            make.trailing.equalToSuperview().offset(-90)
        }
        
        githubLoginButton.snp.makeConstraints { make in
            make.bottom.equalTo(appleLoginButton.snp.top).offset(-15)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(60)
        }
        
        appleLoginButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(60)
        }

    }
}
