-- 1. 配置文件是一个 Lua 表，两个连字符之后的是注释。
-- 2. { key1 = value1, key2 = value2, ... } 是字典，如果 Key 中有特殊字符可使用
--    { ['key name'] = value, ... } 这种格式，`config.language_colors` 里有例子。
-- 3. { value1, value2, ... } 是数组。
-- 4. 大部分输出到页面上的值都可以用 HTML，但是要注意需要转义的字符，尤其是尖括号 `<>`。
-- 5. 如需输入多行字符串，将引号改为 [[ ]]，可参考 `config.comments` 的例子。

local config = {
    -- 格式如 http://your-domain.com，用于生成网址二维码
    base_url = 'https://pigeons.icu',
    -- 头像，填写 HTML 代码，正方形图片，不要限制宽高
    avatar = '<img src="https://cdn.luogu.com.cn/upload/image_hosting/wm0jwzsg.png">',

    -- 是否输出热力日历
    is_heatmap_on = true,
    -- 是否开启抖动特效
    is_shake_on = false,
    -- 是否显示 TODO 徽章
    is_todo_badge_on = true,

    -- 首页边栏
    user_details = {
        fullname = 'Caviar X',
        username = 'Caviar-X',
        description = '喵',
        followers = '0',
        following = '0',
        stars = '0',
        organization = '喵喵喵幼儿园',
        location = '地球',
        website = 'https://pigeons.icu',
    },

    -- 页面上方的三对按钮
    repo_actions = {
        {
            icon = '<span class="octicon-eye"></span>',
            title = 'Watch',
            total = '1',
        },
        {
            icon = '<span class="octicon-star"></span>',
            title = 'Star',
            total = '10',
        },
        {
            icon = '<span class="octicon-repo_forked"></span>',
            title = 'Fork',
            total = '1',
        },
    },

    -- 页面上方导航
    repo_navigator = {
       {
           icon = '<span class="octicon-code"></span>',
           title = 'Code',
           total = '',
            url = '/',
        },
        {
            icon = '<span class="octicon-issue_opened"></span>',
            title = 'Issues',
            total = '',
            url = '#',
        },
        {
            icon = '<span class="octicon-git_pull_request"></span>',
            title = 'Pull requests',
            total = '',
            url = '#',
        },
        {
            icon = '<span class="octicon-play"></span>',
            title = 'Actions',
            total = '',
            url = '#',
        },
        {
            icon = '<span class="octicon-project"></span>',
            title = 'Projects',
            total = '',
            url = '#',
        },
       {
           icon = '<span class="octicon-book"></span>',
           title = 'Wiki',
          total = '',
           url = '#',
       },
       {
           icon = '<span class="octicon-shield"></span>',
           title = 'Security',
           total = '',
           url = '#',
       },
       {
           icon = '<span class="octicon-graph"></span>',
           title = 'Insights',
           total = '',
           url = '#',
       },
    },

    -- 首页上方置顶区域
    pinned_repositories = {
        -- 如果需要，取消下面的注释并填写相应的值，其中 language 不能用 HTML。
        -- {
        --     title = '',
        --     url = '#',
        --     description = '',
        --     language = '',
        --     stars = '',
        --     forks = '',
        -- },
    },

    -- “移动浏览”旁边的按钮，目前只支持设置一个 primary 按钮
    file_actions = {
--         primary = {
--             title = '<span class="octicon-download"></span> <strong>Clone</strong> <span class="dropdown-caret"></span>',
--             url = '#',
--         },
    },

    -- 加载第三方评论代码
    comments = [[
--         <script src='//unpkg.com/valine/dist/Valine.min.js'></script>
--         <div id="vcomments"></div>
--         <script>
--             new Valine({
--                 el: '#vcomments',
--                 appId: 'JY7Qq5IQLUQyjIuqFDMmBfby-MdYXbMMI',
--                 appKey: 'PCWGEPbBHPqsMqelqqhU9v68',
--                 path: document.location.pathname,
--             })
--         </script>
    ]],

    -- 自定义 HTML <head> 的内容
    html_head = [[]],

    -- 页面底部自定义 HTML
    footer = [[]],

    -- 为 language 指定颜色
    language_colors = {
        ['ASP.NET'] = '#9400ff',
        AutoHotkey = '#6594b9',
        AutoIt = '#1C3552',
        C = '#555555',
        ['C#'] = '#178600',
        ['C++'] = '#f34b7d',
        CoffeeScript = '#244776',
        ['Common Lisp'] = '#3fb68b',
        CSS = '#563d7c',
        Dart = '#00B4AB',
        ['Emacs Lisp'] = '#c065db',
        Erlang = '#B83998',
        ['F#'] = '#b845fc',
        Go = '#00ADD8',
        GraphQL = '#e10098',
        Groovy = '#e69f56',
        Haskell = '#5e5086',
        HTML = '#e34c26',
        Java = '#b07219',
        JavaScript = '#f1e05a',
        Julia = '#a270ba',
        Kotlin = '#F18E33',
        Less = '#1d365d',
        Lua = '#000080',
        Markdown = '#083fa1',
        MATLAB = '#e16737',
        Nim = '#ffc200',
        ['Objective-C'] = '#438eff',
        OCaml = '#3be133',
        Pascal = '#E3F171',
        Perl = '#0298c3',
        PHP = '#4F5D95',
        PostScript = '#da291c',
        PowerShell = '#012456',
        PureScript = '#1D222D',
        Python = '#3572A5',
        QML = '#44a51c',
        ['Qt Script'] = '#00b841',
        R = '#198CE7',
        Ruby = '#701516',
        Rust = '#dea584',
        Sass = '#a53b70',
        Scala = '#c22d40',
        SCSS = '#c6538c',
        Shell = '#89e051',
        Stylus = '#ff6347',
        SVG = '#ff9900',
        Swift = '#ffac45',
        TeX = '#3D6117',
        TypeScript = '#2b7489',
        VBA = '#867db1',
        VBScript = '#15dcdc',
        ['Vim script'] = '#199f4b',
        Vue = '#2c3e50',
        WebAssembly = '#04133b',
        YAML = '#cb171e',
    },
}

return config
