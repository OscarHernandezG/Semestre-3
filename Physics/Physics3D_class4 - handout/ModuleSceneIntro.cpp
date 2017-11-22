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

	App->camera->Move(vec3(1.0f, 1.0f, 0.0f));
	App->camera->LookAt(vec3(0, 0, 0));


	// TODO 2: Chain few N spheres together to form a snake
	//PhysBody3D* bodyA = App->physics->AddBody(sphere);
	
	

	PhysBody3D* lastbody = nullptr;
	for (int i = 0; i < MAX_SNAKE; ++i)
	{
		Sphere sphere;
		sphere.radius = 1;
		sphere.SetPos(2 * i, 0, 0);

		pb_snake[i] = App->physics->AddBody(sphere);

		if (lastbody != nullptr)
			App->physics->AddConstraint(*lastbody, *pb_snake[i], { 3,0,0 }, { 0,0,0 });
		lastbody = pb_snake[i];
	}


	lastbody = nullptr;

	for (int i = 0; i < MAX_SNAKE; ++i)
	{
		Sphere sphere;
		sphere.radius = 1;
		sphere.SetPos(2 * i, 0, 10);

		pb_snake2[i] = App->physics->AddBody(sphere);

		if (lastbody != nullptr)
			App->physics->AddHingeConstraint(*lastbody, *pb_snake2[i], { 0,0,0 }, { sphere.radius * 3,0,0 });
		lastbody = pb_snake2[i];
	}


	
	// TODO 4: Chain few N spheres together to form a a bike's sphere
	// Be sure to put the right axis



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


	for(int i = 0; i < MAX_SNAKE; ++i)
	{
		pb_snake[i]->GetTransform(&(s_snake[i].transform));
		s_snake[i].Render();
	}

	for(int i = 0; i < MAX_SNAKE; ++i)
	{
		pb_snake2[i]->GetTransform(&(s_snake2[i].transform));
		s_snake2[i].Render();
	}

	return UPDATE_CONTINUE;
}

void ModuleSceneIntro::OnCollision(PhysBody3D* body1, PhysBody3D* body2)
{
}


