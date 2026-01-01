<template>
  <div class="min-h-screen bg-background font-sans">
    <!-- 顶部导航栏 -->
    <nav class="bg-card border-b border-border">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between items-center h-16">
          <div class="flex items-center">
            <div class="flex-shrink-0 flex items-center">
              <h1 class="text-xl font-bold text-foreground">JRun 平台</h1>
            </div>
            <div class="hidden md:ml-6 md:flex md:space-x-8">
              <a href="#" class="border-b-2 border-indigo-600 text-foreground inline-flex items-center px-1 pt-1 text-sm font-medium">
                仪表板
              </a>
              <a href="#" class="text-muted-foreground hover:text-foreground inline-flex items-center px-1 pt-1 border-b-2 border-transparent text-sm font-medium">
                项目管理
              </a>
              <a href="#" class="text-muted-foreground hover:text-foreground inline-flex items-center px-1 pt-1 border-b-2 border-transparent text-sm font-medium">
                用例管理
              </a>
              <a href="#" class="text-muted-foreground hover:text-foreground inline-flex items-center px-1 pt-1 border-b-2 border-transparent text-sm font-medium">
                报告
              </a>
            </div>
          </div>
          <div class="flex items-center">
            <div class="flex items-center space-x-4">
              <span class="text-foreground">欢迎, {{ user.username }}</span>
              <Button 
                @click="handleLogout" 
                variant="destructive"
                size="sm"
              >
                退出登录
              </Button>
            </div>
          </div>
        </div>
      </div>
    </nav>

    <!-- 主要内容区域 -->
    <div class="py-6">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <Card class="p-6">
          <h2 class="text-2xl font-semibold mb-4 text-foreground">欢迎使用 JRun 自动化测试平台</h2>
          <p class="text-muted-foreground">
            您当前的角色是: <span class="font-semibold text-indigo-600">{{ user.role || '未设置' }}</span>
          </p>
          
          <div class="grid grid-cols-1 md:grid-cols-3 gap-6 pt-6">
            <Card class="p-6">
              <h3 class="text-2xl font-semibold text-foreground mb-2">项目管理</h3>
              <p class="text-muted-foreground mb-4">创建和管理自动化测试项目</p>
              <div class="flex justify-end">
                <Button variant="default">
                  立即开始
                </Button>
              </div>
            </Card>
            
            <Card class="p-6">
              <h3 class="text-2xl font-semibold text-foreground mb-2">用例管理</h3>
              <p class="text-muted-foreground mb-4">编写和执行自动化测试用例</p>
              <div class="flex justify-end">
                <Button variant="default">
                  立即开始
                </Button>
              </div>
            </Card>
            
            <Card class="p-6">
              <h3 class="text-2xl font-semibold text-foreground mb-2">报告分析</h3>
              <p class="text-muted-foreground mb-4">查看和分析测试执行报告</p>
              <div class="flex justify-end">
                <Button variant="default">
                  立即开始
                </Button>
              </div>
            </Card>
          </div>
        </Card>
      </div>
    </div>
  </div>
</template>

<script>
import { useThemeStore } from '@/stores/theme'
import { Button, Card, Label } from '@/components/ui'

export default {
  name: 'Dashboard',
  data() {
    return {
      user: {
        username: '',
        role: ''
      },
      themeStore: useThemeStore(),
      showThemeMenu: false
    }
  },
  methods: {
    handleLogout() {
      // 清除本地存储的 token 和用户信息
      localStorage.removeItem('token')
      localStorage.removeItem('user')
      
      // 重定向到登录页
      this.$router.push('/login')
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
    // 从 localStorage 获取用户信息
    const userStr = localStorage.getItem('user')
    if (userStr) {
      this.user = JSON.parse(userStr)
    } else {
      // 如果没有用户信息，重定向到登录页
      this.$router.push('/login')
    }
    document.addEventListener('click', this.handleClickOutside)
  },
  beforeUnmount() {
    document.removeEventListener('click', this.handleClickOutside)
  }
}
</script>