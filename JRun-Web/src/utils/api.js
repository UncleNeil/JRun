import axios from 'axios'

// 创建 axios 实例
const api = axios.create({
  baseURL: '/api', // 使用代理
  timeout: 10000,
})

// 请求拦截器
api.interceptors.request.use(
  config => {
    // 从 localStorage 获取 token
    const token = localStorage.getItem('token')
    if (token) {
      config.headers.Authorization = `Bearer ${token}`
    }
    return config
  },
  error => {
    return Promise.reject(error)
  }
)

// 响应拦截器
api.interceptors.response.use(
  response => {
    return response
  },
  error => {
    // 处理 401 错误（未授权）
    if (error.response && error.response.status === 401) {
      // 清除本地存储的 token 和用户信息
      localStorage.removeItem('token')
      localStorage.removeItem('user')
      // 重定向到登录页
      window.location.href = '/#/login'
    }
    return Promise.reject(error)
  }
)

export default api