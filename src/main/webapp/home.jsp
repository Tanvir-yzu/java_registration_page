<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.registration.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>Home Page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: {
                            50: '#f0fdf4',
                            100: '#dcfce7',
                            500: '#10b981',
                            600: '#059669',
                            700: '#047857',
                        }
                    },
                    fontFamily: {
                        sans: ['Inter', 'system-ui', '-apple-system', 'sans-serif'],
                    }
                }
            }
        }
    </script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
        }
        .gradient-bg {
            background: linear-gradient(135deg, #f0fdf4 0%, #f8fafc 100%);
        }
        .card-shadow {
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }
        .nav-link {
            position: relative;
            transition: all 0.3s ease;
        }
        .nav-link:hover {
            transform: translateY(-2px);
        }
        .nav-link.active::after {
            content: '';
            position: absolute;
            bottom: -4px;
            left: 0;
            right: 0;
            height: 2px;
            background-color: #10b981;
            border-radius: 1px;
        }
        .profile-card {
            background: linear-gradient(135deg, #ffffff 0%, #f8fafc 100%);
        }
        .btn-logout {
            transition: all 0.3s ease;
        }
        .btn-logout:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px -5px rgba(239, 68, 68, 0.3);
        }
    </style>
</head>
<body class="gradient-bg min-h-screen">
<div class="min-h-screen flex flex-col">
    <!-- 导航栏 -->
    <nav class="bg-white shadow-md">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center h-16">
                <div class="flex items-center">
                    <div class="flex-shrink-0">
                        <h1 class="text-2xl font-bold text-gray-800">
                            <span class="text-primary-600">用户</span>门户
                        </h1>
                    </div>
                    <div class="hidden md:block ml-10">
                        <div class="flex space-x-8">
                            <a href="home.jsp" class="nav-link text-gray-700 hover:text-primary-600 px-3 py-2 rounded-md text-sm font-medium active">首页</a>
                            <a href="index.jsp" class="nav-link text-gray-700 hover:text-primary-600 px-3 py-2 rounded-md text-sm font-medium">注册</a>
                            <a href="login.jsp" class="nav-link text-gray-700 hover:text-primary-600 px-3 py-2 rounded-md text-sm font-medium">登录</a>
                        </div>
                    </div>
                </div>

                <!-- 移动端菜单按钮 -->
                <div class="md:hidden">
                    <button id="mobile-menu-button" type="button" class="inline-flex items-center justify-center p-2 rounded-md text-gray-400 hover:text-gray-500 hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-inset focus:ring-primary-500">
                        <span class="sr-only">打开主菜单</span>
                        <svg class="block h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
                        </svg>
                    </button>
                </div>
            </div>
        </div>

        <!-- 移动端菜单 -->
        <div id="mobile-menu" class="md:hidden hidden">
            <div class="px-2 pt-2 pb-3 space-y-1 sm:px-3 bg-gray-50">
                <a href="home.jsp" class="block px-3 py-2 rounded-md text-base font-medium text-gray-700 hover:text-primary-600 hover:bg-gray-100 active">首页</a>
                <a href="index.jsp" class="block px-3 py-2 rounded-md text-base font-medium text-gray-700 hover:text-primary-600 hover:bg-gray-100">注册</a>
                <a href="login.jsp" class="block px-3 py-2 rounded-md text-base font-medium text-gray-700 hover:text-primary-600 hover:bg-gray-100">登录</a>
            </div>
        </div>
    </nav>

    <!-- 主内容区 -->
    <main class="flex-grow flex items-center justify-center p-4">
        <div class="max-w-4xl w-full">
            <div class="text-center mb-10">
                <h1 class="text-4xl md:text-5xl font-bold text-gray-800 mb-4">
                    欢迎来到用户门户
                </h1>
                <p class="text-gray-600 text-lg">
                    管理您的个人资料和信息
                </p>
            </div>

            <%
                User user = (User) session.getAttribute("user");
                if (user != null) {
            %>

            <!-- 用户已登录时的内容 -->
            <div class="flex flex-col lg:flex-row gap-8">
                <!-- 欢迎卡片 -->
                <div class="lg:w-2/3">
                    <div class="bg-white rounded-2xl card-shadow p-8">
                        <div class="flex items-center mb-6">
                            <div class="w-16 h-16 bg-primary-100 rounded-full flex items-center justify-center">
                                    <span class="text-2xl font-bold text-primary-700">
                                        <%= user.getName().substring(0, 1).toUpperCase() %>
                                    </span>
                            </div>
                            <div class="ml-6">
                                <h2 class="text-2xl font-bold text-gray-800">欢迎回来, <span class="text-primary-600"><%= user.getName() %></span>!</h2>
                                <p class="text-gray-600">很高兴再次见到您</p>
                            </div>
                        </div>

                        <div class="mt-8">
                            <h3 class="text-lg font-semibold text-gray-700 mb-4">今日动态</h3>
                            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                                <div class="bg-primary-50 rounded-xl p-4 border border-primary-100">
                                    <div class="text-sm text-primary-700 font-medium mb-1">个人资料</div>
                                    <div class="text-lg font-bold text-gray-800">已完善</div>
                                </div>
                                <div class="bg-blue-50 rounded-xl p-4 border border-blue-100">
                                    <div class="text-sm text-blue-700 font-medium mb-1">账户状态</div>
                                    <div class="text-lg font-bold text-gray-800">活跃</div>
                                </div>
                                <div class="bg-green-50 rounded-xl p-4 border border-green-100">
                                    <div class="text-sm text-green-700 font-medium mb-1">上次登录</div>
                                    <div class="text-lg font-bold text-gray-800">今天</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 用户资料卡片 -->
                <div class="lg:w-1/3">
                    <div class="profile-card rounded-2xl card-shadow p-8 border border-gray-100">
                        <h2 class="text-xl font-bold text-gray-800 mb-6 pb-4 border-b border-gray-200">个人资料</h2>

                        <div class="space-y-6">
                            <div>
                                <div class="text-sm text-gray-500 font-medium mb-1">姓名</div>
                                <div class="flex items-center">
                                    <svg class="w-5 h-5 text-primary-500 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                                    </svg>
                                    <span class="text-gray-800 font-medium"><%= user.getName() %></span>
                                </div>
                            </div>

                            <div>
                                <div class="text-sm text-gray-500 font-medium mb-1">邮箱</div>
                                <div class="flex items-center">
                                    <svg class="w-5 h-5 text-primary-500 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 4.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"></path>
                                    </svg>
                                    <span class="text-gray-800 font-medium"><%= user.getEmail() %></span>
                                </div>
                            </div>

                            <div>
                                <div class="text-sm text-gray-500 font-medium mb-1">电话</div>
                                <div class="flex items-center">
                                    <svg class="w-5 h-5 text-primary-500 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"></path>
                                    </svg>
                                    <span class="text-gray-800 font-medium"><%= user.getPhone() %></span>
                                </div>
                            </div>
                        </div>

                        <div class="mt-10 pt-6 border-t border-gray-200">
                            <form action="logout" method="post">
                                <button type="submit" class="btn-logout w-full py-3 px-4 bg-gradient-to-r from-red-500 to-red-600 hover:from-red-600 hover:to-red-700 text-white font-medium rounded-xl shadow-md transition duration-300 flex items-center justify-center">
                                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"></path>
                                    </svg>
                                    退出登录
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <% } else { %>

            <!-- 用户未登录时的内容 -->
            <div class="max-w-lg mx-auto">
                <div class="bg-white rounded-2xl card-shadow p-10 text-center">
                    <div class="w-20 h-20 mx-auto bg-gray-100 rounded-full flex items-center justify-center mb-6">
                        <svg class="w-10 h-10 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path>
                        </svg>
                    </div>

                    <h2 class="text-2xl font-bold text-gray-800 mb-4">您尚未登录</h2>
                    <p class="text-gray-600 mb-8">请登录以访问您的个人资料和信息。</p>

                    <div class="space-y-4">
                        <a href="login.jsp" class="block py-3 px-6 bg-gradient-to-r from-primary-500 to-primary-600 hover:from-primary-600 hover:to-primary-700 text-white font-medium rounded-xl shadow-md transition duration-300">
                            立即登录
                        </a>
                        <p class="text-gray-600 text-sm">
                            还没有账户？
                            <a href="index.jsp" class="text-primary-600 hover:text-primary-800 font-medium">立即注册</a>
                        </p>
                    </div>
                </div>
            </div>

            <% } %>
        </div>
    </main>

    <!-- 页脚 -->
    <footer class="bg-white border-t border-gray-200 mt-12">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6">
            <div class="text-center text-gray-600 text-sm">
                <p>© 2023 用户门户系统. 保留所有权利.</p>
            </div>
        </div>
    </footer>
</div>

<!-- 移动端菜单脚本 -->
<script>
    document.getElementById('mobile-menu-button').addEventListener('click', function() {
        const mobileMenu = document.getElementById('mobile-menu');
        mobileMenu.classList.toggle('hidden');
    });

    // 点击外部关闭移动菜单
    document.addEventListener('click', function(event) {
        const mobileMenu = document.getElementById('mobile-menu');
        const menuButton = document.getElementById('mobile-menu-button');

        if (!mobileMenu.contains(event.target) && !menuButton.contains(event.target)) {
            mobileMenu.classList.add('hidden');
        }
    });
</script>
</body>
</html>