package com.project.todo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.project.todo.vo.TodoVo;

import java.util.List;

@Repository
public interface TodoRepository extends JpaRepository<TodoVo, String>{
	List<TodoVo> findByUserId(String userId);
}
