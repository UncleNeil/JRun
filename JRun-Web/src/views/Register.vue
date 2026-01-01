<template>
  <div class="min-h-screen flex flex-col bg-background font-sans">
    <!-- 注册表单居中 -->
    <div class="flex-grow flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8">
      <Card class="w-full max-w-md p-6">
        <div class="text-center mb-6">
          <h2 class="text-4xl font-bold tracking-tight text-foreground">
            JRun 自动化测试平台
          </h2>
          <p class="mt-2 text-sm text-muted-foreground">
            创建新账户
          </p>
        </div>
        
        <form @submit.prevent="handleRegister">
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
                v-model="registerForm.username"
                class="w-full"
                placeholder="请输入用户名"
              />
            </div>
            <div>
              <Label for="email" class="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70 mb-2 block">
                邮箱
              </Label>
              <Input
                id="email"
                name="email"
                type="email"
                autocomplete="email"
                required
                v-model="registerForm.email"
                class="w-full"
                placeholder="请输入邮箱"
              />
            </div>
            <div>
              <Label for="nickname" class="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70 mb-2 block">
                昵称
              </Label>
              <Input
                id="nickname"
                name="nickname"
                type="text"
                autocomplete="nickname"
                v-model="registerForm.nickname"
                class="w-full"
                placeholder="请输入昵称（可选）"
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
                autocomplete="new-password"
                required
                v-model="registerForm.password"
                class="w-full"
                placeholder="请输入密码"
              />
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
              注册中...
            </span>
            <span v-else>注册</span>
          </Button>
          
          <div class="text-center mt-4">
            <p class="text-sm text-muted-foreground">已有账户？</p>
            <router-link to="/login" class="text-sm font-medium text-indigo-600 hover:text-indigo-500">
              立即登录
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
        
        <!-- 成功消息 -->
        <div v-if="success" class="mt-4 rounded-md bg-emerald-50 p-4 border border-emerald-200">
          <div class="flex">
            <div class="flex-shrink-0">
              <svg class="h-5 w-5 text-emerald-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
              </svg>
            </div>
            <div class="ml-3">
              <h3 class="text-sm font-medium text-emerald-800">
                {{ success }}
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
  name: 'Register',
  data() {
    return {
      registerForm: {
        username: '',
        email: '',
        password: '',
        nickname: ''
      },
      loading: false,
      error: '',
      success: '',
      themeStore: useThemeStore(),
      showThemeMenu: false
    }
  },
  methods: {
    async handleRegister() {
      this.loading = true
      this.error = ''
      this.success = ''
      
      try {
        const response = await api.post('/auth/register', this.registerForm)
        
        if (response.data && response.data.message && response.data.message.includes('成功')) {
          this.success = response.data.message
          // 清空表单
          this.registerForm = {
            username: '',
            email: '',
            password: '',
            nickname: ''
          }
          
          // 2秒后跳转到登录页
          setTimeout(() => {
            this.$router.push('/login')
          }, 2000)
        } else {
          this.error = response.data?.message || response.data || '注册失败，请重试'
        }
      } catch (error) {
        console.error('Registration error:', error)
        this.error = error.response?.data || '注册失败，请重试'
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