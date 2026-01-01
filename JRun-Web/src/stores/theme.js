import { defineStore } from 'pinia'

export const useThemeStore = defineStore('theme', {
  state: () => ({
    currentTheme: 'light',
    availableThemes: [
      { name: 'light', label: '浅色' },
      { name: 'dark', label: '深色' },
      { name: 'system', label: '跟随系统' }
    ]
  }),
  
  getters: {
    getCurrentTheme: (state) => state.currentTheme
  },
  
  actions: {
    setTheme(theme) {
      this.currentTheme = theme
      localStorage.setItem('theme', theme)
      
      // 应用主题到文档
      this.applyTheme(theme)
    },
    
    applyTheme(theme) {
      const html = document.documentElement
      
      if (theme === 'dark') {
        html.classList.add('dark')
      } else {
        html.classList.remove('dark')
      }
    },
    
    initTheme() {
      // 从本地存储获取主题设置
      const savedTheme = localStorage.getItem('theme') || 'light'
      this.setTheme(savedTheme)
    }
  }
})