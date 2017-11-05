#include "Globals.h"
#include "Application.h"
#include "ModuleSceneIntro.h"
#include "Primitive.h"

ModuleSceneIntro::ModuleSceneIntro(Application* app, bool start_enabled) : Module(app, start_enabled)
{
}

ModuleSceneIntro::~ModuleSceneIntro()
{}

// Load assets
bool ModuleSceneIntro::Start()
{
	LOG("Loading Intro assets");
	bool ret = true;

	// TODO 2: Place the camera one unit up in Y and one unit to the right
	// experiment with different camera placements, then use LookAt()
	// to make it look at the center

	App->camera->Position.y += 1;
	App->camera->Position.x += 1;
	App->camera->LookAt({ 0,0,0 });


	return ret;
}

// Load assets
bool ModuleSceneIntro::CleanUp()
{
	LOG("Unloading Intro scene");

	return true;
}

// Update: draw background
update_status ModuleSceneIntro::Update()
{
	// TODO 1: Create a Plane primitive. This uses the plane formula
	// so you have to express the normal of the plane to create 
	// a plane centered around 0,0. Make that it draw the axis for reference

	Plane floor(0, 0, 0, 200);
	floor.axis = true;
	floor.Render();
	

	// TODO 6: Draw a sphere of 0.5f radius around the center
	// Draw somewhere else a cube and a cylinder in wireframe

	Sphere sphere(0.5f);
	Color color;

	color.Set(0, 1, 1, 0.0001);
	sphere.color = color;
	sphere.SetPos(0, 0, 0);
	sphere.Render();


	Cylinder cylinder(1, 5);
	cylinder.wire = true;
	cylinder.SetPos(-4, 0, 0);
	cylinder.Render();

	return UPDATE_CONTINUE;
}

