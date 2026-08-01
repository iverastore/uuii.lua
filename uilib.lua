if Library and Library.Unload then
    Library.Unload()
end

local game, math, Color3, string, task, CFrame, Vector3, table, pcall =
	game, math, Color3, string, task, CFrame, Vector3, table, pcall

local GetService, GetAttribute, GetAttributes, GetPropertyChangedSignal, GetDescendants, GetChildren, WaitForChild, FindFirstChild, FindFirstChildWhichIsA, FindFirstChildOfClass, Connect, IsA =
	game.GetService, game.GetAttribute, game.GetAttributes, game.GetPropertyChangedSignal, game.GetDescendants, game.GetChildren, game.WaitForChild, game.FindFirstChild, game.FindFirstChildWhichIsA, game.FindFirstChildOfClass, game.Changed.Connect, game.IsA

local Instance_new, Font_new, TweenInfo_new, Rect_new = 
	Instance.new, Font.new, TweenInfo.new, Rect.new

local os_clock, os_date = 
	os.clock, os.date

local debug_getinfo, debug_info = 
	debug.getinfo, debug.info

local CFrame_new, CFrame_Angles, CFrame_fromOrientation = 
	CFrame.new, CFrame.Angles, CFrame.fromOrientation

local Vector2_new, Vector3_new, Vector3_zero, Vector3_one = 
	Vector2.new, Vector3.new, Vector3.zero, Vector3.one

local UDim_new, UDim2_new, UDim2_fromOffset, UDim2_fromScale = 
	UDim.new, UDim2.new, UDim2.fromOffset, UDim2.fromScale

local NumberSequence_new, NumberSequenceKeypoint_new = 
	NumberSequence.new, NumberSequenceKeypoint.new

local ColorSequence_new, ColorSequenceKeypoint_new = 
	ColorSequence.new, ColorSequenceKeypoint.new

local Color3_new, Color3_fromRGB, Color3_fromHSV, Color3_fromHex = 
	Color3.new, Color3.fromRGB, Color3.fromHSV, Color3.fromHex

local math_random, math_floor, math_clamp, math_round, math_rad, math_max, math_min, math_tan, math_ceil, math_cos, math_sin, math_deg, math_atan2, math_huge, math_pi =
	math.random, math.floor, math.clamp, math.round, math.rad, math.max, math.min, math.tan, math.ceil, math.cos, math.sin, math.deg, math.atan2, math.huge, math.pi

local coroutine_wrap, coroutine_close, coroutine_create, coroutine_resume =
	coroutine.wrap, coroutine.close, coroutine.create, coroutine.resume

local task_wait, task_spawn, task_delay, task_cancel, task_defer =
	task.wait, task.spawn, task.delay, task.cancel, task.defer

local string_format, string_match, string_sub, string_lower, string_upper, string_char, string_byte, string_find, string_gsub =
	string.format, string.match, string.sub, string.lower, string.upper, string.char, string.byte, string.find, string.gsub

local table_insert, table_remove, table_find, table_clone, table_unpack, table_clear, table_concat, table_sort =
	table.insert, table.remove, table.find, table.clone, table.unpack, table.clear, table.concat, table.sort


if not LPH_OBFUSCATED then
    LPH_ENCNUM = function(n, ...)
        assert(type(n) == "number" and #{...} == 0, "LPH_ENCNUM only accepts a single constant double or integer as an argument.")
        return n
    end
    
    LPH_ENCSTR = function(s, ...)
        assert(type(s) == "string" and #{...} == 0, "LPH_ENCSTR only accepts a single constant string as an argument.")
        return s
    end
    
    LPH_ENCFUNC = function(f, e, d, ...)
        assert(type(f) == "function" and type(e) == "string" and #{...} == 0, "LPH_ENCFUNC accepts a constant function, constant string, and string variable as arguments.")
        return f
    end
    
    LPH_JIT = function(f, ...)
        assert(type(f) == "function" and #{...} == 0, "LPH_JIT only accepts a single constant function as an argument.")
        return f
    end
    
    LPH_NO_VIRTUALIZE = function(f, ...)
        assert(type(f) == "function" and #{...} == 0, "LPH_NO_VIRTUALIZE only accepts a single constant function as an argument.")
        return f
    end
    
    LPH_NO_UPVALUES = function(f, ...)
        assert(type(setfenv) == "function", "LPH_NO_UPVALUES can only be used on Lua versions with getfenv & setfenv")
        assert(type(f) == "function" and #{...} == 0, "LPH_NO_UPVALUES only accepts a single constant function as an argument.")
        
        local env = getrenv()
        return setfenv(
            function(...) return func(...) end,
            setmetatable({
                func = f
            },
            {
                __index = env,
                __newindex = env
            })
        )
    end
    
    LPH_CRASH = function(...)
        assert(#{...} == 0, "LPH_CRASH does not accept any arguments.")

        local Message = string.format("[ERROR] | Something went wrong and there was a crash attempt! %s", debug.traceback())

        if getgenv().Library and getgenv().Library.Notify then
            getgenv().Library.Notify(getgenv().Library, {Message = Message, Delay = math_huge})
        else
            local rconsoleprint = rconsoleprint or print
            rconsoleprint(Message)
        end
    end

    LPH_JIT_MAX = LPH_JIT
end

local Service = function(Name)
    return cloneref(GetService(game, Name))
end;

getgenv().Library = {
	DrawingTypes = {"Quad", "Square", "Circle", "Text", "Line", "Triangle", "Font"},
	Connections = {},
	Errors = {},
	Objects = {},
	Drawings = {},
	Flags = {},
	Sections = {},
	Unloaded = Instance_new("BindableEvent"),
	UI = {
		UIName = "alternate.lol",
		ScriptVersion = "v.0.1",
		ScriptBuild = "beta",
		ScriptUser = "admin",
		FolderLocation = "alternate.lol",
        KeybindType = "Upper",
		ClampDragging = false,
		HoverHighlight = false,
		ScreenGui = nil,
		ExtrasScreenGui = nil,
		KeybindListUI = nil,
		ColorPickerUI = nil,
		LastCopiedColor = nil,
		SelectedKeybind = nil,
		DraggingGui = nil,
		Font = Font_new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
		InitTime = os.clock(),
		TotalKeybindModes = 0,
		TotalColorPickers = 0,
		FontSize = 12,
		MainZIndex = 10,
		SectionZIndex = 100,
		DropdownZIndex = 3,
		WatermarkRefreshRate = 0.15,
		RainbowSpeed = 0.2,
		BreatheSpeed = 1.5,
		UnnamedFlags = 0,
		RainbowHue = 0,
		BreatheValue = 0,
		TweenSpeed = 0.1,
		TweenEasingStyle = Enum.EasingStyle.Quad,
		DefaultTween = TweenInfo_new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		KeybindTexts = {},
		ListObjects = {},
		Dropdowns = {},
		ModeLists = {},
		ActiveColorPickers = {},
        ColorPickers = {},
		HoverObjects = {},
		MainWindows = {},
		RichTexts = {},
		Notifications = {},
		Keys = {
			[Enum.KeyCode.LeftShift] = "L-SHIFT",
			[Enum.KeyCode.RightShift] = "R-SHIFT",
			[Enum.KeyCode.LeftControl] = "L-CTRL",
			[Enum.KeyCode.RightControl] = "R-CTRL",
			[Enum.KeyCode.LeftAlt] = "L-ALT",
			[Enum.KeyCode.RightAlt] = "R-ALT",
			[Enum.KeyCode.CapsLock] = "CAPS",
			[Enum.KeyCode.Space] = "SPCE",
			[Enum.KeyCode.One] = "1",
			[Enum.KeyCode.Two] = "2",
			[Enum.KeyCode.Three] = "3",
			[Enum.KeyCode.Four] = "4",
			[Enum.KeyCode.Five] = "5",
			[Enum.KeyCode.Six] = "6",
			[Enum.KeyCode.Seven] = "7",
			[Enum.KeyCode.Eight] = "8",
			[Enum.KeyCode.Nine] = "9",
			[Enum.KeyCode.Zero] = "0",
			[Enum.KeyCode.KeypadOne] = "NUM1",
			[Enum.KeyCode.KeypadTwo] = "NUM2",
			[Enum.KeyCode.KeypadThree] = "NUM3",
			[Enum.KeyCode.KeypadFour] = "NUM4",
			[Enum.KeyCode.KeypadFive] = "NUM5",
			[Enum.KeyCode.KeypadSix] = "NUM6",
			[Enum.KeyCode.KeypadSeven] = "NUM7",
			[Enum.KeyCode.KeypadEight] = "NUM8",
			[Enum.KeyCode.KeypadNine] = "NUM9",
			[Enum.KeyCode.KeypadZero] = "NUM0",
			[Enum.KeyCode.Minus] = "-",
			[Enum.KeyCode.Equals] = "=",
			[Enum.KeyCode.Tilde] = "~",
			[Enum.KeyCode.LeftBracket] = "[",
			[Enum.KeyCode.RightBracket] = "]",
			[Enum.KeyCode.RightParenthesis] = ")",
			[Enum.KeyCode.LeftParenthesis] = "(",
			[Enum.KeyCode.Semicolon] = ",",
			[Enum.KeyCode.Quote] = "'",
			[Enum.KeyCode.BackSlash] = "\\",
			[Enum.KeyCode.Comma] = ",",
			[Enum.KeyCode.Period] = ".",
			[Enum.KeyCode.Slash] = "/",
			[Enum.KeyCode.Asterisk] = "*",
			[Enum.KeyCode.Plus] = "+",
			[Enum.KeyCode.Period] = ".",
			[Enum.KeyCode.Backquote] = "`",
			[Enum.UserInputType.MouseButton1] = "MB1",
			[Enum.UserInputType.MouseButton2] = "MB2",
			[Enum.UserInputType.MouseButton3] = "MMB"
		},
	},
	Theme = {
		Objects = {},
		Default = {
			Accent = Color3_fromRGB(200, 180, 255),
			SecondAccent = Color3_fromRGB(140, 120, 200),
			LightContrast = Color3_fromRGB(30, 30, 35),
			DarkContrast = Color3_fromRGB(18, 18, 22),
			Outline = Color3_fromRGB(0, 0, 0),
			TextColor = Color3_fromRGB(255, 255, 255),
			TextDark = Color3_fromRGB(160, 160, 160),
			Risky = Color3_fromRGB(251, 88, 88),
		},
		Presets = {
			Default = {1, [[{"Accent":"c4e7ff","SecondAccent":"a2bfd3","LightContrast":"16191d","DarkContrast":"101215","InnerLightContrast":"22272c","InnerDarkContrast":"1c2025","Outline":"1c2025","Highlight":"303438","TextColor":"ffffff","TextDark":"8c8c8c","ImageColor":"ffffff","ImageDark":"8c8c8c","Risky":"fb8a8a"}]]},
			Dracula = {2, [[{"Outline":"202026","Accent":"9a81b3","SecondAccent":"675276","TextColor":"b4b4b4","TextDark":"888888","LightContrast":"2a2a38","DarkContrast":"242430","InnerLightContrast":"393947","InnerDarkContrast":"2e2e3a","Highlight":"4d4d5b","Risky":"fb8a8a","ImageColor":"ffffff","ImageDark":"525062"}]]},
			Red = {3, [[{"Outline":"0f0207","Accent":"af3264","SecondAccent":"722141","TextColor":"b4b4b4","TextDark":"888888","LightContrast":"1e0610","DarkContrast":"16040c","InnerLightContrast":"32111b","InnerDarkContrast":"2b0013","Highlight":"463135","Risky":"fb8a8a","ImageColor":"ffffff","ImageDark":"5c1a35"}]]},
			Light = {4, [[{"Outline":"e6e6e6","Accent":"bb60d2","SecondAccent":"824493","TextColor":"000000","TextDark":"000000","LightContrast":"c3c3c3","DarkContrast":"d0d0d0","InnerLightContrast":"d7d7d7","InnerDarkContrast":"e3e3e3","Highlight":"ebebeb","Risky":"fb8a8a","ImageColor":"bb60d2","ImageDark":"a2a2a2"}]]},
		},
	},
}

local Players = Service("Players")
local ReplicatedStorage = Service("ReplicatedStorage")
local TweenService = Service("TweenService")
local RunService = Service("RunService")
local HttpService = Service("HttpService")
local UserInputService = Service("UserInputService")
local Workspace = Service("Workspace")
local GuiService = Service("GuiService")

local Client = Players.LocalPlayer
local Camera = FindFirstChildWhichIsA(Workspace, "Camera")
local Inset = GuiService:GetGuiInset()
local Viewport = Camera.ViewportSize
local UITable = Library.UI
local ThemeTable = Library.Theme
local ThemeDefault = ThemeTable.Default
local Flags = Library.Flags
local ScreenGui = UITable.ScreenGui
local DefaultTweenInfo = UITable.DefaultTween
local ConnectionsTable = Library.Connections
local ObjectsTable = Library.Objects
local ListObjects = UITable.ListObjects
local FolderLocation = UITable.FolderLocation
local DefaultThemes

do -- Files
    Files = {
        Fonts = {
            Loaded = {},

            ["ProggyTiny"] = {Link = "https://github.com/bluescan/proggyfonts/raw/refs/heads/master/ProggyOriginal/ProggyTiny.ttf", Size = 9 },
            ["Tahoma"] = {Link = "https://github.com/LuckyHub1/LuckyHub/raw/main/zekton_rg.ttf", Size = 12},
            ["Sword"] =  {Link = "https://github.com/LuckyHub1/LuckyHub/raw/refs/heads/main/Templehook%20(1).ttf", Size = 12},
        },
    }; do
        local Location = UITable.FolderLocation;
        Files.ConfigsPath = `{Location}\\Configs`;
        Files.ThemesPath = `{Location}\\Themes`;
        Files.FontsPath = `{Location}\\Fonts`;

        if not isfolder(Location) then
            makefolder(Location);
        end;

        if not isfolder(`{Files.ConfigsPath}`) then
            makefolder(`{Files.ConfigsPath}`);
        end;

        if not isfolder(`{Files.ConfigsPath}\\AutoloadConfig`) then
            makefolder(`{Files.ConfigsPath}\\AutoloadConfig`);
        end;

        if not isfolder(`{Files.ThemesPath}`) then
            makefolder(`{Files.ThemesPath}`);
        end;

        if not isfolder(`{Files.FontsPath}`) then
            makefolder(`{Files.FontsPath}`);
        end;

        --

        for Name, Table in Files.Fonts do
            if not Table or not Table.Link then continue; end;

            if not isfile(`{Files.FontsPath}\\{Name}.ttf`) then
                writefile(`{Files.FontsPath}\\{Name}.ttf`, game:HttpGet(Table.Link));
            end;
            
            if not isfile(`{Files.FontsPath}\\{Name}.font`) or --[[ExecutorName == "Zenith"]] true then
                local Config = {
                    name = Name,
                    faces = {{
                        name = "Regular",
                        weight = 9e9,
                        style = "normal",
                        assetId = getcustomasset(`{Files.FontsPath}\\{Name}.ttf`)
                    }}
                };
                
                writefile(`{Files.FontsPath}\\{Name}.font`, HttpService:JSONEncode(Config));
            end;

            for _, FontPath in listfiles(Files.FontsPath) do
                local Name = string_match(FontPath, `{Files.FontsPath}\\(.+)%.font`);

                if Name then
                    Files.Fonts.Loaded[Name] = Font_new(getcustomasset(FontPath), Enum.FontWeight.Regular);
                end;
            end;
        end;
    end;
end

do -- Functions
	function Library.Error(Flag, Extra)
		if Library.Errors[Flag] then return end
		local LPH_LINE = nil
		local ErrorMessage = string_format("âš ï¸ An error has occured:\n%s\n%s\nðŸ“ Trace: %s / %s", Flag, Extra or "", debug.traceback(), LPH_LINE or "No Line")

		if Library.AddOutput then
			Library.AddOutput(ErrorMessage, "Error")
		end

		if Library.Notify then
			Library.Notify({Message = ErrorMessage, Delay = math_huge})
		else
			warn(ErrorMessage)
		end

		Library.Errors[Flag] = true
	end
	
	function Library.AddConnection(Signal, Function)
		local Connection; Connection = Signal:Connect(function(...)
			local Args = ...;
			local Success, Error = pcall(function() coroutine_wrap(Function)(Args) end)

			if not Success and Library and not Library.Errors[Error] then
				if Library.Error then
					Library.Error(Error)
				end

				if ConnectionsTable[Connection] then
					ConnectionsTable[Connection] = nil
				end

				return Connection and Connection:Disconnect()
			end
		end)

		if Connection and ConnectionsTable then
			table_insert(ConnectionsTable, Connection)
		end

		return Connection
	end

    function Library.FadeDescendants(Bool, Table, Callback)
        local ClassProperties = {
            ["Frame"] = {"BackgroundTransparency", true},
            ["TextLabel"] = {"TextTransparency", true},
            ["ImageLabel"] = {"ImageTransparency", true},
            ["UIStroke"] = {"Transparency", true},
            ["UIGradient"] = {"Transparency", false},
        }

        local TotalFades, CompletedFades = 0, 0; for _, Object in Table do
            if ClassProperties[Object.ClassName] then
                TotalFades += 1
            end
        end

        for _, Object in Table do
            local PropertyInfo = ClassProperties[Object.ClassName]
            if not PropertyInfo then continue end

            local Property, UseTween = PropertyInfo[1], PropertyInfo[2]
            local NewValue = Bool and 0 or 1

            if UseTween then
                Library.TweenObject(Object, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {[Property] = NewValue}, function()
                    CompletedFades += 1

                    if CompletedFades == TotalFades and Callback then
                        Callback()
                    end
                end)
            else
                Object[Property] = NumberSequence_new{
                    NumberSequenceKeypoint_new(0, NewValue),
                    NumberSequenceKeypoint_new(1, NewValue),
                }

                CompletedFades += 1

                if CompletedFades == TotalFades and Callback then
                    Callback()
                end
            end
        end
    end

    function Library.GetAllObjects(Object)
        local Table = {}; for _, Descendant in Object:GetDescendants() do
            table_insert(Table, Descendant)
        end

        table_insert(Table, Descendant)

        return Table
    end
    
	function Library.NewFlag()
		UITable.UnnamedFlags += 1

		return string_format("UnknownFlag%s", tostring(UITable.UnnamedFlags))
	end

	function Library.CreateObject(Type, Properties, Hidden)
		local Hidden = Hidden or false
		local Object = Instance_new(Type)

		for Index, Value in Properties do
			Object[Index] = Value
		end

		ObjectsTable[Object] = {Object, Properties, Hidden}

		return Object
	end

	function Library.Validate(Defaults, Options)
		for Index, Value in Defaults do
			if Options[Index] == nil then
				Options[Index] = Value
			end
		end

		return Options
	end

	function Library.TweenObject(Object, Info, Goal, Callback)
		local Tween = TweenService:Create(Object, Info, Goal)

		Library.AddConnection(Tween.Completed, Callback or function() end)

		Tween:Play()
	end

	function Library.ClampPosition(Object, Position, Offset, BottomOffset)
		local BottomOffset = BottomOffset or Offset
		local AbsX = (Position.X.Scale * Viewport.X) + Position.X.Offset
		local AbsY = (Position.Y.Scale * Viewport.Y) + Position.Y.Offset

		local MaxX = math_max(Offset, Viewport.X - Object.AbsoluteSize.X - Offset)
		local MaxY = math_max(BottomOffset, Viewport.Y - Object.AbsoluteSize.Y - BottomOffset)

		local ClampedAbsX = math_clamp(AbsX, Offset, MaxX)
		local ClampedAbsY = math_clamp(AbsY, BottomOffset, MaxY)

		local FinalX = ClampedAbsX - (Position.X.Scale * Viewport.X)
		local FinalY = ClampedAbsY - (Position.Y.Scale * Viewport.Y)

		return UDim2_new(Position.X.Scale, FinalX, Position.Y.Scale, FinalY)
	end

	function Library.UpdateResize(StartingSize, MinResize, MaxResize, MouseLocation)
		if not MouseLocation then return end

		local CurrentMousePosition = UserInputService:GetMouseLocation()
		local Delta = CurrentMousePosition - MouseLocation

		return UDim2_new(0, math_clamp(StartingSize.X.Offset + Delta.X, MinResize.X.Offset, MaxResize.X.Offset), 0, math_clamp(StartingSize.Y.Offset + Delta.Y, MinResize.Y.Offset, MaxResize.Y.Offset))
	end

	function Library.CheckHighestUI(Object)
		local StopDrag = false

		for _, Window in UITable.MainWindows do
			if Window.Visible and Library.MouseOverFrame(Window) and Window.ZIndex > Object.ZIndex then
				StopDrag = true

				break
			end
		end

		return StopDrag
	end

	function Library.MouseOverFrame(Frame)
		local MousePosition = UserInputService:GetMouseLocation() - Inset
		local Position = Frame.AbsolutePosition
		local Size = Frame.AbsoluteSize

		local InsideX = MousePosition.X >= Position.X and MousePosition.X <= Position.X + Size.X
		local InsideY = MousePosition.Y >= Position.Y and MousePosition.Y <= Position.Y + Size.Y

		return InsideX and InsideY
	end

	function Library.MouseOverOtherWindow(CurrentWindow)
		for _, Window in UITable.MainWindows do
			if Window.Visible and Window.ZIndex > CurrentWindow.ZIndex and Library.MouseOverFrame(Window) then
				return true
			end
		end

		return false
	end

	function Library.MouseOverOtherObject()
		for _, Dropdown in UITable.Dropdowns do
			if Dropdown.Visible and Library.MouseOverFrame(Dropdown) then
				return true
			end
		end

		for _, ModeList in UITable.ModeLists do
			if ModeList.Visible and Library.MouseOverFrame(ModeList) then
				return true
			end
		end

		for _, ColorPicker in UITable.ActiveColorPickers do
			if ColorPicker.Visible and Library.MouseOverFrame(ColorPicker) then
				return true
			end
		end

		return false
	end

	function Library.GetObjectsTable(MainUI, AddMain, Ignored)
		local AddMain = AddMain or false
		local Ignored = Ignored or {}
		local DescendantTable = {}
		local NewTable = {}

		for _, Descendant in MainUI:GetDescendants() do
			if table_find(Ignored, Descendant) then continue end

			DescendantTable[#DescendantTable + 1] = Descendant
		end

		if AddMain then
			DescendantTable[#DescendantTable + 1] = MainUI
		end

		for _, Descendant in DescendantTable do
			local Found = ObjectsTable[Descendant]

			if Found then
				local Properties = Found[2]
				local HiddenValue = Found[3]

				NewTable[#NewTable + 1] = {Descendant, Properties, HiddenValue}
			end
		end

		return NewTable
	end

	function Library.Resizable(WindowTable, DragFrame, MinResize, MaxResize, Shadow)
		local StartingSize, ObjectSize, Dragging, MouseLocation, PerformanceDragUI, NewMouse, Hovering, Object

		Library.AddConnection(DragFrame.MouseEnter, LPH_NO_VIRTUALIZE(function()
			Object = (typeof(WindowTable) == "table" and WindowTable.GetParent() or WindowTable)

			local StopDrag = Library.CheckHighestUI(Object)

			if StopDrag then
				return
			end

			UserInputService.MouseIconEnabled = false
			UITable.Resizing = true
			Hovering = true
		end))

		Library.AddConnection(DragFrame.MouseLeave, LPH_NO_VIRTUALIZE(function()
			if NewMouse then NewMouse:Destroy() NewMouse = nil end

			if not UITable.CustomCursor then
				UserInputService.MouseIconEnabled = true
			end

			UITable.Resizing = false
			Hovering = false
		end))

		Library.AddConnection(DragFrame.InputBegan, LPH_NO_VIRTUALIZE(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 then
				Object = (typeof(WindowTable) == "table" and WindowTable.GetParent() or WindowTable)
				Dragging = true
				MouseLocation = UserInputService:GetMouseLocation()
				StartingSize = Object.Size

				local StopDrag = Library.CheckHighestUI(Object)

				if StopDrag then
					Dragging = false

					return
				end

				UITable.MainZIndex = UITable.MainZIndex + 2
				Object.ZIndex = UITable.MainZIndex + UITable.DropdownZIndex

				if Shadow then
					Shadow.ZIndex = Object.ZIndex - 2
				end

				if UITable.PerformanceMode then
					PerformanceDragUI = Library.CreateObject("Frame", {
						Name = "PerformanceDrag",
						Position = Object.Position,
						BorderColor3 = Color3_fromRGB(0, 0, 0),
						Size = Object.Size,
						BorderSizePixel = 0,
						BackgroundTransparency = 1,
						Visible = true,
						ZIndex = UITable.MainZIndex + 100,
						Parent = Object.Parent
					})

					local PerformanceDragOutline = Library.CreateObject("UIStroke", {
						Name = "PerformanceDragStroke",
						Color = ThemeDefault.Accent,
						Parent = PerformanceDragUI
					})
				end

                if Object.Parent == UITable.ExtrasScreenGui then
                    UITable.ExtrasScreenGui.DisplayOrder = 20000001
                    UITable.ScreenGui.DisplayOrder = 20000000
                elseif Object.Parent == UITable.ScreenGui then
                    UITable.ScreenGui.DisplayOrder = 20000001
                    UITable.ExtrasScreenGui.DisplayOrder = 20000000
                end

				UITable.MainZIndex = Object.ZIndex + 2
			end
		end))

		Library.AddConnection(UserInputService.InputChanged, LPH_NO_VIRTUALIZE(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseMovement then
				if Hovering or Dragging then
					local MousePosition = UserInputService:GetMouseLocation()

					UserInputService.MouseIconEnabled = false
					UITable.Resizing = true

					if not NewMouse then
						NewMouse = Library.CreateObject("ImageLabel", {
							BorderColor3 = Color3_fromRGB(0, 0, 0),
							Image = "rbxassetid://87982048533100",
							BackgroundTransparency = 1,
							AnchorPoint = Vector2_new(0.5, 0.5),
							Name = "Transparency",
							Size = UDim2_new(0, 35, 0, 35),
							ZIndex = 10000,
							BorderSizePixel = 0,
							BackgroundColor3 = Color3_fromRGB(255, 255, 255),
							Parent = Object.Parent
						})
					end

					NewMouse.Position = UDim2_new(0, MousePosition.X, 0, MousePosition.Y)
				end

				if Dragging then
					local NewSize = Library.UpdateResize(StartingSize, MinResize, MaxResize, MouseLocation)

					if not UITable.PerformanceMode then
						Library.TweenObject(Object, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {Size = NewSize})

						if Shadow then
							Library.TweenObject(Shadow, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {Size = NewSize})
						end
					else
						PerformanceDragUI.Size = NewSize
					end
				end
			end
		end))

		Library.AddConnection(UserInputService.InputEnded, LPH_NO_VIRTUALIZE(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 and Dragging then
				if NewMouse then NewMouse:Destroy() NewMouse = nil end

				if not UITable.CustomCursor then
					UserInputService.MouseIconEnabled = true
				end

				UITable.Resizing = false
				Dragging = false

				if UITable.PerformanceMode then
					PerformanceDragUI:Destroy()

					Library.TweenObject(Object, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {Size = PerformanceDragUI.Size})
					Library.TweenObject(Shadow, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {Size = PerformanceDragUI.Size})
				end
			end
		end))
	end

	function Library.Draggable(Object, DragFrame)
		local StartingPosition, ObjectPosition, Dragging

		if not (Object and DragFrame) then
			return
		end

		Library.AddConnection(DragFrame.MouseButton1Down, LPH_NO_VIRTUALIZE(function()
			Dragging = true
			StartingPosition = UserInputService:GetMouseLocation()
			ObjectPosition = Object.Position

			if Object.Parent == UITable.ExtrasScreenGui then
				UITable.ExtrasScreenGui.DisplayOrder = 20000001
				UITable.ScreenGui.DisplayOrder = 20000000
			elseif Object.Parent == UITable.ScreenGui then
				UITable.ScreenGui.DisplayOrder = 20000001
				UITable.ExtrasScreenGui.DisplayOrder = 20000000
			end

			UITable.MainZIndex += 1
			Object.ZIndex = UITable.MainZIndex + UITable.DropdownZIndex

			UITable.MainZIndex = Object.ZIndex + 1
		end))

		Library.AddConnection(UserInputService.InputChanged, LPH_NO_VIRTUALIZE(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseMovement and Dragging then
				local MouseLocation = UserInputService:GetMouseLocation()
				local Delta = MouseLocation - StartingPosition
				local NewPosition = UDim2_new(ObjectPosition.X.Scale, ObjectPosition.X.Offset + Delta.X, ObjectPosition.Y.Scale, ObjectPosition.Y.Offset + Delta.Y)

				NewPosition = UITable.ClampDragging and Library.ClampPosition(Object, NewPosition, 10, 10) or NewPosition

				Library.TweenObject(Object, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {Position = NewPosition})
			end
		end))

		Library.AddConnection(UserInputService.InputEnded, LPH_NO_VIRTUALIZE(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 and Dragging then
				Dragging = false
			end
		end))
	end

	function Library.ScrollingCheck(ScrollingFrame, Frame)
		if not IsA(ScrollingFrame, "ScrollingFrame") then
			return true
		end

		local VisibleTopLeft = ScrollingFrame.CanvasPosition
		local VisibleBottomRight = VisibleTopLeft + ScrollingFrame.AbsoluteWindowSize

		local FrameTopLeft = Frame.AbsolutePosition - ScrollingFrame.AbsolutePosition + ScrollingFrame.CanvasPosition
		local FrameBottomRight = FrameTopLeft + Frame.AbsoluteSize

		return FrameBottomRight.X > VisibleTopLeft.X and FrameTopLeft.X < VisibleBottomRight.X and FrameBottomRight.Y > VisibleTopLeft.Y and FrameTopLeft.Y < VisibleBottomRight.Y
	end

	function Library.GetTableIndexes(Table, Custom)
		local NewTable = {}

		for Index, Value in Table do
			NewTable[Custom and Value[1] or #NewTable + 1] = Index 
		end

		return NewTable
	end

	function Library.ApplyRichText(TextLabel, ColorList)
        if ColorList == nil then return end
        if Library.DictionaryLength(ColorList) == 0 then return end

		local StartText = TextLabel.Text

		table_insert(UITable.RichTexts, {TextObject = TextLabel, Original = StartText, ColorList = ColorList})

		for Word, Color in ColorList do
			local R, G, B = (Color.R * 255) // 1, (Color.G * 255) // 1, (Color.B * 255) // 1
			local NewColor = string_format('<font color="rgb(%d,%d,%d)">%s</font>', R, G, B, Word)
			local NewWord = Word:gsub("(%W)","%%%1")

			StartText = StartText:gsub(NewWord, NewColor)
		end

		TextLabel.Text = StartText
		TextLabel.RichText = true
	end

	function Library.SubtractColor(OriginalColor, Value)
		local R, G, B = (OriginalColor.R * 255) // 1, (OriginalColor.G * 255) // 1, (OriginalColor.B * 255) // 1
		local NewR, NewG, NewB = math_max(R - Value, 0), math_max(G - Value, 0), math_max(B - Value, 0)

		return Color3_fromRGB(NewR, NewG, NewB)
	end

	function Library.GetConfig()
        local Config = {}
        
        for Index, Value in Flags do
            if Value.IgnoreConfig then continue end

            if Value.Get then
                local ActualValue = Value.Get()

                if ActualValue == nil then continue end

                if type(ActualValue) == "table" then
                    if ActualValue.Color then
                        local Transparency = ActualValue.Transparency
                        local SelectedModes = ActualValue.Animations
                        local Hue, Saturation, Value = ActualValue.Color:ToHSV()
                        local Modes = {}; for ModeName, ModeValue in SelectedModes do
                            if ModeValue == true then
                                table_insert(Modes, ModeName)
                            end
                        end
                        
                        Config[Index] = {Hue, Saturation, Value, Transparency, Modes}
                    else
                        Config[Index] = ActualValue
                    end
                else
                    if Value.Active and type(Value.Active) == "function" then
                        Config[Index] = {ActualValue, Value.Mode}
                    else
                        Config[Index] = ActualValue
                    end
                end
            end
        end
        
        return HttpService:JSONEncode(Config)
    end

	function Library.LoadConfig(Config)
		local Config = HttpService:JSONDecode(Config)

		for Index, Value in Config do
			if Flags[Index] then
				Flags[Index].Set(Value)
			end
		end
	end

	function Library.ReturnConfigs()
		local Configs = {}

		for _, ConfigFile in listfiles(FolderLocation .. "/Configs/") do
			local FileName = ConfigFile:match("([^\\/]*)%.%w+$")

			table_insert(Configs, FileName)
		end

		return Configs
	end

    function Library.DictionaryLength(Table)
        local Length = 0; for _, _ in Table do
            Length += 1
        end

        return Length
    end

    function Library.Notify(optsOrSelf, optsOrDur, durArg)
        -- Handles both Library.Notify({Message=...}) and Library:Notify("msg", dur)
        local msg, delay
        if type(optsOrSelf) == "table" and optsOrSelf.Message then
            msg = optsOrSelf.Message
            delay = optsOrSelf.Delay or 5
        elseif type(optsOrSelf) == "string" then
            msg = optsOrSelf
            delay = optsOrDur or 5
        elseif type(optsOrDur) == "table" and optsOrDur.Message then
            msg = optsOrDur.Message
            delay = optsOrDur.Delay or 5
        elseif type(optsOrDur) == "string" then
            msg = optsOrDur
            delay = durArg or 5
        else
            return
        end
        pcall(function() warn("[alternate] " .. tostring(msg)) end)
    end

	function Library.AddTheme(Object, Properties)
		local Table = ThemeTable.Objects

		Table[Object] = Table[Object] or {}

		for Index, Value in Properties do
			Table[Object][Index] = Value
		end
	end

	function Library.UpdateColor(ColorType, ColorValue)
		local Table = ThemeTable.Objects

		ThemeTable.Default[ColorType] = ColorValue

		for Object, Properties in Table do
			for Property, ThemeKeys in Properties do
				if typeof(ThemeKeys) == "table" then
					if IsA(Object, "UIGradient") and Property == "Color" then
						if ThemeTable.Default[ThemeKeys[1]] then
							Object.Color = ColorSequence_new{
								ColorSequenceKeypoint_new(0, ThemeTable.Default[ThemeKeys[1]]),
								ColorSequenceKeypoint_new(1, ThemeTable.Default[ThemeKeys[2]])
							}
						end
					end
				else
					if ThemeKeys == ColorType then
						Object[Property] = ThemeTable.Default[ThemeKeys]
					end
				end
			end
		end
	end

	function Library.UpdateRichTexts(NewColor)
		for _, TextData in UITable.RichTexts do
			local TextObject = TextData.TextObject
			local OriginalText = TextData.Original
			local ColorList = TextData.ColorList
			local NewText = OriginalText

			for Word, _ in ColorList do
				local R = (NewColor.R * 255) // 1
				local G = (NewColor.G * 255) // 1
				local B = (NewColor.B * 255) // 1

				local NewTextColor = string_format('<font color="rgb(%d,%d,%d)">%s</font>', R, G, B, Word)
				local SafeWord = string_gsub(Word, "(%W)", "%%%1")

				NewText = string_gsub(NewText, SafeWord, NewTextColor)
			end

			TextObject.Text = NewText
			TextObject.RichText = true
		end
	end

	function Library.UpdateTheme(ThemeType, ThemeValue)
		if Flags["ConfigTheme_" .. ThemeType] then
			Flags["ConfigTheme_" .. ThemeType].Set(ThemeValue)
		end
	end

	function Library.LoadTheme(ThemeType)
		if ThemeTable.Presets[ThemeType] then
			local ThemeValue = HttpService:JSONDecode(ThemeTable.Presets[ThemeType][2])

			for Index, Value in ThemeValue do
				local NewColor

				if typeof(Value) == "string" then
					NewColor = Color3_fromHex(Value)
				elseif typeof(Value) == "Color3" then
					NewColor = Value
				elseif typeof(Value) == "table" then
					NewColor = Color3_fromHSV(Value[1], Value[2], Value[3])
				end

				local H, S, V = NewColor:ToHSV()
				local ActualColor = Color3_fromHSV(H, S, V)

				Library.UpdateTheme(Index, ActualColor)
			end
		end
	end

	function Library.UpdateThemeList()
		for _, ThemeFile in listfiles(FolderLocation .. "/Themes/") do
			local ThemeName = ThemeFile:match("([^\\/]*)%.%w+$")
			local ThemeIndex = 1
			local ThemeSettings = readfile(ThemeFile)

			for _ in ThemeTable.Presets do
				ThemeIndex += 1
			end

			ThemeTable.Presets[ThemeName] = {ThemeIndex, ThemeSettings}
		end
	end

	function Library.SaveTheme(ThemeName)
		local Theme = {}

		for Index, Value in Flags do
			if string_find(Index, "ConfigTheme_") then
				local CleanIndex = string_gsub(Index, "^ConfigTheme_", "")

				if typeof(Value.Get()) == "table" then
					if Value.Get().Color and Value.Get().Transparency then
						local Transparency = Value.Get().Transparency
						local Hue, Saturation, Value = Value.Get().Color:ToHSV()

						Theme[CleanIndex] = {Hue, Saturation, Value, Transparency}
					end
				end
			end
		end

		writefile(FolderLocation .. "/Themes/" .. ThemeName, HttpService:JSONEncode(Theme))
	end

    function Library.GetAutoloadConfig()
        local Location = `{Files.ConfigsPath}\\AutoloadConfig`

        if #listfiles(Location) > 0 then
            for _, File in listfiles(Location) do
                Library.LoadConfig(readfile(File))
            end
        end
    end
end

do -- Connections
    local Rainbow = 0
    local Fade = 0
    local Frames = 0

    Library.AddConnection(RunService.PostSimulation, LPH_NO_VIRTUALIZE(function(Delta)
        Frames += Delta

        if Frames < 1 / 35 then
            return
        end

        Frames = 0

        local RainbowSpeed = (Flags.RainbowSpeed and Flags.RainbowSpeed.Value / 10) or 0.1
        local FadeSpeed = (Flags.FadeSpeed and Flags.FadeSpeed.Value / 10) or 0.1

        Rainbow = (Rainbow + RainbowSpeed * Delta) % 1
        Fade = (Fade + FadeSpeed * Delta) % 1

        local Value = math_sin(Fade * math_pi * 2) * 0.5 + 0.5

        task_defer(function()
            for _, Data in UITable.ColorPickers do
                local Modified = false
                local Color = Data.Color
                local Alpha = Data.Transparency

                if Data.SelectedModes.Rainbow then
                    local H, S, V = Color:ToHSV()

                    Color = Color3_fromHSV(Rainbow, S, V)
                    Modified = true
                end

                if Data.SelectedModes.Neon then
                    local Boost = 5

                    Color = Color3_new(Color.R * Boost, Color.G * Boost, Color.B * Boost)
                    Modified = true
                end

                if Data.SelectedModes.Fade then
                    Alpha = Alpha - (Alpha - 0) * Value
                    Modified = true
                end

                if Modified then
                    Data.SetInternal(Color, Alpha)
                end
            end
        end)
    end))
end

Library.__index = Library
Library.Sections.__index = Library.Sections
UITable.Font = Files.Fonts.Loaded["Tahoma"]
UITable.ScreenGui = Library.CreateObject("ScreenGui", {
	Name = "\n",
	ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	ResetOnSpawn = false,
	DisplayOrder = 20000001,
	IgnoreGuiInset = true,
	Parent = Client.PlayerGui
})

UITable.ExtrasScreenGui = Library.CreateObject("ScreenGui", {
	Name = "\n",
	ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	ResetOnSpawn = false,
	DisplayOrder = 20000000,
	IgnoreGuiInset = true,
	Parent = gethui()
})

local Sections = Library.Sections

do -- Elements
    function Library.CreateKeybind(Options)
        Options = Library.Validate({
            Text = "",
            Mode = "Toggle",
            Default = nil,
            Count = 1,
            HideFromList = false,
            ToggleState = false,
            Debounce = false,
            Parent = nil,
            Toggle = nil,
            MainUI = nil,
            ToolTip = "",
            ColorPickers = {},
            Blacklisted = {},
            Flag = Library.NewFlag(),
            Callback = function() end
        }, Options or {})

        local Keybind = {
            Text = Options.Text,
            Mode = Options.Mode,
            Keybind = Options.Default,
            ToggleObject = Options.Toggle,
            HideFromList = Options.HideFromList,
            Hovering = false,
            ActiveFrame = false,
            Value = Options.Toggle.Value,
            SelectingKeybind = false,
            Toggle = false,
            Connection = nil,
            ConfigKeybind = nil,
            CurrentMode = nil,
            RegKeybind = nil,
            ModeList = nil,
            DebounceTick = 0,
            Current = {},
            UserInputTypeBinds = {"MouseButton1", "MouseButton2", "MouseButton3"},
        }
        
        Flags[Options.Flag] = Keybind
        UITable.TotalKeybindModes += 1

        local LibraryFontSize = UITable.FontSize
        local LibraryFont = UITable.Font
        local KeybindOutline = Library.CreateObject("CanvasGroup", {
            Name = "KeybindOutline",
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Size = UDim2_new(0, 0, 1, 0),
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.X,
            LayoutOrder = 10 - Options.Count,
            BackgroundTransparency = 1,
            Parent = Options.Parent
        })

        local KeybindText = Library.CreateObject("TextButton", {
            FontFace = LibraryFont,
            TextColor3 = ThemeDefault.TextColor,
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Name = "KeybindText",
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.X,
            Size = UDim2_new(0, 0, 1, 0),
            BorderSizePixel = 0,
            ZIndex = 10,
            TextSize = LibraryFontSize,
            BackgroundColor3 = Color3_fromRGB(255, 255, 255),
            Parent = KeybindOutline
        }); Library.AddTheme(KeybindText, { TextColor3 = "TextColor" })

        local UIStroke_4 = Library.CreateObject("UIStroke", {
            LineJoinMode = Enum.LineJoinMode.Miter,
            Parent = KeybindText
        })

        local UIPadding = Library.CreateObject("UIPadding", {
            PaddingRight = UDim.new(0, 1),
            PaddingTop = UDim_new(0, -2),
            Parent = KeybindText
        })

        do -- Functions
            function Keybind.Set(Key)
                local ActualKey = nil
                
                if typeof(Key) == "boolean" then return end
                if typeof(Key) == "table" then
                    --Library.RemoveKeybindFrame(Options.Toggle.GetName(), Options.Toggle.GetSection())
                    ActualKey = Key[1]
                    Keybind.SetMode(Key[2])
                else
                    ActualKey = Key
                end
                
                if typeof(ActualKey) == "EnumItem" then
                    Keybind.RegKeybind = ActualKey
                elseif typeof(ActualKey) == "string" then
                    if table_find(Keybind.UserInputTypeBinds, ActualKey) then
                        Keybind.RegKeybind = Enum.UserInputType[ActualKey]
                        ActualKey = Enum.UserInputType[ActualKey]
                    else
                        Keybind.RegKeybind = Enum.KeyCode[ActualKey]
                        ActualKey = Enum.KeyCode[ActualKey]
                    end
                end
                
                if typeof(ActualKey) == "string" then
                    if ActualKey:find("KEY") then
                        ActualKey = Enum.KeyCode[ActualKey:gsub("KEY_", "")]
                    elseif ActualKey:find("INPUT") then
                        ActualKey = Enum.UserInputType[ActualKey:gsub("INPUT_", "")]
                    end
                end
                
                local ValidKey = false
                local KeyString = ""
                
                if table_find(Options.Blacklisted, ActualKey) then
                    ActualKey = nil
                end
                
                if ActualKey then
                    if ((ActualKey.EnumType == Enum.KeyCode and UserInputService:GetStringForKeyCode(ActualKey) ~= "") or UITable.Keys[ActualKey]) then
                        ValidKey = true
                        KeyString = UITable.Keys[ActualKey] or UserInputService:GetStringForKeyCode(ActualKey)
                    end
                end
                
                if ValidKey then
                    KeyString = `[ {KeyString} ]`
                    Keybind.Keybind = KeyString
                    Options.Callback(ActualKey)
                    Library.Flags[Options.Flag] = Keybind
                    KeybindText.Text = UITable.KeybindType == "Upper" and string_upper(KeyString) or string_lower(KeyString)
                else
                    Keybind.Keybind = UITable.KeybindType == "Upper" and "None" or "none"
                    KeybindText.Text = Keybind.Keybind
                end
                
                if string_lower(Keybind.Keybind) == "none" then
                    --Library.RemoveKeybindFrame(Options.Toggle.GetName(), Options.Toggle.GetSection())
                end
            end

            function Keybind.SetMode(Mode)
                Keybind.Mode = Mode
                
                if Mode == "Always" or Mode == "Off Hold" then
                    if Mode == "Always" then
                        Keybind.Toggle(true, true)
                    end
                    
                    if not Keybind.Value then
                        Keybind.Value = true
                        
                        if Options.Toggle.Value then
                            --Library.AddKeybindFrame(Options.Toggle.GetName(), Keybind.Keybind, Options.Toggle.GetSection())
                        end
                    else
                        --Library.UpdateKeybindFrame(Options.Toggle.GetName(), Options.Toggle.GetSection(), Keybind.Keybind)
                    end
                elseif Mode == "Toggle" then
                    if Keybind.Value then
                        --Library.UpdateKeybindFrame(Options.Toggle.GetName(), Options.Toggle.GetSection(), Keybind.Keybind)
                    end
                elseif Mode == "On Hold" then
                    Keybind.Value = false
                    
                    --Library.RemoveKeybindFrame(Options.Toggle.GetName(), Options.Toggle.GetSection())
                end
            end

            function Keybind.SetVisible(Bool)
                Keybind.MouseLeave()
                KeybindOutline.ZIndex = Bool and 3 or 0
                Library.TweenObject(KeybindOutline, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.InOut), {GroupTransparency = Bool and 0 or 1})
                
                return Keybind
            end

            function Keybind.Toggle(UseToggle, Bool)
                if Bool ~= nil then
                    Keybind.Value = Bool
                else
                    Keybind.Value = not Keybind.Value
                end

                if not Options.HideFromList then
                    if Keybind.Value then
                        --Library.AddKeybindFrame(Keybind.Text ~= "" and Keybind.Text or Options.Toggle.GetName(), Keybind.Keybind, Options.Toggle.GetSection())
                    else
                        --Library.RemoveKeybindFrame(Keybind.Text ~= "" and Keybind.Text or Options.Toggle.GetName(), Options.Toggle.GetSection())
                    end
                end

                -- Actually toggle the parent Toggle UI to update its state and fire callback
                if Options.Toggle and Options.Toggle.ToggleUI then
                    Options.Toggle.ToggleUI(Keybind.Value)
                else
                    if Options.Toggle.GetFlag then
                        Library.Flags[Options.Toggle.GetFlag()] = Keybind
                    end
                    Options.Toggle.GetCallback(Keybind.Value)
                end
            end

            function Keybind.Get()
                if not Keybind.RegKeybind then
                    return
                end

                local KeyString = Keybind.RegKeybind.EnumType == Enum.KeyCode and tostring(Keybind.RegKeybind):match("^Enum%.KeyCode%.(.+)$") or tostring(Keybind.RegKeybind):match("^Enum%.UserInputType%.(.+)$")
                
                return KeyString
            end
            
            function Keybind.Active()
                return Keybind.Value
            end

            function Keybind.MouseEnter()
                if Library.MouseOverOtherWindow(Options.MainUI) then
                    Keybind.MouseLeave()
                    
                    return
                end

                if Library.MouseOverOtherObject() then
                    Keybind.MouseLeave()

                    return
                end
                
                Keybind.Hovering = true

                if (not Keybind.Fading) then
                    Library.TweenObject(KeybindText, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.InOut), {TextColor3 = ThemeDefault.TextDark}, function()
                        Library.AddTheme(KeybindText, {TextColor3 = "TextDark"}, "TextColor")
                    end)

                    Keybind.Fading = true
                end
            end

            function Keybind.MouseLeave()
                Keybind.Hovering = false

                if Keybind.Fading and (not Keybind.SelectingKeybind) and (not Keybind.ModeList) then
                    Library.TweenObject(KeybindText, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.InOut), {TextColor3 = ThemeDefault.TextColor}, function()
                        Library.AddTheme(KeybindText, {TextColor3 = "TextColor"}, "TextDark")
                    end)

                    Keybind.Fading = false
                end
            end
        end

        do -- Connections
            Library.AddConnection(KeybindText.MouseButton1Click, LPH_NO_VIRTUALIZE(function()
                if Library.MouseOverOtherWindow(Options.MainUI) then
                    return
                end

                if Library.MouseOverOtherObject() then
                    return
                end

                if Keybind.Connection then
                    Keybind.Connection:Disconnect()
                end
                
                Keybind.SelectingKeybind = true
                
                KeybindText.Text = "..."

                Keybind.Connection = Library.AddConnection(UserInputService.InputBegan, function(Input)
                    Keybind.Set(Input.UserInputType == Enum.UserInputType.Keyboard and Input.KeyCode or Input.UserInputType)
                    Keybind.Value = true

                    if Keybind.Connection then
                        Keybind.Connection:Disconnect()
                        Keybind.Connection = nil
                        Keybind.SelectingKeybind = false
                    end

                    Keybind.MouseLeave()
                end)
            end))

            -- Right-click mode selection menu
            Library.AddConnection(KeybindText.MouseButton2Click, LPH_NO_VIRTUALIZE(function()
                if Library.MouseOverOtherWindow(Options.MainUI) then
                    return
                end

                -- Destroy existing mode list if open
                if Keybind.ModeList then
                    local idx = table_find(UITable.ModeLists, Keybind.ModeList)
                    if idx then table_remove(UITable.ModeLists, idx) end
                    pcall(function() Keybind.ModeList:Destroy() end)
                    Keybind.ModeList = nil
                    return
                end

                local Modes = {"Toggle", "Hold", "Always"}
                local ModeMap = {["Toggle"] = "Toggle", ["Hold"] = "On Hold", ["Always"] = "Always"}

                local ModeFrame = Library.CreateObject("Frame", {
                    Name = "ModeList",
                    Position = UDim2_new(0, 0, 1, 2),
                    Size = UDim2_new(1, 20, 0, #Modes * 18 + 4),
                    BackgroundColor3 = ThemeDefault.DarkContrast,
                    BorderSizePixel = 0,
                    ZIndex = 200,
                    Parent = KeybindOutline
                }); Library.AddTheme(ModeFrame, {BackgroundColor3 = "DarkContrast"})

                Library.CreateObject("UIStroke", {
                    Color = ThemeDefault.Outline, Thickness = 1, Parent = ModeFrame
                })

                Library.CreateObject("UIListLayout", {
                    Padding = UDim_new(0, 0),
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Parent = ModeFrame
                })

                Library.CreateObject("UIPadding", {
                    PaddingTop = UDim_new(0, 2), PaddingBottom = UDim_new(0, 2),
                    PaddingLeft = UDim_new(0, 4), PaddingRight = UDim_new(0, 4),
                    Parent = ModeFrame
                })

                Keybind.ModeList = ModeFrame
                table_insert(UITable.ModeLists, ModeFrame)

                for _, modeName in ipairs(Modes) do
                    local isActive = (ModeMap[modeName] == Keybind.Mode)
                    local ModeBtn = Library.CreateObject("TextButton", {
                        Name = modeName,
                        FontFace = UITable.Font,
                        Text = modeName,
                        TextColor3 = isActive and ThemeDefault.Accent or ThemeDefault.TextDark,
                        TextSize = UITable.FontSize,
                        Size = UDim2_new(1, 0, 0, 16),
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        AutoButtonColor = false,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        ZIndex = 201,
                        Parent = ModeFrame
                    })

                    Library.AddConnection(ModeBtn.MouseButton1Click, function()
                        Keybind.SetMode(ModeMap[modeName])
                        -- Close the menu
                        if Keybind.ModeList then
                            local idx = table_find(UITable.ModeLists, Keybind.ModeList)
                            if idx then table_remove(UITable.ModeLists, idx) end
                            pcall(function() Keybind.ModeList:Destroy() end)
                            Keybind.ModeList = nil
                        end
                    end)
                end

                -- Close on click outside
                task_delay(0.1, function()
                    local closeConn
                    closeConn = Library.AddConnection(UserInputService.InputBegan, function(Input)
                        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.MouseButton2 then
                            if ModeFrame and ModeFrame.Parent and not Library.MouseOverFrame(ModeFrame) then
                                local idx = table_find(UITable.ModeLists, ModeFrame)
                                if idx then table_remove(UITable.ModeLists, idx) end
                                pcall(function() ModeFrame:Destroy() end)
                                Keybind.ModeList = nil
                                if closeConn then closeConn:Disconnect() end
                            end
                        end
                    end)
                end)
            end))

            Library.AddConnection(UserInputService.InputBegan, LPH_NO_VIRTUALIZE(function(Input, Proccessed)
                if Proccessed then return end
                
                if (Input.UserInputType == Enum.UserInputType.Keyboard and Keybind.Keybind and string_lower(Keybind.Keybind) ~= "none" and Input.KeyCode == Keybind.RegKeybind) or (Input.UserInputType == Enum.UserInputType.MouseButton1 and Keybind.Keybind == "MB1") or (Input.UserInputType == Enum.UserInputType.MouseButton2 and Keybind.Keybind == "MB2") or (Input.UserInputType == Enum.UserInputType.MouseButton3 and Keybind.Keybind == "MMB") then
                    local Tick = os_clock()

                    if typeof(Options.Debounce) == "number" then
                        if Tick - Keybind.DebounceTick < Options.Debounce then
                            return
                        end
                    end

                    Keybind.DebounceTick = Tick

                    if Keybind.Mode == "Always" then
                        Keybind.Toggle(true, true)
                    elseif Keybind.Mode == "Off Hold" then
                        Keybind.Toggle(true, false)
                    else
                        Keybind.Toggle(true)
                    end
                end
            end))
            
            Library.AddConnection(UserInputService.InputEnded, LPH_NO_VIRTUALIZE(function(Input, Proccessed)
                if Proccessed then return end
                
                if Keybind.Mode == "On Hold" or Keybind.Mode == "Off Hold" then
                    if (Input.UserInputType == Enum.UserInputType.Keyboard and string_lower(Keybind.Keybind) ~= "none" and Input.KeyCode == Keybind.RegKeybind) or (Input.UserInputType == Enum.UserInputType.MouseButton1 and Keybind.Keybind == "MB1") or (Input.UserInputType == Enum.UserInputType.MouseButton2 and Keybind.Keybind == "MB2") or (Input.UserInputType == Enum.UserInputType.MouseButton3 and Keybind.Keybind == "MMB") then
                        if Keybind.Mode == "Off Hold" then
                            Keybind.Toggle(true, true)
                        else
                            Keybind.Toggle(true)
                        end
                    end
                end
            end))

            Library.AddConnection(KeybindOutline.MouseEnter, LPH_NO_VIRTUALIZE(function()
                if not Options.MainUI.Visible then
                    return
                end

                if not Library.MouseOverFrame(Options.MainUI) then
                    return
                end

                Keybind.MouseEnter()

                if Keybind.MouseConnection then
                    Keybind.MouseConnection:Disconnect()
                    Keybind.MouseConnection = nil
                end

                Keybind.MouseConnection = Library.AddConnection(UserInputService.InputChanged, function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseMovement then
                        if not Library.MouseOverFrame(KeybindOutline) then
                            Keybind.MouseLeave()
                            Keybind.MouseConnection:Disconnect()
                            Keybind.MouseConnection = nil
                        end
                    end
                end)
            end))
        end

        Keybind.Set(Options.Default)

        return Keybind
    end

    function Library.CreateColorPicker(Options)
        Options = Library.Validate({
            Name = "Color Picker",
            Default = Color3_fromRGB(255, 255, 255),
            Keybind = false,
            Parent = nil,
            MainUI = nil,
            TabUI = nil,
            Transparency = 1,
            Count = 1,
            Animations = {},
            Flag = Library.NewFlag(),
            Callback = function() end,
        }, Options or {})

        local SelectedOptions = {}
        local Modes = {}
        local Hue, Saturation, Value = Options.Default:ToHSV()
        local ColorPicker = {
            Loop = nil,
            ModeList = nil,
            Hover = false,
            Active = false,
            MouseDown = false,
            MainFrameHover = false,
            ActiveFrame = false,
            FrameOpened = false,
            Name = Options.Name,
            Color = Options.Default,
            Options = Options,
            SecondColor = Library.SubtractColor(Options.Default, 44),
            Transparency = Options.Transparency,
            Hue = Hue,
            Saturation = {Saturation, Value},
            SelectedModes = {Rainbow = false, Neon = false, Fade = false},
            Modes = {},
            InternalColor = Options.Default,
            InternalTransparency = Options.Transparency
        }

        for _, Mode in Options.Animations do
            table_insert(Modes, Mode)
        end

        ColorPicker.Modes = Modes
        Flags[Options.Flag] = ColorPicker
        table_insert(UITable.ColorPickers, ColorPicker)
        UITable.TotalColorPickers += 1

        local ColorPickerOutline_4 = Library.CreateObject("Frame", {
            Name = "ColorPickerOutline" .. UITable.TotalColorPickers,
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            AnchorPoint = Vector2_new(0, 0.5),
            Position = UDim2_new(0, 0, 0.5, 0),
            Size = UDim2_new(0, 24, 0, 13),
            BorderSizePixel = 0,
            LayoutOrder = 10 - Options.Count,
            BackgroundColor3 = ThemeDefault.Outline,
            Parent = Options.Parent
        }); Library.AddTheme(ColorPickerOutline_4, { BackgroundColor3 = "Outline" })

        local ColorPickerOutline_41 = Library.CreateObject("UIShadow", {
            Name = "ColorPickerOutline_41",
            Transparency = 0.6,
            BlurRadius = UDim_new(0, 7),
            Parent = ColorPickerOutline_4
        })

        local WhiteFrame = Library.CreateObject("Frame", {
            Name = "WhiteFrame",
            Position = UDim2_new(0, 1, 0, 1),
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Size = UDim2_new(1, -2, 1, -2),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            BackgroundColor3 = Color3_fromRGB(255, 255, 255),
            ZIndex = 111,
            Parent = ColorPickerOutline_4
        })

        local Button_14 = Library.CreateObject("TextButton", {
            FontFace = Font_new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
            TextColor3 = ThemeDefault.Outline,
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Name = "Button_14",
            BackgroundTransparency = 1,
            Size = UDim2_new(1, 0, 1, 0),
            BorderSizePixel = 0,
            TextTransparency = 1,
            TextSize = 14,
            BackgroundColor3 = Color3_fromRGB(255, 255, 255),
            Parent = ColorPickerOutline_4
        }); Library.AddTheme(Button_14, { TextColor3 = "Outline" })

        local ImageTransparency_4 = Library.CreateObject("ImageLabel", {
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Name = "ImageTransparency_4",
            Image = "rbxassetid://70692989220220",
            BackgroundTransparency = 1,
            Position = UDim2_new(0, 1, 0, 1),
            Size = UDim2_new(1, -2, 1, -2),
            BorderSizePixel = 0,
            ImageColor3 = ThemeDefault.LightContrast,
            Parent = ColorPickerOutline_4
        }); Library.AddTheme(ImageTransparency_4, { ImageColor3 = "LightContrast" })

        local Gradient_24 = Library.CreateObject("Frame", {
            Size = UDim2_new(1, -2, 1, -2),
            Name = "Gradient_24",
            Position = UDim2_new(0, 1, 0, 1),
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            BackgroundTransparency = 1 - Options.Transparency,
            ZIndex = 2,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3_fromRGB(255, 255, 255),
            Parent = ColorPickerOutline_4
        })

        local UIGradient_38 = Library.CreateObject("UIGradient", {
            Rotation = 90,
            Color = ColorSequence_new{ColorSequenceKeypoint_new(0, ColorPicker.Color), ColorSequenceKeypoint_new(1, Library.SubtractColor(ColorPicker.Color, 44))},
            Parent = Gradient_24
        })

        do -- Functions
            function ColorPicker.Set(Color, Transparency, IgnoreUpdate)
                if typeof(Color) == "table" then
                    local H, S, V = math_clamp(Color[1], 0, 1), math_clamp(Color[2], 0, 1), math_clamp(Color[3], 0, 1)
                    local Transparency = math_clamp(Color[4] or 1, 0, 1)
                    local Animations = Color[5] or {}

                    ColorPicker.Color = Color3_fromHSV(H, S, V)
                    ColorPicker.Alpha = Transparency
                    ColorPicker.Hue = Color[1]
                    ColorPicker.Saturation[1] = Color[2]
                    ColorPicker.Saturation[2] = Color[3]
                    UIGradient_38.Color = ColorSequence_new{ColorSequenceKeypoint_new(0, ColorPicker.Color), ColorSequenceKeypoint_new(1, Library.SubtractColor(ColorPicker.Color, 44))}
                    Gradient_24.BackgroundTransparency = 1 - ColorPicker.Alpha

                    for _, Animation in Animations do
                        ColorPicker.SelectedModes[Animation] = true
                    end
                elseif typeof(Color) == "Color3" then
                    local Red = math_clamp(Color.R, 0, 1)
                    local Green = math_clamp(Color.G, 0, 1)
                    local Blue = math_clamp(Color.B, 0, 1)
                    
                    local SanityColor = Color3_new(Red, Green, Blue)
                    local H, S, V = SanityColor:ToHSV()

                    ColorPicker.Color = Color3_fromHSV(H, S, V)
                    ColorPicker.Alpha = Transparency or 1
                    ColorPicker.Hue = H
                    ColorPicker.Saturation[1] = S
                    ColorPicker.Saturation[2] = V
                    UIGradient_38.Color = ColorSequence_new{ColorSequenceKeypoint_new(0, ColorPicker.Color), ColorSequenceKeypoint_new(1, Library.SubtractColor(ColorPicker.Color, 44))}
                    Gradient_24.BackgroundTransparency = 1 - ColorPicker.Alpha
                end

                Flags[Options.Flag] = ColorPicker
                Options.Callback(ColorPicker.Color, ColorPicker.Alpha)

                if (not IgnoreUpdate) and ColorPicker.ActiveFrame then
                    Library.UpdateColorPicker(true, ColorPickerOutline_4.Name, ColorPicker)
                end
            end

            function ColorPicker.Get()
                return {Color = ColorPicker.Color, Transparency = ColorPicker.Transparency, Animations = ColorPicker.SelectedModes}
            end

            function ColorPicker.Animations(List)
                ColorPicker.SelectedModes = List
            end

            function ColorPicker.SetInternal(Color, Transparency)
                if typeof(Color) ~= "Color3" then return end

                ColorPicker.InternalColor = Color
                ColorPicker.InternalTransparency = Transparency
                Options.Callback(Color, Transparency)
            end

            function ColorPicker.MouseEnter()
                if Library.MouseOverOtherWindow(Options.MainUI) then
                    ColorPicker.MouseLeave()

                    return
                end

                ColorPicker.Hovering = true

                if (not ColorPicker.Active) and (not ColorPicker.Fading) then
                    Library.TweenObject(WhiteFrame, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {BackgroundTransparency = 0.95})

                    ColorPicker.Fading = true
                end
            end

            function ColorPicker.MouseLeave()
                ColorPicker.Hovering = false

                if ColorPicker.ActiveFrame then
                    return
                end

                if ColorPicker.Fading and (not ColorPicker.Active) and (not ColorPicker.ModeList) then
                    Library.TweenObject(WhiteFrame, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {BackgroundTransparency = 1})

                    ColorPicker.Fading = false
                end
            end
        end
        
        do -- Connections
            Library.AddConnection(ColorPickerOutline_4.Parent.Parent:GetPropertyChangedSignal("AbsoluteSize"), LPH_NO_VIRTUALIZE(function()
                ColorPickerOutline_4.Size = UDim2_new(0, 24, 0, math_clamp(ColorPickerOutline_4.Parent.Parent.AbsoluteSize.Y, -1000, 13))
            end))

            Library.AddConnection(Button_14.MouseButton1Click, LPH_NO_VIRTUALIZE(function()
                if Library.FindColorPicker(ColorPickerOutline_4.Name) then
                    Library.RemoveColorPicker(ColorPickerOutline_4.Name)
                    ColorPicker.ActiveFrame = false

                    return
                end

                Library.TweenObject(WhiteFrame, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {BackgroundTransparency = 0.95})
                ColorPicker.ActiveFrame = true
                Library.UpdateColorPicker(true, ColorPickerOutline_4.Name, ColorPicker)
            end))

            Library.AddConnection(ColorPickerOutline_4.MouseEnter, LPH_NO_VIRTUALIZE(function()
                if not Options.MainUI.Visible then
                    return
                end

                if not Library.MouseOverFrame(Options.MainUI) then
                    return
                end

                ColorPicker.MouseEnter()

                if ColorPicker.MouseConnection then
                    ColorPicker.MouseConnection:Disconnect()
                    ColorPicker.MouseConnection = nil
                end

                ColorPicker.MouseConnection = Library.AddConnection(UserInputService.InputChanged, function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseMovement then
                        if not Library.MouseOverFrame(ColorPickerOutline_4) then
                            ColorPicker.MouseLeave()
                            ColorPicker.MouseConnection:Disconnect()
                            ColorPicker.MouseConnection = nil
                        end
                    end
                end)
            end))
        end
    end

    function Library.CreateButton(Options)
        Options = Library.Validate({
            Name = "Button",
            Confirmation = false,
            Risky = false,
            ToolTip = "",
            Parent = nil,
            MainUI = nil,
            LayoutOrder = 1,
            Size = UDim2_new(1, 0, 0, 18),
            Position = UDim2_new(0, 0, 0, 0),
            Callback = function() end
        }, Options or {})
        
        local Button = {
            MouseDown = false,
            Fading = false,
            Hovering = false,
            WaitingForConfirm = false,
            ConfirmationConnection = nil,
            ConfirmationTime = 0,
        }

        local LibraryFontSize = UITable.FontSize
        local LibraryFont = UITable.Font
        local ButtonOutline = Library.CreateObject("Frame", {
            Name = "ButtonTemplate",
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Size = UDim2_new(1, 0, 0, 20),
            BorderSizePixel = 0,
            LayoutOrder = Options.LayoutOrder,
            BackgroundColor3 = ThemeDefault.Outline,
            Parent = Options.Parent
        }); Library.AddTheme(ButtonOutline, { BackgroundColor3 = "Outline" })

        local ButtonShadow = Library.CreateObject("UIShadow", {
            Name = "ButtonShadow",
            Transparency = 0.6,
            BlurRadius = UDim_new(0, 10),
            Parent = ButtonOutline
        })

        local Button_1 = Library.CreateObject("TextButton", {
            FontFace = Font_new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
            TextColor3 = ThemeDefault.Outline,
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Name = "Button_1",
            BackgroundTransparency = 1,
            Size = UDim2_new(1, 0, 1, 0),
            BorderSizePixel = 0,
            TextTransparency = 1,
            ZIndex = 10,
            TextSize = 14,
            BackgroundColor3 = Color3_fromRGB(255, 255, 255),
            Parent = ButtonOutline
        }); Library.AddTheme(Button_1, { TextColor3 = "Outline" })

        local Gradient_2 = Library.CreateObject("Frame", {
            Name = "Gradient_2",
            Position = UDim2_new(0, 1, 0, 1),
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Size = UDim2_new(1, -2, 1, -2),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3_fromRGB(255, 255, 255),
            Parent = ButtonOutline
        })

        local WhiteFrame = Library.CreateObject("Frame", {
            Name = "WhiteFrame",
            Position = UDim2_new(0, 0, 0, 0),
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Size = UDim2_new(1, 0, 1, 0),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            BackgroundColor3 = Color3_fromRGB(255, 255, 255),
            ZIndex = 3,
            Parent = Gradient_2
        })

        local ButtonText = Library.CreateObject("TextLabel", {
            FontFace = LibraryFont,
            TextColor3 = Options.Risky and ThemeDefault.Risky or ThemeDefault.TextColor,
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Text = Options.Name,
            Name = "ButtonText",
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2_new(1, 0, 1, 0),
            ZIndex = 5,
            TextSize = LibraryFontSize,
            BackgroundColor3 = Color3_fromRGB(255, 255, 255),
            Parent = Gradient_2
        }); Library.AddTheme(ButtonText, {TextColor3 = Options.Risky and "Risky" or "TextColor"})

        local UIPadding_6 = Library.CreateObject("UIPadding", {
            PaddingBottom = UDim.new(0, 1),
            Parent = ButtonText
        })

        local UIStroke_4 = Library.CreateObject("UIStroke", {
            LineJoinMode = Enum.LineJoinMode.Miter,
            Parent = ButtonText
        })

        local UIGradient_7 = Library.CreateObject("UIGradient", {
            Rotation = 90,
			Color = ColorSequence_new({ ColorSequenceKeypoint_new(0, ThemeDefault.LightContrast), ColorSequenceKeypoint_new(1, ThemeDefault.DarkContrast) }),
			Parent = Gradient_2
		}); Library.AddTheme(UIGradient_7, { Color = {"LightContrast", "DarkContrast"} })

        do -- Functions
            function Button.ChangeCallback(Callback)
                Options.Callback = Callback
            end

            function Button.UpdateSize(Size)
                ButtonOutline.Size = Size
            end
            
            function Button.UpdatePosition(Position)
                ButtonOutline.Position = Position
            end

            function Button.SetVisible(Bool)
                Button.MouseLeave()
                ButtonOutline.ZIndex = Bool and 3 or 0
                --Library.TweenObject(ButtonOutline, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {GroupTransparency = Bool and 0 or 1})
                --Library.TweenDescendants(Bool, Library.GetAllObjects(ButtonOutline))
                --Library.TweenObject(ButtonOutline, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {Size = Bool and UDim2_new(1, 0, 0, 18) or UDim2_new(1, 0, 0, -4)})
                ButtonOutline.Visible = Bool

                return Button
            end

            function Button.ConfirmationStart()
                Button.MouseDown = true
                Button.WaitingForConfirm = true
                Button.ConfirmationTime = 5
                ButtonText.Text = "Confirm? (" .. Button.ConfirmationTime .. "s)"
                
                if Button.ConfirmationConnection then
                    coroutine_close(Button.ConfirmationConnection)
                    Button.ConfirmationConnection = nil
                end
                
                Button.ConfirmationConnection = coroutine_create(function()
                    for i = 1, 5 do 
                        task_wait(1)
                        
                        Button.ConfirmationTime = Button.ConfirmationTime - 1
                        
                        if Button.ConfirmationTime > 0 then
                            ButtonText.Text = "Confirm? (" .. Button.ConfirmationTime .. "s)"
                        else
                            ButtonText.Text = Options.Name
                            
                            if Button.MouseDown then
                                Library.TweenObject(ButtonText, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {TextColor3 = Options.Risky and ThemeDefault.Risky or ThemeDefault.TextColor}, function()
                                    Library.AddTheme(ButtonText, {TextColor3 = Options.Risky and "Risky" or "TextColor"})
                                end)

                                Button.MouseDown = false
                                Button.WaitingForConfirm = false
                            end
                            
                            break
                        end
                    end
                end)
                
                coroutine_resume(Button.ConfirmationConnection)
            end

            function Button.MouseEnter()
                if Library.MouseOverOtherWindow(Options.MainUI) then
                    Button.MouseLeave()

                    return
                end

                if Library.MouseOverOtherObject() then
                    Button.MouseLeave()
                    
                    return
                end

                Button.Hovering = true

                if Button.MouseDown or Button.WaitingForConfirm then
                    return
                end

                if not Button.Fading then
                    Library.TweenObject(WhiteFrame, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {BackgroundTransparency = 0.95})

                    Button.Fading = true
                end
            end

            function Button.MouseLeave()
                Button.Hovering = false

                if Button.MouseDown or Button.WaitingForConfirm then
                    return
                end

                if Button.Fading then
                    Library.TweenObject(WhiteFrame, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {BackgroundTransparency = 1})

                    Button.Fading = false
                end
            end
        end

        do -- Connections
            Library.AddConnection(Button_1.MouseButton1Down, LPH_NO_VIRTUALIZE(function()
                if Library.MouseOverOtherWindow(Options.MainUI) then
                    return
                end

                if Library.MouseOverOtherObject() then
                    return
                end

                Library.TweenObject(ButtonText, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {TextColor3 = ThemeDefault.Accent}, function()
                    Library.AddTheme(ButtonText, {TextColor3 = Options.Risky and "Risky" or "TextColor"})
                end)

                if Options.Confirmation then
                    if not Button.WaitingForConfirm then
                        Button.ConfirmationStart()
                    else
                        if Button.ConfirmationConnection then
                            coroutine_close(Button.ConfirmationConnection)
                            Button.ConfirmationConnection = nil
                        end
                        
                        Options.Callback()
                        Button.MouseDown = true
                        Button.WaitingForConfirm = false
                        ButtonText.Text = Options.Name
                    end
                else
                    Options.Callback()
                    Button.MouseDown = true
                end
            end))

            Library.AddConnection(UserInputService.InputEnded, LPH_NO_VIRTUALIZE(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 and Button.MouseDown and not Button.WaitingForConfirm then
                    Button.MouseDown = false

                    Library.TweenObject(ButtonText, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {TextColor3 = Options.Risky and ThemeDefault.Risky or ThemeDefault.TextColor}, function()
                        Library.AddTheme(ButtonText, {TextColor3 = Options.Risky and "Risky" or "TextColor"})
                    end)
                end
            end))

            Library.AddConnection(ButtonOutline.MouseEnter, LPH_NO_VIRTUALIZE(function()
                if not Options.MainUI.Visible then
                    return
                end
                
                if not Library.MouseOverFrame(Options.MainUI) then
                    return
                end

                Button.MouseEnter()

                if Button.MouseConnection then
                    Button.MouseConnection:Disconnect()
                    Button.MouseConnection = nil
                end

                Button.MouseConnection = Library.AddConnection(UserInputService.InputChanged, function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseMovement then
                        if not Library.MouseOverFrame(ButtonOutline) then
                            Button.MouseLeave()
                            Button.MouseConnection:Disconnect()
                            Button.MouseConnection = nil
                        end
                    end
                end)
            end))
        end

        return Button
    end

    function Library.CreateTextBox(Options)
         Options = Library.Validate({
            Default = "",
            Name = "TextBox",
            Parent = nil,
            MainUI = nil,
            IgnoreConfig = false,
            NumbersOnly = false,
            ClearOnFocus = false,
            CheckIfPressedEnter = false,
            Risky = false,
            ToolTip = "",
            Max = 32,
            Size = UDim2_new(1, 0, 0, 18),
            Position = UDim2_new(0, 0, 0, 0),
            AnchorPoint = Vector2_new(0, 0),
            Flag = Library.NewFlag(),
            Callback = function() end
        }, Options or {})
        
        local TextBox = {
            Value = Options.Default,
            IgnoreConfig = Options.IgnoreConfig,
            Focused = false,
            Fading = false,
            Hovering = false,
        }
        
        Flags[Options.Flag] = TextBox

        local LibraryFontSize = UITable.FontSize
        local LibraryFont = UITable.Font
        local TextBoxOutline = Library.CreateObject("Frame", {
            Name = "TextBoxTemplate",
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Size = UDim2_new(1, 0, 0, 20),
            BorderSizePixel = 0,
            LayoutOrder = Options.LayoutOrder,
            BackgroundColor3 = ThemeDefault.Outline,
            Parent = Options.Parent
        }); Library.AddTheme(TextBoxOutline, { BackgroundColor3 = "Outline" })

        local TextBoxOutline1 = Library.CreateObject("UIShadow", {
            Name = "TextBoxOutline1",
            Transparency = 0.6,
            BlurRadius = UDim_new(0, 7),
            Parent = TextBoxOutline
        })

        local ActualTextBox = Library.CreateObject("TextBox", {
            FontFace = LibraryFont,
            TextSize = LibraryFontSize,
            Name = "ActualTextBox",
            Text = Options.Default,
            PlaceholderText = Options.Name,
            PlaceholderColor3 = Options.Risky and ThemeDefault.Risky or ThemeDefault.TextDark,
            ClearTextOnFocus = Options.ClearOnFocus,
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Size = UDim2_new(1, 0, 1, 0),
            TextColor3 = Options.Risky and ThemeDefault.Risky or ThemeDefault.TextColor,
            BorderSizePixel = 0,
            Active = true,
            ZIndex = 3,
            BackgroundColor3 = Color3_fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            Parent = TextBoxOutline
        }); Library.AddTheme(ActualTextBox, {TextColor3 = Options.Risky and "Risky" or "TextColor", PlaceholderColor3 = Options.Risky and "Risky" or "TextDark"})

        local UIPadding_6 = Library.CreateObject("UIPadding", {
            PaddingBottom = UDim.new(0, 2),
            Parent = ActualTextBox
        })

        local UIStroke_4 = Library.CreateObject("UIStroke", {
            LineJoinMode = Enum.LineJoinMode.Miter,
            Parent = ActualTextBox
        })

        local Gradient_2 = Library.CreateObject("Frame", {
            Name = "Gradient_2",
            Position = UDim2_new(0, 1, 0, 1),
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Size = UDim2_new(1, -2, 1, -2),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3_fromRGB(255, 255, 255),
            Parent = TextBoxOutline
        })

        local WhiteFrame = Library.CreateObject("Frame", {
            Name = "WhiteFrame",
            Position = UDim2_new(0, 0, 0, 0),
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Size = UDim2_new(1, 0, 1, 0),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            BackgroundColor3 = Color3_fromRGB(255, 255, 255),
            ZIndex = 3,
            Parent = Gradient_2
        })

        local UIGradient_7 = Library.CreateObject("UIGradient", {
            Rotation = 90,
			Color = ColorSequence_new({ ColorSequenceKeypoint_new(0, ThemeDefault.LightContrast), ColorSequenceKeypoint_new(1, ThemeDefault.DarkContrast) }),
			Parent = Gradient_2
		}); Library.AddTheme(UIGradient_7, { Color = {"LightContrast", "DarkContrast"} })

        do -- Functions
            function TextBox.SetVisible(Bool)
                TextBox.MouseLeave()
                TextBoxOutline.ZIndex = Bool and 3 or 0
                --Library.TweenObject(TextBoxOutline, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {GroupTransparency = Bool and 0 or 1})
                --Library.TweenDescendants(Bool, Library.GetAllObjects(TextBoxOutline))
                --Library.TweenObject(TextBoxOutline, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {Size = Bool and UDim2_new(1, 0, 0, 18) or UDim2_new(1, 0, 0, -4)})
                TextBoxOutline.Visible = Bool

                return TextBox
            end
            
            function TextBox.Get()
                return ActualTextBox.Text
            end
            
            function TextBox.Set(Text)
                ActualTextBox.Text = Text
                TextBox.Value = Text
            end

            function TextBox.MouseEnter()
                if Library.MouseOverOtherWindow(Options.MainUI) then
                    TextBox.MouseLeave()

                    return
                end

                if Library.MouseOverOtherObject() then
                    TextBox.MouseLeave()
                    
                    return
                end

                TextBox.Hovering = true

                if TextBox.Focused then
                    return
                end

                if not TextBox.Fading then
                    Library.TweenObject(WhiteFrame, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {BackgroundTransparency = 0.95})

                    TextBox.Fading = true
                end
            end

            function TextBox.MouseLeave()
                TextBox.Hovering = false

                if TextBox.Focused then
                    return
                end

                if TextBox.Fading then
                    Library.TweenObject(WhiteFrame, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {BackgroundTransparency = 1})

                    TextBox.Fading = false
                end
            end
        end

        do -- Connections
            Library.AddConnection(ActualTextBox:GetPropertyChangedSignal("Text"), LPH_NO_VIRTUALIZE(function()
                ActualTextBox.Text = string_sub(ActualTextBox.Text, 1, Options.Max)
                
                if Options.NumbersOnly then
                    ActualTextBox.Text = string_gsub(ActualTextBox.Text, "[^%d%.%-]+", "")
                end

                TextBox.Value = ActualTextBox.Text
            end))
            
            Library.AddConnection(ActualTextBox.Focused, LPH_NO_VIRTUALIZE(function()
                TextBox.Focused = true
            end))
            
            Library.AddConnection(ActualTextBox.FocusLost, LPH_NO_VIRTUALIZE(function(EnterPressed)
                if Options.CheckIfPressedEnter and not EnterPressed then
                    return
                end
                
                TextBox.Focused = false
                TextBox.MouseLeave()

                Flags[Options.Flag] = TextBox
                Options.Callback(ActualTextBox.Text)
            end))

            Library.AddConnection(TextBoxOutline.MouseEnter, LPH_NO_VIRTUALIZE(function()
                if not Options.MainUI.Visible then
                    return
                end
                
                if not Library.MouseOverFrame(Options.MainUI) then
                    return
                end

                TextBox.MouseEnter()

                if TextBox.MouseConnection then
                    TextBox.MouseConnection:Disconnect()
                    TextBox.MouseConnection = nil
                end

                TextBox.MouseConnection = Library.AddConnection(UserInputService.InputChanged, function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseMovement then
                        if not Library.MouseOverFrame(TextBoxOutline) then
                            TextBox.MouseLeave()
                            TextBox.MouseConnection:Disconnect()
                            TextBox.MouseConnection = nil
                        end
                    end
                end)
            end))
        end

        return TextBox
    end

    function Library.CreateList(Options)
        Options = Library.Validate({
            Name = "List",
            MainUI = nil,
            Size = UDim2_new(1, 0, 0, 100),
            Flag = Library.NewFlag(),
            IgnoreConfig = false,
            Callback = function() end
        }, Options or {})
        
        local List = {
            IgnoreConfig = Options.IgnoreConfig,
            CurrentItem = nil,
            CurrentItemName = nil,
            PlayerSelected = Instance_new("BindableEvent"),
            Items = {},
        }
        
        Flags[Options.Flag] = List

        local LibraryFontSize = UITable.FontSize
        local LibraryFont = UITable.Font
        local ListTemplate = Library.CreateObject("Frame", {
            Name = "ListTemplate",
            BackgroundTransparency = 1,
            Size = UDim2_new(1, 0, 0, 13),
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundColor3 = Color3_fromRGB(255, 255, 255),
            Parent = Options.Parent
        })

        local Title = Library.CreateObject("TextLabel", {
            FontFace = LibraryFont,
            TextColor3 = Options.Risky and ThemeDefault.Risky or ThemeDefault.TextColor,
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Text = Options.Name,
            Visible = Options.Name ~= "",
            BackgroundTransparency = 1,
            Name = "Title",
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.XY,
            TextSize = LibraryFontSize,
            BackgroundColor3 = ThemeDefault.DarkContrast,
            Parent = ListTemplate
        }); Library.AddTheme(Title, { TextColor3 = Options.Risky and "Risky" or "TextColor", BackgroundColor3 = "DarkContrast" })

        local UIStroke = Library.CreateObject("UIStroke", {
            LineJoinMode = Enum.LineJoinMode.Miter,
            Parent = Title
        })

        local UIPadding = Library.CreateObject("UIPadding", {
            PaddingLeft = UDim.new(0, 1),
            Parent = Title
        })

        local ActualList = Library.CreateObject("Frame", {
            Name = "ActualList",
            Size = Options.Size,
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            BorderSizePixel = 0,
            LayoutOrder = 2,
            BackgroundColor3 = ThemeDefault.Outline,
            Parent = ListTemplate
        }); Library.AddTheme(ActualList, { BackgroundColor3 = "Outline" })

        local ActualList1 = Library.CreateObject("UIShadow", {
            Name = "ActualList1",
            Transparency = 0.6,
            BlurRadius = UDim_new(0, 7),
            Parent = ActualList
        })

        local Gradient = Library.CreateObject("Frame", {
            Name = "Gradient",
            Position = UDim2_new(0, 1, 0, 1),
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Size = UDim2_new(1, -2, 1, -2),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3_fromRGB(255, 255, 255),
            Parent = ActualList
        })

        local Holder = Library.CreateObject("ScrollingFrame", {
            Active = true,
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            BorderSizePixel = 0,
            CanvasSize = UDim2_new(0, 0, 0, 0),
            ScrollBarImageColor3 = ThemeDefault.Accent,
            MidImage = "rbxassetid://95591733073455",
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            ScrollBarThickness = 3,
            Name = "Holder",
            BackgroundTransparency = 1,
            Size = UDim2_new(1, 0, 1, 0),
            BottomImage = "rbxassetid://95591733073455",
            TopImage = "rbxassetid://95591733073455",
            BackgroundColor3 = Color3_fromRGB(255, 255, 255),
            Parent = Gradient
        }); Library.AddTheme(Holder, { ScrollBarImageColor3 = "Accent" })

        local UIListLayout = Library.CreateObject("UIListLayout", {
            Padding = UDim.new(0, 4),
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = Holder
        })

        local UIPadding_1 = Library.CreateObject("UIPadding", {
            PaddingRight = UDim.new(0, 6),
            PaddingLeft = UDim.new(0, 5),
            Parent = Holder
        })

        local UIPadding_2 = Library.CreateObject("UIPadding", {
            PaddingBottom = UDim.new(0, 4),
            PaddingTop = UDim.new(0, 4),
            PaddingRight = UDim.new(0, 4),
            Parent = Gradient
        })

        local UIGradient = Library.CreateObject("UIGradient", {
            Rotation = 90,
			Color = ColorSequence_new({ ColorSequenceKeypoint_new(0, ThemeDefault.LightContrast), ColorSequenceKeypoint_new(1, ThemeDefault.DarkContrast) }),
			Parent = Gradient
		}); Library.AddTheme(UIGradient, { Color = {"LightContrast", "DarkContrast"} })

        local UIListLayout_9 = Library.CreateObject("UIListLayout", {
            Padding = UDim.new(0, 6),
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = ListTemplate
        })

        do -- Functions
            function List.SetVisible(Bool)
                ListTemplate.ZIndex = Bool and 3 or 0
                --Library.TweenObject(ListTemplate, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {GroupTransparency = Bool and 0 or 1})
                --Tween.TweenDescendants(Bool, Library.GetAllObjects(ListTemplate))
                --Library.TweenObject(ListTemplate, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {Size = Bool and Options.Size or UDim2_new(Options.Size.X.Scale, Options.Size.X.Offset, 0, -4)})
                ListTemplate.Visible = false

                return List
            end

            function List.Get(IsWhole)
                if not List.CurrentItem then
                    return
                end

                return IsWhole and List.CurrentItem or List.CurrentItem.Name
            end

            function List.Set(Item, IsValue)
                for Name, ItemObject in List.Items do
                    if Name == Item then
                        ItemObject.Activate()

                        if IsValue then
                            ItemObject.Value = Value
                        end
                    else
                        ItemObject.Deactivate()
                    end
                end
            end

            function List.FindValue(Item)
                return FindFirstChild(Holder, Item)
            end

            function List.ClearSelected()
                for Name, ItemObject in List.Items do
                    ItemObject.Deactivate()
                end
            end

            function List.AddValue(Item, LayoutOrder, IconSettings)
                local ExistingObject = FindFirstChild(Holder, Item)

                if ExistingObject then
                    return
                end

                local ItemObject = {
                    Active = false,
                    Hovering = false,
                    Fading = false,
                    Name = Item,
                }

                List.Items[Item] = ItemObject

                local ItemTemplate = Library.CreateObject("Frame", {
                    BackgroundTransparency = 1,
                    Name = Item,
                    LayoutOrder = LayoutOrder or 1,
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    Size = UDim2_new(1, 0, 0, 15),
                    BorderSizePixel = 0,
                    ZIndex = 2,
                    BackgroundColor3 = Color3_fromRGB(255, 255, 255),
                    Parent = Holder
                })

                local TextButton = Library.CreateObject("TextButton", {
                    FontFace = LibraryFont,
                    TextColor3 = ThemeDefault.TextColor,
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    Text = Item,
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.XY,
                    TextSize = LibraryFontSize,
                    ZIndex = 50,
                    BackgroundColor3 = Color3_fromRGB(255, 255, 255),
                    Parent = ItemTemplate
                }); Library.AddTheme(TextButton, { TextColor3 = "TextColor" })

                local UIStroke_1 = Library.CreateObject("UIStroke", {
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Parent = TextButton
                })

                local ImageLabel = Library.CreateObject("ImageLabel", {
                    Visible = IconSettings ~= nil,
                    ScaleType = Enum.ScaleType.Fit,
                    BackgroundTransparency = 1,
                    Image = IconSettings and IconSettings.Image or "rbxassetid://1",
                    ImageColor3 = IconSettings and IconSettings.Color or Color3_fromRGB(255, 255, 255),
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    Size = UDim2_new(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3_fromRGB(255, 255, 255),
                    Parent = ItemTemplate
                })

                local UIAspectRatioConstraint = Library.CreateObject("UIAspectRatioConstraint", {
                    Parent = ImageLabel
                })

                local UIListLayout_1 = Library.CreateObject("UIListLayout", {
                    FillDirection = Enum.FillDirection.Horizontal,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, 6),
                    Parent = ItemTemplate
                })

                do -- Functions
                    function ItemObject.Activate()
                        if Library.MouseOverOtherWindow(Options.MainUI) then
                            return
                        end

                        if Library.MouseOverOtherObject() then
                            return
                        end

                        if not ItemObject.Active then
                            if List.CurrentItem then
                                List.CurrentItem.Deactivate()
                            end

                            Library.TweenObject(TextButton, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {TextColor3 = ThemeDefault.Accent}, function()
                                Library.AddTheme(TextButton, {TextColor3 = "Accent"}, "TextColor")
                            end)

                            List.PlayerSelected:Fire(Item)
                            ItemObject.Active = true
                            List.CurrentItem = ItemObject
                            Flags[Options.Flag] = List
                            Options.Callback(Item)
                        end
                    end

                    function ItemObject.Deactivate()
                        if ItemObject.Active then
                            ItemObject.Active = false
                            ItemObject.Fading = false

                            Library.TweenObject(TextButton, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {TextColor3 = ThemeDefault.TextColor}, function()
                                Library.AddTheme(TextButton, {TextColor3 = "TextColor"}, "Accent")
                            end)
                        end
                    end

                    function ItemObject.MouseEnter()
                        ItemObject.Hovering = true

                        if Library.MouseOverOtherWindow(Options.MainUI) then
                            return
                        end

                        if Library.MouseOverOtherObject() then
                            return
                        end

                        if (not ItemObject.Fading) and (not ItemObject.Active) then
                            Library.TweenObject(TextButton, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {TextColor3 = ThemeDefault.TextDark}, function()
                                Library.AddTheme(TextButton, {TextColor3 = "TextDark"})
                            end)

                            ItemObject.Fading = true
                        end
                    end

                    function ItemObject.MouseLeave()
                        ItemObject.Hovering = false

                        if ItemObject.Fading and not ItemObject.Active then
                            Library.TweenObject(TextButton, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {TextColor3 = ThemeDefault.TextColor}, function()
                                Library.AddTheme(TextButton, {TextColor3 = "TextColor"})
                            end)

                            ItemObject.Fading = false
                        end
                    end
                end

                do -- Connections
                    Library.AddConnection(TextButton.MouseButton1Click, ItemObject.Activate)
                    Library.AddConnection(ItemTemplate.MouseEnter, LPH_NO_VIRTUALIZE(function()
                        if not Options.MainUI.Visible then
                            return
                        end

                        ItemObject.MouseEnter()

                        if ItemObject.MouseConnection then
                            ItemObject.MouseConnection:Disconnect()
                            ItemObject.MouseConnection = nil
                        end

                        ItemObject.MouseConnection = Library.AddConnection(UserInputService.InputChanged, function(Input)
                            if Input.UserInputType == Enum.UserInputType.MouseMovement then
                                if not Library.MouseOverFrame(ItemTemplate) then
                                    ItemObject.MouseLeave()
                                    ItemObject.MouseConnection:Disconnect()
                                    ItemObject.MouseConnection = nil
                                end
                            end
                        end)
                    end))
                end
            end

            function List.RemoveValue(Item)
                for _, Object in Holder:GetChildren() do
                    if Object.Name == Item then
                        Object:Destroy()
                    end
                end

                if List.Items[Item] then List.Items[Item] = nil end
            end

            function List.ClearValues()
                List.ClearSelected()

                for _, Value in GetChildren(Holder) do
                    if IsA(Value, "Frame") then
                        Value:Destroy()
                    end
                end

                table_clear(List.Items)
                List.PlayerSelected:Fire(nil)
            end
        end

        return List
    end

	function Library.CreateToggle(Options)
		Options = Library.Validate({
			Default = false,
			Name = "Toggle",
			Risky = false,
			Debounce = false,
			ToolTip = "",
			SectionName = nil,
			Parent = nil,
			MainUI = nil,
			Flag = Library.NewFlag(),
			Callback = function() end
		}, Options or {})

		local Toggle = {
			MainUI = Options.MainUI,
			Debounce = Options.Debounce,
			MainTable = Options.MainTable,
			Fading = false,
			Active = false,
			Hovering = false,
			Value = false,
			KeybindObject = nil,
			ColorPickers = {},
		}

		Flags[Options.Flag] = Toggle

		local LibraryFontSize = UITable.FontSize
		local LibraryFont = UITable.Font
		local ToggleMain_2 = Library.CreateObject("Frame", {
			BackgroundTransparency = 1,
			Name = "ToggleTemplate_4",
			BorderColor3 = Color3_fromRGB(0, 0, 0),
			Size = UDim2_new(1, 0, 0, 14),
			BorderSizePixel = 0,
			BackgroundColor3 = Color3_fromRGB(255, 255, 255),
			Parent = Options.Parent
		})

		local ToggleHighlight = Library.CreateObject("Frame", {
			BackgroundTransparency = 1,
			Name = "ToggleHighlight",
			BorderColor3 = Color3_fromRGB(0, 0, 0),
			Size = UDim2_new(0.5, 0, 1, 0),
			BorderSizePixel = 0,
            ZIndex = 3,
			BackgroundColor3 = Color3_fromRGB(255, 255, 255),
			Parent = ToggleMain_2
		})
		
		local ToggleOutline_2 = Library.CreateObject("Frame", {
			Name = "Toggle_4",
			BorderColor3 = Color3_fromRGB(0, 0, 0),
            AnchorPoint = Vector2_new(0, 0.5),
            Position = UDim2_new(0, 0, 0.5, 0),
			Size = UDim2_new(0, 13, 0, 13),
			BorderSizePixel = 0,
			BackgroundColor3 = ThemeDefault.Outline,
			Parent = ToggleMain_2
		}); Library.AddTheme(ToggleOutline_2, { BackgroundColor3 = "Outline" })

        local ToggleOutline_21 = Library.CreateObject("UIShadow", {
            Name = "ToggleOutline_2",
            Transparency = 0.6,
            BlurRadius = UDim_new(0, 7),
            Parent = ToggleOutline_2
        })

		local ToggleActive_2 = Library.CreateObject("Frame", {
			Name = "Active_4",
			BackgroundTransparency = 1,
			Position = UDim2_new(0, 1, 0, 1),
			ZIndex = 5,
			BorderColor3 = Color3_fromRGB(0, 0, 0),
			Size = UDim2_new(1, -2, 1, -2),
			BorderSizePixel = 0,
			BackgroundColor3 = Color3_fromRGB(255, 255, 255),
			Parent = ToggleOutline_2
		})

        local WhiteFrame = Library.CreateObject("Frame", {
            Name = "WhiteFrame",
            Position = UDim2_new(0, 1, 0, 1),
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Size = UDim2_new(1, -2, 1, -2),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            BackgroundColor3 = Color3_fromRGB(255, 255, 255),
            ZIndex = 111,
            Parent = ToggleOutline_2
        })

		local UIGradient_36 = Library.CreateObject("UIGradient", {
			Rotation = 90,
			Color = ColorSequence_new({ ColorSequenceKeypoint_new(0, ThemeDefault.Accent), ColorSequenceKeypoint_new(1, ThemeDefault.SecondAccent) }),
			Parent = ToggleActive_2
		}); Library.AddTheme(UIGradient_36, { Color = {"Accent", "SecondAccent"} })

		local Inactive_4 = Library.CreateObject("Frame", {
			Name = "Inactive_4",
			Position = UDim2_new(0, 1, 0, 1),
			BorderColor3 = Color3_fromRGB(0, 0, 0),
			Size = UDim2_new(1, -2, 1, -2),
			BorderSizePixel = 0,
			BackgroundColor3 = Color3_fromRGB(255, 255, 255),
			Parent = ToggleOutline_2
		})

		local UIGradient_37 = Library.CreateObject("UIGradient", {
			Rotation = 90,
			Color = ColorSequence_new({ ColorSequenceKeypoint_new(0, ThemeDefault.LightContrast), ColorSequenceKeypoint_new(1, ThemeDefault.DarkContrast) }),
			Parent = Inactive_4
		}); Library.AddTheme(UIGradient_37, { Color = {"LightContrast", "DarkContrast"} })

		local Title_24 = Library.CreateObject("TextLabel", {
			FontFace = LibraryFont,
			TextColor3 = Options.Risky and ThemeDefault.Risky or ThemeDefault.TextColor,
			BorderColor3 = Color3_fromRGB(0, 0, 0),
			Text = Options.Name,
			Name = "Title_24",
			BackgroundTransparency = 1,
			Position = UDim2_new(0, 20, 0, -1),
            Size = UDim2_new(0, 0, 1, 0),
			BorderSizePixel = 0,
			AutomaticSize = Enum.AutomaticSize.X,
			TextSize = LibraryFontSize,
			Parent = ToggleOutline_2
		}); Library.AddTheme(Title_24, { TextColor3 = Options.Risky and "Risky" or "TextColor" })

		local UIStroke_95 = Library.CreateObject("UIStroke", {
			LineJoinMode = Enum.LineJoinMode.Miter,
			Parent = Title_24
		})

		local UIAspectRatioConstraint_26 = Library.CreateObject("UIAspectRatioConstraint", {
			Parent = ToggleOutline_2
		})

		local ExtrasHolder_2 = Library.CreateObject("Frame", {
			BorderColor3 = Color3_fromRGB(0, 0, 0),
			AnchorPoint = Vector2_new(1, 0),
			Name = "ExtraHolder_6",
			BackgroundTransparency = 1,
			Position = UDim2_new(1, 0, 0, 0),
			Size = UDim2_new(0, 0, 1, 0),
			BorderSizePixel = 0,
			AutomaticSize = Enum.AutomaticSize.X,
            ZIndex = 100,
			BackgroundColor3 = Color3_fromRGB(255, 255, 255),
			Parent = ToggleMain_2
		})
		
        local UIListLayout_46 = Library.CreateObject("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            Padding = UDim.new(0, 6),
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = ExtrasHolder_2
        })

		local Button = Library.CreateObject("TextButton", {
			FontFace = Font_new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
			TextColor3 = ThemeDefault.Outline,
			BorderColor3 = Color3_fromRGB(0, 0, 0),
			Name = "DragButton",
			BackgroundTransparency = 1,
			Size = UDim2_new(1, 0, 1, 0),
			BorderSizePixel = 0,
			TextTransparency = 1,
			TextSize = 14,
			ZIndex = 10,
			BackgroundColor3 = Color3_fromRGB(255, 255, 255),
			Parent = ToggleMain_2
		})

		do -- Functions
			function Toggle.SetInternal(Bool)
				Toggle.Value = Bool
				Options.Callback(Bool)
				Flags[Options.Flag] = Toggle
			end

			function Toggle.ToggleUI(Bool)
				if Bool ~= nil then
					Toggle.Value = Bool
				else
					Toggle.Value = not Toggle.Value
				end

				if Toggle.Value then
					Library.TweenObject(ToggleActive_2, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {BackgroundTransparency = 0})
				else
					Library.TweenObject(ToggleActive_2, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {BackgroundTransparency = 1})
				end

				Flags[Options.Flag] = Toggle
				Options.Callback(Toggle.Value)
			end

			function Toggle.Get()
				return Toggle.Value
			end

			function Toggle.Set(Bool)
				Toggle.ToggleUI(Bool)
			end

			function Toggle.SetVisible(Bool)
				Toggle.MouseLeave()
				ToggleMain_2.ZIndex = Bool and 3 or 0
				ExtrasHolder_2.ZIndex = Bool and 3 or 0
				--Library.TweenObject(ToggleMain_2, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {GroupTransparency = Bool and 0 or 1})
				--Library.TweenDescendants(Bool, Library.GetAllObjects(ToggleMain_2))
                ToggleMain_2.Visible = Bool
                --Library.TweenObject(ToggleMain_2, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {Size = Bool and UDim2_new(1, 0, 0, 14) or UDim2_new(1, 0, 0, -4)})
				--Library.TweenObject(ExtrasHolder_2, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {Size = Bool and UDim2_new(1, 0, 0, 14) or UDim2_new(1, 0, 0, -4)})
				
				return Toggle
			end

			function Toggle.GetName()
				return Options.Name
			end

			function Toggle.GetFlag()
				return Options.Flag
			end

			function Toggle.GetSection()
				return Options.SectionName
			end

			function Toggle.GetState()
				return Toggle.Value
			end

			function Toggle.GetCallback(Bool)
				Options.Callback(Bool)
			end

			function Toggle.Keybind(Options)
				Options = Library.Validate({
					Text = "",
					Mode = "Toggle",
					Default = nil,
					HideFromList = false,
					Blacklisted = {},
					Flag = Library.NewFlag(),
					Callback = function() end
				}, Options or {})

				local Keybind = Library.CreateKeybind({
					Text = Options.Text,
					Parent = ExtrasHolder_2,
					MainTable = Toggle.MainTable,
					Default = Options.Default,
					Debounce = Toggle.Debounce,
					Mode = Options.Mode,
					HideFromList = Options.HideFromList,
					Blacklisted = Options.Blacklisted,
					Toggle = Toggle,
					MainUI = Toggle.MainUI,
					ToggleState = Toggle.Value,
					Flag = Options.Flag,
					Callback = Options.Callback,
					Count = #Toggle.ColorPickers + 1,
					ColorPickers = Toggle.ColorPickers,
				})

				Toggle.KeybindObject = Keybind

				return Keybind
			end

			function Toggle.ColorPicker(Options)
				Options = Library.Validate({
					Name = "Color Picker",
					Transparency = 1,
					Default = Color3_fromRGB(255, 255, 255),
					Animations = {},
					Flag = Library.NewFlag(),
					Callback = function() end,
				}, Options or {})

				local ColorpickerIndex = #Toggle.ColorPickers + 1
				Toggle.ColorPickers[ColorpickerIndex] = {}

				local ColorPickerFrame = Library.CreateColorPicker({
					Parent = ExtrasHolder_2,
					Name = Options.Name,
					MainTable = Toggle.MainTable,
					Default = Options.Default,
					Flag = Options.Flag,
					Transparency = Options.Transparency,
					MainUI = Toggle.MainUI,
					Callback = Options.Callback,
					Animations = Options.Animations,
					Count = #Toggle.ColorPickers,
					ColorPickers = Toggle.ColorPickers,
				})

				Toggle.ColorPickers[ColorpickerIndex] = ColorPickerFrame

				return ColorPickerFrame
			end

            function Toggle.MouseEnter()
                if Library.MouseOverOtherWindow(Options.MainUI) then
                    Toggle.MouseLeave()

                    return
                end

                if Library.MouseOverOtherObject() then
                    Toggle.MouseLeave()

                    return
                end

                Toggle.Hovering = true

                if not Toggle.Fading then
                    Library.TweenObject(WhiteFrame, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {BackgroundTransparency = 0.95})

                    Toggle.Fading = true
                end
            end

            function Toggle.MouseLeave()
                Toggle.Hovering = false
            
                if Toggle.Fading then
                    Library.TweenObject(WhiteFrame, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {BackgroundTransparency = 1})
                    
                    Toggle.Fading = false
                end
            end
		end

		do -- Connections
			Library.AddConnection(Button.MouseButton1Click, LPH_NO_VIRTUALIZE(function()
				if Library.MouseOverOtherWindow(Options.MainUI) then
					return
				end

				if Library.MouseOverOtherObject() then
					return
				end

				Toggle.ToggleUI()
			end))

            Library.AddConnection(ToggleHighlight.MouseEnter, LPH_NO_VIRTUALIZE(function()
                if not Options.MainUI.Visible then
                    return
                end

                if not Library.MouseOverFrame(Options.MainUI) then
                    return
                end

                Toggle.MouseEnter()

                if Toggle.MouseConnection then
                    Toggle.MouseConnection:Disconnect()
                    Toggle.MouseConnection = nil
                end

                Toggle.MouseConnection = Library.AddConnection(UserInputService.InputChanged, function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseMovement then
                        if not Library.MouseOverFrame(ToggleHighlight) then
                            Toggle.MouseLeave()
                            Toggle.MouseConnection:Disconnect()
                            Toggle.MouseConnection = nil
                        end
                    end
                end)
            end))
		end

		if Options.ToolTip ~= "" then
			Library.CreateToolTip({
				MainTable = Options.MainTable,
				MainUI = Options.MainUI,
				Parent = ToggleHighlight,
				Text = Options.ToolTip,
			})
		end

		Toggle.ToggleUI(Options.Default)

		return Toggle
	end
    
	function Library.CreateLabel(Options)
		Options = Library.Validate({
			Message = "Label",
			Side = "Left",
			UseButton = false,
			Risky = false,
			Debounce = false,
			Parent = nil,
			SectionName = nil,
			MainUI = nil,
			ToolTip = "",
			ColoredTexts = {},
			Callback = function() end
		}, Options or {})

		local Label = {
			MainTable = Options.MainTable,
			MainUI = Options.MainUI,
			Debounce = Options.Debounce,
			KeybindState = false,
			Value = true,
			ColorPickers = {},
		}
		
		local LibraryFontSize = UITable.FontSize
		local LibraryFont = UITable.Font
		local LabelTemplate_2 = Library.CreateObject("CanvasGroup", {
			BackgroundTransparency = 1,
			Name = "LabelTemplate_2",
			BorderColor3 = Color3_fromRGB(0, 0, 0),
			Size = UDim2_new(1, 0, 0, 14),
			BorderSizePixel = 0,
			BackgroundColor3 = Color3_fromRGB(255, 255, 255),
			Parent = Options.Parent
		})

		local ExtraHolder_8 = Library.CreateObject("Frame", {
			BorderColor3 = Color3_fromRGB(0, 0, 0),
			AnchorPoint = Vector2_new(1, 0),
			Name = "ExtraHolder_8",
			BackgroundTransparency = 1,
			Position = UDim2_new(1, 0, 0, 0),
			Size = UDim2_new(0, 0, 1, 0),
			BorderSizePixel = 0,
			AutomaticSize = Enum.AutomaticSize.X,
			BackgroundColor3 = Color3_fromRGB(255, 255, 255),
			Parent = LabelTemplate_2
		})

		local UIListLayout_48 = Library.CreateObject("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Right,
			Padding = UDim.new(0, 6),
			SortOrder = Enum.SortOrder.LayoutOrder,
			Parent = ExtraHolder_8
		})

		local Title_27 = Library.CreateObject("TextLabel", {
			FontFace = LibraryFont,
			TextColor3 = Options.Risky and ThemeDefault.Risky or ThemeDefault.TextColor,
			BorderColor3 = Color3_fromRGB(0, 0, 0),
			AnchorPoint = Vector2_new(0, 0.5),
			Text = Options.Message,
			Name = "Title_27",
			BackgroundTransparency = 1,
			Position = UDim2_new(0, 0, 0.5, 0),
            Size = UDim2_new(0, 0, 1, 0),
			BorderSizePixel = 0,
			AutomaticSize = Enum.AutomaticSize.X,
			TextSize = LibraryFontSize,
            TextXAlignment = Enum.TextXAlignment[Options.Side],
			Parent = LabelTemplate_2
		}); Library.AddTheme(Title_27, { TextColor3 = Options.Risky and "Risky" or "TextColor" })

		local UIStroke_100 = Library.CreateObject("UIStroke", {
			LineJoinMode = Enum.LineJoinMode.Miter,
			Parent = Title_27
		})

		local UIPadding_68 = Library.CreateObject("UIPadding", {
			PaddingLeft = UDim.new(0, 1),
            PaddingBottom = UDim_new(0, 2),
			Parent = Title_27
		})
		
		do -- Functions
			function Label.Destroy()
				LabelTemplate_2:Destroy()
				Label = nil
			end

			function Label.GetName()
				return Options.Message
			end

			function Label.Update(Text, ColoredTexts)
				Title_27.Text = Text

				Library.ApplyRichText(Title_27, ColoredTexts)
			end

			function Label.GetState()
				return Label.Value
			end

			function Label.GetSection()
				return Options.SectionName
			end

			function Label.GetCallback(Bool)
				Options.Callback(Bool)
			end

			function Label.SetVisible(Bool)
				LabelTemplate_2.ZIndex = Bool and 3 or 0
				ExtraHolder_8.ZIndex = Bool and 3 or 0
				Library.TweenObject(LabelTemplate_2, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {GroupTransparency = Bool and 0 or 1})
				Library.TweenObject(LabelTemplate_2, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {Size = Bool and UDim2_new(1, 0, 0, 14) or UDim2_new(1, 0, 0, -4)})
				Library.TweenObject(ExtraHolder_8, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {Size = Bool and UDim2_new(1, 0, 0, 14) or UDim2_new(1, 0, 0, -4)})
				
				return Label
			end

			function Label.Keybind(Options)
				Options = Library.Validate({
					Mode = "Toggle",
					Default = nil,
					HideFromList = false,
					Blacklisted = {},
					Flag = Library.NewFlag(),
					Callback = function() end
				}, Options or {})

				local Keybind = Library.CreateKeybind({
					Parent = ExtraHolder_8,
					Default = Options.Default,
					MainTable = Label.MainTable,
					Mode = Options.Mode,
					HideFromList = Options.HideFromList,
					Blacklisted = Options.Blacklisted,
					Debounce = Label.Debounce,
					Toggle = Label,
					MainUI = Label.MainUI,
					ToggleState = Label.Value,
					Flag = Options.Flag,
					Callback = Options.Callback,
					Count = #Label.ColorPickers + 1,
					ColorPickers = Label.ColorPickers,
				})

				return Keybind
			end

			function Label.ColorPicker(Options)
				Options = Library.Validate({
					Name = "Color Picker",
					Transparency = 1,
					Default = Color3_fromRGB(255, 255, 255),
					Animations = {},
					Flag = Library.NewFlag(),
					Callback = function() end,
				}, Options or {})

				local ColorpickerIndex = #Label.ColorPickers + 1
				Label.ColorPickers[ColorpickerIndex] = {}

				local ColorPickerFrame = Library.CreateColorPicker({
					Parent = ExtraHolder_8,
					Name = Options.Name,
					Default = Options.Default,
					Flag = Options.Flag,
					MainTable = Label.MainTable,
					Transparency = Options.Transparency,
					MainUI = Label.MainUI,
					Callback = Options.Callback,
					Animations = Options.Animations,
					Count = #Label.ColorPickers,
					ColorPickers = Label.ColorPickers,
				})

				Label.ColorPickers[ColorpickerIndex] = ColorPickerFrame

				return ColorPickerFrame
			end
		end

        return Label
	end
	
    function Library.CreateSlider(Options)
        Options = Library.Validate({
            Name = "Slider",
            Min = 0,
            Max = 100,
            Default = 1,
            Decimal = 1,
            Offset = -1,
            Suffix = "",
            Risky = false,
            Draggable = true,
            UseCanvasGroup = true,
            ToolTip = "",
            Parent = nil,
            MainUI = nil,
            Position = UDim2_new(0, 0, 0, 0),
            Flag = Library.NewFlag(),
            Callback = function() end
        }, Options or {})
        
        local Slider = {
            Connection = nil,
            MouseDown = false,
            Hovering = false,
            Fading = false,
            StartingSize = 0,
            Value = math_huge,
            Fadeable = {},
        }

        Flags[Options.Flag] = Slider
        
        local SliderSize = Options.Name == "" and UDim2_new(1, 0, 0, 16) or UDim2_new(1, 0, 0, 31)
        local LibraryFontSize = UITable.FontSize
        local LibraryFont = UITable.Font
        local SliderMain = Library.CreateObject("Frame", {
            BackgroundTransparency = 1,
            Name = "SliderTemplate_2",
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Size = SliderSize,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3_fromRGB(255, 255, 255),
            Parent = Options.Parent
        })

        local Slider_2 = Library.CreateObject("Frame", {
            AnchorPoint = Vector2_new(0, 1),
            Name = "Slider_2",
            Position = UDim2_new(0, 0, 1, 0),
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Size = UDim2_new(1, 0, 0, 16),
            BorderSizePixel = 0,
            BackgroundColor3 = ThemeDefault.Outline,
            Parent = SliderMain
        }); Library.AddTheme(Slider_2, { BackgroundColor3 = "Outline" })

        local Slider_21 = Library.CreateObject("UIShadow", {
            Name = "Slider_2",
            Transparency = 0.6,
            BlurRadius = UDim_new(0, 7),
            Parent = Slider_2
        })

        local Button_17 = Library.CreateObject("TextButton", {
            FontFace = Font_new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
            TextColor3 = ThemeDefault.Outline,
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Name = "Button_17",
            BackgroundTransparency = 1,
            Size = UDim2_new(1, 0, 1, 0),
            BorderSizePixel = 0,
            TextTransparency = 1,
            TextSize = 14,
            BackgroundColor3 = Color3_fromRGB(255, 255, 255),
            Parent = Slider_2
        }); Library.AddTheme(Button_17, { TextColor3 = "Outline" })

        local SliderBack = Library.CreateObject("Frame", {
            Name = "Gradient_26",
            Position = UDim2_new(0, 1, 0, 1),
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Size = UDim2_new(1, -2, 1, -2),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3_fromRGB(255, 255, 255),
            Parent = Slider_2
        })

        local WhiteFrame = Library.CreateObject("Frame", {
            Name = "WhiteFrame",
            Position = UDim2_new(0, 0, 0, 0),
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Size = UDim2_new(1, 0, 1, 0),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            BackgroundColor3 = Color3_fromRGB(255, 255, 255),
            ZIndex = 111,
            Parent = SliderBack
        })

        local Bar_2 = Library.CreateObject("Frame", {
            Name = "Bar_2",
            Size = UDim2_new(0, 0, 1, 0),
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            ZIndex = 2,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3_fromRGB(255, 255, 255),
            Parent = SliderBack
        })

        local RightBar_2 = Library.CreateObject("Frame", {
            Name = "RightBar_2",
            Position = UDim2_new(1, 0, 0, 0),
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Size = UDim2_new(0, 1, 1, 0),
            BorderSizePixel = 0,
            BackgroundColor3 = ThemeDefault.Outline,
            Parent = Bar_2
        }); Library.AddTheme(RightBar_2, { BackgroundColor3 = "Outline" })

        local UIGradient_42 = Library.CreateObject("UIGradient", {
            Rotation = 90,
			Color = ColorSequence_new({ ColorSequenceKeypoint_new(0, ThemeDefault.Accent), ColorSequenceKeypoint_new(1, ThemeDefault.SecondAccent) }),
			Parent = Bar_2
		}); Library.AddTheme(UIGradient_42, { Color = {"Accent", "SecondAccent"} })

        local SliderValue = Library.CreateObject("TextLabel", {
            FontFace = LibraryFont,
            TextColor3 = ThemeDefault.TextColor,
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Text = "100/100",
            Name = "Value_8",
            BackgroundTransparency = 1,
            ZIndex = 115,
            BorderSizePixel = 0,
            Size = UDim2_new(1, 0, 1, 0),
            TextSize = LibraryFontSize,
            Parent = SliderBack
        }); Library.AddTheme(SliderValue, { TextColor3 = "TextColor", })

        local UIPadding_65 = Library.CreateObject("UIPadding", {
            PaddingBottom = UDim.new(0, 1),
            Parent = SliderValue
        })

        local UIStroke_98 = Library.CreateObject("UIStroke", {
            LineJoinMode = Enum.LineJoinMode.Miter,
            Parent = SliderValue
        })

        local UIGradient_43 = Library.CreateObject("UIGradient", {
            Rotation = 90,
            Color = ColorSequence_new({ ColorSequenceKeypoint_new(0, ThemeDefault.LightContrast), ColorSequenceKeypoint_new(1, ThemeDefault.DarkContrast) }),
            Parent = SliderBack
        }); Library.AddTheme(UIGradient_43, { Color = {"LightContrast", "DarkContrast"} })

        if Options.Name ~= "" then
            local Title_26 = Library.CreateObject("TextLabel", {
                FontFace = LibraryFont,
                TextColor3 = Options.Risky and ThemeDefault.Risky or ThemeDefault.TextColor,
                BorderColor3 = Color3_fromRGB(0, 0, 0),
                Text = Options.Name,
                BackgroundTransparency = 1,
                Name = "Title_26",
                BorderSizePixel = 0,
                Position = UDim2_new(0, 0, 0, 1),
                Size = UDim2_new(1, 0, 0, 0),
                TextXAlignment = Enum.TextXAlignment.Left,
                AutomaticSize = Enum.AutomaticSize.Y,
                TextSize = LibraryFontSize,
                Parent = SliderMain
            }); Library.AddTheme(Title_26, { TextColor3 = Options.Risky and "Risky" or "TextColor" })

            local UIPadding_66 = Library.CreateObject("UIPadding", {
                PaddingTop = UDim.new(0, -2),
                PaddingLeft = UDim.new(0, 1),
                Parent = Title_26
            })

            local UIStroke_99 = Library.CreateObject("UIStroke", {
                LineJoinMode = Enum.LineJoinMode.Miter,
                Parent = Title_26
            })
        end

        do -- Functions
            function Slider.ReturnValue(Value)
                return string_format("%.14g", Value)
            end

            function Slider.UpdateOffset(Value)
                SliderValue.Position = UDim2_new(0.5, 0, 0.5, Value)
            end
            
            function Slider.Set(Value)
                local Value = Value and math_clamp(Options.Decimal * math_round(Value / Options.Decimal), Options.Min, Options.Max)
                
                SliderValue.Text = Slider.ReturnValue(Value) .. Options.Suffix .. "/" .. Slider.ReturnValue(Options.Max) .. Options.Suffix
                
                if Value ~= Slider.Value then
                    Slider.Value = Value

                    if Slider.Value == Options.Min then
                        RightBar_2.Visible = false
                    else
                        RightBar_2.Visible = true
                    end
                    
                    Library.TweenObject(Bar_2, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {Size = UDim2_new((Value - Options.Min) / (Options.Max - Options.Min), 0, 1, 0)})
                end
                
                Flags[Options.Flag] = Slider
                Options.Callback(tonumber(Slider.ReturnValue(Value)))
            end

            function Slider.SetMax(NewMax)
                Options.Max = NewMax

                Slider.Set(Slider.Value)
            end

            function Slider.SetMin(NewMin)
                Options.Min = NewMin

                Slider.Set(Slider.Value)
            end

            function Slider.Get()
                return tonumber(Slider.ReturnValue(Slider.Value))
            end

            function Slider.Max()
                return Options.Max
            end
            
            function Slider.Min()
                return Options.Min
            end

            function Slider.SetVisible(Bool)
                Slider.MouseLeave()
                SliderMain.ZIndex = Bool and 3 or 0
                --Library.TweenObject(SliderMain, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {GroupTransparency = Bool and 0 or 1})
                --Library.FadeDescendants(Bool, Library.GetAllObjects(SliderMain))
                --Library.TweenObject(SliderMain, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {Size = Bool and SliderSize or UDim2_new(1, 0, 0, -4)})
                SliderMain.Visible = Bool

                return Slider
            end

            function Slider.Update(Input)
                local SizeX = (Input.Position.X - SliderBack.AbsolutePosition.X) / SliderBack.AbsoluteSize.X
                local Value = math_clamp((Options.Max - Options.Min) * SizeX + Options.Min, Options.Min, Options.Max)
                
                Slider.Set(Value)
            end

            function Slider.MouseEnter()
                if Library.MouseOverOtherWindow(Options.MainUI) then
                    Slider.MouseLeave()

                    return
                end

                if Library.MouseOverOtherObject() then
                    Slider.MouseLeave()

                    return
                end

                Slider.Hovering = true

                if not Options.Draggable then
                    return
                end

                if not Slider.Fading then
                    Library.TweenObject(WhiteFrame, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {BackgroundTransparency = 0.95})

                    Slider.Fading = true
                end
            end

            function Slider.MouseLeave()
                Slider.Hovering = false

                if not Options.Draggable then
                    return
                end

                if Slider.Fading and not Slider.MouseDown then
                    Library.TweenObject(WhiteFrame, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {BackgroundTransparency = 1})

                    Slider.Fading = false
                end
            end
        end

        do -- Connections
            Library.AddConnection(Button_17.MouseButton1Down, LPH_NO_VIRTUALIZE(function()
                if Library.MouseOverOtherWindow(Options.MainUI) then
                    return
                end

                if Library.MouseOverOtherObject() then
                    return
                end

                if not Options.Draggable then
                    return
                end

                UITable.DraggingGui = Bar_2
                Slider.MouseDown = true

                Slider.Update({Position = UserInputService:GetMouseLocation()})
            end))
            
            Library.AddConnection(UserInputService.InputChanged, LPH_NO_VIRTUALIZE(function(Input)
                if UITable.DraggingGui ~= Bar_2 and not (UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)) then
                    return
                end

                if not Options.Draggable then
                    return
                end
                
                if Slider.MouseDown and Input.UserInputType == Enum.UserInputType.MouseMovement then
                    Slider.Update(Input)
                end
            end))
            
            Library.AddConnection(UserInputService.InputEnded, LPH_NO_VIRTUALIZE(function(Input)
                if not Options.Draggable then
                    return
                end

                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Slider.MouseDown = false
                    UITable.DraggingGui = nil

                    if not Slider.Hovering then
                        Slider.MouseLeave()
                    end
                end
            end))

            Library.AddConnection(Slider_2.MouseEnter, LPH_NO_VIRTUALIZE(function()
                if not Options.MainUI.Visible then
                    return
                end

                if not Library.MouseOverFrame(Options.MainUI) then
                    return
                end

                Slider.MouseEnter()

                if Slider.MouseConnection then
                    Slider.MouseConnection:Disconnect()
                    Slider.MouseConnection = nil
                end

                Slider.MouseConnection = Library.AddConnection(UserInputService.InputChanged, function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseMovement then
                        if not Library.MouseOverFrame(Slider_2) then
                            Slider.MouseLeave()
                            Slider.MouseConnection:Disconnect()
                            Slider.MouseConnection = nil
                        end
                    end
                end)
                end))
        end

        Slider.Set(Options.Default)

        return Slider
    end

    function Library.CreateDropdown(Options)
        Options = Library.Validate({
            Default = "None",
            Name = "Dropdown",
            ID = "Dropdown",
            Risky = false,
            ScreenGui = UITable.ScreenGui,
            Parent = nil,
            MainUI = nil,
            TabUI = nil,
            Content = {},
            ToolTip = "",
            Flag = Library.NewFlag(),
            Callback = function() end
        }, Options or {})
        
        local Dropdown = {
            Open = false,
            Active = false,
            Hovering = false,
            CurrentItem = nil,
            Value = Options.Default,
            Items = {},
            MainUIConnections = {},
        }
        
        Flags[Options.Flag] = Dropdown

        local DropdownSize = Options.Name == "" and UDim2_new(1, 0, 0, 21) or UDim2_new(1, 0, 0, 36)
        local LibraryFontSize = UITable.FontSize
        local LibraryFont = UITable.Font
        local DropdownMain = Library.CreateObject("Frame", {
            BackgroundTransparency = 1,
            Name = Options.ID,
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Size = DropdownSize,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3_fromRGB(255, 255, 255),
            Parent = Options.Parent
        })

        local Dropdown_2 = Library.CreateObject("Frame", {
            AnchorPoint = Vector2_new(0, 1),
            Name = "Dropdown_2",
            Position = UDim2_new(0, 0, 1, -1),
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Size = UDim2_new(1, 0, 0, 20),
            BorderSizePixel = 0,
            BackgroundColor3 = ThemeDefault.Outline,
            Parent = DropdownMain
        }); Library.AddTheme(Dropdown_2, { BackgroundColor3 = "Outline" })

        local Dropdown_21 = Library.CreateObject("UIShadow", {
            Name = "Dropdown_2",
            Transparency = 0.6,
            BlurRadius = UDim_new(0, 7),
            Parent = Dropdown_2
        })

        local DropdownChecker = Library.CreateObject("Frame", {
            Name = "DropdownChecker",
            Position = UDim2_new(0, 0, 1, 0),
            Visible = false,
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Size = UDim2_new(1, 0, 0, 1),
            BorderSizePixel = 0,
            Parent = Dropdown_2
        })

        local Button_13 = Library.CreateObject("TextButton", {
            FontFace = Font_new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
            TextColor3 = ThemeDefault.Outline,
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Name = "Button_13",
            BackgroundTransparency = 1,
            Size = UDim2_new(1, 0, 1, 0),
            BorderSizePixel = 0,
            TextTransparency = 1,
            TextSize = 14,
            BackgroundColor3 = Color3_fromRGB(255, 255, 255),
            Parent = Dropdown_2
        }); Library.AddTheme(Button_13, { TextColor3 = "Outline" })

        local Gradient_23 = Library.CreateObject("Frame", {
            Name = "Gradient_23",
            Position = UDim2_new(0, 1, 0, 1),
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Size = UDim2_new(1, -2, 1, -2),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3_fromRGB(255, 255, 255),
            Parent = Dropdown_2
        })

        local WhiteFrame = Library.CreateObject("Frame", {
            Name = "WhiteFrame",
            Position = UDim2_new(0, 0, 0, 0),
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Size = UDim2_new(1, 0, 1, 0),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            BackgroundColor3 = Color3_fromRGB(255, 255, 255),
            ZIndex = 111,
            Parent = Gradient_23
        })

        local Indicator_2 = Library.CreateObject("Frame", {
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            AnchorPoint = Vector2_new(1, 0),
            Name = "Indicator_2",
            Position = UDim2_new(1, 0, 0, 0),
            Size = UDim2_new(1, 0, 1, 0),
            ZIndex = 113,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3_fromRGB(255, 255, 255),
            Parent = Gradient_23
        })

        local LeftBar_5 = Library.CreateObject("Frame", {
            Name = "LeftBar_5",
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Size = UDim2_new(0, 1, 1, 0),
            BorderSizePixel = 0,
            BackgroundColor3 = ThemeDefault.Outline,
            Parent = Indicator_2
        }); Library.AddTheme(LeftBar_5, { BackgroundColor3 = "Outline" })

        local PlusIcon = Library.CreateObject("TextLabel", {
            FontFace = LibraryFont,
            TextColor3 = ThemeDefault.TextColor,
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Text = "+",
            Name = "Value_6",
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2_new(1, 0, 1, 0),
            ZIndex = 5,
            TextSize = LibraryFontSize,
            Parent = Indicator_2
        }); Library.AddTheme(PlusIcon, { TextColor3 = "TextColor" })

        local UIPadding_62 = Library.CreateObject("UIPadding", {
            PaddingBottom = UDim.new(0, 3),
            PaddingLeft = UDim.new(0, 2),
            Parent = PlusIcon
        })

        local UIStroke_92 = Library.CreateObject("UIStroke", {
            LineJoinMode = Enum.LineJoinMode.Miter,
            Parent = PlusIcon
        })

        local UIAspectRatioConstraint_25 = Library.CreateObject("UIAspectRatioConstraint", {
            Parent = Indicator_2
        })

        local UIGradient_34 = Library.CreateObject("UIGradient", {
            Rotation = 90,
			Color = ColorSequence_new({ ColorSequenceKeypoint_new(0, ThemeDefault.Accent), ColorSequenceKeypoint_new(1, ThemeDefault.SecondAccent) }),
			Parent = Indicator_2
		}); Library.AddTheme(UIGradient_34, { Color = {"Accent", "SecondAccent"} })

        local Value_7 = Library.CreateObject("TextLabel", {
            FontFace = LibraryFont,
            TextColor3 = ThemeDefault.TextColor,
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Text = "None",
            Name = "Value_7",
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            ZIndex = 114,
            TextXAlignment = Enum.TextXAlignment.Left,
            Size = UDim2_new(1, -20, 1, 0),
            ZIndex = 5,
            TextSize = LibraryFontSize,
            Parent = Gradient_23
        }); Library.AddTheme(Value_7, { TextColor3 = "TextColor" })

        local UIPadding_63 = Library.CreateObject("UIPadding", {
            PaddingBottom = UDim.new(0, 2),
            PaddingLeft = UDim.new(0, 5),
            Parent = Value_7
        })

        local UIStroke_93 = Library.CreateObject("UIStroke", {
            LineJoinMode = Enum.LineJoinMode.Miter,
            Parent = Value_7
        })

        local UIGradient_35 = Library.CreateObject("UIGradient", {
            Rotation = 90,
            Color = ColorSequence_new({ ColorSequenceKeypoint_new(0, ThemeDefault.LightContrast), ColorSequenceKeypoint_new(1, ThemeDefault.DarkContrast) }),
            Parent = Gradient_23
        }); Library.AddTheme(UIGradient_35, { Color = {"LightContrast", "DarkContrast"} })

        local Title_23 = Library.CreateObject("TextLabel", {
            FontFace = LibraryFont,
            TextColor3 = Options.Risky and ThemeDefault.Risky or ThemeDefault.TextColor,
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Text = Options.Name,
            BackgroundTransparency = 1,
            Name = "Title_23",
            Position = UDim2_new(0, 0, 0, -1),
            Size = UDim2_new(1, 0, 0, 0),
            TextXAlignment = Enum.TextXAlignment.Left,
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.Y,
            TextSize = LibraryFontSize,
            Parent = DropdownMain
        }); Library.AddTheme(Title_23, { TextColor3 = Options.Risky and "Risky" or "TextColor" })

        local UIPadding_68 = Library.CreateObject("UIPadding", {
			PaddingLeft = UDim.new(0, 1),
			Parent = Title_23
		})

        local UIStroke_94 = Library.CreateObject("UIStroke", {
            LineJoinMode = Enum.LineJoinMode.Miter,
            Parent = Title_23
        })

        local DropdownContentHolder = Library.CreateObject("CanvasGroup", {
            Visible = false,
            GroupTransparency = 1,
            Name = "DropdownOutline",
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            BorderSizePixel = 0,
            BackgroundColor3 = ThemeDefault.Outline,
            Parent = Options.ScreenGui
        }); Library.AddTheme(DropdownContentHolder, { BackgroundColor3 = "Outline" })

        table_insert(UITable.Dropdowns, DropdownContentHolder)

        local Gradient_3 = Library.CreateObject("Frame", {
            Name = "Gradient_3",
            Position = UDim2_new(0, 1, 0, 1),
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Size = UDim2_new(1, -2, 1, -2),
            BorderSizePixel = 0,
            BackgroundColor3 = ThemeDefault.LightContrast,
            Parent = DropdownContentHolder
        }); Library.AddTheme(Gradient_3, { BackgroundColor3 = "LightContrast" })

        local DropdownContentScrolling = Library.CreateObject("ScrollingFrame", {
            Active = true,
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            BorderSizePixel = 0,
            CanvasSize = UDim2_new(0, 0, 0, 0),
            ScrollBarImageColor3 = ThemeDefault.Accent,
            MidImage = "rbxassetid://95591733073455",
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            ScrollBarThickness = 3,
            Name = "Holder",
            BackgroundTransparency = 1,
            Size = UDim2_new(1, 0, 1, 0),
            ScrollBarImageTransparency = 1,
            BottomImage = "rbxassetid://95591733073455",
            TopImage = "rbxassetid://95591733073455",
            BackgroundColor3 = Color3_fromRGB(255, 255, 255),
            Parent = Gradient_3
        }); Library.AddTheme(DropdownContentScrolling, { ScrollBarImageColor3 = "Accent" })

        local UIListLayout_4 = Library.CreateObject("UIListLayout", {
            Padding = UDim.new(0, 4),
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = DropdownContentScrolling
        })

        local UIPadding_8 = Library.CreateObject("UIPadding", {
            PaddingRight = UDim.new(0, 6),
            PaddingLeft = UDim.new(0, 5),
            Parent = DropdownContentScrolling
        })

        local UIPadding_9 = Library.CreateObject("UIPadding", {
            PaddingRight = UDim.new(0, 4),
            PaddingTop = UDim.new(0, 4),
            PaddingBottom = UDim.new(0, 4),
            Parent = Gradient_3
        })

        do -- Functions
            function Dropdown.UpdateName(Name)
                DropdownMain.Name = Name
            end

            function Dropdown.Set(State)
                for Index, Value in Dropdown.Items do
                    if Index == State then
                        Value.Activate()
                    end
                end
            end
            
            function Dropdown.ChangeCallback(NewCallback)
                Options.Callback = NewCallback
            end

            function Dropdown.Get()
                return Dropdown.Value
            end

            function Dropdown.FindValue(Value)
                return FindFirstChild(DropdownContentScrolling, Value)
            end
            
            function Dropdown.SetVisible(Bool, Fast)
                Dropdown.MouseLeave()
                DropdownMain.ZIndex = Bool and 3 or 0

                if Bool == true then
                    DropdownMain.Visible = true
                end

                if Fast then
                    --DropdownMain.GroupTransparency = Bool and 0 or 1
                    DropdownMain.Size = Bool and DropdownSize or UDim2_new(1, 0, 0, -4)

                    if Bool == false then
                        DropdownMain.Visible = false
                    end
                else
                    --Library.TweenObject(DropdownMain, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {GroupTransparency = Bool and 0 or 1})
                    --Library.FadeDescendants(Bool, Library.GetAllObjects(DropdownMain))
                    DropdownMain.Visible = Bool
                    if Bool == false then
                        DropdownMain.Visible = false
                    end

                    --[[Library.TweenObject(DropdownMain, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {Size = Bool and DropdownSize or UDim2_new(1, 0, 0, -4)}, function()
                        if Bool == false then
                            DropdownMain.Visible = false
                        end
                    end)]]
                end
            
                if Bool == false and Dropdown.Open then
                    Dropdown.Toggle(true, true)
                end

                return Dropdown
            end
            
            function Dropdown.Update()
                local TabHolder = Options.Parent.Parent.Parent

                DropdownContentHolder.Size = UDim2_new(0, Dropdown_2.AbsoluteSize.X, 0, DropdownContentHolder.AbsoluteSize.Y)
                DropdownContentHolder.Position = UDim2_new(0, Dropdown_2.AbsolutePosition.X, 0, ((Dropdown_2.AbsolutePosition.Y + Dropdown_2.AbsoluteSize.Y) + Inset.Y - 1))
                
                if Dropdown.Open then
                    DropdownContentHolder.Visible = Library.ScrollingCheck(Options.Parent, DropdownChecker) and TabHolder.Visible
                end
            end

            function Dropdown.Toggle(Bool, Fast)
                if Bool ~= nil then
                    Dropdown.Open = Bool
                end

                if Dropdown.Open then
                    PlusIcon.Text = "+"

                    if Fast then
                        DropdownContentHolder.GroupTransparency = 1
                        DropdownContentHolder.Size = UDim2_new(0, Dropdown_2.AbsoluteSize.X, 0, 0)
                    else
                        Library.TweenObject(DropdownContentHolder, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {GroupTransparency = 1})
                        Library.TweenObject(DropdownContentHolder, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {Size = UDim2_new(0, Dropdown_2.AbsoluteSize.X, 0, 0)}, function()
                            DropdownMain.ZIndex = 1
                        end)
                    end
                    
                    Library.TweenObject(DropdownContentScrolling, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {ScrollBarImageTransparency = 1})
                else
                    DropdownContentHolder.ZIndex = Options.MainUI.ZIndex + UITable.DropdownZIndex
                    UITable.DropdownZIndex += 1

                    Library.TweenObject(DropdownContentHolder, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {GroupTransparency = 0})
                    
                    PlusIcon.Text = "-"
                    
                    if Library.DictionaryLength(Dropdown.Items) < 6 then
                        Library.TweenObject(DropdownContentHolder, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {Size = UDim2_new(0, Dropdown_2.AbsoluteSize.X, 0, (Library.DictionaryLength(Dropdown.Items) * 16) + 8)})
                    else
                        Library.TweenObject(DropdownContentScrolling, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {ScrollBarImageTransparency = 0})
                        Library.TweenObject(DropdownContentHolder, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {Size = UDim2_new(0, Dropdown_2.AbsoluteSize.X, 0, 104)})
                    end
                end
                
                Dropdown.Open = not Dropdown.Open

                Dropdown.Update()
            end

            function Dropdown.MouseEnter()
                if Library.MouseOverOtherWindow(Options.MainUI) then
                    Dropdown.MouseLeave()

                    return
                end

                if Library.MouseOverOtherObject() then
                    Dropdown.MouseLeave()

                    return
                end
                
                Dropdown.Hovering = true
                
                if (not Dropdown.Fading) then
                    Library.TweenObject(WhiteFrame, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {BackgroundTransparency = 0.95})

                    Dropdown.Fading = true
                end
            end

            function Dropdown.MouseLeave()
                Dropdown.Hovering = false

                if Dropdown.Open then
                    return
                end
                
                if Dropdown.Fading then
                    Library.TweenObject(WhiteFrame, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {BackgroundTransparency = 1})

                    Dropdown.Fading = false
                end
            end

            function Dropdown.AddValue(Value)
                local Item = {
                    Active = false,
                    Hovering = false,
                    Name = Value,
                }

                Dropdown.Items[Value] = Item

                local ItemTemplate = Library.CreateObject("TextLabel", {
                    FontFace = LibraryFont,
                    TextColor3 = ThemeDefault.TextColor,
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    Text = Value,
                    Name = Value,
                    Size = UDim2_new(1, 0, 0, 0),
                    Position = UDim2_new(0, 10, 0, 0),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    TextSize = LibraryFontSize,
                    Parent = DropdownContentScrolling
                }); Library.AddTheme(ItemTemplate, { TextColor3 = "TextColor" })

                local ClickDetection_3 = Library.CreateObject("TextButton", {
                    FontFace = LibraryFont,
                    TextColor3 = Color3_fromRGB(0, 0, 0),
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    Name = "ClickDetection_3",
                    BackgroundTransparency = 1,
                    Size = UDim2_new(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    TextTransparency = 1,
                    TextSize = LibraryFontSize,
                    BackgroundColor3 = Color3_fromRGB(255, 255, 255),
                    Parent = ItemTemplate
                })

                local UIStroke_5 = Library.CreateObject("UIStroke", {
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Parent = ItemTemplate
                })

                local NamePadding = Library.CreateObject("UIPadding", {
                    Parent = ItemTemplate
                })

                do -- Functions
                    function Item.Activate()
                        if not Item.Active then
                            if Dropdown.CurrentItem then
                                Dropdown.CurrentItem.Deactivate()
                            end

                            Item.Active = true
                            Dropdown.CurrentItem = Item
                            Dropdown.Value = Value
                            Value_7.Text = Value

                            Library.TweenObject(NamePadding, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {PaddingLeft = UDim_new(0, 2)})
                            Library.TweenObject(ItemTemplate, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {TextColor3 = ThemeDefault.Accent}, function()
                                Library.AddTheme(ItemTemplate, {TextColor3 = "Accent"}, "TextColor")
                            end)

                            Flags[Options.Flag] = Dropdown
                            Options.Callback(Value)
                        end
                    end

                    function Item.Deactivate()
                        if Item.Active then
                            Item.Active = false
                            Dropdown.CurrentItem = nil
                            Item.MouseLeave()

                            Library.TweenObject(NamePadding, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {PaddingLeft = UDim_new(0, 0)})
                            Library.TweenObject(ItemTemplate, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {TextColor3 = Item.Hovering and ThemeDefault.TextDark or ThemeDefault.TextColor}, function()
                                Library.AddTheme(ItemTemplate, {TextColor3 = Item.Hovering and "TextDark" or "TextColor"}, "Accent")
                            end)
                        end
                    end

                    function Item.MouseEnter()
                        if Library.MouseOverOtherWindow(Options.MainUI) then
                            Item.MouseLeave()

                            return
                        end

                        Item.Hovering = true

                        if (not Item.Fading) and (not Item.Active) then
                            Library.TweenObject(ItemTemplate, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {TextColor3 = ThemeDefault.TextDark}, function()
                                Library.AddTheme(ItemTemplate, {TextColor3 = "TextDark"}, "TextColor")
                            end)

                            Item.Fading = true
                        end
                    end

                    function Item.MouseLeave()
                        Item.Hovering = false

                        if Item.Fading and not Item.Active then
                            Library.TweenObject(ItemTemplate, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {TextColor3 = ThemeDefault.TextColor}, function()
                                Library.AddTheme(ItemTemplate, {TextColor3 = "TextColor"}, "TextDark")
                            end)

                            Item.Fading = false
                        end
                    end
                end

                do -- Connections
                    Library.AddConnection(ClickDetection_3.MouseButton1Click, LPH_NO_VIRTUALIZE(function()
                        if Library.MouseOverOtherWindow(Options.MainUI) then
                            return
                        end

                        Item.Activate()
                    end))

                    Library.AddConnection(ItemTemplate.MouseEnter, LPH_NO_VIRTUALIZE(function()
                        if not Options.MainUI.Visible then
                            return
                        end

                        Item.MouseEnter()

                        if Item.MouseConnection then
                            Item.MouseConnection:Disconnect()
                            Item.MouseConnection = nil
                        end

                        Item.MouseConnection = Library.AddConnection(UserInputService.InputChanged, function(Input)
                            if Input.UserInputType == Enum.UserInputType.MouseMovement then
                                if not Library.MouseOverFrame(ItemTemplate) then
                                    Item.MouseLeave()
                                    Item.MouseConnection:Disconnect()
                                    Item.MouseConnection = nil
                                end
                            end
                        end)
                    end))
                end

                if Value == Options.Default then
                    Item.Activate()
                end
            end

            function Dropdown.RemoveValue(Value)
                for _, Object in GetChildren(DropdownContentScrolling) do
                    if Object.Name == Value then
                        local CurrentItem = Dropdown.CurrentItem

                        Object:Destroy()
                        Dropdown.Items[Value] = nil

                        if CurrentItem and CurrentItem.Name == Value then
                            CurrentItem.Deactivate()

                            Value_7.Text = "None"
                        end
                    end
                end
            end
        end

        do -- Connections
            Library.AddConnection(Button_13.MouseButton1Click, LPH_NO_VIRTUALIZE(function()
                if Library.MouseOverOtherWindow(Options.MainUI) then
                    return
                end

                if Library.MouseOverOtherObject() then
                    return
                end

                Dropdown.Toggle()
            end))

            Library.AddConnection(Dropdown_2.MouseEnter, LPH_NO_VIRTUALIZE(function()
                if not Options.MainUI.Visible then
                    return
                end

                if not Library.MouseOverFrame(Options.MainUI) then
                    return
                end

                Dropdown.MouseEnter()

                if Dropdown.MouseConnection then
                    Dropdown.MouseConnection:Disconnect()
                    Dropdown.MouseConnection = nil
                end

                Dropdown.MouseConnection = Library.AddConnection(UserInputService.InputChanged, function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseMovement then
                        if not Library.MouseOverFrame(Dropdown_2) then
                            Dropdown.MouseLeave()
                            Dropdown.MouseConnection:Disconnect()
                            Dropdown.MouseConnection = nil
                        end
                    end
                end)
            end))

            do -- Positioning
                local TabHolder = Options.Parent.Parent.Parent.Parent.Parent.Parent.Parent

                Library.AddConnection(Dropdown_2:GetPropertyChangedSignal("AbsolutePosition"), Dropdown.Update)
                Library.AddConnection(Dropdown_2:GetPropertyChangedSignal("AbsoluteSize"), Dropdown.Update)

                if IsA(Options.Parent, "ScrollingFrame") then
                    Library.AddConnection(Options.Parent:GetPropertyChangedSignal("CanvasPosition"), Dropdown.Update)
                end

                Library.AddConnection(Options.MainUI:GetPropertyChangedSignal("ZIndex"), LPH_NO_VIRTUALIZE(function()
                    DropdownContentHolder.ZIndex = Options.MainUI.ZIndex + UITable.DropdownZIndex
                end))

                if IsA(Options.MainUI, "CanvasGroup") then
                    Library.AddConnection(Options.MainUI:GetPropertyChangedSignal("GroupTransparency"), LPH_NO_VIRTUALIZE(function()
                        if Options.MainUI.GroupTransparency == 1 then
                            Dropdown.Toggle(true)
                        end

                        if Dropdown.Open then
                            DropdownContentHolder.GroupTransparency = Options.MainUI.GroupTransparency
                        end
                    end))
                end

                if not IsA(TabHolder, "GuiObject") then
                    TabHolder = Options.Parent.Parent
                end

                Library.AddConnection(TabHolder:GetPropertyChangedSignal("Visible"), LPH_NO_VIRTUALIZE(function()
                    if not TabHolder.Visible then
                        DropdownContentHolder.Visible = false
                    else
                        DropdownContentHolder.Visible = Dropdown.Open and TabHolder
                    end
                end))

                Library.AddConnection(Options.MainUI:GetPropertyChangedSignal("Visible"), LPH_NO_VIRTUALIZE(function()
                    if not Options.MainUI.Visible then
                        DropdownContentHolder.Visible = false
                    else
                        DropdownContentHolder.Visible = Dropdown.Open and TabHolder
                    end
                end))

                Library.AddConnection(Options.Parent:GetPropertyChangedSignal("Visible"), LPH_NO_VIRTUALIZE(function()
                    if not Options.Parent.Visible then
                        DropdownContentHolder.Visible = false
                    else
                        DropdownContentHolder.Visible = Dropdown.Open and TabHolder
                    end
                end))
            end
        end

        Dropdown.Update()
            
        for _, Value in Options.Content do
            Dropdown.AddValue(Value)
        end

        return Dropdown
    end

    function Library.CreateMultiBox(Options)
        Options = Library.Validate({
            Name = "MultiBox",
            Risky = false,
            Parent = nil,
            ScreenGui = UITable.ScreenGui,
            MainUI = nil,
            TabUI = nil,
            Content = {},
            Default = {},
            ToolTip = "",
            Flag = Library.NewFlag(),
            Callback = function() end
        }, Options or {})
        
        local MultiBox = {
            Open = false,
            Active = false,
            Fading = false,
            Hovering = false,
            MouseConnection = nil,
            Items = Options.Content,
            Value = {},
            MainUIConnections = {},
            SelectedOrder = {},
            AllItems = {},
            Items = {},
        }
        
        Flags[Options.Flag] = MultiBox
        Options.Callback(Options.Default)

        local MultiBoxSize = Options.Name == "" and UDim2_new(1, 0, 0, 20) or UDim2_new(1, 0, 0, 36)
        local LibraryFontSize = UITable.FontSize
        local LibraryFont = UITable.Font
        local MultiBoxMain = Library.CreateObject("Frame", {
            BackgroundTransparency = 1,
            Name = Options.ID,
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Size = MultiBoxSize,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3_fromRGB(255, 255, 255),
            Parent = Options.Parent
        })

        local MultiBox_2 = Library.CreateObject("Frame", {
            AnchorPoint = Vector2_new(0, 1),
            Name = "MultiBox_2",
            Position = UDim2_new(0, 0, 1, 0),
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Size = UDim2_new(1, 0, 0, 20),
            BorderSizePixel = 0,
            BackgroundColor3 = ThemeDefault.Outline,
            Parent = MultiBoxMain
        }); Library.AddTheme(MultiBox_2, { BackgroundColor3 = "Outline" })

        local MultiBox_21 = Library.CreateObject("UIShadow", {
            Name = "MultiBox_2",
            Transparency = 0.6,
            BlurRadius = UDim_new(0, 7),
            Parent = MultiBox_2
        })

        local MultiBoxChecker = Library.CreateObject("Frame", {
            Name = "MultiBoxChecker",
            Position = UDim2_new(0, 0, 1, -1),
            Visible = false,
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Size = UDim2_new(1, 0, 0, 1),
            BorderSizePixel = 0,
            Parent = MultiBox_2
        })

        local Button_13 = Library.CreateObject("TextButton", {
            FontFace = Font_new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
            TextColor3 = ThemeDefault.Outline,
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Name = "Button_13",
            BackgroundTransparency = 1,
            Size = UDim2_new(1, 0, 1, 0),
            BorderSizePixel = 0,
            TextTransparency = 1,
            TextSize = 14,
            BackgroundColor3 = Color3_fromRGB(255, 255, 255),
            Parent = MultiBox_2
        }); Library.AddTheme(Button_13, { TextColor3 = "Outline" })

        local Gradient_23 = Library.CreateObject("Frame", {
            Name = "Gradient_23",
            Position = UDim2_new(0, 1, 0, 1),
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Size = UDim2_new(1, -2, 1, -2),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3_fromRGB(255, 255, 255),
            Parent = MultiBox_2
        })

        local WhiteFrame = Library.CreateObject("Frame", {
            Name = "WhiteFrame",
            Position = UDim2_new(0, 0, 0, 0),
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Size = UDim2_new(1, 0, 1, 0),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            BackgroundColor3 = Color3_fromRGB(255, 255, 255),
            ZIndex = 111,
            Parent = Gradient_23
        })

        local Indicator_2 = Library.CreateObject("Frame", {
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            AnchorPoint = Vector2_new(1, 0),
            Name = "Indicator_2",
            Position = UDim2_new(1, 0, 0, 0),
            Size = UDim2_new(1, 0, 1, 0),
            ZIndex = 113,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3_fromRGB(255, 255, 255),
            Parent = Gradient_23
        })

        local LeftBar_5 = Library.CreateObject("Frame", {
            Name = "LeftBar_5",
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Size = UDim2_new(0, 1, 1, 0),
            BorderSizePixel = 0,
            BackgroundColor3 = ThemeDefault.Outline,
            Parent = Indicator_2
        }); Library.AddTheme(LeftBar_5, { BackgroundColor3 = "Outline" })

        local PlusIcon = Library.CreateObject("TextLabel", {
            FontFace = LibraryFont,
            TextColor3 = ThemeDefault.TextColor,
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Text = "+",
            Name = "Value_6",
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2_new(1, 0, 1, 0),
            ZIndex = 5,
            TextSize = LibraryFontSize,
            Parent = Indicator_2
        }); Library.AddTheme(PlusIcon, { TextColor3 = "TextColor" })

        local UIPadding_62 = Library.CreateObject("UIPadding", {
            PaddingBottom = UDim.new(0, 3),
            PaddingLeft = UDim.new(0, 2),
            Parent = PlusIcon
        })

        local UIStroke_92 = Library.CreateObject("UIStroke", {
            LineJoinMode = Enum.LineJoinMode.Miter,
            Parent = PlusIcon
        })

        local UIAspectRatioConstraint_25 = Library.CreateObject("UIAspectRatioConstraint", {
            Parent = Indicator_2
        })

        local UIGradient_34 = Library.CreateObject("UIGradient", {
            Rotation = 90,
			Color = ColorSequence_new({ ColorSequenceKeypoint_new(0, ThemeDefault.Accent), ColorSequenceKeypoint_new(1, ThemeDefault.SecondAccent) }),
			Parent = Indicator_2
		}); Library.AddTheme(UIGradient_34, { Color = {"Accent", "SecondAccent"} })

        local Value_7 = Library.CreateObject("TextLabel", {
            FontFace = LibraryFont,
            TextColor3 = ThemeDefault.TextColor,
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Text = "None",
            Name = "Value_7",
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            ZIndex = 114,
            TextXAlignment = Enum.TextXAlignment.Left,
            Size = UDim2_new(1, -20, 1, 0),
            ZIndex = 5,
            TextSize = LibraryFontSize,
            Parent = Gradient_23
        }); Library.AddTheme(Value_7, { TextColor3 = "TextColor" })

        local UIPadding_63 = Library.CreateObject("UIPadding", {
            PaddingBottom = UDim.new(0, 2),
            PaddingLeft = UDim.new(0, 5),
            Parent = Value_7
        })

        local UIStroke_93 = Library.CreateObject("UIStroke", {
            LineJoinMode = Enum.LineJoinMode.Miter,
            Parent = Value_7
        })

        local UIGradient_35 = Library.CreateObject("UIGradient", {
            Rotation = 90,
            Color = ColorSequence_new({ ColorSequenceKeypoint_new(0, ThemeDefault.LightContrast), ColorSequenceKeypoint_new(1, ThemeDefault.DarkContrast) }),
            Parent = Gradient_23
        }); Library.AddTheme(UIGradient_35, { Color = {"LightContrast", "DarkContrast"} })

        local Title_23 = Library.CreateObject("TextLabel", {
            FontFace = LibraryFont,
            TextColor3 = Options.Risky and ThemeDefault.Risky or ThemeDefault.TextColor,
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Text = Options.Name,
            BackgroundTransparency = 1,
            Name = "Title_23",
            BorderSizePixel = 0,
            Position = UDim2_new(0, 0, 0, -1),
            TextXAlignment = Enum.TextXAlignment.Left,
            Size = UDim2_new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            TextSize = LibraryFontSize,
            Parent = MultiBoxMain
        }); Library.AddTheme(Title_23, { TextColor3 = Options.Risky and "Risky" or "TextColor" })

        local UIPadding_64 = Library.CreateObject("UIPadding", {
            PaddingLeft = UDim.new(0, 1),
            Parent = Title_23
        })

        local UIStroke_94 = Library.CreateObject("UIStroke", {
            LineJoinMode = Enum.LineJoinMode.Miter,
            Parent = Title_23
        })

        local MultiBoxContentHolder = Library.CreateObject("CanvasGroup", {
            Visible = false,
            GroupTransparency = 1,
            Name = "MultiBoxOutline",
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            BorderSizePixel = 0,
            BackgroundColor3 = ThemeDefault.Outline,
            Parent = Options.ScreenGui
        }); Library.AddTheme(MultiBoxContentHolder, { BackgroundColor3 = "Outline" })

        table_insert(UITable.Dropdowns, MultiBoxContentHolder)

        local Gradient_3 = Library.CreateObject("Frame", {
            Name = "Gradient_3",
            Position = UDim2_new(0, 1, 0, 1),
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            Size = UDim2_new(1, -2, 1, -2),
            BorderSizePixel = 0,
            BackgroundColor3 = ThemeDefault.LightContrast,
            Parent = MultiBoxContentHolder
        }); Library.AddTheme(Gradient_3, { BackgroundColor3 = "LightContrast" })

        local MultiBoxContentScrolling = Library.CreateObject("ScrollingFrame", {
            Active = true,
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            BorderSizePixel = 0,
            CanvasSize = UDim2_new(0, 0, 0, 0),
            ScrollBarImageColor3 = ThemeDefault.Accent,
            MidImage = "rbxassetid://95591733073455",
            BorderColor3 = Color3_fromRGB(0, 0, 0),
            ScrollBarThickness = 3,
            Name = "Holder",
            BackgroundTransparency = 1,
            Size = UDim2_new(1, 0, 1, 0),
            ScrollBarImageTransparency = 1,
            BottomImage = "rbxassetid://95591733073455",
            TopImage = "rbxassetid://95591733073455",
            BackgroundColor3 = Color3_fromRGB(255, 255, 255),
            Parent = Gradient_3
        }); Library.AddTheme(MultiBoxContentScrolling, { ScrollBarImageColor3 = "Accent" })

        local UIListLayout_4 = Library.CreateObject("UIListLayout", {
            Padding = UDim.new(0, 4),
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = MultiBoxContentScrolling
        })

        local UIPadding_8 = Library.CreateObject("UIPadding", {
            PaddingRight = UDim.new(0, 6),
            PaddingLeft = UDim.new(0, 5),
            Parent = MultiBoxContentScrolling
        })

        local UIPadding_9 = Library.CreateObject("UIPadding", {
            PaddingRight = UDim.new(0, 4),
            PaddingTop = UDim.new(0, 4),
            PaddingBottom = UDim.new(0, 4),
            Parent = Gradient_3
        })

        do -- Functions
            function MultiBox.UpdateName(Name)
                MultiBoxMain.Name = Name
            end

            function MultiBox.Set(Values)
                if type(Values) ~= "table" then return end
                
                for Index, Item in MultiBox.AllItems do
                    if not table_find(Values, Index) then
                        MultiBox.Items[Index] = true
                    else
                        MultiBox.Items[Index] = false
                    end
                    
                    Item.Toggle()
                end
            end
            
            function MultiBox.Get()
                return MultiBox.Value
            end

            function MultiBox.GetSelectedItems()
                local SelectedItems = {}
                
                for _, Item in MultiBox.SelectedOrder do
                    if MultiBox.Items[Item] then
                        table_insert(SelectedItems, Item)
                    end
                end
                
                return SelectedItems
            end

            function MultiBox.UpdateValue()
                MultiBox.Value = MultiBox.GetSelectedItems()

                if #MultiBox.Value == 0 then
                    Value_7.Text = "None"

                    return
                end

                Value_7.Text = table_concat(MultiBox.Value, ", ")
            end
            
            function MultiBox.SetVisible(Bool, Fast)
                MultiBox.MouseLeave()
                MultiBoxMain.ZIndex = Bool and 3 or 0

                if Bool == true then
                    MultiBoxMain.Visible = true
                end

                if Fast then
                    --MultiBoxMain.GroupTransparency = Bool and 0 or 1
                    MultiBoxMain.Size = Bool and MultiBoxSize or UDim2_new(1, 0, 0, -4)

                    if Bool == false then
                        MultiBoxMain.Visible = false
                    end
                else
                    --Library.TweenObject(MultiBoxMain, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {GroupTransparency = Bool and 0 or 1})
                    Library.FadeDescendants(Bool, Library.GetAllObjects(MultiBoxMain))
                    Library.TweenObject(MultiBoxMain, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {Size = Bool and MultiBoxSize or UDim2_new(1, 0, 0, -4)}, function()
                        if Bool == false then
                            MultiBoxMain.Visible = false
                        end
                    end)
                end
            
                if Bool == false and MultiBox.Open then
                    MultiBox.Toggle(true, true)
                end

                return MultiBox
            end
            
            function MultiBox.Update()
                local TabHolder = Options.Parent.Parent.Parent

                MultiBoxContentHolder.Size = UDim2_new(0, MultiBox_2.AbsoluteSize.X, 0, MultiBoxContentHolder.AbsoluteSize.Y)
                MultiBoxContentHolder.Position = UDim2_new(0, MultiBox_2.AbsolutePosition.X, 0, ((MultiBox_2.AbsolutePosition.Y + MultiBox_2.AbsoluteSize.Y) + Inset.Y - 1))
                
                if MultiBox.Open then
                    MultiBoxContentHolder.Visible = Library.ScrollingCheck(Options.Parent, MultiBoxChecker) and TabHolder.Visible
                end
            end

            function MultiBox.Toggle(Bool, Fast)
                if Bool ~= nil then
                    MultiBox.Open = Bool
                end

                if MultiBox.Open then
                    PlusIcon.Text = "+"

                    if Fast then
                        MultiBoxContentHolder.GroupTransparency = 1
                        MultiBoxContentHolder.Size = UDim2_new(0, MultiBox_2.AbsoluteSize.X, 0, 0)
                    else
                        Library.TweenObject(MultiBoxContentHolder, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {GroupTransparency = 1})
                        Library.TweenObject(MultiBoxContentHolder, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {Size = UDim2_new(0, MultiBox_2.AbsoluteSize.X, 0, 0)}, function()
                            MultiBoxMain.ZIndex = 1
                        end)
                    end
                    
                    Library.TweenObject(MultiBoxContentScrolling, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {ScrollBarImageTransparency = 1})
                else
                    MultiBoxContentHolder.ZIndex = Options.MainUI.ZIndex + UITable.DropdownZIndex
                    UITable.DropdownZIndex += 1

                    Library.TweenObject(MultiBoxContentHolder, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {GroupTransparency = 0})
                    
                    PlusIcon.Text = "-"
                    
                    if #Options.Content < 6 then
                        Library.TweenObject(MultiBoxContentHolder, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {Size = UDim2_new(0, MultiBox_2.AbsoluteSize.X, 0, (#Options.Content * 16) + 8)})
                    else
                        Library.TweenObject(MultiBoxContentScrolling, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {ScrollBarImageTransparency = 0})
                        Library.TweenObject(MultiBoxContentHolder, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {Size = UDim2_new(0, MultiBox_2.AbsoluteSize.X, 0, 104)})
                    end
                end
                
                MultiBox.Open = not MultiBox.Open

                MultiBox.Update()
            end

            function MultiBox.MouseEnter()
                if Library.MouseOverOtherWindow(Options.MainUI) then
                    MultiBox.MouseLeave()

                    return
                end

                if Library.MouseOverOtherObject() then
                    MultiBox.MouseLeave()

                    return
                end
                
                MultiBox.Hovering = true
                
                if (not MultiBox.Fading) then
                    Library.TweenObject(WhiteFrame, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {BackgroundTransparency = 0.95})

                    MultiBox.Fading = true
                end
            end

            function MultiBox.MouseLeave()
                MultiBox.Hovering = false

                if MultiBox.Open then
                    return
                end
                
                if MultiBox.Fading then
                    Library.TweenObject(WhiteFrame, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {BackgroundTransparency = 1})

                    MultiBox.Fading = false
                end
            end

            function MultiBox.AddValue(Value)
                local Item = {
                    MouseConnection = nil,
                    Active = false,
                    Hovering = false,
                    Name = Value,
                }

                MultiBox.AllItems[Value] = Item

                local ItemTemplate = Library.CreateObject("TextLabel", {
                    FontFace = LibraryFont,
                    TextColor3 = ThemeDefault.TextColor,
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    Text = Value,
                    Name = "ItemTemplate",
                    Size = UDim2_new(1, 0, 0, 0),
                    Position = UDim2_new(0, 10, 0, 0),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    TextSize = LibraryFontSize,
                    Parent = MultiBoxContentScrolling
                }); Library.AddTheme(ItemTemplate, { TextColor3 = "TextColor" })

                local ClickDetection_3 = Library.CreateObject("TextButton", {
                    FontFace = LibraryFont,
                    TextColor3 = Color3_fromRGB(0, 0, 0),
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    Name = "ClickDetection_3",
                    BackgroundTransparency = 1,
                    Size = UDim2_new(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    TextTransparency = 1,
                    TextSize = LibraryFontSize,
                    BackgroundColor3 = Color3_fromRGB(255, 255, 255),
                    Parent = ItemTemplate
                })

                local UIStroke_5 = Library.CreateObject("UIStroke", {
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Parent = ItemTemplate
                })

                local NamePadding = Library.CreateObject("UIPadding", {
                    Parent = ItemTemplate
                })

                do -- Functions
                    function Item.SelectItem(Item)
                        if not table_find(MultiBox.SelectedOrder, Item) then
                            table_insert(MultiBox.SelectedOrder, Item)
                        end
                        
                        MultiBox.UpdateValue()
                    end

                    function Item.DeselectItem(Item)
                        for Index, Value in MultiBox.SelectedOrder do
                            if Value == Item then
                                table_remove(MultiBox.SelectedOrder, Index)

                                break
                            end
                        end
                        
                        MultiBox.UpdateValue()
                    end

                    function Item.Activate()
                        if not Item.Active then
                            Item.Active = true
                            MultiBox.Value = Value
                            Value_7.Text = Value
                            MultiBox.Items[Value] = true

                            Library.TweenObject(NamePadding, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {PaddingLeft = UDim_new(0, 2)})
                            Library.TweenObject(ItemTemplate, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {TextColor3 = ThemeDefault.Accent}, function()
                                Library.AddTheme(ItemTemplate, {TextColor3 = "Accent"}, "TextColor")
                            end)

                            Flags[Options.Flag] = MultiBox
                            Options.Callback(MultiBox.Items)
                            Item.SelectItem(Value)
                        end
                    end

                    function Item.Deactivate()
                        if Item.Active then
                            Item.Active = false
                            MultiBox.Items[Value] = false

                            Item.DeselectItem(Value)

                            Library.TweenObject(NamePadding, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {PaddingLeft = UDim_new(0, 0)})
                            Library.TweenObject(ItemTemplate, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {TextColor3 = Item.Hovering and ThemeDefault.TextDark or ThemeDefault.TextColor}, function()
                                Library.AddTheme(ItemTemplate, {TextColor3 = Item.Hovering and "TextDark" or "TextColor"}, "Accent")
                            end)
                        end
                    end
                    
                    function Item.Toggle()
                        MultiBox.Items[Value] = not MultiBox.Items[Value]
                        
                        if MultiBox.Items[Value] then
                            Item.Activate()
                        else
                            Item.Deactivate()
                        end
                    end

                    function Item.MouseEnter()
                        if Library.MouseOverOtherWindow(Options.MainUI) then
                            Item.MouseLeave()

                            return
                        end

                        Item.Hovering = true

                        if (not Item.Fading) and (not Item.Active) then
                            Library.TweenObject(ItemTemplate, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {TextColor3 = ThemeDefault.TextDark}, function()
                                Library.AddTheme(ItemTemplate, {TextColor3 = "TextDark"}, "TextColor")
                            end)

                            Item.Fading = true
                        end
                    end

                    function Item.MouseLeave()
                        Item.Hovering = false

                        if Item.Fading and not Item.Active then
                            Library.TweenObject(ItemTemplate, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {TextColor3 = ThemeDefault.TextColor}, function()
                                Library.AddTheme(ItemTemplate, {TextColor3 = "TextColor"}, "TextDark")
                            end)

                            Item.Fading = false
                        end
                    end
                end

                do -- Connections
                    Library.AddConnection(ClickDetection_3.MouseButton1Click, LPH_NO_VIRTUALIZE(function()
                        if Library.MouseOverOtherWindow(Options.MainUI) then
                            return
                        end

                        Item.Toggle()
                    end))

                    Library.AddConnection(ItemTemplate.MouseEnter, LPH_NO_VIRTUALIZE(function()
                        if not Options.MainUI.Visible then
                            return
                        end

                        Item.MouseEnter()

                        if Item.MouseConnection then
                            Item.MouseConnection:Disconnect()
                            Item.MouseConnection = nil
                        end

                        Item.MouseConnection = Library.AddConnection(UserInputService.InputChanged, function(Input)
                            if Input.UserInputType == Enum.UserInputType.MouseMovement then
                                if not Library.MouseOverFrame(ItemTemplate) then
                                    Item.MouseLeave()
                                    Item.MouseConnection:Disconnect()
                                    Item.MouseConnection = nil
                                end
                            end
                        end)
                    end))
                end

                if table_find(Options.Default, Value) then
                    Item.Activate()
                end
            end

            function MultiBox.RemoveValue(Value)
                for _, Object in GetChildren(MultiBoxContentScrolling) do
                    if Object.Name == Value then
                        local CurrentItem = MultiBox.CurrentItem

                        Object:Destroy()

                        if CurrentItem and CurrentItem.Name == Value then
                            CurrentItem.Deactivate()

                            Value_7.Text = "None"
                        end
                    end
                end

                MultiBox.CheckScrolling()
            end
        end

        do -- Connections
            Library.AddConnection(Button_13.MouseButton1Click, LPH_NO_VIRTUALIZE(function()
                if Library.MouseOverOtherWindow(Options.MainUI) then
                    return
                end

                if Library.MouseOverOtherObject() then
                    return
                end

                MultiBox.Toggle()
            end))

            Library.AddConnection(MultiBox_2.MouseEnter, LPH_NO_VIRTUALIZE(function()
                if not Options.MainUI.Visible then
                    return
                end

                if not Library.MouseOverFrame(Options.MainUI) then
                    return
                end

                MultiBox.MouseEnter()

                if MultiBox.MouseConnection then
                    MultiBox.MouseConnection:Disconnect()
                    MultiBox.MouseConnection = nil
                end

                MultiBox.MouseConnection = Library.AddConnection(UserInputService.InputChanged, function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseMovement then
                        if not Library.MouseOverFrame(MultiBox_2) then
                            MultiBox.MouseLeave()
                            MultiBox.MouseConnection:Disconnect()
                            MultiBox.MouseConnection = nil
                        end
                    end
                end)
            end))

            do -- Positioning
                local TabHolder = Options.Parent.Parent.Parent.Parent.Parent.Parent.Parent

                Library.AddConnection(MultiBox_2:GetPropertyChangedSignal("AbsolutePosition"), MultiBox.Update)
                Library.AddConnection(MultiBox_2:GetPropertyChangedSignal("AbsoluteSize"), MultiBox.Update)

                if IsA(Options.Parent, "ScrollingFrame") then
                    Library.AddConnection(Options.Parent:GetPropertyChangedSignal("CanvasPosition"), MultiBox.Update)
                end

                Library.AddConnection(Options.MainUI:GetPropertyChangedSignal("ZIndex"), LPH_NO_VIRTUALIZE(function()
                    MultiBoxContentHolder.ZIndex = Options.MainUI.ZIndex + UITable.DropdownZIndex
                end))

                if IsA(Options.MainUI, "CanvasGroup") then
                    Library.AddConnection(Options.MainUI:GetPropertyChangedSignal("GroupTransparency"), LPH_NO_VIRTUALIZE(function()
                        if Options.MainUI.GroupTransparency == 1 then
                            MultiBox.Toggle(true)
                        end

                        if MultiBox.Open then
                            MultiBoxContentHolder.GroupTransparency = Options.MainUI.GroupTransparency
                        end
                    end))
                end

                if not IsA(TabHolder, "GuiObject") then
                    TabHolder = Options.Parent.Parent
                end

                Library.AddConnection(TabHolder:GetPropertyChangedSignal("Visible"), LPH_NO_VIRTUALIZE(function()
                    if not TabHolder.Visible then
                        MultiBoxContentHolder.Visible = false
                    else
                        MultiBoxContentHolder.Visible = MultiBox.Open and TabHolder
                    end
                end))

                Library.AddConnection(Options.MainUI:GetPropertyChangedSignal("Visible"), LPH_NO_VIRTUALIZE(function()
                    if not Options.MainUI.Visible then
                        MultiBoxContentHolder.Visible = false
                    else
                        MultiBoxContentHolder.Visible = MultiBox.Open and TabHolder
                    end
                end))

                Library.AddConnection(Options.Parent:GetPropertyChangedSignal("Visible"), LPH_NO_VIRTUALIZE(function()
                    if not Options.Parent.Visible then
                        MultiBoxContentHolder.Visible = false
                    else
                        MultiBoxContentHolder.Visible = MultiBox.Open and TabHolder
                    end
                end))
            end
        end

        MultiBox.Update()
            
        for _, Value in Options.Content do
            MultiBox.AddValue(Value)
        end

        return MultiBox
    end

	function Library.CreateWindow(Options)
		Options = Library.Validate({
			Name = "example ui",
			Icon = nil,
			ColoredTexts = {},
		}, Options or {})

		local Window = {
			Visible = true,
			CurrentTab = nil,
			ColoredTexts = Options.ColoredTexts,
			Tabs = {},
		}

        local LibraryFontSize = UITable.FontSize
        local LibraryFont = UITable.Font
		local ScreenGui = UITable.ScreenGui
		local ExtrasScreenGui = UITable.ExtrasScreenGui
		local Holder_7 = Library.CreateObject("CanvasGroup", {
			Name = "Holder_7",
			Position = UDim2_new(0, 0, 0, 0),
			BorderColor3 = Color3_fromRGB(0, 0, 0),
			Size = UDim2_new(0, 750, 0, 480),
			BorderSizePixel = 0,
			BackgroundColor3 = ThemeDefault.Outline,
			Parent = ScreenGui
		}); Library.AddTheme(Holder_7, { BackgroundColor3 = "Outline" })
		
		table_insert(UITable.MainWindows, Holder_7)

        local HolderShadow = Library.CreateObject("UIShadow", {
            Name = "HolderShadow",
            Transparency = 0.5,
            BlurRadius = UDim_new(0, 20),
            Parent = Holder_7
        })

		local MainBackground = Library.CreateObject("Frame", {
			Size = UDim2_new(1, -2, 1, -2),
			Name = "MainBackground",
			Position = UDim2_new(0, 1, 0, 1),
			BorderColor3 = Color3_fromRGB(0, 0, 0),
			ZIndex = 2,
			BorderSizePixel = 0,
			BackgroundColor3 = ThemeDefault.LightContrast,
			Parent = Holder_7
		}); Library.AddTheme(MainBackground, { BackgroundColor3 = "LightContrast" })

		local TopBar = Library.CreateObject("Frame", {
			BackgroundTransparency = 1,
			Name = "TopBar",
			BorderColor3 = Color3_fromRGB(0, 0, 0),
			Size = UDim2_new(1, 0, 0, 50),
			BorderSizePixel = 0,
			BackgroundColor3 = Color3_fromRGB(255, 255, 255),
			Parent = MainBackground
		})
		
		local ResizeButton_2 = Library.CreateObject("ImageButton", {
			ImageColor3 = ThemeDefault.Outline,
			ScaleType = Enum.ScaleType.Fit,
			BorderColor3 = Color3_fromRGB(0, 0, 0),
			Name = "ResizeButton_2",
			AnchorPoint = Vector2_new(1, 1),
			Image = "rbxassetid://126006666702327",
			BackgroundTransparency = 1,
			Position = UDim2_new(1, 0, 1, 0),
			Size = UDim2_new(0, 12, 0, 12),
			BorderSizePixel = 0,
			BackgroundColor3 = Color3_fromRGB(255, 255, 255),
			Parent = MainBackground
		}); Library.AddTheme(ResizeButton_2, { ImageColor3 = "Outline" })

		local MainHolder = Library.CreateObject("Frame", {
			Name = "MainHolder",
			BorderColor3 = Color3_fromRGB(0, 0, 0),
			Size = UDim2_new(1, 0, 0, 25),
			BorderSizePixel = 0,
			BackgroundColor3 = Color3_fromRGB(255, 255, 255),
			Parent = TopBar
		})

        local DragButton = Library.CreateObject("TextButton", {
			FontFace = Font_new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
			TextColor3 = ThemeDefault.Outline,
			BorderColor3 = Color3_fromRGB(0, 0, 0),
			Name = "DragButton",
			BackgroundTransparency = 1,
			Size = UDim2_new(1, 0, 1, 0),
			BorderSizePixel = 0,
			TextTransparency = 1,
			TextSize = 14,
			BackgroundColor3 = Color3_fromRGB(255, 255, 255),
			Parent = MainHolder
		})

		local Title = Library.CreateObject("TextLabel", {
			FontFace = LibraryFont,
			TextColor3 = ThemeDefault.TextColor,
			BorderColor3 = Color3_fromRGB(0, 0, 0),
			Text = `{Options.Name} - {UITable.ScriptBuild}`,
			Name = "Title",
			Size = UDim2_new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			TextXAlignment = Enum.TextXAlignment.Left,
			BorderSizePixel = 0,
			RichText = true,
			TextSize = LibraryFontSize,
			BackgroundColor3 = Color3_fromRGB(255, 255, 255),
			Parent = MainHolder
		}); Library.AddTheme(Title, { TextColor3 = "TextColor" })

		local UIStroke_42 = Library.CreateObject("UIStroke", {
			LineJoinMode = Enum.LineJoinMode.Miter,
			Parent = Title
		})

		local UIPadding_14 = Library.CreateObject("UIPadding", {
			PaddingBottom = UDim.new(0, 3),
			PaddingLeft = UDim.new(0, 7),
			Parent = Title
		})

		local BottomBar = Library.CreateObject("Frame", {
			BorderColor3 = Color3_fromRGB(0, 0, 0),
			AnchorPoint = Vector2_new(0, 1),
			Name = "BottomBar",
			Position = UDim2_new(0, 0, 1, 0),
			Size = UDim2_new(1, 0, 0, 1),
			ZIndex = 3,
			BorderSizePixel = 0,
			BackgroundColor3 = ThemeDefault.Outline,
			Parent = MainHolder
		}); Library.AddTheme(BottomBar, { BackgroundColor3 = "Outline" })

		local UIGradient = Library.CreateObject("UIGradient", {
			Rotation = 90,
			Color = ColorSequence_new({ ColorSequenceKeypoint_new(0, ThemeDefault.Accent), ColorSequenceKeypoint_new(1, ThemeDefault.SecondAccent) }),
			Parent = MainHolder
		}); Library.AddTheme(UIGradient, { Color = {"Accent", "SecondAccent"} })

		local CloseButton = Library.CreateObject("Frame", {
			BorderColor3 = Color3_fromRGB(0, 0, 0),
			AnchorPoint = Vector2_new(1, 0),
			BackgroundTransparency = 1,
			Position = UDim2_new(1, 1, 0, 0),
			Name = "CloseButton",
			Size = UDim2_new(1, 0, 1, 0),
			BorderSizePixel = 0,
			ZIndex = 5,
			BackgroundColor3 = Color3_fromRGB(255, 255, 255),
			Parent = MainHolder
		})

		local UIAspectRatioConstraint = Library.CreateObject("UIAspectRatioConstraint", {
			Parent = CloseButton
		})

		local Button = Library.CreateObject("TextButton", {
			FontFace = LibraryFont,
			TextColor3 = ThemeDefault.TextColor,
			BorderColor3 = Color3_fromRGB(0, 0, 0),
			Text = "X",
			AutoButtonColor = false,
			AnchorPoint = Vector2_new(1, 0),
			Name = "Button",
			BackgroundTransparency = 1,
			Position = UDim2_new(1, 0, 0, 0),
			Size = UDim2_new(1, 0, 1, 0),
			BorderSizePixel = 0,
			TextSize = LibraryFontSize,
			BackgroundColor3 = Color3_fromRGB(255, 255, 255),
			Parent = CloseButton
		}); Library.AddTheme(Button, { TextColor3 = "TextColor" })

		local UIStroke_43 = Library.CreateObject("UIStroke", {
			LineJoinMode = Enum.LineJoinMode.Miter,
			Parent = Button
		})

		local UIPadding_15 = Library.CreateObject("UIPadding", {
			PaddingBottom = UDim.new(0, 3),
			PaddingRight = UDim.new(0, -4),
			Parent = Button
		})

		local UIGradient_1 = Library.CreateObject("UIGradient", {
			Rotation = 90,
			Color = ColorSequence_new({ ColorSequenceKeypoint_new(0, Color3_fromRGB(245, 77, 80)), ColorSequenceKeypoint_new(1, Color3_fromRGB(141, 1, 3)) }),
			Parent = CloseButton
		})

		local LeftBar = Library.CreateObject("Frame", {
			AnchorPoint = Vector2_new(1, 0),
			BackgroundTransparency = 1,
			Name = "LeftBar",
			BorderColor3 = Color3_fromRGB(0, 0, 0),
			Size = UDim2_new(0, 1, 1, 0),
			BorderSizePixel = 0,
			BackgroundColor3 = ThemeDefault.Outline,
			Parent = CloseButton
		}); Library.AddTheme(LeftBar, { BackgroundColor3 = "Outline" })

		local Navigation = Library.CreateObject("Frame", {
			BorderColor3 = Color3_fromRGB(0, 0, 0),
			AnchorPoint = Vector2_new(0, 1),
			BackgroundTransparency = 1,
			Position = UDim2_new(0, 0, 1, 0),
			Name = "Navigation",
			Size = UDim2_new(1, 0, 0, 25),
			BorderSizePixel = 0,
			BackgroundColor3 = Color3_fromRGB(255, 255, 255),
			Parent = TopBar
		})

		local Tabs = Library.CreateObject("Frame", {
			BackgroundTransparency = 1,
			Name = "Tabs",
			BorderColor3 = Color3_fromRGB(0, 0, 0),
			Size = UDim2_new(1, 0, 1, 0),
			BorderSizePixel = 0,
			BackgroundColor3 = Color3_fromRGB(255, 255, 255),
			Parent = Navigation
		})
		
		local UIPadding_59 = Library.CreateObject("UIPadding", {
			PaddingTop = UDim.new(0, -1),
			PaddingRight = UDim.new(0, -1),
			PaddingLeft = UDim.new(0, -1),
			Parent = Tabs
		})

		local UIListLayout_7 = Library.CreateObject("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, -1),
			Parent = Tabs
		})
		
		local BottomBar_5 = Library.CreateObject("Frame", {
			AnchorPoint = Vector2_new(0, 1),
			Name = "BottomBar_5",
			Position = UDim2_new(0, 0, 1, 0),
			BorderColor3 = Color3_fromRGB(0, 0, 0),
			Size = UDim2_new(1, 0, 0, 1),
			BorderSizePixel = 0,
			BackgroundColor3 = ThemeDefault.Outline,
			Parent = Navigation
		}); Library.AddTheme(BottomBar_5, { BackgroundColor3 = "Outline" })
		
		do -- Functions
            function Window.CreateColorPicker()
                local Table = {
                    Enabled = false,
                    FirstClick = false,
                    MainUI = nil,
                    OldPicker = nil,
                    AnimationConnection = nil,
                    Color = Color3_fromRGB(255, 255, 255),
                    Saturation = {1, 1},
                    Alpha = 1,
                    Hue = 1,
                    Dropdowns = {},
                    ChangingConnections = {},
                }

                local ColorPicker = Library.CreateObject("CanvasGroup", {
                    Visible = false,
                    GroupTransparency = 1,
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    Name = "ColorPicker",
                    Size = UDim2_new(0, 230, 0, 290),
                    BorderSizePixel = 0,
                    BackgroundColor3 = ThemeDefault.Outline,
                    Parent = ExtrasScreenGui
                }); Library.AddTheme(ColorPicker, { BackgroundColor3 = "Outline" })

                ColorPicker.Position = UDim2_fromOffset(Holder_7.AbsolutePosition.X - ColorPicker.AbsoluteSize.X - 10, Holder_7.AbsolutePosition.Y + Inset.Y)

                local MainBackground = Library.CreateObject("Frame", {
                    Size = UDim2_new(1, -2, 1, -2),
                    Name = "MainBackground",
                    Position = UDim2_new(0, 1, 0, 1),
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = ThemeDefault.LightContrast,
                    Parent = ColorPicker
                }); Library.AddTheme(MainBackground, { BackgroundColor3 = "LightContrast" })

                local TopBar = Library.CreateObject("Frame", {
                    BackgroundTransparency = 1,
                    Name = "TopBar",
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    Size = UDim2_new(1, 0, 0, 50),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3_fromRGB(255, 255, 255),
                    Parent = MainBackground
                })

                local MainHolder = Library.CreateObject("Frame", {
                    Name = "MainHolder",
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    Size = UDim2_new(1, 0, 0, 25),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3_fromRGB(255, 255, 255),
                    Parent = TopBar
                })

                local Title = Library.CreateObject("TextLabel", {
                    FontFace = LibraryFont,
                    TextColor3 = ThemeDefault.TextColor,
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    Text = "Colorpicker Window",
                    Name = "Title",
                    Size = UDim2_new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BorderSizePixel = 0,
                    RichText = true,
                    TextSize = LibraryFontSize,
                    BackgroundColor3 = Color3_fromRGB(255, 255, 255),
                    Parent = MainHolder
                }); Library.AddTheme(Title, { TextColor3 = "TextColor" })

                local UIStroke = Library.CreateObject("UIStroke", {
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Parent = Title
                })

                local UIPadding = Library.CreateObject("UIPadding", {
                    PaddingBottom = UDim.new(0, 3),
                    PaddingLeft = UDim.new(0, 7),
                    Parent = Title
                })

                local BottomBar = Library.CreateObject("Frame", {
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    AnchorPoint = Vector2_new(0, 1),
                    Name = "BottomBar",
                    Position = UDim2_new(0, 0, 1, 0),
                    Size = UDim2_new(1, 0, 0, 1),
                    ZIndex = 3,
                    BorderSizePixel = 0,
                    BackgroundColor3 = ThemeDefault.Outline,
                    Parent = MainHolder
                }); Library.AddTheme(BottomBar, { BackgroundColor3 = "Outline" })

                local UIGradient = Library.CreateObject("UIGradient", {
                    Rotation = 90,
                    Color = ColorSequence_new({ ColorSequenceKeypoint_new(0, ThemeDefault.Accent), ColorSequenceKeypoint_new(1, ThemeDefault.SecondAccent) }),
                    Parent = MainHolder
                }); Library.AddTheme(UIGradient, { Color = {"Accent", "SecondAccent"} })

                local CloseButton = Library.CreateObject("Frame", {
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    AnchorPoint = Vector2_new(1, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2_new(1, 2, 0, 0),
                    Name = "CloseButton",
                    ZIndex = 100,
                    Size = UDim2_new(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3_fromRGB(255, 255, 255),
                    Parent = MainHolder
                })

                local UIAspectRatioConstraint = Library.CreateObject("UIAspectRatioConstraint", {
                    Parent = CloseButton
                })

                local ClosingButton = Library.CreateObject("TextButton", {
                    FontFace = LibraryFont,
                    TextColor3 = ThemeDefault.TextColor,
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    Text = "X",
                    AutoButtonColor = false,
                    AnchorPoint = Vector2_new(1, 0),
                    Name = "Button",
                    BackgroundTransparency = 1,
                    Position = UDim2_new(1, 0, 0, 0),
                    Size = UDim2_new(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    TextSize = LibraryFontSize,
                    BackgroundColor3 = Color3_fromRGB(255, 255, 255),
                    Parent = CloseButton
                }); Library.AddTheme(ClosingButton, { TextColor3 = "TextColor" })

                local UIStroke_1 = Library.CreateObject("UIStroke", {
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Parent = ClosingButton
                })

                local UIPadding_1 = Library.CreateObject("UIPadding", {
                    PaddingBottom = UDim.new(0, 3),
                    PaddingRight = UDim.new(0, -3),
                    Parent = ClosingButton
                })

                local UIGradient_1 = Library.CreateObject("UIGradient", {
                    Rotation = 90,
                    Color = ColorSequence_new({ ColorSequenceKeypoint_new(0, Color3_fromRGB(245, 77, 80)), ColorSequenceKeypoint_new(1, Color3_fromRGB(141, 1, 3)) }),
                    Parent = CloseButton
                })

                local LeftBar = Library.CreateObject("Frame", {
                    AnchorPoint = Vector2_new(1, 0),
                    BackgroundTransparency = 1,
                    Name = "LeftBar",
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    Size = UDim2_new(0, 1, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = ThemeDefault.Outline,
                    Parent = CloseButton
                }); Library.AddTheme(LeftBar, { BackgroundColor3 = "Outline" })

                local Navigation = Library.CreateObject("Frame", {
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    AnchorPoint = Vector2_new(0, 1),
                    BackgroundTransparency = 1,
                    Position = UDim2_new(0, 0, 1, 0),
                    Name = "Navigation",
                    Size = UDim2_new(1, 0, 0, 25),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3_fromRGB(255, 255, 255),
                    Parent = TopBar
                })

                local Tabs = Library.CreateObject("Frame", {
                    BackgroundTransparency = 1,
                    Name = "Tabs",
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    Size = UDim2_new(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3_fromRGB(255, 255, 255),
                    Parent = Navigation
                })

                local UIListLayout = Library.CreateObject("UIListLayout", {
                    Padding = UDim.new(0, -1),
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    FillDirection = Enum.FillDirection.Horizontal,
                    Parent = Tabs
                })

                local UIPadding_3 = Library.CreateObject("UIPadding", {
                    PaddingTop = UDim.new(0, -1),
                    PaddingRight = UDim.new(0, -1),
                    PaddingLeft = UDim.new(0, -1),
                    Parent = Tabs
                })

                local TabTable = Window.CreateTab({Name = "Picker", Parent = Tabs, Holder = MainBackground, Table = Table, MainUI = ColorPicker, Solo = true})
                local OtherTabTable = Window.CreateTab({Name = "Settings", Parent = Tabs, MainUI = ColorPicker, Holder = MainBackground, Table = Table, Solo = true})

                local Picker = Library.CreateObject("Frame", {
                    Name = "Picker",
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    Size = UDim2_new(1, -26, 1, -26),
                    BorderSizePixel = 0,
                    BackgroundColor3 = ThemeDefault.Outline,
                    Parent = TabTable.Holder
                }); Library.AddTheme(Picker, { BackgroundColor3 = "Outline" })

                local PickerButton = Library.CreateObject("TextButton", {
                    FontFace = Font_new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
                    TextColor3 = ThemeDefault.Outline,
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    Name = "DragButton",
                    BackgroundTransparency = 1,
                    Size = UDim2_new(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    TextTransparency = 1,
                    TextSize = 14,
                    ZIndex = 10,
                    BackgroundColor3 = Color3_fromRGB(255, 255, 255),
                    Parent = Picker
                })

                local TransparencyGradient = Library.CreateObject("Frame", {
                    Size = UDim2_new(1, -2, 1, -2),
                    Name = "TransparencyGradient",
                    Position = UDim2_new(0, 1, 0, 1),
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3_fromRGB(255, 255, 255),
                    Parent = Picker
                })

                local UIGradient_4 = Library.CreateObject("UIGradient", {
                    Rotation = 180,
                    Parent = TransparencyGradient
                })

                local ImageLabel = Library.CreateObject("ImageLabel", {
                    ImageColor3 = Color3_fromRGB(0, 0, 0),
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    Image = "rbxassetid://8180999986",
                    BackgroundTransparency = 1,
                    Size = UDim2_new(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3_fromRGB(255, 255, 255),
                    Parent = TransparencyGradient
                })

                local DraggingDot = Library.CreateObject("Frame", {
                    Name = "DraggingDot",
                    Size = UDim2_new(0, 6, 0, 6),
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    ZIndex = 5,
                    BorderSizePixel = 0,
                    BackgroundColor3 = ThemeDefault.Outline,
                    Parent = Picker
                }); Library.AddTheme(DraggingDot, { BackgroundColor3 = "Outline" })

                local Inside = Library.CreateObject("Frame", {
                    Name = "Inside",
                    Position = UDim2_new(0, 1, 0, 1),
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    Size = UDim2_new(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3_fromRGB(255, 255, 255),
                    Parent = DraggingDot
                })

                local HueOutline = Library.CreateObject("Frame", {
                    AnchorPoint = Vector2_new(1, 0),
                    Name = "HueOutline",
                    Position = UDim2_new(1, 0, 0, 0),
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    Size = UDim2_new(0, 20, 1, -26),
                    BorderSizePixel = 0,
                    BackgroundColor3 = ThemeDefault.Outline,
                    Parent = TabTable.Holder
                }); Library.AddTheme(HueOutline, { BackgroundColor3 = "Outline" })

                local HueButton = Library.CreateObject("TextButton", {
                    FontFace = Font_new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
                    TextColor3 = ThemeDefault.Outline,
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    Name = "DragButton",
                    BackgroundTransparency = 1,
                    Size = UDim2_new(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    TextTransparency = 1,
                    TextSize = 14,
                    ZIndex = 10,
                    BackgroundColor3 = Color3_fromRGB(255, 255, 255),
                    Parent = HueOutline
                })

                local ImageLabel_1 = Library.CreateObject("ImageLabel", {
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    Image = "rbxassetid://8180989234",
                    BackgroundTransparency = 1,
                    Position = UDim2_new(0, 1, 0, 1),
                    Size = UDim2_new(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3_fromRGB(255, 255, 255),
                    Parent = HueOutline
                })

                local HueDraggingLine = Library.CreateObject("Frame", {
                    Name = "DraggingDot_1",
                    Size = UDim2_new(1, 0, 0, 4),
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    ZIndex = 5,
                    BorderSizePixel = 0,
                    BackgroundColor3 = ThemeDefault.Outline,
                    Parent = HueOutline
                }); Library.AddTheme(HueDraggingLine, { BackgroundColor3 = "Outline" })

                local Inside_1 = Library.CreateObject("Frame", {
                    Name = "Inside_1",
                    Position = UDim2_new(0, 1, 0, 1),
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    Size = UDim2_new(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3_fromRGB(255, 255, 255),
                    Parent = HueDraggingLine
                })

                local TransparencyOutline = Library.CreateObject("Frame", {
                    AnchorPoint = Vector2_new(0, 1),
                    Name = "TransparencyOutline",
                    Position = UDim2_new(0, 0, 1, 0),
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    Size = UDim2_new(1, -26, 0, 20),
                    BorderSizePixel = 0,
                    BackgroundColor3 = ThemeDefault.Outline,
                    Parent = TabTable.Holder
                }); Library.AddTheme(TransparencyOutline, { BackgroundColor3 = "Outline" })

                local SaturationButton = Library.CreateObject("TextButton", {
                    FontFace = Font_new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
                    TextColor3 = ThemeDefault.Outline,
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    Name = "DragButton",
                    BackgroundTransparency = 1,
                    Size = UDim2_new(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    TextTransparency = 1,
                    TextSize = 14,
                    ZIndex = 10,
                    BackgroundColor3 = Color3_fromRGB(255, 255, 255),
                    Parent = TransparencyOutline
                })

                local TransparencyGradient_1 = Library.CreateObject("Frame", {
                    Size = UDim2_new(1, -2, 1, -2),
                    Name = "TransparencyGradient_1",
                    Position = UDim2_new(0, 1, 0, 1),
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    Parent = TransparencyOutline
                })

                local UIGradient_5 = Library.CreateObject("UIGradient", {
                    Transparency = NumberSequence.new{
                    NumberSequenceKeypoint.new(0, 1),
                    NumberSequenceKeypoint.new(1, 0)
                },
                    Parent = TransparencyGradient_1
                })

                local ImageLabel_2 = Library.CreateObject("ImageLabel", {
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    Size = UDim2_new(1, -2, 1, -2),
                    Image = "rbxassetid://17716156120",
                    TileSize = UDim2_new(0, 10, 0, 10),
                    Position = UDim2_new(0, 1, 0, 1),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3_fromRGB(255, 255, 255),
                    Parent = TransparencyOutline
                })

                local AlphaDraggingLine = Library.CreateObject("Frame", {
                    Name = "DraggingDot_2",
                    Size = UDim2_new(0, 4, 1, 0),
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    ZIndex = 5,
                    BorderSizePixel = 0,
                    BackgroundColor3 = ThemeDefault.Outline,
                    Parent = TransparencyOutline
                }); Library.AddTheme(AlphaDraggingLine, { BackgroundColor3 = "Outline" })

                local Inside_2 = Library.CreateObject("Frame", {
                    Name = "Inside_2",
                    Position = UDim2_new(0, 1, 0, 1),
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    Size = UDim2_new(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3_fromRGB(255, 255, 255),
                    Parent = AlphaDraggingLine
                })

                local ActualColor = Library.CreateObject("Frame", {
                    AnchorPoint = Vector2_new(1, 1),
                    Name = "ActualColor",
                    Position = UDim2_new(1, 0, 1, 0),
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    Size = UDim2_new(0, 20, 0, 20),
                    BorderSizePixel = 0,
                    BackgroundColor3 = ThemeDefault.Outline,
                    Parent = TabTable.Holder
                }); Library.AddTheme(ActualColor, { BackgroundColor3 = "Outline" })

                local TransparencyGradient_2 = Library.CreateObject("Frame", {
                    Size = UDim2_new(1, -2, 1, -2),
                    Name = "TransparencyGradient_2",
                    Position = UDim2_new(0, 1, 0, 1),
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3_fromRGB(255, 255, 255),
                    Parent = ActualColor
                })

                local UIGradient_6 = Library.CreateObject("UIGradient", {
                    Rotation = 90,
                    Color = ColorSequence_new({ ColorSequenceKeypoint_new(0, Color3_fromRGB(255, 0, 4)), ColorSequenceKeypoint_new(1, Color3_fromRGB(144, 0, 2)) }),
                    Parent = TransparencyGradient_2
                })

                local ResizeButton = Library.CreateObject("ImageButton", {
                    ImageColor3 = ThemeDefault.Outline,
                    ScaleType = Enum.ScaleType.Fit,
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    Name = "ResizeButton",
                    AnchorPoint = Vector2_new(1, 1),
                    Image = "rbxassetid://126006666702327",
                    BackgroundTransparency = 1,
                    Position = UDim2_new(1, 0, 1, 0),
                    Size = UDim2_new(0, 12, 0, 12),
                    BorderSizePixel = 0,
                    ZIndex = 100,
                    BackgroundColor3 = Color3_fromRGB(255, 255, 255),
                    Parent = MainBackground
                }); Library.AddTheme(ResizeButton, { ImageColor3 = "Outline" })

                local DragButton = Library.CreateObject("TextButton", {
                    FontFace = Font_new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
                    TextColor3 = ThemeDefault.Outline,
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    Name = "DragButton",
                    BackgroundTransparency = 1,
                    Size = UDim2_new(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    TextTransparency = 1,
                    TextSize = 14,
                    BackgroundColor3 = Color3_fromRGB(255, 255, 255),
                    Parent = MainHolder
                })



                local BottomHolder = Library.CreateObject("Frame", {
                    LayoutOrder = 2,
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    AnchorPoint = Vector2_new(0, 1),
                    Name = "BottomHolder",
                    BackgroundTransparency = 1,
                    Position = UDim2_new(0, 0, 1, 0),
                    Size = UDim2_new(1, 0, 0, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundColor3 = Color3_fromRGB(255, 255, 255),
                    Parent = OtherTabTable.Holder
                })

                local UIListLayout_1 = Library.CreateObject("UIListLayout", {
                    Padding = UDim.new(0, 6),
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Parent = BottomHolder
                })

                local TopHolder = Library.CreateObject("Frame", {
                    Name = "TopHolder",
                    BackgroundTransparency = 1,
                    Position = UDim2_new(0, 0, 0, 50),
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    Size = UDim2_new(1, 0, 0, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3_fromRGB(255, 255, 255),
                    Parent = OtherTabTable.Holder
                })

                local UIFlexItem_2 = Library.CreateObject("UIFlexItem", {
                    FlexMode = Enum.UIFlexMode.Fill,
                    Parent = TopHolder
                })

                local Picker_1 = Library.CreateObject("Frame", {
                    Name = "Picker_1",
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    Size = UDim2_new(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = ThemeDefault.Outline,
                    Parent = TopHolder
                }); Library.AddTheme(Picker_1, { BackgroundColor3 = "Outline" })

                local TransparencyGradient_3 = Library.CreateObject("Frame", {
                    Size = UDim2_new(1, -2, 1, -2),
                    Name = "TransparencyGradient_3",
                    Position = UDim2_new(0, 1, 0, 1),
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3_fromRGB(255, 255, 255),
                    Parent = Picker_1
                })

                local UIGradient_62 = Library.CreateObject("UIGradient", {
                    Rotation = 90,
                    Color = ColorSequence_new({ ColorSequenceKeypoint_new(0, Color3_fromRGB(255, 0, 4)), ColorSequenceKeypoint_new(1, Color3_fromRGB(144, 0, 2)) }),
                    Parent = TransparencyGradient_3
                })

                local UIFlexItem_3 = Library.CreateObject("UIFlexItem", {
                    FlexMode = Enum.UIFlexMode.Fill,
                    Parent = Picker_1
                })

                local UIListLayout_2 = Library.CreateObject("UIListLayout", {
                    FillDirection = Enum.FillDirection.Horizontal,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, 6),
                    Parent = TopHolder
                })

                local Picker_2 = Library.CreateObject("Frame", {
                    Name = "Picker_2",
                    BorderColor3 = Color3_fromRGB(0, 0, 0),
                    Size = UDim2_new(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    Parent = TopHolder
                })

                local UIListLayout_3242 = Library.CreateObject("UIListLayout", {
                    VerticalAlignment = Enum.VerticalAlignment.Top,
                    HorizontalAlignment = Enum.HorizontalAlignment.Left,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, 2),
                    Parent = Picker_2
                })

                local UIFlexItem_4 = Library.CreateObject("UIFlexItem", {
                    FlexMode = Enum.UIFlexMode.Fill,
                    Parent = Picker_2
                })

                local UIListLayout_3 = Library.CreateObject("UIListLayout", {
                    VerticalAlignment = Enum.VerticalAlignment.Bottom,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, 10),
                    Parent = OtherTabTable.Holder
                })

                local ResetButton = Library.CreateButton({
                    MainTable = Window,
                    MainUI = ColorPicker,
                    Parent = BottomHolder,
                    LayoutOrder = 3,
                    Name = "Reset",
                    Risky = false,
                    ToolTip = "",
                    Confirmation = true,
                    Callback = function() end,
                })

                local CopyButton = Library.CreateButton({
                    MainTable = Window,
                    MainUI = ColorPicker,
                    Parent = BottomHolder,
                    LayoutOrder = 4,
                    Name = "Copy",
                    Risky = false,
                    ToolTip = "",
                    Confirmation = true,
                    Callback = function() end,
                })

                local PasteButton = Library.CreateButton({
                    MainTable = Window,
                    MainUI = ColorPicker,
                    Parent = BottomHolder,
                    LayoutOrder = 5,
                    Name = "Paste",
                    Risky = false,
                    ToolTip = "",
                    Confirmation = true,
                    Callback = function() end,
                })

                local HexText = Library.CreateLabel({
					MainTable = Window,
					MainUI = ColorPicker,
					Message = "Hex: #00000",
					Side = "Left",
					ToolTip = "",
					SectionName = "ColorPickerSettings",
					Parent = Picker_2
				})

                local RGBText = Library.CreateLabel({
					MainTable = Window,
					MainUI = ColorPicker,
					Message = "RGB: 0, 0, 0",
					Side = "Left",
					ToolTip = "",
					SectionName = "ColorPickerSettings",
					Parent = Picker_2
				})

                local HSVText = Library.CreateLabel({
					MainTable = Window,
					MainUI = ColorPicker,
					Message = "HSV: 0, 0, 0",
					Side = "Left",
					ToolTip = "",
					SectionName = "ColorPickerSettings",
					Parent = Picker_2
				})

                local AlphaText = Library.CreateLabel({
					MainTable = Window,
					MainUI = ColorPicker,
					Message = "Transparency: 0",
					Side = "Left",
					ToolTip = "",
					SectionName = "ColorPickerSettings",
					Parent = Picker_2
				})

                do -- Functions
                    function Library.FindColorPicker(ColorPickerName)
                        return (Table.OldPicker == ColorPickerName) and ColorPicker.Visible
                    end

                    function Library.RemoveColorPicker(ColorPickerName)
                        Library.TweenObject(ColorPicker, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {GroupTransparency = 1}, function()
                            ColorPicker.Visible = false
                        end)
                    end

                    function Library.HideOther(ColorPickerName)
                        for _, Object in GetChildren(BottomHolder) do
                            if Object.Name == ColorPickerName then
                                continue
                            end

                            local Dropdown = Table.Dropdowns[Object.Name]

                            if Dropdown then
                                Dropdown.SetVisible(false, true)
                            end
                        end
                    end

                    function Library.UpdateColorPicker(Visible, ColorPickerName, ColorPickerTable)
                        local ChangingConnections = Table.ChangingConnections
                        local DraggableObjects = {Picker, TransparencyOutline, HueOutline}
                        local Dropdown = Table.Dropdowns[ColorPickerName]
                        local DefaultModes = {}; for ModeName, ModeValue in ColorPickerTable.SelectedModes do
                            if ModeValue == true then
                                table_insert(DefaultModes, ModeName)
                            end
                        end

                        if Table.FirstClick == false then
                            ColorPicker.Position = UDim2_fromOffset(Holder_7.AbsolutePosition.X - ColorPicker.AbsoluteSize.X - 10, Holder_7.AbsolutePosition.Y + Inset.Y)
                            Table.FirstClick = true
                        end

                        Library.HideOther(ColorPickerName)

                        if not Dropdown then
                            Table.Dropdowns[ColorPickerName] = Library.CreateMultiBox({
                                MainTable = Window,
                                MainUI = ColorPicker,
                                ID = ColorPickerName,
                                Name = "Animations",
                                Default = DefaultModes,
                                ScreenGui = ExtrasScreenGui,
                                Content = ColorPickerTable.Modes,
                                Parent = BottomHolder,
                                Callback = function(Values)
                                    for Mode, NewValue in Values do
                                        ColorPickerTable.SelectedModes[Mode] = NewValue or false
                                    end
                                end
                            })

                            Dropdown = Table.Dropdowns[ColorPickerName]
                        end

                        for _, Connection in ChangingConnections do
                            Connection:Disconnect()
                        end

                        table_clear(ChangingConnections)

                        Table.OldPicker = ColorPickerName
                        Title.Text = ColorPickerTable.Name
                        Dropdown.SetVisible(Library.DictionaryLength(ColorPickerTable.Modes) > 0, true)
                        Dropdown.UpdateName(ColorPickerName)
                        UITable.ExtrasScreenGui.DisplayOrder = 20000001
                        UITable.ScreenGui.DisplayOrder = 20000000
                        ColorPicker.ZIndex = UITable.MainZIndex + UITable.DropdownZIndex + 1
                        Table.Enabled = Visible
                        
                        if Visible == true then
                            ColorPicker.Visible = true
                        end

                        Library.TweenObject(ColorPicker, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {GroupTransparency = 0}, function()
                            if Visible == false then
                                ColorPicker.Visible = false
                            end
                        end)

                        do -- Updating
                            UIGradient_4.Color = ColorSequence_new{ColorSequenceKeypoint_new(0, ColorPickerTable.Color), ColorSequenceKeypoint_new(1, Color3_fromRGB(255, 255, 255))}
                            TransparencyGradient_1.BackgroundColor3 = ColorPickerTable.Color
                            Table.Hue = ColorPickerTable.Hue
                            Table.Transparency = ColorPickerTable.Transparency
                            Table.Saturation = ColorPickerTable.Saturation

                            ResetButton.ChangeCallback(function()
                                ColorPickerTable.Set(ColorPickerTable.Options.Default, ColorPickerTable.Options.Transparency, true)
                                Table.UpdateValues(ColorPickerTable.Options.Default, ColorPickerTable.Options.Transparency)
                            end)
                            
                            CopyButton.ChangeCallback(function()
                                UITable.LastCopiedColor = {Color = ColorPickerTable.Color, Transparency = ColorPickerTable.Transparency}
                            end)

                            PasteButton.ChangeCallback(function()
                                if UITable.LastCopiedColor then
                                    ColorPickerTable.Set(UITable.LastCopiedColor.Color, UITable.LastCopiedColor.Transparency, true)
                                    Table.UpdateValues(UITable.LastCopiedColor.Color, UITable.LastCopiedColor.Transparency)
                                end
                            end)
                        end

                        do -- Functions
                            local function SmartFormat(Value)
                                return string_format("%g", math_round(Value * 10) / 10)
                            end

                            function Table.UpdateValues(Color, Transparency)
                                local H, S, V = Color:ToHSV()

                                Table.Hue = H
                                Table.Saturation = {S, V}
                                Table.Color = Color3_fromHSV(H, S, V)
                                Table.Transparency = Transparency

                                Table.UpdatePositions()
                            end

                            function Table.UpdatePositions()
                                local Hue = math_clamp(Table.Hue, 0, 1)
                                local Transparency = math_clamp(Table.Transparency, 0, 1)
                                local Sat = math_clamp(Table.Saturation[1], 0, 1)
                                local Val = math_clamp(Table.Saturation[2], 0, 1)
                                local Color = Color3_fromHSV(Hue, Sat, Val)
                                local PixelOffset = 0

                                local TransparencyClamp = math_max(0, (TransparencyOutline.AbsoluteSize.X - AlphaDraggingLine.AbsoluteSize.X - PixelOffset) / TransparencyOutline.AbsoluteSize.X)
                                local HueClamp = math_max(0, (HueOutline.AbsoluteSize.Y - HueDraggingLine.AbsoluteSize.Y - PixelOffset) / HueOutline.AbsoluteSize.Y)
                                local SatXClamp = math_max(0, Picker.AbsoluteSize.X - DraggingDot.AbsoluteSize.X - PixelOffset) / Picker.AbsoluteSize.X
                                local SatYClamp = math_max(0, Picker.AbsoluteSize.Y - DraggingDot.AbsoluteSize.Y - PixelOffset) / Picker.AbsoluteSize.Y

                                Library.TweenObject(AlphaDraggingLine, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {Position = UDim2_new(math_clamp(Transparency, 0, TransparencyClamp), 0, 0, 0)})
                                Library.TweenObject(HueDraggingLine, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {Position = UDim2_new(0, 0, math_clamp(Hue, 0, HueClamp), 0)})
                                Library.TweenObject(DraggingDot, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {Position = UDim2_fromScale(math_clamp(Sat, 0, SatXClamp), math_clamp(1 - Val, 0, SatYClamp))})

                                HexText.Update(`Hex: #{tostring(string_upper(Color:ToHex()))}`)
                                RGBText.Update(`RGB: {math_round(Color.R * 255)}, {math_round(Color.G * 255)}, {math_round(Color.B * 255)}`)
                                HSVText.Update(`HSV: {SmartFormat(Hue)}, {SmartFormat(Sat)}, {SmartFormat(Val)}`)
                                AlphaText.Update(`Transparency: {SmartFormat(1 - Transparency)}`)

                                TransparencyGradient_1.BackgroundColor3 = Color
                                UIGradient_6.Color = ColorSequence_new{ColorSequenceKeypoint_new(0, Color), ColorSequenceKeypoint_new(1, Library.SubtractColor(Color, 44))}
                                UIGradient_62.Color = ColorSequence_new{ColorSequenceKeypoint_new(0, Color), ColorSequenceKeypoint_new(1, Library.SubtractColor(Color, 44))}
                                UIGradient_4.Color = ColorSequence_new{ColorSequenceKeypoint_new(0, Color3_fromHSV(Hue, 1, 1)), ColorSequenceKeypoint_new(1, Color3_fromRGB(255, 255, 255))}
                                ColorPickerTable.Set(Color, Transparency, true)
                            end
                        end
                        
                        do -- Connections
                            ChangingConnections[#ChangingConnections + 1] = Library.AddConnection(PickerButton.InputBegan, function(Input)
                                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                                    local InputPosition = Vector2_new(Input.Position.X, Input.Position.Y)
                                    local Percentage = (InputPosition - Picker.AbsolutePosition) / Picker.AbsoluteSize

                                    UITable.DraggingGui = Picker
                                    Table.Saturation = {Percentage.X, 1 - Percentage.Y}
                                    
                                    Table.UpdatePositions()
                                end
                            end)

                            ChangingConnections[#ChangingConnections + 1] = Library.AddConnection(HueButton.InputBegan, function(Input)
                                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                                    local InputPosition = Vector2_new(Input.Position.X, Input.Position.Y)
                                    local Percentage = (InputPosition - HueOutline.AbsolutePosition) / HueOutline.AbsoluteSize

                                    UITable.DraggingGui = HueOutline
                                    Table.Hue = Percentage.Y
                                    
                                    Table.UpdatePositions()
                                end
                            end)

                            ChangingConnections[#ChangingConnections + 1] = Library.AddConnection(SaturationButton.InputBegan, function(Input)
                                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                                    local InputPosition = Vector2_new(Input.Position.X, Input.Position.Y)
                                    local Percentage = (InputPosition - TransparencyOutline.AbsolutePosition) / TransparencyOutline.AbsoluteSize

                                    UITable.DraggingGui = TransparencyOutline
                                    Table.Transparency = Percentage.X
                                    
                                    Table.UpdatePositions()
                                end
                            end)

                            ChangingConnections[#ChangingConnections + 1] = Library.AddConnection(UserInputService.InputChanged, function(Input)
                                if not table_find(DraggableObjects, UITable.DraggingGui) then
                                    return
                                end
                                
                                if not (UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)) then
                                    UITable.DraggingGui = nil

                                    return
                                end
                                
                                local InputPosition = Vector2_new(Input.Position.X, Input.Position.Y)
                                
                                if (Input.UserInputType == Enum.UserInputType.MouseMovement) then
                                    if UITable.DraggingGui == HueOutline then
                                        local Percentage = (InputPosition - HueOutline.AbsolutePosition) / HueOutline.AbsoluteSize
                                        
                                        Table.Hue = Percentage.Y

                                        Table.UpdatePositions()
                                    end

                                    if UITable.DraggingGui == TransparencyOutline then
                                        local Percentage = (InputPosition - TransparencyOutline.AbsolutePosition) / TransparencyOutline.AbsoluteSize
                                        
                                        Table.Transparency = Percentage.X

                                        Table.UpdatePositions()
                                    end

                                    if UITable.DraggingGui == Picker then
                                        local Percentage = (InputPosition - Picker.AbsolutePosition) / Picker.AbsoluteSize

                                        Table.Saturation = {Percentage.X, 1 - Percentage.Y}
                                        
                                        Table.UpdatePositions()
                                    end
                                end
                            end)

                            ChangingConnections[#ChangingConnections + 1] = Library.AddConnection(UserInputService.InputEnded, function(Input)
                                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                                    UITable.DraggingGui = nil
                                end
                            end)
                        end

                        Table.UpdatePositions()
                    end
                end

                do -- Connections
                    Library.AddConnection(Holder_7:GetPropertyChangedSignal("GroupTransparency"), LPH_NO_VIRTUALIZE(function()
                        if not Table.Enabled then
                            return
                        end

                        ColorPicker.GroupTransparency = Holder_7.GroupTransparency
                    end))

                    Library.AddConnection(ClosingButton.MouseButton1Click, LPH_NO_VIRTUALIZE(function()
                        Library.RemoveColorPicker(Table.OldPicker)
                    end))
                    
                    Library.Draggable(ColorPicker, DragButton)
                    Library.Resizable(ColorPicker, ResizeButton, UDim2_fromOffset(230, 290), UDim2_fromOffset(400, 430))
                end

                Table.MainUI = ColorPicker
				UITable.ColorPickerUI = Table.MainUI
            end

			function Library.ToggleMenu(Bool)
				Window.Visible = Bool or not Window.Visible
				
				if Window.Visible == true then
					Holder_7.Visible = true
				end

				Library.TweenObject(Holder_7, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle), {GroupTransparency = Window.Visible and 0 or 1}, function()
					if Window.Visible == false then
						Holder_7.Visible = false
					end
				end)
			end
			
			function Library.Init()
				local InitTime = string_format("%.2f", os_clock() - UITable.InitTime)
				local Message = string_format("Welcome. Successfully loaded in %s seconds", string_format("%.2f", InitTime))

				--Library.Notify({Message = Message, ColoredTexts = {[string_format("%s seconds", InitTime)] = ThemeTable.Default.Accent}, Sound = "rbxassetid://18886652611", Delay = 5, Type = "Success"})
				--Window.CreateKeybindMode()

				Library.AddConnection(Camera:GetPropertyChangedSignal("ViewportSize"), LPH_NO_VIRTUALIZE(function()
					Viewport = Camera.ViewportSize
				end))

                Holder_7.Position = UDim2_fromOffset((Viewport.X / 2) - (Holder_7.AbsoluteSize.X / 2), (Viewport.Y / 2) - (Holder_7.AbsoluteSize.Y / 2))
                Window.CreateColorPicker()
                Library.GetAutoloadConfig()
			end

			function Library.Unload()
				if Library then
					Library.Unloaded:Fire()
				end

				UserInputService.MouseIconEnabled = true

				for _, Connection in ConnectionsTable do
					Connection:Disconnect()
				end

				for _, Object in ObjectsTable do
					pcall(function() Object[1]:Destroy() end)
				end

				-- Destroy the ScreenGuis directly
				pcall(function()
					if UITable.ScreenGui then UITable.ScreenGui:Destroy() end
				end)
				pcall(function()
					if UITable.ExtrasScreenGui then UITable.ExtrasScreenGui:Destroy() end
				end)

				-- Clear library reference
				getgenv().Library = nil
			end
		end
		
		do -- Connections
			Library.AddConnection(CloseButton.Button.MouseButton1Click, LPH_NO_VIRTUALIZE(function()
				if Window.Visible == false then return end
				
				Library.ToggleMenu(false)
			end))

			Library.Draggable(Holder_7, DragButton)
			Library.Resizable(Holder_7, ResizeButton_2, UDim2_fromOffset(400, 300), UDim2_fromOffset(800, 700))
		end
		
		do -- Elements
			function Window.Section(Options)
				Options = Library.Validate({
					Name = "Preview Section",
					Fill = false,
					Parent = nil,
					SizeList = nil,
				}, Options or {})
				
				local Section = {
					Elements = {},
				}

				UITable.SectionZIndex -= 1
				
				local SectionOutline_2 = Library.CreateObject("Frame", {
					Name = "SectionOutline_2",
					Size = UDim2_new(1, 0, 0, 0),
					BorderColor3 = Color3_fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = ThemeDefault.Outline,
					Parent = Options.Parent
				}); Library.AddTheme(SectionOutline_2, { BackgroundColor3 = "Outline" })

                local SectionOutline_21 = Library.CreateObject("UIShadow", {
                    Name = "SectionOutline_21",
                    Transparency = 0.5,
                    BlurRadius = UDim_new(0, 7),
                    Parent = SectionOutline_2
                })
				
				local UIPadding_75 = Library.CreateObject("UIPadding", {
					PaddingBottom = UDim.new(0, 2),
					Parent = SectionOutline_2
				})

				local SectionAccent_2 = Library.CreateObject("Frame", {
					Size = UDim2_new(1, -2, 1, -2),
					Name = "SectionAccent_2",
					Position = UDim2_new(0, 1, 0, 1),
					BorderColor3 = Color3_fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = ThemeDefault.Accent,
					Parent = SectionOutline_2
				}); Library.AddTheme(SectionAccent_2, { BackgroundColor3 = "Accent" })

				local SectionInline_2 = Library.CreateObject("Frame", {
					Size = UDim2_new(1, -2, 1, -2),
					Name = "SectionInline_2",
					Position = UDim2_new(0, 1, 0, 1),
					BorderColor3 = Color3_fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = ThemeDefault.Outline,
					Parent = SectionAccent_2
				}); Library.AddTheme(SectionInline_2, { BackgroundColor3 = "Outline" })

				local UIPadding_61 = Library.CreateObject("UIPadding", {
					PaddingBottom = UDim.new(0, -1),
					Parent = SectionInline_2
				})

				local SectionGradient_2 = Library.CreateObject("Frame", {
					BorderColor3 = Color3_fromRGB(0, 0, 0),
					Size = UDim2_new(1, -2, 0, -2),
					Name = "SectionGradient_2",
					Position = UDim2_new(0, 1, 0, 1),
					BorderSizePixel = 0,
					ZIndex = 2,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = ThemeDefault.LightContrast,
					Parent = SectionInline_2
				}); Library.AddTheme(SectionGradient_2, { BackgroundColor3 = "LightContrast" })
				
				local UIPadding_72 = Library.CreateObject("UIPadding", {
					PaddingBottom = UDim.new(0, 3),
					PaddingTop = UDim.new(0, 4),
					PaddingRight = UDim.new(0, -2),
					Parent = SectionGradient_2
				})

				local UIPadding_73 = Library.CreateObject("UIPadding", {
					PaddingBottom = UDim.new(0, 2),
					Parent = SectionAccent_2
				})

				local Holder_14 = Library.CreateObject("ScrollingFrame", {
					Active = true,
					AutomaticCanvasSize = Enum.AutomaticSize.Y,
					ScrollingDirection = Enum.ScrollingDirection.Y,
					AutomaticSize = Enum.AutomaticSize.Y,
					CanvasSize = UDim2_new(0, 0, 0, 0),
					ScrollBarImageColor3 = ThemeDefault.Accent,
					MidImage = "rbxassetid://95591733073455",
					BorderColor3 = Color3_fromRGB(0, 0, 0),
					ScrollBarThickness = 3,
					Name = "Holder_14",
					Size = UDim2_new(1, -2, 1, -2),
					Position = UDim2_new(0, 1, 0, 1),
					TopImage = "rbxassetid://95591733073455",
					BorderSizePixel = 0,
					BottomImage = "rbxassetid://95591733073455",
					BackgroundTransparency = 1,
					Parent = SectionGradient_2
				}); Library.AddTheme(Holder_14, { ScrollBarImageColor3 = "Accent" })

				local UIListLayout_45 = Library.CreateObject("UIListLayout", {
					Padding = UDim.new(0, 5),
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Holder_14
				})
				
				local UIPadding_67 = Library.CreateObject("UIPadding", {
					PaddingTop = UDim.new(0, 1),
					PaddingBottom = UDim.new(0, 4),
					PaddingRight = UDim.new(0, 7),
					PaddingLeft = UDim.new(0, 5),
					Parent = Holder_14
				})
				
				local Title_29 = Library.CreateObject("TextLabel", {
					FontFace = LibraryFont,
					TextColor3 = ThemeDefault.TextColor,
					BorderColor3 = Color3_fromRGB(0, 0, 0),
					Text = Options.Name,
					AnchorPoint = Vector2_new(0, 0.5),
					Name = "Title_29",
					Position = UDim2_new(0, 10, 0, 0),
					BorderSizePixel = 0,
                    TextXAlignment = Enum.TextXAlignment.Left,
					AutomaticSize = Enum.AutomaticSize.XY,
					TextSize = LibraryFontSize,
					BackgroundColor3 = ThemeDefault.LightContrast,
					Parent = SectionOutline_2
				}); Library.AddTheme(Title_29, { TextColor3 = "TextColor", BackgroundColor3 = "LightContrast" })

				local UIStroke_110 = Library.CreateObject("UIStroke", {
					LineJoinMode = Enum.LineJoinMode.Miter,
					Parent = Title_29
				})

				local UIPadding_74 = Library.CreateObject("UIPadding", {
					PaddingRight = UDim.new(0, 2),
					PaddingLeft = UDim.new(0, 3),
					Parent = Title_29
				})

                if Options.Fill then
                    local function CheckScrolling()
                        if (Holder_14.AbsoluteCanvasSize.Y == Holder_14.AbsoluteSize.Y) then
                            UIPadding_72.PaddingRight = UDim_new(0, -2)
                        elseif (Holder_14.AbsoluteCanvasSize.Y > SectionGradient_2.AbsoluteSize.Y) then
                            UIPadding_72.PaddingRight = UDim_new(0, 3)
                        end
                    end
                    
                    local UIFlexItem_2 = Library.CreateObject("UIFlexItem", {
                        FlexMode = Enum.UIFlexMode.Fill,
                        Parent = SectionOutline_2
                    })

                    SectionOutline_2.AutomaticSize = Enum.AutomaticSize.None
                    SectionAccent_2.AutomaticSize = Enum.AutomaticSize.None
                    SectionInline_2.AutomaticSize = Enum.AutomaticSize.None
                    SectionGradient_2.AutomaticSize = Enum.AutomaticSize.None
                    Holder_14.AutomaticSize = Enum.AutomaticSize.None
                    SectionGradient_2.Size = UDim2_new(1, -2, 1, -2)

                    UIPadding_73.PaddingBottom = UDim_new(0, 0)
                    UIPadding_61.PaddingBottom = UDim_new(0, 0)
                    UIPadding_75.PaddingBottom = UDim_new(0, 0)

                    task_defer(CheckScrolling)
                    Library.AddConnection(Holder_7:GetPropertyChangedSignal("AbsoluteSize"), CheckScrolling)
                end
				
				Section.Elements = {
					Name = Title_29,
					ElementsHolder = Holder_14,
				}

				return setmetatable(Section, Library.Sections)
			end
			
			function Window.CreateTab(Options)
				Options = Library.Validate({
					Name = "Main",
                    Parent = Tabs,
                    Table = Window,
                    MainUI = Holder_7,
                    Holder = MainBackground,
                    Solo = false,
				}, Options or {})
				
				local WindowTab = {
					Active = false,
					Hovering = false,
					Fading = false,
                    Holder = nil,
				}
				
				local TabTemplate_2 = Library.CreateObject("Frame", {
					Name = "TabTemplate_2",
					Size = UDim2_new(1, 0, 1, 0),
					BorderColor3 = Color3_fromRGB(0, 0, 0),
					ZIndex = 2,
					BorderSizePixel = 0,
					BackgroundColor3 = ThemeDefault.Outline,
					Parent = Options.Parent
				}); Library.AddTheme(TabTemplate_2, { BackgroundColor3 = "Outline" })
				
				local Button = Library.CreateObject("TextButton", {
					FontFace = Font_new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
					TextColor3 = ThemeDefault.Outline,
					BorderColor3 = Color3_fromRGB(0, 0, 0),
					Name = "DragButton",
					BackgroundTransparency = 1,
					Size = UDim2_new(1, 0, 1, 0),
					BorderSizePixel = 0,
					TextTransparency = 1,
					TextSize = 14,
					BackgroundColor3 = Color3_fromRGB(255, 255, 255),
					Parent = TabTemplate_2
				})

				local UIFlexItem_9 = Library.CreateObject("UIFlexItem", {
					FlexMode = Enum.UIFlexMode.Fill,
					Parent = TabTemplate_2
				})

				local WhiteFrame = Library.CreateObject("Frame", {
					Name = "WhiteFrame",
					Position = UDim2_new(0, 1, 0, 1),
					BorderColor3 = Color3_fromRGB(0, 0, 0),
					Size = UDim2_new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundTransparency = 1,
					BackgroundColor3 = Color3_fromRGB(255, 255, 255),
					ZIndex = 3,
					Parent = TabTemplate_2
				})

				local Gradient_22 = Library.CreateObject("Frame", {
					Name = "Gradient_22",
					Position = UDim2_new(0, 1, 0, 1),
					BorderColor3 = Color3_fromRGB(0, 0, 0),
					Size = UDim2_new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3_fromRGB(255, 255, 255),
					Parent = TabTemplate_2
				})

				local UIGradient_33 = Library.CreateObject("UIGradient", {
					Rotation = 90,
					Color = ColorSequence_new({ ColorSequenceKeypoint_new(0, ThemeDefault.LightContrast), ColorSequenceKeypoint_new(1, ThemeDefault.DarkContrast) }),
					Parent = Gradient_22
				}); Library.AddTheme(UIGradient_33, { Color = {"LightContrast", "DarkContrast"} })

				local Title_22 = Library.CreateObject("TextLabel", {
					FontFace = LibraryFont,
					TextColor3 = ThemeDefault.TextDark,
					BorderColor3 = Color3_fromRGB(0, 0, 0),
					Text = Options.Name,
					Name = "Title_22",
					BackgroundTransparency = 1,
					Size = UDim2_new(1, 0, 1, 0),
					BorderSizePixel = 0,
					RichText = true,
					TextSize = LibraryFontSize,
					BackgroundColor3 = Color3_fromRGB(255, 255, 255),
					Parent = TabTemplate_2
				}); Library.AddTheme(Title_22, { TextColor3 = "TextDark" })

				local UIStroke_91 = Library.CreateObject("UIStroke", {
					LineJoinMode = Enum.LineJoinMode.Miter,
					Parent = Title_22
				})

				local UIPadding_60 = Library.CreateObject("UIPadding", {
					PaddingBottom = UDim.new(0, 1),
					Parent = Title_22
				})
				
				local MainHolder_5 = Library.CreateObject("Frame", {
					Name = "MainHolder_5",
					BackgroundTransparency = 1,
                    Visible = false,
					Position = UDim2_new(0, 0, 0, 50),
					BorderColor3 = Color3_fromRGB(0, 0, 0),
					Size = UDim2_new(1, 0, 1, -50),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3_fromRGB(255, 255, 255),
					Parent = Options.Holder
				})

                local Left_2, Right_2

                if Options.Solo == false then
                    Left_2 = Library.CreateObject("Frame", {
                        BackgroundTransparency = 1,
                        Name = "Left_2",
                        BorderColor3 = Color3_fromRGB(0, 0, 0),
                        Size = UDim2_new(1, 0, 1, 0),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Color3_fromRGB(255, 255, 255),
                        Parent = MainHolder_5
                    })

                    local UIFlexItem_10 = Library.CreateObject("UIFlexItem", {
                        FlexMode = Enum.UIFlexMode.Fill,
                        Parent = Left_2
                    })

                    local UIListLayout_44 = Library.CreateObject("UIListLayout", {
                        Padding = UDim.new(0, 10),
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        Parent = Left_2
                    })
                    
                    Right_2 = Library.CreateObject("Frame", {
                        BackgroundTransparency = 1,
                        Name = "Right_2",
                        BorderColor3 = Color3_fromRGB(0, 0, 0),
                        Size = UDim2_new(1, 0, 1, 0),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Color3_fromRGB(255, 255, 255),
                        Parent = MainHolder_5
                    })

                    local UIFlexItem_11 = Library.CreateObject("UIFlexItem", {
                        FlexMode = Enum.UIFlexMode.Fill,
                        Parent = Right_2
                    })

                    local UIListLayout_59 = Library.CreateObject("UIListLayout", {
                        Padding = UDim.new(0, 10),
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        Parent = Right_2
                    })

                    local UIListLayout_60 = Library.CreateObject("UIListLayout", {
                        FillDirection = Enum.FillDirection.Horizontal,
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        Padding = UDim.new(0, 10),
                        Parent = MainHolder_5
                    })
                end

                local UIPadding_76 = Library.CreateObject("UIPadding", {
                    PaddingTop = UDim.new(0, 10),
                    PaddingBottom = UDim.new(0, 10),
                    PaddingRight = UDim.new(0, 10),
                    PaddingLeft = UDim.new(0, 10),
                    Parent = MainHolder_5
                })
				
				do -- Functions
					function WindowTab.Activate()
						if Library.MouseOverOtherWindow(Holder_7) then
							return
						end

						if Library.MouseOverOtherObject() then
							return
						end

						if not WindowTab.Active then
							if Options.Table.CurrentTab then
								Options.Table.CurrentTab.Deactivate()
							end

							Library.TweenObject(WhiteFrame, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {BackgroundTransparency = 0.95})
							Library.TweenObject(Title_22, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {TextColor3 = ThemeDefault.TextColor}, function()
								Library.AddTheme(Title_22, {TextColor3 = "TextColor"}, "TextDark")
							end)

							WindowTab.Active = true
							MainHolder_5.Visible = true
							Options.Table.CurrentTab = WindowTab
						end
					end

					function WindowTab.Deactivate()
						if WindowTab.Active then
							WindowTab.Active = false
							WindowTab.Hovering = false
							MainHolder_5.Visible = false
                            WindowTab.MouseLeave()

							Library.TweenObject(WhiteFrame, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {BackgroundTransparency = 1})
							Library.TweenObject(Title_22, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {TextColor3 = ThemeDefault.TextDark}, function()
								Library.AddTheme(Title_22, {TextColor3 = "TextDark"}, "TextColor")
							end)
						end
					end
					
					function WindowTab.MouseEnter()
						if Library.MouseOverOtherWindow(Options.MainUI) then
							WindowTab.MouseLeave()

							return
						end

						if Library.MouseOverOtherObject() then
							WindowTab.MouseLeave()

							return
						end

						WindowTab.Hovering = true

						if (not WindowTab.Fading) and (not WindowTab.Active) then
							Library.TweenObject(Title_22, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {TextColor3 = ThemeDefault.TextColor}, function()
								Library.AddTheme(Title_22, {TextColor3 = "TextColor"}, "TextDark")
							end)

							WindowTab.Fading = true
						end
					end

					function WindowTab.MouseLeave()
						WindowTab.Hovering = false

						if WindowTab.Fading and not WindowTab.Active then
							Library.TweenObject(Title_22, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {TextColor3 = ThemeDefault.TextDark}, function()
								Library.AddTheme(Title_22, {TextColor3 = "TextDark"}, "TextColor")
							end)

							WindowTab.Fading = false
							Options.Table.CurrentHover = nil
						end
					end
					
                    if Options.Solo == false then
                        function WindowTab.Section(Options)
                            Options = Library.Validate({
                                Name = "Preview Section",
                                Side = "Left",
                                Fill = false,
                            }, Options or {})

                            local Parent = Options.Side == "Left" and Left_2 or Right_2

                            local Section = Window.Section({
                                Name = Options.Name,
                                Fill = Options.Fill,
                                Parent = Parent,
                            })

                            return Section
                        end
                    end
				end
				
				do -- Connections
					Library.AddConnection(Button.MouseButton1Click, WindowTab.Activate)
					Library.AddConnection(TabTemplate_2.MouseEnter, LPH_NO_VIRTUALIZE(function()
						if not Library.MouseOverFrame(Options.MainUI) then
							return
						end

						if Options.Table.CurrentHover then
							Options.Table.CurrentHover.MouseLeave()
						end

						WindowTab.MouseEnter()

						if Options.Table.MouseConnection then
							Options.Table.MouseConnection:Disconnect()
							Options.Table.MouseConnection = nil
						end

						Options.Table.CurrentHover = WindowTab
						Options.Table.MouseConnection = Library.AddConnection(UserInputService.InputChanged, function(Input)
							if Input.UserInputType == Enum.UserInputType.MouseMovement then
								if not Library.MouseOverFrame(TabTemplate_2) then
									WindowTab.MouseLeave()
									Options.Table.MouseConnection:Disconnect()
									Options.Table.MouseConnection = nil
								end
							end
						end)
					end))
				end
				
                WindowTab.Holder = MainHolder_5

				if Options.Table.CurrentTab == nil then
					WindowTab.Activate()
				end
				
				return WindowTab
			end
			
			function Sections:Toggle(Options)
				Options = Library.Validate({
					Name = "Toggle",
					Debounce = false,
					Default = false, 
					Risky = false,
					ToolTip = "",
					MainUI = Holder_7,
					Flag = Library.NewFlag(),
					Callback = function() end
				}, Options or {})

				local Elements = self.Elements
				local Toggle = Library.CreateToggle({
					MainTable = Window,
					MainUI = Holder_7,
					SectionName = Elements.Name.Text,
					Parent = Elements.ElementsHolder,
					Debounce = Options.Debounce,
					ToolTip = Options.ToolTip,
					Default = Options.Default,
					Name = Options.Name,
					Risky = Options.Risky,
					Flag = Options.Flag,
					Callback = Options.Callback
				})

				return Toggle
			end
			
			function Sections:Label(Options)
				Options = Library.Validate({
					Message = "Label",
					Side = "Left",
					UseButton = false,
					Risky = false,
					Debounce = false,
					ToolTip = "",
					ColoredTexts = {},
					Callback = function() end
				}, Options or {})

				local Elements = self.Elements
				local Label = Library.CreateLabel({
					MainTable = Window,
					UseButton = Options.UseButton,
					MainUI = Holder_7,
					Message = Options.Message,
					Side = Options.Side,
					ToolTip = Options.ToolTip,
					Debounce = Options.Debounce,
					Risky = Options.Risky,
					SectionName = Elements.Name.Text,
					Callback = Options.Callback,
					ColoredTexts = Options.ColoredTexts,
					Parent = Elements.ElementsHolder
				})

				return Label
			end

            function Sections:Slider(Options)
                Options = Library.Validate({
                    Name = "Slider",
                    Suffix = "",
                    Min = 0,
                    Max = 100,
                    Default = 1,
                    Decimal = 1,
                    ToolTip = "",
                    Risky = false,
                    Flag = Library.NewFlag(),
                    Callback = function() end
                }, Options or {})
                
                local Elements = self.Elements
                local Slider = Library.CreateSlider({
                    MainTable = Window,
                    MainUI = Holder_7,
                    Parent = Elements.ElementsHolder,
                    ToolTip = Options.ToolTip,
                    Name = Options.Name,
                    Min = Options.Min,
                    Max = Options.Max,
                    Default = Options.Default,
                    Decimal = Options.Decimal,
                    Suffix = Options.Suffix,
                    Risky = Options.Risky,
                    Flag = Options.Flag,
                    Callback = Options.Callback
                })
                
                return Slider
            end

            function Sections:Button(Options)
                Options = Library.Validate({
                    Name = "Button",
                    Confirmation = false,
                    Risky = false,
                    ToolTip = "",
                    Callback = function() end
                }, Options or {})
                
                local Elements = self.Elements
                local Button = Library.CreateButton({
                    MainTable = Window,
                    MainUI = Holder_7,
                    Parent = Elements.ElementsHolder,
                    Name = Options.Name,
                    Risky = Options.Risky,
                    ToolTip = Options.ToolTip,
                    Confirmation = Options.Confirmation,
                    Callback = Options.Callback,
                })
                
                return Button
            end

            function Sections:Dropdown(Options)
                Options = Library.Validate({
                    Name = "Dropdown",
                    Default = "None",
                    Risky = false,
                    Content = {},
                    ToolTip = "",
                    Flag = Library.NewFlag(),
                    Callback = function() end
                }, Options or {})
                
                local Elements = self.Elements
                local Dropdown = Library.CreateDropdown({
                    MainTable = Window,
                    MainUI = Holder_7,
                    Default = Options.Default,
                    Name = Options.Name,
                    ToolTip = Options.ToolTip,
                    Content = Options.Content,
                    Risky = Options.Risky,
                    Flag = Options.Flag,
                    Callback = Options.Callback,
                    Parent = Elements.ElementsHolder
                })
                
                return Dropdown
            end

            function Sections:MultiBox(Options)
                Options = Library.Validate({
                    Name = "MultiBox",
                    Risky = false,
                    Default = {},
                    Content = {},
                    ToolTip = "",
                    Flag = Library.NewFlag(),
                    Callback = function() end
                }, Options or {})
                
                local Elements = self.Elements
                local MultiBox = Library.CreateMultiBox({
                    MainTable = Window,
                    MainUI = Holder_7,
                    Default = Options.Default,
                    Name = Options.Name,
                    ToolTip = Options.ToolTip,
                    Content = Options.Content,
                    Risky = Options.Risky,
                    Flag = Options.Flag,
                    Callback = Options.Callback,
                    Parent = Elements.ElementsHolder
                })
                
                return MultiBox
            end

            function Sections:TextBox(Options)
                Options = Library.Validate({
                    Default = "",
                    Name = "TextBox",
                    Max = 32,
                    IgnoreConfig = false,
                    NumbersOnly = false,
                    ClearOnFocus = false,
                    CheckIfPressedEnter = false,
                    Risky = false,
                    ToolTip = "",
                    Flag = Library.NewFlag(),
                    Callback = function() end
                }, Options or {})
                
                local Elements = self.Elements
                local TextBox = Library.CreateTextBox({
                    MainTable = Window,
                    MainUI = Holder_7,
                    Parent = Elements.ElementsHolder,
                    Default = Options.Default,
                    ToolTip = Options.ToolTip,
                    IgnoreConfig = Options.IgnoreConfig,
                    Name = Options.Name,
                    Max = Options.Max,
                    NumbersOnly = Options.NumbersOnly,
                    ClearOnFocus = Options.ClearOnFocus,
                    CheckIfPressedEnter = Options.CheckIfPressedEnter,
                    Risky = Options.Risky,
                    Flag = Options.Flag,
                    Callback = Options.Callback
                })
                
                return TextBox
            end

            function Sections:List(Options)
                Options = Library.Validate({
                    Name = "List",
                    Size = UDim2_new(1, 0, 0, 100),
                    Flag = Library.NewFlag(),
                    IgnoreConfig = false,
                    Callback = function() end
                }, Options or {})
                
                local Elements = self.Elements
                local List = Library.CreateList({
                    MainTable = Window,
                    MainUI = Holder_7,
                    Name = Options.Name,
                    Parent = Elements.ElementsHolder,
                    Size = Options.Size,
                    IgnoreConfig = Options.IgnoreConfig,
                    Flag = Options.Flag,
                    Callback = Options.Callback
                })

                return List
            end

            function Sections:ButtonGroup(Options)
                Options = Library.Validate({
                    Settings = {[1] = {Name = "Button", ToolTip = "", Confirmation = false, Risky = false, Callback = function() end}}
                }, Options or {})
                
                local ButtonGroup = {Buttons = {}}
                local Elements = self.Elements
                local ButtonsHolder = Library.CreateObject("Frame", {
                    Size = UDim2_new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundTransparency = 1,
                    Parent = Elements.ElementsHolder
                })

                local UIPadding_145 = Library.CreateObject("UIPadding", {
                    PaddingTop = UDim.new(0, 1),
                    Parent = ButtonsHolder
                })

                do -- Functions
                    function ButtonGroup.UpdateButtonSizes()
                        local TotalButtons = #ButtonGroup.Buttons

                        for Index, Button in ButtonGroup.Buttons do
                            local LastButton = Index == TotalButtons
                            local OddNumber = TotalButtons % 2 == 1
                            local SingleRow = OddNumber and LastButton and Index % 2 == 1

                            local NewRow = ((Index - 1) / 2) // 1
                            local NewColumn = (Index - 1) % 2

                            local SizeXScale = SingleRow and 1 or 0.5
                            local SizeXOffset = SingleRow and 0 or -3
                            local PositionXScale = SingleRow and 0 or NewColumn * 0.5
                            local PositionXOffset = SingleRow and 0 or NewColumn * 3
                            local PositionYOffset = NewRow * (20 + 6)

                            Button.UpdateSize(UDim2_new(SizeXScale, SizeXOffset, 0, 20))
                            Button.UpdatePosition(UDim2_new(PositionXScale, PositionXOffset, 0, PositionYOffset))
                        end
                    end
                end

                for i = 1, #Options.Settings do
                    local ButtonSettings = Options.Settings[i]

                    ButtonGroup.Buttons[i] = Library.CreateButton({
                        MainTable = Window,
                        MainUI = Holder_7,
                        Parent = ButtonsHolder,
                        Name = ButtonSettings.Name,
                        ToolTip = ButtonSettings.ToolTip,
                        Risky = ButtonSettings.Risky,
                        Confirmation = ButtonSettings.Confirmation,
                        Callback = ButtonSettings.Callback,
                    })
                end

                ButtonGroup.UpdateButtonSizes()
            end
		end
		
		return Window	
	end
end

DefaultThemes = Library.GetTableIndexes(ThemeTable.Presets, true)
Library.UpdateThemeList()




-- ═══════════════════════════════════════════════════════════════
-- WATERMARK
-- ═══════════════════════════════════════════════════════════════
do
    local WM = Library.CreateObject("CanvasGroup", {
        Name = "Watermark", Position = UDim2_fromOffset(10, 10),
        Size = UDim2_new(0, 200, 0, 22), BackgroundColor3 = ThemeDefault.DarkContrast,
        BorderSizePixel = 0, Visible = true, Parent = UITable.ExtrasScreenGui
    }); Library.AddTheme(WM, {BackgroundColor3 = "DarkContrast"})

    Library.CreateObject("UIStroke", {Color = ThemeDefault.Outline, Thickness = 1, Parent = WM})

    local WMAccent = Library.CreateObject("Frame", {
        Name = "Accent", Size = UDim2_new(1, 0, 0, 1), BorderSizePixel = 0,
        BackgroundColor3 = Color3_fromRGB(255,255,255), Parent = WM
    })
    Library.CreateObject("UIGradient", {
        Color = ColorSequence_new({ColorSequenceKeypoint_new(0, ThemeDefault.Accent), ColorSequenceKeypoint_new(1, ThemeDefault.SecondAccent)}),
        Parent = WMAccent
    })

    local WMText = Library.CreateObject("TextLabel", {
        FontFace = UITable.Font, Text = UITable.UIName,
        TextColor3 = ThemeDefault.TextColor, TextSize = UITable.FontSize,
        BackgroundTransparency = 1, Size = UDim2_new(1, -10, 1, 0),
        Position = UDim2_new(0, 5, 0, 1), TextXAlignment = Enum.TextXAlignment.Left,
        BorderSizePixel = 0, Parent = WM
    }); Library.AddTheme(WMText, {TextColor3 = "TextColor"})
    Library.CreateObject("UIStroke", {LineJoinMode = Enum.LineJoinMode.Miter, Parent = WMText})

    task.spawn(function()
        while task.wait(UITable.WatermarkRefreshRate or 0.5) do
            if WM and WM.Parent and WM.Visible then
                local fps = math_floor(1 / (RunService.RenderStepped:Wait() + 0.0001))
                local ping = 0
                pcall(function() local s=game:GetService("Stats"):FindFirstChild("PerformanceStats"); if s then local p=s:FindFirstChild("Ping"); if p then ping=math_floor(p.Value) end end end)
                WMText.Text = string_format("%s | %dfps | %dms | %s", UITable.UIName, fps, ping, os_date("%H:%M"))
                local ts = game:GetService("TextService"):GetTextSize(WMText.Text, UITable.FontSize, Enum.Font.SourceSansBold, Vector2_new(800, 22))
                WM.Size = UDim2_new(0, ts.X + 14, 0, 22)
            end
        end
    end)

    -- Drag handle
    local WMDrag = Library.CreateObject("TextButton", {
        Name = "Drag", Text = "", BackgroundTransparency = 1,
        Size = UDim2_new(1, 0, 1, 0), BorderSizePixel = 0, AutoButtonColor = false, Parent = WM
    })
    Library.Draggable(WM, WMDrag)

    function Library.SetWatermarkVisible(v) WM.Visible = v end
    Library.WatermarkFrame = WM
end

-- ═══════════════════════════════════════════════════════════════
-- KEYBIND LIST
-- ═══════════════════════════════════════════════════════════════
do
    local KL = Library.CreateObject("CanvasGroup", {
        Name = "KeybindList", AnchorPoint = Vector2_new(1, 0),
        Position = UDim2_new(1, -10, 0, 40), Size = UDim2_new(0, 170, 0, 20),
        AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = ThemeDefault.DarkContrast,
        BorderSizePixel = 0, Visible = true, Parent = UITable.ExtrasScreenGui
    }); Library.AddTheme(KL, {BackgroundColor3 = "DarkContrast"})
    Library.CreateObject("UIStroke", {Color = ThemeDefault.Outline, Thickness = 1, Parent = KL})

    local KLAccent = Library.CreateObject("Frame", {
        Size = UDim2_new(1, 0, 0, 1), BorderSizePixel = 0,
        BackgroundColor3 = Color3_fromRGB(255,255,255), Parent = KL
    })
    Library.CreateObject("UIGradient", {
        Color = ColorSequence_new({ColorSequenceKeypoint_new(0, ThemeDefault.Accent), ColorSequenceKeypoint_new(1, ThemeDefault.SecondAccent)}),
        Parent = KLAccent
    })

    local KLTitle = Library.CreateObject("TextLabel", {
        FontFace = UITable.Font, Text = "keybinds",
        TextColor3 = ThemeDefault.TextDark, TextSize = UITable.FontSize,
        BackgroundTransparency = 1, Size = UDim2_new(1, 0, 0, 18),
        Position = UDim2_new(0, 0, 0, 1), BorderSizePixel = 0, Parent = KL
    }); Library.AddTheme(KLTitle, {TextColor3 = "TextDark"})
    Library.CreateObject("UIStroke", {LineJoinMode = Enum.LineJoinMode.Miter, Parent = KLTitle})

    local KLHolder = Library.CreateObject("Frame", {
        BackgroundTransparency = 1, Position = UDim2_new(0, 0, 0, 20),
        Size = UDim2_new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
        BorderSizePixel = 0, Parent = KL
    })
    Library.CreateObject("UIListLayout", {Padding = UDim_new(0,0), SortOrder = Enum.SortOrder.LayoutOrder, Parent = KLHolder})
    Library.CreateObject("UIPadding", {PaddingLeft = UDim_new(0,4), PaddingRight = UDim_new(0,4), PaddingBottom = UDim_new(0,3), Parent = KLHolder})

    UITable.KeybindListUI = KL

    -- Drag handle
    local KLDrag = Library.CreateObject("TextButton", {
        Name = "Drag", Text = "", BackgroundTransparency = 1,
        Size = UDim2_new(1, 0, 0, 20), BorderSizePixel = 0, AutoButtonColor = false, Parent = KL
    })
    Library.Draggable(KL, KLDrag)

    function Library.SetKeybindListVisible(v) KL.Visible = v end
end

-- ═══════════════════════════════════════════════════════════════
-- TARGET HUD (sharp, gradient HP, extra info)
-- ═══════════════════════════════════════════════════════════════
do
    local TH = Library.CreateObject("CanvasGroup", {
        Name = "TargetHUD", AnchorPoint = Vector2_new(0.5, 0),
        Position = UDim2_new(0.5, 0, 0, 70), Size = UDim2_new(0, 260, 0, 72),
        BackgroundColor3 = ThemeDefault.DarkContrast, BorderSizePixel = 0,
        Visible = false, Parent = UITable.ExtrasScreenGui
    }); Library.AddTheme(TH, {BackgroundColor3 = "DarkContrast"})
    Library.CreateObject("UIStroke", {Color = ThemeDefault.Outline, Thickness = 1, Parent = TH})

    -- Top accent gradient line
    local THAccent = Library.CreateObject("Frame", {
        Size = UDim2_new(1, 0, 0, 1), BorderSizePixel = 0,
        BackgroundColor3 = Color3_fromRGB(255,255,255), Parent = TH
    })
    Library.CreateObject("UIGradient", {
        Color = ColorSequence_new({ColorSequenceKeypoint_new(0, ThemeDefault.Accent), ColorSequenceKeypoint_new(1, ThemeDefault.SecondAccent)}),
        Parent = THAccent
    })

    -- Inner background
    local THInner = Library.CreateObject("Frame", {
        Name = "Inner", Position = UDim2_new(0, 1, 0, 2),
        Size = UDim2_new(1, -2, 1, -3), BackgroundColor3 = ThemeDefault.DarkContrast,
        BorderSizePixel = 0, BackgroundTransparency = 1, Parent = TH
    })

    -- Avatar
    local THAvatar = Library.CreateObject("ImageLabel", {
        Name = "Avatar", BackgroundColor3 = ThemeDefault.LightContrast,
        BorderSizePixel = 0, Position = UDim2_new(0, 6, 0, 6),
        Size = UDim2_new(0, 48, 0, 48), Image = "", Parent = THInner
    }); Library.AddTheme(THAvatar, {BackgroundColor3 = "LightContrast"})
    Library.CreateObject("UIStroke", {Color = ThemeDefault.Outline, Thickness = 1, Parent = THAvatar})

    -- Name
    local THName = Library.CreateObject("TextLabel", {
        FontFace = UITable.Font, Text = "Target",
        TextColor3 = ThemeDefault.TextColor, TextSize = UITable.FontSize,
        TextXAlignment = Enum.TextXAlignment.Left, BackgroundTransparency = 1,
        Position = UDim2_new(0, 62, 0, 4), Size = UDim2_new(1, -68, 0, 14), Parent = THInner
    }); Library.AddTheme(THName, {TextColor3 = "TextColor"})
    Library.CreateObject("UIStroke", {LineJoinMode = Enum.LineJoinMode.Miter, Parent = THName})

    -- HP Bar background
    local THHPBg = Library.CreateObject("Frame", {
        BackgroundColor3 = ThemeDefault.LightContrast, BorderSizePixel = 0,
        Position = UDim2_new(0, 62, 0, 22), Size = UDim2_new(1, -68, 0, 12), Parent = THInner
    }); Library.AddTheme(THHPBg, {BackgroundColor3 = "LightContrast"})
    Library.CreateObject("UIStroke", {Color = ThemeDefault.Outline, Thickness = 1, Parent = THHPBg})

    -- HP Bar fill with gradient
    local THHPBar = Library.CreateObject("Frame", {
        BackgroundColor3 = Color3_fromRGB(255,255,255), BorderSizePixel = 0,
        Size = UDim2_new(1, 0, 1, 0), Parent = THHPBg
    })
    local THHPGradient = Library.CreateObject("UIGradient", {
        Color = ColorSequence_new({
            ColorSequenceKeypoint_new(0, ThemeDefault.Accent),
            ColorSequenceKeypoint_new(1, ThemeDefault.SecondAccent)
        }),
        Parent = THHPBar
    })

    -- HP Text
    local THHPText = Library.CreateObject("TextLabel", {
        FontFace = UITable.Font, Text = "100 / 100",
        TextColor3 = ThemeDefault.TextColor, TextSize = UITable.FontSize - 1,
        TextXAlignment = Enum.TextXAlignment.Left, BackgroundTransparency = 1,
        Position = UDim2_new(0, 62, 0, 38), Size = UDim2_new(0.5, -32, 0, 12), Parent = THInner
    }); Library.AddTheme(THHPText, {TextColor3 = "TextColor"})
    Library.CreateObject("UIStroke", {LineJoinMode = Enum.LineJoinMode.Miter, Parent = THHPText})

    -- Distance text
    local THDist = Library.CreateObject("TextLabel", {
        FontFace = UITable.Font, Text = "0m",
        TextColor3 = ThemeDefault.TextDark, TextSize = UITable.FontSize - 1,
        TextXAlignment = Enum.TextXAlignment.Right, BackgroundTransparency = 1,
        Position = UDim2_new(0.5, 0, 0, 38), Size = UDim2_new(0.5, -68, 0, 12),
        AnchorPoint = Vector2_new(0, 0), Parent = THInner
    }); Library.AddTheme(THDist, {TextColor3 = "TextDark"})
    Library.CreateObject("UIStroke", {LineJoinMode = Enum.LineJoinMode.Miter, Parent = THDist})

    -- Weapon text
    local THWeapon = Library.CreateObject("TextLabel", {
        FontFace = UITable.Font, Text = "",
        TextColor3 = ThemeDefault.TextDark, TextSize = UITable.FontSize - 1,
        TextXAlignment = Enum.TextXAlignment.Left, BackgroundTransparency = 1,
        Position = UDim2_new(0, 62, 0, 52), Size = UDim2_new(1, -68, 0, 12), Parent = THInner
    }); Library.AddTheme(THWeapon, {TextColor3 = "TextDark"})
    Library.CreateObject("UIStroke", {LineJoinMode = Enum.LineJoinMode.Miter, Parent = THWeapon})

    -- Drag handle (invisible TextButton)
    local THDrag = Library.CreateObject("TextButton", {
        Name = "Drag", Text = "", BackgroundTransparency = 1,
        Size = UDim2_new(1, 0, 0, 18), Position = UDim2_new(0, 0, 0, 0),
        BorderSizePixel = 0, AutoButtonColor = false, Parent = TH
    })
    Library.Draggable(TH, THDrag)

    -- API
    local TargetHUDAPI = {Visible = false, Target = nil, Items = {Container = TH}}

    function TargetHUDAPI:SetVisibility(v)
        self.Visible = v
        if not v then TH.Visible = false end
    end

    function TargetHUDAPI:SetTarget(t)
        self.Target = t
        if not t or not self.Visible then TH.Visible = false; return end
        local name, userId, char = "Unknown", 0, nil
        if typeof(t) == "Instance" then
            if t:IsA("Player") then name = t.DisplayName or t.Name; userId = t.UserId; char = t.Character
            elseif t:IsA("Model") then
                name = t.Name; char = t
                local plr = Players:GetPlayerFromCharacter(t)
                if plr then userId = plr.UserId; name = plr.DisplayName or plr.Name end
            end
        end
        THName.Text = name
        THAvatar.Image = userId > 0 and string_format("rbxthumb://type=AvatarHeadShot&id=%d&w=60&h=60", userId) or ""
        TH.Visible = true
        self:Update()
    end

    function TargetHUDAPI:Update()
        if not self.Target or not self.Visible then return end
        local char
        if typeof(self.Target) == "Instance" then
            if self.Target:IsA("Player") then char = self.Target.Character
            elseif self.Target:IsA("Model") then char = self.Target end
        end
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then TH.Visible = false; return end
        local pct = math_clamp(hum.Health / math_max(hum.MaxHealth, 1), 0, 1)
        Library.TweenObject(THHPBar, TweenInfo_new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2_new(pct, 0, 1, 0)})
        THHPText.Text = string_format("%d / %d", math_floor(hum.Health), math_floor(hum.MaxHealth))
        -- Distance
        local myChar = Client.Character
        local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if myHrp and hrp then
            THDist.Text = string_format("%dm", math_floor((myHrp.Position - hrp.Position).Magnitude))
        end
        -- Weapon
        local tool = char:FindFirstChildOfClass("Tool")
        THWeapon.Text = tool and tool.Name or ""
    end

    Library.TargetHUDElement = TargetHUDAPI

    function Library.CreateTargetHUD(opts) return TargetHUDAPI end
end

-- ═══════════════════════════════════════════════════════════════
-- SUBTAB SYSTEM
-- Creates sub-navigation within a tab (e.g. Combat > Aimbot | Silent | Aimbot+)
-- ═══════════════════════════════════════════════════════════════
function Library.CreateSubTabs(ParentTab, SubTabNames)
    -- ParentTab = WindowTab returned by CreateTab
    -- SubTabNames = {"Aimbot", "Silent", "Aimbot+"}
    -- Returns table of {Name = SubTabWrapper} for each subtab

    local holder = ParentTab.Holder
    if not holder then return {} end

    -- Create subtab navigation bar at top of tab content
    local SubNav = Library.CreateObject("Frame", {
        Name = "SubNav", BackgroundColor3 = ThemeDefault.DarkContrast,
        BorderSizePixel = 0, Size = UDim2_new(1, 0, 0, 22),
        Position = UDim2_new(0, 0, 0, 0), Parent = holder
    }); Library.AddTheme(SubNav, {BackgroundColor3 = "DarkContrast"})

    local SubNavLayout = Library.CreateObject("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = SubNav
    })

    -- Hide existing content (parent tab's default Left/Right columns) since subtabs replace them
    -- Also remove the horizontal UIListLayout that would conflict with vertical subtab layout
    for _, child in holder:GetChildren() do
        if child ~= SubNav then
            if child:IsA("UIListLayout") then
                child:Destroy()
            elseif child:IsA("UIFlexItem") then
                child:Destroy()
            elseif child:IsA("UIPadding") then
                -- Remove top padding so subtab bar is flush below tab bar
                child.PaddingTop = UDim_new(0, 0)
                child.PaddingLeft = UDim_new(0, 0)
                child.PaddingRight = UDim_new(0, 0)
                child.PaddingBottom = UDim_new(0, 0)
            elseif child:IsA("GuiObject") then
                child.Visible = false
            end
        end
    end

    local subHolders = {}
    local activeSubTab = nil

    for i, name in ipairs(SubTabNames) do
        -- Create button for each subtab
        local btn = Library.CreateObject("TextButton", {
            Name = name, FontFace = UITable.Font, Text = name,
            TextColor3 = ThemeDefault.TextDark, TextSize = UITable.FontSize,
            BackgroundTransparency = 1, Size = UDim2_new(1 / #SubTabNames, 0, 1, 0),
            BorderSizePixel = 0, AutoButtonColor = false, Parent = SubNav
        }); Library.AddTheme(btn, {TextColor3 = "TextDark"})

        -- Create holder frame for subtab content (left + right columns)
        local subHolder = Library.CreateObject("Frame", {
            Name = name .. "_Holder", BackgroundTransparency = 1,
            Position = UDim2_new(0, 0, 0, 22), Size = UDim2_new(1, 0, 1, -22),
            Visible = (i == 1), BorderSizePixel = 0, Parent = holder
        })

        local subLeft = Library.CreateObject("Frame", {
            BackgroundTransparency = 1, Name = "Left",
            Size = UDim2_new(1, 0, 1, 0), BorderSizePixel = 0, Parent = subHolder
        })
        Library.CreateObject("UIFlexItem", {FlexMode = Enum.UIFlexMode.Fill, Parent = subLeft})
        Library.CreateObject("UIListLayout", {Padding = UDim_new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder, Parent = subLeft})

        local subRight = Library.CreateObject("Frame", {
            BackgroundTransparency = 1, Name = "Right",
            Size = UDim2_new(1, 0, 1, 0), BorderSizePixel = 0, Parent = subHolder
        })
        Library.CreateObject("UIFlexItem", {FlexMode = Enum.UIFlexMode.Fill, Parent = subRight})
        Library.CreateObject("UIListLayout", {Padding = UDim_new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder, Parent = subRight})

        Library.CreateObject("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim_new(0, 10), Parent = subHolder
        })

        Library.CreateObject("UIPadding", {
            PaddingTop = UDim_new(0, 10), PaddingBottom = UDim_new(0, 10),
            PaddingRight = UDim_new(0, 10), PaddingLeft = UDim_new(0, 10),
            Parent = subHolder
        })

        subHolders[name] = {holder = subHolder, left = subLeft, right = subRight, btn = btn}

        -- Click handler
        Library.AddConnection(btn.MouseButton1Click, function()
            if activeSubTab == name then return end
            -- Deactivate current
            if activeSubTab and subHolders[activeSubTab] then
                subHolders[activeSubTab].holder.Visible = false
                Library.TweenObject(subHolders[activeSubTab].btn, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {TextColor3 = ThemeDefault.TextDark})
            end
            -- Activate new
            activeSubTab = name
            subHolders[name].holder.Visible = true
            Library.TweenObject(btn, TweenInfo_new(UITable.TweenSpeed, UITable.TweenEasingStyle, Enum.EasingDirection.Out), {TextColor3 = ThemeDefault.TextColor})
        end)

        if i == 1 then
            activeSubTab = name
            btn.TextColor3 = ThemeDefault.TextColor
        end
    end

    -- Return section creators for each subtab
    -- Each subtab entry has a .Section(opts) function that creates proper sections
    local result = {}
    for name, data in pairs(subHolders) do
        local subTabWrapper = {}

        -- Section function creates a proper section inside this subtab
        function subTabWrapper.Section(opts)
            opts = opts or {}
            local side = opts.Side or "Left"
            if side == 1 then side = "Left" elseif side == 2 then side = "Right" end
            local parent = side == "Right" and data.right or data.left

            -- Use the same Section construction as Window.Section but with our subtab parent
            local Section = {
                Elements = {},
            }

            UITable.SectionZIndex = (UITable.SectionZIndex or 100) - 1

            local SectionOutline_2 = Library.CreateObject("Frame", {
                Name = "SectionOutline_2",
                Size = UDim2_new(1, 0, 0, 0),
                BorderColor3 = Color3_fromRGB(0, 0, 0),
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundColor3 = ThemeDefault.Outline,
                Parent = parent
            }); Library.AddTheme(SectionOutline_2, { BackgroundColor3 = "Outline" })

            Library.CreateObject("UIShadow", {
                Name = "SectionOutline_21",
                Transparency = 0.5,
                BlurRadius = UDim_new(0, 7),
                Parent = SectionOutline_2
            })

            Library.CreateObject("UIPadding", {
                PaddingBottom = UDim.new(0, 2),
                Parent = SectionOutline_2
            })

            local SectionAccent_2 = Library.CreateObject("Frame", {
                Size = UDim2_new(1, -2, 1, -2),
                Name = "SectionAccent_2",
                Position = UDim2_new(0, 1, 0, 1),
                BorderColor3 = Color3_fromRGB(0, 0, 0),
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundColor3 = ThemeDefault.Accent,
                Parent = SectionOutline_2
            }); Library.AddTheme(SectionAccent_2, { BackgroundColor3 = "Accent" })

            local SectionInline_2 = Library.CreateObject("Frame", {
                Size = UDim2_new(1, -2, 1, -2),
                Name = "SectionInline_2",
                Position = UDim2_new(0, 1, 0, 1),
                BorderColor3 = Color3_fromRGB(0, 0, 0),
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundColor3 = ThemeDefault.Outline,
                Parent = SectionAccent_2
            }); Library.AddTheme(SectionInline_2, { BackgroundColor3 = "Outline" })

            Library.CreateObject("UIPadding", {
                PaddingBottom = UDim.new(0, -1),
                Parent = SectionInline_2
            })

            local SectionGradient_2 = Library.CreateObject("Frame", {
                BorderColor3 = Color3_fromRGB(0, 0, 0),
                Size = UDim2_new(1, -2, 0, -2),
                Name = "SectionGradient_2",
                Position = UDim2_new(0, 1, 0, 1),
                BorderSizePixel = 0,
                ZIndex = 2,
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundColor3 = ThemeDefault.LightContrast,
                Parent = SectionInline_2
            }); Library.AddTheme(SectionGradient_2, { BackgroundColor3 = "LightContrast" })

            local UIPadding_72 = Library.CreateObject("UIPadding", {
                PaddingBottom = UDim.new(0, 3),
                PaddingTop = UDim.new(0, 4),
                PaddingRight = UDim.new(0, -2),
                Parent = SectionGradient_2
            })

            Library.CreateObject("UIPadding", {
                PaddingBottom = UDim.new(0, 2),
                Parent = SectionAccent_2
            })

            local Holder_14 = Library.CreateObject("ScrollingFrame", {
                Active = true,
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                ScrollingDirection = Enum.ScrollingDirection.Y,
                AutomaticSize = Enum.AutomaticSize.Y,
                CanvasSize = UDim2_new(0, 0, 0, 0),
                ScrollBarImageColor3 = ThemeDefault.Accent,
                MidImage = "rbxassetid://95591733073455",
                BorderColor3 = Color3_fromRGB(0, 0, 0),
                ScrollBarThickness = 3,
                Name = "Holder_14",
                Size = UDim2_new(1, -2, 1, -2),
                Position = UDim2_new(0, 1, 0, 1),
                TopImage = "rbxassetid://95591733073455",
                BorderSizePixel = 0,
                BottomImage = "rbxassetid://95591733073455",
                BackgroundTransparency = 1,
                Parent = SectionGradient_2
            }); Library.AddTheme(Holder_14, { ScrollBarImageColor3 = "Accent" })

            Library.CreateObject("UIListLayout", {
                Padding = UDim.new(0, 5),
                SortOrder = Enum.SortOrder.LayoutOrder,
                Parent = Holder_14
            })

            Library.CreateObject("UIPadding", {
                PaddingTop = UDim.new(0, 1),
                PaddingBottom = UDim.new(0, 4),
                PaddingRight = UDim.new(0, 7),
                PaddingLeft = UDim.new(0, 5),
                Parent = Holder_14
            })

            local LibraryFont = UITable.Font
            local LibraryFontSize = UITable.FontSize or 12

            local Title_29 = Library.CreateObject("TextLabel", {
                FontFace = LibraryFont,
                TextColor3 = ThemeDefault.TextColor,
                BorderColor3 = Color3_fromRGB(0, 0, 0),
                Text = opts.Name or "Section",
                AnchorPoint = Vector2_new(0, 0.5),
                Name = "Title_29",
                Position = UDim2_new(0, 10, 0, 0),
                BorderSizePixel = 0,
                TextXAlignment = Enum.TextXAlignment.Left,
                AutomaticSize = Enum.AutomaticSize.XY,
                TextSize = LibraryFontSize,
                BackgroundColor3 = ThemeDefault.LightContrast,
                Parent = SectionOutline_2
            }); Library.AddTheme(Title_29, { TextColor3 = "TextColor", BackgroundColor3 = "LightContrast" })

            Library.CreateObject("UIStroke", {
                LineJoinMode = Enum.LineJoinMode.Miter,
                Parent = Title_29
            })

            Library.CreateObject("UIPadding", {
                PaddingRight = UDim.new(0, 2),
                PaddingLeft = UDim.new(0, 3),
                Parent = Title_29
            })

            if opts.Fill then
                local UIFlexItem_2 = Library.CreateObject("UIFlexItem", {
                    FlexMode = Enum.UIFlexMode.Fill,
                    Parent = SectionOutline_2
                })

                SectionOutline_2.AutomaticSize = Enum.AutomaticSize.None
                SectionAccent_2.AutomaticSize = Enum.AutomaticSize.None
                SectionInline_2.AutomaticSize = Enum.AutomaticSize.None
                SectionGradient_2.AutomaticSize = Enum.AutomaticSize.None
                Holder_14.AutomaticSize = Enum.AutomaticSize.None
                SectionGradient_2.Size = UDim2_new(1, -2, 1, -2)
            end

            Section.Elements = {
                Name = Title_29,
                ElementsHolder = Holder_14,
            }

            return setmetatable(Section, Library.Sections)
        end

        result[name] = subTabWrapper
    end

    return result
end

