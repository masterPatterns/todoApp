package com.project.todo.service;

import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.project.todo.repository.UserRepository;
import com.project.todo.vo.UserVo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class UserService {

	@Autowired
	private UserRepository userRepository;

	public UserVo create(final UserVo userVo) {
		if(userVo == null || userVo.getEmail() == null ) {
			throw new RuntimeException("Invalid arguments");
		}
		final String email = userVo.getEmail();
		if(userRepository.existsByEmail(email)) {
			log.warn("Email already exists {}", email);
			throw new RuntimeException("Email already exists");
		}

		return userRepository.save(userVo);
	}

//	public UserVo getByCredentials(final String email, final String password, final PasswordEncoder encoder) {
	public UserVo getByCredentials(final String email, final String password) {
		final UserVo originalUser = userRepository.findByEmail(email);

		// matches 메서드를 이용해 패스워드가 같은지 확인
		if(originalUser != null && password.matches(originalUser.getPassword())) {
			return originalUser;
		}
		return null;
	}
}
