#include "Globals.h"
#include "Application.h"
#include "ModulePhysics.h"
#include "math.h"

// TODO 1: Include Box 2 header and library
#include "Box2D/Box2D/Box2D.h"

#ifdef _DEBUG
#pragma comment (lib, "Box2D/libx86/Debug/Box2D.lib")
#endif //_DEBUG

#pragma comment (lib, "Box2D/libx86/Release/Box2D.lib")

#define METERS_TO_PIXELS(x) (x*10)
#define PIXELS_TO_METERS(x) (x/10)

struct list {
	uint8 r, g, b;
};

list color[500];
int last_circle = 0;


ModulePhysics::ModulePhysics(Application* app, bool start_enabled) : Module(app, start_enabled)
{
	debug = true;
}

// Destructor
ModulePhysics::~ModulePhysics()
{
}

bool ModulePhysics::Start()
{
	LOG("Creating Physics 2D environment");
	
	// TODO 2: Create a private variable for the world
	// - You need to send it a default gravity
	// - You need init the world in the constructor
	// - Remember to destroy the world after using it

	World = new b2World({ 0.0f,20.00f });
	
	// TODO 4: Create a a big static circle as "ground"

	
	b2BodyDef body;
	body.type = b2_staticBody;
	body.position.Set(PIXELS_TO_METERS(500), PIXELS_TO_METERS(400));
	
	b2Body* ground = World->CreateBody(&body);

	b2CircleShape shape;
	shape.m_radius = PIXELS_TO_METERS(300);

	b2FixtureDef circle;
	circle.shape = &shape;
	ground->CreateFixture(&circle);
	color[last_circle].r = 255;
	color[last_circle].g = 255;
	color[last_circle++].b = 255;
	//ground.CreateFixture(&circle);

	return true;
}

// 
update_status ModulePhysics::PreUpdate()
{
	// TODO 3: Update the simulation ("step" the world)

	World->Step(1.0f / 60.0f, 8, 3);

	return UPDATE_CONTINUE;
}

// 
update_status ModulePhysics::PostUpdate()
{
	// TODO 5: On space bar press, create a circle on mouse position
	// - You need to transform the position / radius

	if (App->input->GetKey(SDL_SCANCODE_SPACE) == KEY_DOWN) {
		b2BodyDef body;
		body.type = b2_dynamicBody;
		body.position.Set(PIXELS_TO_METERS(App->input->GetMouseX()), PIXELS_TO_METERS(App->input->GetMouseY()));

		b2Body* ground = World->CreateBody(&body);

		b2CircleShape circle;
		circle.m_radius = PIXELS_TO_METERS(rand() % (21 - 10) + 10);

		color[last_circle].r = rand() % 255;
		color[last_circle].g = rand() % 255;
		color[last_circle++].b = rand() % 255;

		b2FixtureDef fixture;
		fixture.shape = &circle;
		ground->CreateFixture(&fixture);
	}


	if(App->input->GetKey(SDL_SCANCODE_F1) == KEY_DOWN)
		debug = !debug;

	if(!debug)
		return UPDATE_CONTINUE;

	// Bonus code: this will iterate all objects in the world and draw the circles
	// You need to provide your own macro to translate meters to pixels
	int i = last_circle;
	for(b2Body* b = World->GetBodyList(); b; b = b->GetNext())
	{

		for(b2Fixture* f = b->GetFixtureList(); f; f = f->GetNext())
		{
			i--;
			switch(f->GetType())
			{
				case b2Shape::e_circle:
				{
					b2CircleShape* shape = (b2CircleShape*)f->GetShape();
					b2Vec2 pos = f->GetBody()->GetPosition();
					App->renderer->DrawCircle(METERS_TO_PIXELS(pos.x), METERS_TO_PIXELS(pos.y), METERS_TO_PIXELS(shape->m_radius), color[i].r, color[i].g,color[i].b);
			}
				break;

				// You will have to add more cases to draw boxes, edges, and polygons ...
			}
		}
	}

	return UPDATE_CONTINUE;
}


// Called before quitting
bool ModulePhysics::CleanUp()
{
	LOG("Destroying physics world");

	// Delete the whole physics world!

	delete World;
	World = nullptr;

	return true;
}
