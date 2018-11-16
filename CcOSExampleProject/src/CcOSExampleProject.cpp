/*
 * This file is part of CcOSExampleProject.
 *
 * CcOSExampleProject is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * CcOSExampleProject is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with CcOSExampleProject.  If not, see <http://www.gnu.org/licenses/>.
 **/
/**
 * @file
 * @copyright Andreas Dirmeier (C) 2017
 * @author    Andreas Dirmeier
 * @par       Web: http://coolcow.de
 * @version   0.01
 * @date      2016-04
 * @par       Language   C++ ANSI V3
 * @brief     Implemtation of class CcOSExampleProject
 */
#include "CcOSExampleProject.h"
#include "CcKernel.h"
#include "CcConsole.h"
#include "CcString.h"

class CcOSExampleProjectPrivate
{
public:
  CcString oServerconfig;
};

CcOSExampleProject::CcOSExampleProject()
{
  init();
}

CcOSExampleProject::CcOSExampleProject(const CcArguments& oArguments) : m_oArguments(oArguments) 
{
  init();
}

CcOSExampleProject::~CcOSExampleProject()
{
  CCDELETE(m_pPrivate);
}

void CcOSExampleProject::run()
{
  CCDEBUG("CcOSExampleProject::run");
}

void CcOSExampleProject::init()
{
  m_pPrivate = new CcOSExampleProjectPrivate();
  CCMONITORNEW(m_pPrivate);
}