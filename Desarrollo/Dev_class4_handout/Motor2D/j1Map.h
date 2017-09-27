#ifndef __j1MAP_H__
#define __j1MAP_H__

#include "PugiXml/src/pugixml.hpp"
#include "p2List.h"
#include "p2Point.h"
#include "j1Module.h"

// TODO 2: Create a struct to hold information for a TileSet

struct TileSet {

	unsigned int firstgid = 0;
	char* name = nullptr;
	unsigned int tilewidht=0, tileheigth=0;
	int spacing=0;
	int margin=0;
	char* source = nullptr;
};

// Ignore Terrain Types and Tile Types for now, but we want the image!
// ----------------------------------------------------


// TODO 1: Create a struct needed to hold the information to Map node



struct MapInfo
{
	enum TYPE_Orientation {
		Default,
		ortogonal,
		isometric,
		staggered,
		hexagonal
	};
	enum TYPE_RenderOrder {
		Default,
		RightDown,
		RightUp,
		LeftDown,
		LeftUp
	};

	float version = 0;
	TYPE_Orientation orientation= TYPE_Orientation::Default;
	TYPE_RenderOrder renderorder= TYPE_RenderOrder::Default;
	unsigned int width, height = 0;
	unsigned int tilewidht=0, tileheigth=0;
	unsigned int nextobjectid=0;

};

// ----------------------------------------------------
class j1Map : public j1Module
{
public:

	j1Map();

	// Destructor
	virtual ~j1Map();

	// Called before render is available
	bool Awake(pugi::xml_node& conf);

	// Called each loop iteration
	void Draw();

	// Called before quitting
	bool CleanUp();

	// Load new map
	bool Load(const char* path);

	void LoadMapInfo(pugi::xml_node& mapinfo);

private:


public:

	// TODO 1: Add your struct for map info as public for now

private:

	pugi::xml_document	map_file;
	p2SString			folder;
	bool				map_loaded;
};

#endif // __j1MAP_H__