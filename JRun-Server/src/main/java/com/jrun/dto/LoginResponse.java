package com.jrun.dto;

public class LoginResponse {

    private String token;
    private String refreshToken;
    private Long userId;
    private String username;
    private String role;

    // 构造函数
    public LoginResponse() {}

    public LoginResponse(String token, String refreshToken, Long userId, String username, String role) {
        this.token = token;
        this.refreshToken = refreshToken;
        this.userId = userId;
        this.username = username;
        this.role = role;
    }

    // Getter 和 Setter
    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getRefreshToken() {
        return refreshToken;
    }

    public void setRefreshToken(String refreshToken) {
        this.refreshToken = refreshToken;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
}