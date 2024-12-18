function love.conf(t)
	t.window.resizable = true
	t.window.title = "Snake"
	t.window.borderless = true

	t.modules.audio = false
	t.modules.data = false
	t.modules.event = true
	t.modules.font = false
	t.modules.graphics = true
	t.modules.image = false
	t.modules.joystick = false
	t.modules.keyboard = true
	t.modules.math = true
	t.modules.mouse = false
	t.modules.physics = false
	t.modules.sound = false
	t.modules.system = false
	t.modules.thread = false
	t.modules.timer = true
	t.modules.touch = false
	t.modules.video = false
	t.modules.window = true
end
