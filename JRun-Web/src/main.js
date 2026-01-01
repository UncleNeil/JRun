import { createApp } from 'vue'
import { createPinia } from 'pinia'
import App from './App.vue'
import router from './router'
import './assets/css/tailwind.css'
import { useThemeStore } from './stores/theme'

// 导入 Shadcn UI 组件
import { Button, Input, Card, Label } from './components/ui'

const app = createApp(App)

app.use(createPinia())
app.use(router)

// 注册全局组件
app.component('Button', Button)
app.component('Input', Input)
app.component('Card', Card)
app.component('Label', Label)

// 在应用挂载前初始化主题
const themeStore = useThemeStore()
themeStore.initTheme()

app.mount('#app')