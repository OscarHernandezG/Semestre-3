#pragma once
#include "Module.h"
#include "Globals.h"

#define GRAVITY_X 0.0f
#define GRAVITY_Y -7.0f

#define PIXELS_PER_METER 50.0f // if touched change METER_PER_PIXEL too
#define METER_PER_PIXEL 0.02f // this is 1 / PIXELS_PER_METER !

#define METERS_TO_PIXELS(m) ((int) floor(PIXELS_PER_METER * m))
#define PIXEL_TO_METERS(p)  ((float) METER_PER_PIXEL * p)

class b2World;
class b2Body;
class b2Vec2;

// TODO 6: Create a small class that keeps a pointer to tghe b2Body
// and has a method to request the position
// then write the implementation in the .cpp
// Then make your circle creation function to return a pointer to that class




struct node
{
	b2Body* body = nullptr;
	node* next = nullptr;

};

class List{
public:

	node* first = nullptr;

	void addBody(b2Body* body) {
		if (first == nullptr) {
			node* aux = new node;
			first = aux;
			first->body = body;

		}
		else {
			node* iterator = first;
			while (iterator->next != nullptr) {
				iterator = iterator->next;
			}
			node* aux = new node;
			aux->body = body;
			iterator->next = aux;
		}
	}

	int Position_x(b2Body* body);

	int Position_y(b2Body* body);

	int GetRotation(b2Body* body);


};


class ModulePhysics : public Module
{
public:
	ModulePhysics(Application* app, bool start_enabled = true);
	~ModulePhysics();

	bool Start();
	update_status PreUpdate();
	update_status PostUpdate();
	bool CleanUp();

	// TODO 4: Move body creation to 3 functions to create circles, rectangles and chains
	
	void CreateCircle(int mouse_x, int mouse_y, int radius);
	void CreateRectangle(int mouse_x, int mouse_y, int h, int w);
	void CreateChain(int mouse_x, int mouse_y, int* vec);


	List circles;
	List boxes;
	List chain;

private:

	bool debug;
	b2World* world;
};