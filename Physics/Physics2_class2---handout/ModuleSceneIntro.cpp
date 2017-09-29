#include "Globals.h"
#include "Application.h"
#include "ModuleRender.h"
#include "ModuleSceneIntro.h"
#include "ModuleInput.h"
#include "ModuleTextures.h"
#include "ModulePhysics.h"


ModuleSceneIntro::ModuleSceneIntro(Application* app, bool start_enabled) : Module(app, start_enabled)
{
	circle = box = rick = NULL;
}

ModuleSceneIntro::~ModuleSceneIntro()
{}

// Load assets
bool ModuleSceneIntro::Start()
{
	LOG("Loading Intro assets");
	bool ret = true;

	App->renderer->camera.x = App->renderer->camera.y = 0;

	circle = App->textures->Load("pinball/wheel.png"); 
	box = App->textures->Load("pinball/crate.png");
	rick = App->textures->Load("pinball/rick_head.png");

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
	// TODO 5: Move all creation of bodies on 1,2,3 key press here in the scene
	
	if (App->input->GetKey(SDL_SCANCODE_1) == KEY_DOWN)
	{
		App->physics->CreateCircle(App->input->GetMouseX(), App->input->GetMouseY(), 25);
	}

	if (App->input->GetKey(SDL_SCANCODE_2) == KEY_DOWN)
	{
		App->physics->CreateRectangle(App->input->GetMouseX(), App->input->GetMouseY(), 50, 25);
	}

	if (App->input->GetKey(SDL_SCANCODE_3) == KEY_DOWN)
	{
		// TODO 3: Create a chain shape using those vertices
		// remember to convert them from pixels to meters!

		int points[24] = {
			-38, 80,
			-44, -54,
			-16, -60,
			-16, -17,
			19, -19,
			19, -79,
			61, -77,
			57, 73,
			17, 78,
			20, 16,
			-25, 13,
			-9, 72
		};

		int elephant[114] = {
			24, 308,
			31, 259,
			60, 197,
			155, 98,
			264, 52,
			364, 47,
			450, 58,
			516, 49,
			577, 26,
			691, 33,
			775, 58,
			821, 104,
			859, 183,
			875, 302,
			846, 391,
			793, 454,
			731, 507,
			730, 538,
			759, 556,
			759, 575,
			733, 596,
			706, 603,
			674, 563,
			662, 516,
			677, 475,
			723, 426,
			723, 403,
			700, 393,
			612, 436,
			593, 467,
			588, 503,
			592, 543,
			623, 616,
			586, 628,
			499, 627,
			466, 615,
			473, 560,
			475, 515,
			458, 474,
			440, 460,
			385, 476,
			311, 455,
			286, 468,
			275, 496,
			287, 555,
			319, 614,
			283, 628,
			192, 624,
			153, 613,
			136, 593,
			151, 461,
			147, 414,
			106, 360,
			85, 315,
			71, 277,
			50, 298,
			431, 272
		};


		int rick_head[68] = {
			41, 0,
			60, 15,
			74, 33,
			87, 5,
			94, 21,
			93, 39,
			111, 34,
			104, 58,
			116, 67,
			109, 73,
			109, 82,
			104, 93,
			110, 99,
			103, 105,
			101, 116,
			105, 120,
			105, 125,
			98, 126,
			97, 137,
			89, 143,
			78, 148,
			61, 146,
			48, 134,
			35, 137,
			39, 126,
			24, 123,
			30, 115,
			10, 102,
			29, 89,
			1, 76,
			30, 62,
			14, 36,
			43, 39,

		};

		App->physics->CreateChain(App->input->GetMouseX(), App->input->GetMouseY(), rick_head);

	}

	// TODO 7: Draw all the circles using "circle" texture

	node* iterator = App->physics->circles.first;
		while (iterator != nullptr) {
			b2Vec2 pos = App->physics->circles.Position(iterator->body);
			App->renderer->Blit(circle, pos.x - 25, pos.y - 25, 0, 1,  App->physics->circles.GetRotation(iterator->body));
			iterator = iterator->next;
		}


		iterator = App->physics->boxes.first;
		while (iterator != nullptr) {
			b2Vec2 pos = App->physics->boxes.Position(iterator->body);

			App->renderer->Blit(box, pos.x-50, pos.y-25, 0, 1, App->physics->circles.GetRotation(iterator->body));
			iterator = iterator->next;
		}
	
		iterator = App->physics->chain.first;
		while (iterator != nullptr) {
			b2Vec2 pos = App->physics->chain.Position(iterator->body);
			App->renderer->Blit(rick, pos.x, pos.y, 0, 1, App->physics->chain.GetRotation(iterator->body));
			iterator = iterator->next;
		}

	return UPDATE_CONTINUE;
}
