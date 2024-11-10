package main

Agent :: struct {
	wants: int,
	needs: int,
}

gen_agent :: proc() -> Agent {
	return Agent{}
}
