#include "PhysBody3D.h"
#include "glmath.h"
#include "Bullet/include/btBulletDynamicsCommon.h"
#include "Application.h"

// TODO 4: Fill in PhysBody methods. Remember to use 
// get/setOpenGLMatrix methods

// ---------------------------------------------------------
PhysBody3D::PhysBody3D(btRigidBody* body)
{}

// ---------------------------------------------------------
PhysBody3D::~PhysBody3D()
{}

// ---------------------------------------------------------
void PhysBody3D::GetTransform(float* matrix) const
{

	this->body->getWorldTransform().getOpenGLMatrix((btScalar*)matrix);
}

// ---------------------------------------------------------
void PhysBody3D::SetTransform(const float* matrix) const
{
	btTransform trans;
	trans.setFromOpenGLMatrix(matrix);
	

	btTransform bodytrans = this->body->getWorldTransform();

	btTransform ret = trans * bodytrans;

	body->setWorldTransform(ret);
}

// ---------------------------------------------------------
void PhysBody3D::SetPos(float x, float y, float z)
{
	btVector3 newpos({ x,y,z });
	btVector3 thispos = body->getCenterOfMassPosition();
	
	body->translate(newpos - thispos);
}
