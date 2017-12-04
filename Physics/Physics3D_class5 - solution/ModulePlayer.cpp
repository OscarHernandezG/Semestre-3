#include "Globals.h"
#include "Application.h"
#include "ModulePlayer.h"
#include "Primitive.h"
#include "PhysVehicle3D.h"
#include "PhysBody3D.h"

#include "PlayerHelper.h"

ModulePlayer::ModulePlayer(Application* app, bool start_enabled) : Module(app, start_enabled), vehicle(NULL)
{
	turn = acceleration = brake = 0.0f;
}

ModulePlayer::~ModulePlayer()
{}

// Load assets
bool ModulePlayer::Start()
{
	LOG("Loading player");

	VehicleInfo car;

// Car properties ----------------------------------------
	car.chassis_size.Set(2.5, 2, 4);
	car.chassis_offset.Set(0, 1.5, 0);
	car.mass = 500.0f;
	car.suspensionStiffness = 15.88f;
	car.suspensionCompression = 0.83f;
	car.suspensionDamping = 0.88f;
	car.maxSuspensionTravelCm = 1000.0f;
	car.frictionSlip = 50.5;
	car.maxSuspensionForce = 6000.0f;

	// Wheel properties ---------------------------------------
	float connection_height = 1.2f;
	float wheel_radius = 0.6f;
	float wheel_width = 0.5f;
	float suspensionRestLength = 1.2f;

	// Don't change anything below this line ------------------

	float half_width = car.chassis_size.x*0.5f;
	float half_length = car.chassis_size.z*0.5f;
	
	vec3 direction(0,-1,0);
	vec3 axis(-1,0,0);
	
	car.num_wheels = 3;
	car.wheels = new Wheel[car.num_wheels];

	//// FRONT-LEFT ------------------------
	//car.wheels[0].connection.Set(half_width - 0.3f * wheel_width, connection_height, half_length - wheel_radius);
	//car.wheels[0].direction = direction;
	//car.wheels[0].axis = axis;
	//car.wheels[0].suspensionRestLength = suspensionRestLength;
	//car.wheels[0].radius = wheel_radius;
	//car.wheels[0].width = wheel_width;
	//car.wheels[0].front = true;
	//car.wheels[0].drive = true;
	//car.wheels[0].brake = false;
	//car.wheels[0].steering = true;

	// FRONT-RIGHT ------------------------
	//car.wheels[1].connection.Set(-half_width + 0.3f * wheel_width, connection_height, half_length - wheel_radius);
	//car.wheels[1].direction = direction;
	//car.wheels[1].axis = axis;
	//car.wheels[1].suspensionRestLength = suspensionRestLength;
	//car.wheels[1].radius = wheel_radius;
	//car.wheels[1].width = wheel_width;
	//car.wheels[1].front = true;
	//car.wheels[1].drive = true;
	//car.wheels[1].brake = false;
	//car.wheels[1].steering = true;

	// FRONT ------------------------
	car.wheels[0].connection.Set(half_width - 2.5*wheel_width, connection_height, half_length - wheel_radius);
	car.wheels[0].direction = direction;
	car.wheels[0].axis = axis;
	car.wheels[0].suspensionRestLength = suspensionRestLength;
	car.wheels[0].radius = wheel_radius;
	car.wheels[0].width = wheel_width;
	car.wheels[0].front = true;
	car.wheels[0].drive = true;
	car.wheels[0].brake = false;
	car.wheels[0].steering = true;

	// REAR-LEFT ------------------------
	car.wheels[1].connection.Set(half_width - 0.3f * wheel_width, 2 * connection_height, -half_length + wheel_radius);
	car.wheels[1].direction = direction;
	car.wheels[1].axis = axis;
	car.wheels[1].suspensionRestLength = suspensionRestLength;
	car.wheels[1].radius =  2 * wheel_radius + connection_height/2;
	car.wheels[1].width =  2 * wheel_width;
	car.wheels[1].front = false;
	car.wheels[1].drive = false;
	car.wheels[1].brake = true;
	car.wheels[1].steering = false;

	// REAR-RIGHT ------------------------
	car.wheels[2].connection.Set(-half_width + 0.3f * wheel_width, 2*connection_height, -half_length + wheel_radius);
	car.wheels[2].direction = direction;
	car.wheels[2].axis = axis;
	car.wheels[2].suspensionRestLength = suspensionRestLength;
	car.wheels[2].radius = 2 * wheel_radius + connection_height/2;
	car.wheels[2].width =  2 *wheel_width;
	car.wheels[2].front = false;
	car.wheels[2].drive = false;
	car.wheels[2].brake = true;
	car.wheels[2].steering = false;

	vehicle = App->physics->AddVehicle(car);
	vehicle->SetPos(0, 12, 10);
	


	return true;
}

// Unload assets
bool ModulePlayer::CleanUp()
{
	LOG("Unloading player");

	return true;
}

// Update: draw background
update_status ModulePlayer::Update(float dt)
{

	if (ft) {

		std::vector<tinyobj::shape_t> shapes;
		std::vector<tinyobj::material_t> materials;
		tinyobj::attrib_t attrib;
		std::string err;
		bool ret = tinyobj::LoadObj(&attrib, &shapes, &materials, &err, "models/Avent.obj", "models/", false);

		attribute = attrib;

		ft = !ft;
	}

	else {
		glLineWidth(1.0f);

		glBegin(GL_LINE_STRIP);
		glColor4f(1.0f, 0.0f, 0.0f, 1.0f);
		for (size_t v = 0; v < attribute.vertices.size() / 3; v++) {

			glVertex3f(attribute.vertices[3 * v + 0] * 2, attribute.vertices[3 * v + 1] * 2, attribute.vertices[3 * v + 2] * 2);


		//	glColor3f(1, 1, 0);
			glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
		
		}
	glEnd();
		
	}



	turn = acceleration = brake = 0.0f;

	if(App->input->GetKey(SDL_SCANCODE_UP) == KEY_REPEAT)
	{
		acceleration = MAX_ACCELERATION;
	}
	
	if (App->input->GetKey(SDL_SCANCODE_P) == KEY_REPEAT)
	{
		acceleration = 100000;
	}

	if(App->input->GetKey(SDL_SCANCODE_LEFT) == KEY_REPEAT)
	{
		if(turn < TURN_DEGREES)
			turn +=  TURN_DEGREES;
	}

	if(App->input->GetKey(SDL_SCANCODE_RIGHT) == KEY_REPEAT)
	{
		if(turn > -TURN_DEGREES)
			turn -= TURN_DEGREES;
	}

	if(App->input->GetKey(SDL_SCANCODE_DOWN) == KEY_REPEAT)
	{
		if (vehicle->GetKmh() >= 0)
		brake = BRAKE_POWER;
		else 
			acceleration = -MAX_ACCELERATION;
	}

	if (App->input->GetKey(SDL_SCANCODE_SPACE) == KEY_REPEAT)
	{
			brake = 2 * BRAKE_POWER;

	}

	vehicle->ApplyEngineForce(acceleration);
	vehicle->Turn(turn);
	vehicle->Brake(brake);

	vehicle->Render();
	
	float* matrix = new float[20];

	vehicle->GetTransform(matrix);
	new_pos = vec3(matrix[12], matrix[13], matrix[14]);
	//App->camera->LookAt(new_pos);

	vec3 move = new_pos - last_pos;
	
	last_pos = new_pos;
	App->camera->Move(move);

	char title[80];
	sprintf_s(title, "%.1f Km/h", vehicle->GetKmh());
	App->window->SetTitle(title);

	return UPDATE_CONTINUE;
}



