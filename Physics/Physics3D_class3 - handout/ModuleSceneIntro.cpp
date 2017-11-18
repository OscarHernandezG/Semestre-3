#include "Globals.h"
#include "Application.h"
#include "ModuleSceneIntro.h"
#include "Primitive.h"
#include "PhysBody3D.h"

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

	App->camera->Move(vec3(1.0f	, 1.0f, 0.0f));
	App->camera->LookAt(vec3(0, 0, 0));

	// TODO 3: create a sphere in the world with a primitive
	// and create a physics body for it. Remember to render it in Update()

	sphere.radius = 2;
	sphere.color = { 0,1,0,0.001f };
	sphere.SetPos(0, 3, 0);

	
	App->physics->AddBody(sphere, 1);

	sphere.radius = 2;
	sphere.color = { 0,1,0,0.001f };
	sphere.SetPos(0, 6, 0);


	App->physics->AddBody(sphere, 1);

	sphere.radius = 2;
	sphere.color = { 0,1,0,0.001f };
	sphere.SetPos(2, 50, 0);


	App->physics->AddBody(sphere, 1);



	// TODO 5: Add this module to the list of collision listeners

	

	return ret;
}

// Load assets
bool ModuleSceneIntro::CleanUp()
{
	LOG("Unloading Intro scene");

	return true;
}

// Update
update_status ModuleSceneIntro::Update(float dt)
{
	Plane p(0, 1, 0, 0);
	p.axis = true;
	p.Render();

	// TODO 4: update the transform of the shape to meet the
	// physics one
	if (App->input->GetKey(SDL_SCANCODE_L) == KEY_REPEAT) {

		sphere.radius = 2;
		sphere.color = { 0,1,0,0.001f };
		sphere.SetPos(2, 50, 0);
		
		App->physics->AddBody(sphere, 1);

	}


	for (p2List_item<PhysBody3D*>* CurrNode = App->physics->BodysList.getFirst(); CurrNode != nullptr; CurrNode = CurrNode->next)
	{
//		CurrNode->data->GetTransform(sphere.transform.M);
		sphere.Render();
	}
	

	//sphere.SetPos(0, 0, 0);

	return UPDATE_CONTINUE;
}

// TODO 5: ... and define it for the ModuleScenario. Set the ball
// in red if it happens using is color property


