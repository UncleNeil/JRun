<template>
  <div class="min-h-screen flex flex-col bg-background font-sans">
    <!-- 登录表单居中 -->
    <div class="flex-grow flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8">
      <Card class="w-full max-w-md p-6">
        <div class="text-center mb-6">
          <h2 class="text-4xl font-bold tracking-tight text-foreground">
            JRun 自动化测试平台
          </h2>
          <p class="mt-2 text-sm text-muted-foreground">
            请登录您的账户
          </p>
        </div>
        
        <form @submit.prevent="handleLogin">
          <div class="space-y-4">
            <div>
              <Label for="username" class="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70 mb-2 block">
                用户名
              </Label>
              <Input
                id="username"
                name="username"
                type="text"
                autocomplete="username"
                required
                v-model="loginForm.username"
                class="w-full"
                placeholder="请输入用户名"
              />
            </div>
            <div>
              <Label for="password" class="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70 mb-2 block">
                密码
              </Label>
              <Input
                id="password"
                name="password"
                type="password"
                autocomplete="current-password"
                required
                v-model="loginForm.password"
                class="w-full"
                placeholder="请输入密码"
              />
            </div>
          </div>

          <div class="flex items-center justify-between mt-4">
            <div class="flex items-center space-x-2">
              <input
                id="remember-me"
                name="remember-me"
                type="checkbox"
                class="h-4 w-4 rounded border-input text-indigo-600 focus:ring-indigo-600"
              />
              <label for="remember-me" class="text-sm text-foreground">
                记住我
              </label>
            </div>

            <div class="text-sm">
              <a href="#" class="font-medium text-indigo-600 hover:text-indigo-500">
                忘记密码？
              </a>
            </div>
          </div>

          <Button
            type="submit"
            variant="default"
            class="w-full mt-6 h-10 px-4 py-2"
            :disabled="loading"
          >
            <span v-if="loading" class="flex items-center justify-center">
              <svg class="animate-spin -ml-1 mr-2 h-4 w-4 text-current" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
              </svg>
              登录中...
            </span>
            <span v-else>登录</span>
          </Button>
          
          <div class="text-center mt-4">
            <p class="text-sm text-muted-foreground">还没有账户？</p>
            <router-link to="/register" class="text-sm font-medium text-indigo-600 hover:text-indigo-500">
              立即注册
            </router-link>
          </div>
        </form>
        
        <!-- 错误消息 -->
        <div v-if="error" class="mt-4 rounded-md bg-rose-50 p-4 border border-rose-200">
          <div class="flex">
            <div class="flex-shrink-0">
              <svg class="h-5 w-5 text-rose-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd" />
              </svg>
            </div>
            <div class="ml-3">
              <h3 class="text-sm font-medium text-rose-800">
                {{ error }}
              </h3>
            </div>
          </div>
        </div>
      </Card>
    </div>
  </div>
</template>

<script>
import api from '@/utils/api'
import { useThemeStore } from '@/stores/theme'
import { Button, Input, Card, Label } from '@/components/ui'

export default {
  name: 'Login',
  data() {
    return {
      loginForm: {
        username: '',
        password: ''
      },
      loading: false,
      error: '',
      themeStore: useThemeStore(),
      showThemeMenu: false
    }
  },
  methods: {
    async handleLogin() {
      this.loading = true
      this.error = ''
      
      // 前端验证
      if (!this.loginForm.username.trim()) {
        this.error = '请输入用户名'
        this.loading = false
        return
      }
      
      if (this.loginForm.username.trim().length < 3) {
        this.error = '用户名长度不能少于3个字符'
        this.loading = false
        return
      }
      
      if (!this.loginForm.password.trim()) {
        this.error = '请输入密码'
        this.loading = false
        return
      }
      
      if (this.loginForm.password.trim().length < 6) {
        this.error = '密码长度不能少于6个字符'
        this.loading = false
        return
      }
      
      try {
        const response = await api.post('/auth/login', this.loginForm)
        
        if (response.data && response.data.token) {
          // 存储 token 到 localStorage
          localStorage.setItem('token', response.data.token)
          localStorage.setItem('user', JSON.stringify({
            id: response.data.userId || '',
            username: response.data.username || '',
            role: response.data.role || ''
          }))
          
          // 跳转到仪表板
          this.$router.push('/dashboard')
        } else {
          this.error = '登录失败，请重试'
        }
      } catch (error) {
        console.error('Login error:', error)
        this.error = error.response?.data?.message || error.response?.data || error.message || '登录失败，请重试'
      } finally {
        this.loading = false
      }
    },
    changeTheme(theme) {
      this.themeStore.setTheme(theme)
      this.showThemeMenu = false
    },
    
    toggleThemeMenu() {
      this.showThemeMenu = !this.showThemeMenu
    },
    
    // 点击外部关闭主题菜单
    handleClickOutside(event) {
      const themeButton = this.$el.querySelector('button[aria-label="切换主题"]')
      const themeMenu = this.$el.querySelector('.absolute')
      
      if (themeButton && themeMenu && !themeButton.contains(event.target) && !themeMenu.contains(event.target)) {
        this.showThemeMenu = false
      }
    }
  },
  mounted() {
    document.addEventListener('click', this.handleClickOutside)
  },
  beforeUnmount() {
    document.removeEventListener('click', this.handleClickOutside)
  }
}
</script>