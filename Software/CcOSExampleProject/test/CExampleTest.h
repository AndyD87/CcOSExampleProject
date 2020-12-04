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
 * @page      CCExampleTest
 * @subpage   CExampleTest
 *
 * @page      CExampleTest
 * @copyright Andreas Dirmeier (C) 2017
 * @author    Andreas Dirmeier
 * @par       Web:      http://coolcow.de/projects/CcOSExampleProject
 * @par       Language: C++11
 * @brief     Class CExampleTest
 **/
#ifndef H_CExampleTest_H_
#define H_CExampleTest_H_

#include "CcBase.h"
#include "CcTest.h"

/**
 * @brief Class implementation
 */
class CExampleTest : public CcTest<CExampleTest>
{
public:
  /**
   * @brief Constructor
   */
  CExampleTest();

  /**
   * @brief Destructor
   */
  virtual ~CExampleTest();

private:
  bool test1();
};

#endif // H_CExampleTest_H_
