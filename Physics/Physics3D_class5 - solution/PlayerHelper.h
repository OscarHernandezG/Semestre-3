#pragma once


#include "tiny_obj_loader.h"


#include "Globals.h"
#include <gl/GL.h>
#include <gl/GLU.h>
#include "Primitive.h"
#include "glut/glut.h"

#pragma comment (lib, "glut/glut32.lib")


tinyobj::attrib_t attribute;

std::vector<tinyobj::shape_t> shapes;
std::vector<tinyobj::material_t> materials;
tinyobj::attrib_t attrib;
std::string err;

