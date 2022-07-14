-- Beex Version: ≥ 0.8.0

local config = require("config")

local months = {
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
}

-- 返回 Key 的 ID，未找到返回 0。
function get_activities_id(activities, key)
    for id, acti in ipairs(activities) do
        if acti[key] then
            return id
        end
    end
    return 0
end

function in_array(arr, val)
    for _, v in pairs(arr) do
        if val ~= nil and v == val then
            return true
        end
    end
    return false
end

function has_tweet_tag(archive)
    for _, v in pairs(archive.tags) do
        if v.title == "tweet" then
            return true
        end
    end
    return false
end

--[[
    按月组织 archives。
    Key-Table 是无序的所以使用如下形式存储：

        {
            [1] = {"December 2020" = {archives}},
            [2] = {"November 2020" = {archives}},
            ...
        }

    使用 get_activities_id() 查找 ID。
]]
function archives_to_activity(archives, skip_tags)
    local activities = {}
    local last_archive
    for _, archive in pairs(archives) do
        local is_continue = false
        for _, tag in pairs(archive.tags) do
            if in_array(skip_tags, tag.title) then
                is_continue = true
                break
            end
        end
        if not is_continue then
            archive.is_tweet = has_tweet_tag(archive)

            local key
            if archive.sticky > 0 then
                key = "Pinned"
            else
                local yyyy, mm = string.match(archive.created, "(%d%d%d%d)-(%d%d)-%d%d")
                key = months[tonumber(mm)] .. " " .. yyyy
            end
            local idx = get_activities_id(activities, key)
            if idx == 0 then
                archive.show_badge = true
                table.insert(activities, {[key] = {archive}})
            else
                if last_archive.is_tweet ~= archive.is_tweet then
                    archive.show_badge = true
                else
                    archive.show_badge = false
                end
                table.insert(activities[idx][key], archive)
            end

            last_archive = archive
        end
    end
    return activities
end

function homepage(context)
    if context.ctx.current_url == "/" then
        context.theme_ctx.activities = archives_to_activity(context.archives, {})
        context.theme_ctx.pinned_repositories = config.pinned_repositories
        context.theme_ctx.language_colors = config.language_colors
    else
        context.theme_ctx.activities = {}
    end
    return context
end

function theme_context(context)
    if not context.theme_ctx then
        local base_url = config.base_url
        if string.sub(base_url, -1) == '/' then
            base_url = string.sub(base_url, 1, -2)
        end
        context.theme_ctx = {
            ['base_url'] = base_url,
            is_heatmap_on = config.is_heatmap_on,
            is_shake_on = config.is_shake_on,
            is_todo_badge_on = config.is_todo_badge_on,
            avatar = config.avatar,
            user_details = config.user_details,
            repo_actions = config.repo_actions,
            repo_navigator = config.repo_navigator,
            file_actions = config.file_actions,
            comments = config.comments,
            html_head = config.html_head,
            footer = config.footer,
        }
    end
    return context
end

beex:add_filter("gen_before_render_html", "theme_context")
beex:add_filter("gen_before_render_html", "homepage")
