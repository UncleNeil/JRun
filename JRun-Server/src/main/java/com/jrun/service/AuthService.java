package com.jrun.service;

import com.jrun.dto.LoginRequest;
import com.jrun.dto.LoginResponse;
import com.jrun.dto.RegisterRequest;
import com.jrun.dto.RegisterResponse;
import com.jrun.entity.User;
import com.jrun.repository.UserRepository;
import com.jrun.util.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class AuthService {

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private JwtUtil jwtUtil;

    public ResponseEntity<?> login(LoginRequest loginRequest) {
        try {
            // 验证用户凭据
            Authentication authentication = authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(
                            loginRequest.getUsername(),
                            loginRequest.getPassword()
                    )
            );

            SecurityContextHolder.getContext().setAuthentication(authentication);

            // 获取用户信息
            User user = userRepository.findByUsername(loginRequest.getUsername())
                    .orElseThrow(() -> new RuntimeException("用户不存在"));

            // 生成 JWT token
            String token = jwtUtil.generateToken(user.getUsername(), user.getRole().name());
            String refreshToken = jwtUtil.generateToken(user.getUsername(), user.getRole().name()); // 实际应用中应使用专门的刷新token机制

            LoginResponse response = new LoginResponse(
                    token,
                    refreshToken,
                    user.getId(),
                    user.getUsername(),
                    user.getRole().name()
            );

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("用户名或密码错误");
        }
    }

    public ResponseEntity<?> register(RegisterRequest registerRequest) {
        // 检查用户名是否已存在
        if (userRepository.existsByUsername(registerRequest.getUsername())) {
            return ResponseEntity.badRequest().body("用户名已存在");
        }

        // 检查邮箱是否已存在
        if (userRepository.existsByEmail(registerRequest.getEmail())) {
            return ResponseEntity.badRequest().body("邮箱已被注册");
        }

        // 创建新用户
        User user = new User();
        user.setUsername(registerRequest.getUsername());
        user.setEmail(registerRequest.getEmail());
        user.setPassword(passwordEncoder.encode(registerRequest.getPassword()));
        user.setNickname(registerRequest.getNickname());
        user.setRole(User.Role.TESTER); // 默认为测试工程师角色

        User savedUser = userRepository.save(user);

        RegisterResponse response = new RegisterResponse(
                savedUser.getId(),
                savedUser.getUsername(),
                savedUser.getEmail(),
                savedUser.getNickname(),
                "注册成功"
        );

        return ResponseEntity.ok(response);
    }
}