--[[
Title: TipsWindow
Author(s): Shangzhi
Date: 2017/11/24
Desc:
]]
local Window = commonlib.gettable("System.Windows.Window")
local MainWindow = commonlib.gettable("AppLauncher.MainWindow")

local TipsWindow = commonlib.gettable("AppLauncher.TipsWindow")

function TipsWindow.OnInit()
    TipsWindow.page = document:GetPageCtrl()
end

function TipsWindow.ShowPage()
    local window = Window:new();
    url = "script/AppLauncher/main/TipsWindow.html";
	window:Show({
		url = url,
		alignment = "_ct", left = -250, top = -154.5, width = 500, height = 309,
	});

    TipsWindow.window = window

    TipsWindow.ShowTips()
end

function TipsWindow.ShowTips()
    if TipsWindow.page then
        local node = MainWindow.GetSelectedNode()
        if node then
            local id = node.id
            local a = MainWindow.CreateOrGetAssetsManager(id)
            local cur_version = a:getCurVersion()
            local latest_version = a:getLatestVersion()

            local s = string.format("新版本v%s已经提供下载，你目前的版本是v%s，现在需要更新吗？", cur_version, latest_version)
            TipsWindow.page:SetValue("tips_txt", s)
        end
    end
end

function TipsWindow.OnJump()
    local node = MainWindow.GetSelectedNode()
    if node then
        MainWindow.OpenApp(node.id)
    else
        LOG.std(nil, "debug", "AppLauncher", "TipsWindow.OnJump() failed. Can not get the selected node.")
    end
end

function TipsWindow.OnUpdate()
    MainWindow.OnUpdate()

    TipsWindow.window:CloseWindow(true)
    TipsWindow.window = nil
end
