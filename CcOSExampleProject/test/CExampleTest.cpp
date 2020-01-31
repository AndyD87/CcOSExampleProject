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
 * @par       Web:      http://coolcow.de/projects/CcOSExampleProject
 * @par       Language: C++11
 * @brief     Implemtation of class CExampleTest
 */
#include "CExampleTest.h"
#include "CcKernel.h"
#include "CcFile.h"
#include "CcGphotoCamera.h"

CExampleTest::CExampleTest() :
  CcTest("CExampleTest")
{
  appendTestMethod("Start first test", &CExampleTest::test1);
}

CExampleTest::~CExampleTest()
{
}

bool CExampleTest::testStartServer()
{
  CcStatus oStatus = true;
  // Something to test
  return oStatus;
}
