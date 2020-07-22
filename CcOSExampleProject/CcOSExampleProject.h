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
 * @page      CcOSExampleProject
 * @copyright Andreas Dirmeier (C) 2017
 * @author    Andreas Dirmeier
 * @par       Web: http://coolcow.de
 * @par       Language   C++ ANSI V3
 * @brief     Class CcOSExampleProject
 **/
#ifndef CcOSExampleProject_H_
#define CcOSExampleProject_H_

#include "CcBase.h"
#include "CcApp.h"
#include "CcArguments.h"

/**
 * @brief CcOSExampleProject impelmentation
 *        Main class wich is loaded to start Application.
 */
class CcOSExampleProject : public CcApp
{
public:
  /**
   * @brief Constructor
   */
  CcOSExampleProject(void);

  /**
   * @brief Constructor with Arguments
   * @param oArguments: Arguments from cli to pass.
   */
  CcOSExampleProject(const CcArguments& oArguments);

  /**
   * @brief Destructor
   */
  virtual ~CcOSExampleProject( void );

private:
  /**
   * @brief Main method
   */
  virtual void run() override;
  
  /**
   * @brief Init internals of CMain App
   */
  void init();

private:
  class CPrivate;
  CcArguments m_oArguments;               //!< Arguments from starup
  CPrivate*   m_pPrivate    = nullptr;  //!< Private data for applicaton.
};

#endif /* CcOSExampleProject_H_ */
