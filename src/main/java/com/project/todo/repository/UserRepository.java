package com.project.todo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.project.todo.vo.UserVo;

@Repository
public interface UserRepository extends JpaRepository<UserVo, String> {

	UserVo findByEmail(String email);
	Boolean existsByEmail(String email);
	UserVo findByEmailAndPassword(String email, String password);

}
