package main

import "core:fmt"
import "core:mem"
import "core:strings"
import ray "vendor:raylib"

main :: proc() {
	// code: https://odin-lang.org/docs/overview/#tracking-allocator
	when ODIN_DEBUG || true {
		track: mem.Tracking_Allocator
		mem.tracking_allocator_init(&track, context.allocator)
		context.allocator = mem.tracking_allocator(&track)

		defer {
			if len(track.allocation_map) > 0 {
				fmt.eprintf("=== %v allocations not freed: ===\n", len(track.allocation_map))
				for _, entry in track.allocation_map {
					fmt.eprintf("- %v bytes @ %v\n", entry.size, entry.location)
				}
			}
			if len(track.bad_free_array) > 0 {
				fmt.eprintf("=== %v incorrect frees: ===\n", len(track.bad_free_array))
				for entry in track.bad_free_array {
					fmt.eprintf("- %p @ %v\n", entry.memory, entry.location)
				}
			}
			mem.tracking_allocator_destroy(&track)
		}
	}


	width: i32 = 800
	height: i32 = 600

	frame := 0

	ray.InitWindow(width, height, "Lovely Title")
	ray.SetTargetFPS(60)

	for !ray.WindowShouldClose() {
		frame += 1
		ray.BeginDrawing()
		ray.ClearBackground(ray.RAYWHITE)
		ray.DrawText("Hello!", 50, 50, 14, ray.LIGHTGRAY)
		msg: cstring = fmt.ctprintf("frame: %d", frame)


		ray.DrawText(msg, 150, 50, 14, ray.DARKPURPLE)
		ray.EndDrawing()
	}
	ray.CloseWindow()
}
