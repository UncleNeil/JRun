package com.jrun.dto;

public class RegisterResponse {

    private Long id;
    private String username;
    private String email;
    private String nickname;
    private String message;

    // 构造函数
    public RegisterResponse() {}

    public RegisterResponse(Long id, String username, String email, String nickname, String message) {
        this.id = id;
        this.username = username;
        this.email = email;
        this.nickname = nickname;
        this.message = message;
    }

    // Getter 和 Setter
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}