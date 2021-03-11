//Support (Bill) Menu////////////////////////////////////////////////////////////////

//Bill Menu Draw
Action:SupportMenuDraw(iClient) 
{
	decl String:text[512];

	DeleteAllMenuParticles(iClient);
	
	Menu menu = CreateMenu(SupportMenuHandler);
	SetMenuPagination(menu, MENU_NO_PAGINATION);
	
	FormatEx(text, sizeof(text), "\n \nLevel %d	XP: %d/%d\n=	=	=	=	=	=	=	=	=	=	=	=	=	=\n \n					Bill's Support Talents\n ", g_iClientLevel[iClient], g_iClientXP[iClient], g_iClientNextLevelXPAmount[iClient]);
	SetMenuTitle(menu, text);
	
	FormatEx(text, sizeof(text), "	[Level %d]	Inspirational Leadership", g_iInspirationalLevel[iClient]);
	AddMenuItem(menu, "option1", text);
	FormatEx(text, sizeof(text), "	[Level %d]	Ghillie Tactics", g_iGhillieLevel[iClient]);
	AddMenuItem(menu, "option2", text);
	FormatEx(text, sizeof(text), "	[Level %d]	Will to Live", g_iWillLevel[iClient]);
	AddMenuItem(menu, "option3", text);
	FormatEx(text, sizeof(text), "	[Level %d]	Exorcism in a Barrel", g_iExorcismLevel[iClient]);
	AddMenuItem(menu, "option4", text);
	FormatEx(text, sizeof(text), "	[Level %d]	Die Hard (Bind 1)", g_iDiehardLevel[iClient]);
	AddMenuItem(menu, "option5", text);
	FormatEx(text, sizeof(text), "	[Level %d]	Promotional Benefits (Bind 2)          \n ", g_iPromotionalLevel[iClient]);
	AddMenuItem(menu, "option6", text);
	
	AddMenuItem(menu, "option7", "Open In Website	\n ");
	AddMenuItem(menu, "option8", "", ITEMDRAW_NOTEXT);
	AddMenuItem(menu, "option9", "Back\n \n=	=	=	=	=	=	=	=	=	=	=	=	=	=\
		\n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n ");
	
	SetMenuExitButton(menu, false);
	DisplayMenu(menu, iClient, MENU_TIME_FOREVER);

	return Plugin_Handled;
}

//Inspirational Leadership Draw
Action:InspirationalMenuDraw(iClient) 
{
	decl String:text[512];

	DeleteAllMenuParticles(iClient);
	if(g_bEnabledVGUI[iClient] == true && g_iClientTeam[iClient] == TEAM_SURVIVORS && IsPlayerAlive(iClient) == true)
	{
		g_iPID_MD_Bill_Inspirational[iClient] = WriteParticle(iClient, "md_bill_inspirational", 0.0);
		g_bShowingVGUI[iClient] =  true;
	}
	
	Menu menu = CreateMenu(InspirationalMenuHandler);
	
	FormatEx(text, sizeof(text), "\
		\n \
		\n				Inspirational Leadership (Level %d)\
		\n \
		\nLevel 1:\
		\n(Team) +10 bonus XP per level for teammates on SI kill\
		\n(Charge) Regenerate 1 life to random ally per level\
		\n \
		\n \
		\nSkill Uses:\
		\n(Charge) HP Regeneration: Hold [CROUCH] to heal allies\
		\nevery 6 seconds\
		\n ",
		g_iInspirationalLevel[iClient]);
	SetMenuTitle(menu, text);
	
	AddMenuItem(menu, "option1", "Back\
	\n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n ");
	
	SetMenuExitButton(menu, false);
	DisplayMenu(menu, iClient, MENU_TIME_FOREVER);

	return Plugin_Handled;
}

//Ghillie Tactics
Action:GhillieMenuDraw(iClient) 
{
	decl String:text[512];

	DeleteAllMenuParticles(iClient);
	if(g_bEnabledVGUI[iClient] == true && g_iClientTeam[iClient] == TEAM_SURVIVORS && IsPlayerAlive(iClient) == true)
	{
		g_iPID_MD_Bill_Ghillie[iClient] = WriteParticle(iClient, "md_bill_ghillie", 0.0);
		g_bShowingVGUI[iClient] =  true;
	}
				
	Menu menu = CreateMenu(GhillieMenuHandler);

	FormatEx(text, sizeof(text), "\
		\n \
		\n				Ghillie Tactics(Level %d):\
		\n \
		\nLevel 1:\
		\n+13%%%% cloaking per level\
		\n(Charge) +30 sprinting stamina per level\
		\n \
		\n \
		\nSkill Uses:\
		\n(Charge) sprinting stamina builds over time\
		\nHold [WALK] to activate\
		\nWorks while incapacitated\
		\n ", 
		g_iGhillieLevel[iClient]);
	SetMenuTitle(menu, text);

	AddMenuItem(menu, "option1", "Back\
	\n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n ");

	SetMenuExitButton(menu, false);
	DisplayMenu(menu, iClient, MENU_TIME_FOREVER);

	return Plugin_Handled;
}

//Will to Live Draw
Action:WillMenuDraw(iClient) 
{
	decl String:text[512];

	DeleteAllMenuParticles(iClient);
	if(g_bEnabledVGUI[iClient] == true && g_iClientTeam[iClient] == TEAM_SURVIVORS && IsPlayerAlive(iClient) == true)
	{
		g_iPID_MD_Bill_Will[iClient] = WriteParticle(iClient, "md_bill_will", 0.0);
		g_bShowingVGUI[iClient] =  true;
	}
	
	Menu menu = CreateMenu(WillMenuHandler);
	
	FormatEx(text, sizeof(text), "\
		\n \
		\n					Will to Live(Level %d):\
		\n \
		\nLevel 1:\
		\n+5 max health per level\
		\n+50 incap health per level\
		\n(Team) Allow crawling\
		\n(Stacks) (Team) +5 crawl speed per level\
		\n \
		\n \
		\nSkill Uses:\
		\nCrawl speed (Stacks) with itself\
		\nUnlimited stacks\
		\n ",
		g_iWillLevel[iClient]);
	SetMenuTitle(menu, text);

	AddMenuItem(menu, "option1", "Back\
	\n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n ");

	SetMenuExitButton(menu, false);
	DisplayMenu(menu, iClient, MENU_TIME_FOREVER);

	return Plugin_Handled;
}


//Exorcism in a Barrel Draw
Action:ExorcismMenuDraw(iClient) 
{
	decl String:text[512];
	
	DeleteAllMenuParticles(iClient);
	if(g_bEnabledVGUI[iClient] == true && g_iClientTeam[iClient] == TEAM_SURVIVORS && IsPlayerAlive(iClient) == true)
	{
		g_iPID_MD_Bill_Exorcism[iClient] = WriteParticle(iClient, "md_bill_exorcism", 0.0);
		g_bShowingVGUI[iClient] =  true;
	}
	
	Menu menu = CreateMenu(ExorcismMenuHandler);
	
	FormatEx(text, sizeof(text), "\
		\n \
		\n  Exorcism in a Barrel(Level %d):\
		\n \
		\nLevel 1:\
		\n+4%%%% Assault Rifle damage per level\
		\n+20%%%% Reload speed per level\
		\n ", g_iExorcismLevel[iClient]);
	SetMenuTitle(menu, text);
	
	AddMenuItem(menu, "option1", "Back\
	\n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n ");

	SetMenuExitButton(menu, false);
	DisplayMenu(menu, iClient, MENU_TIME_FOREVER);

	return Plugin_Handled;
}

//Die Hard Draw
Action:DiehardMenuDraw(iClient) 
{
	decl String:text[512];
	
	DeleteAllMenuParticles(iClient);
	if(g_bEnabledVGUI[iClient] == true && g_iClientTeam[iClient] == TEAM_SURVIVORS && IsPlayerAlive(iClient) == true)
	{
		g_iPID_MD_Bill_Diehard[iClient] = WriteParticle(iClient, "md_bill_diehard", 0.0);
		g_bShowingVGUI[iClient] =  true;
	}
	
	Menu menu = CreateMenu(DiehardMenuHandler);
	
	FormatEx(text, sizeof(text), "\
		\n \
		\n					Die Hard(Level %d):\
		\n					Requires Level 11\
		\n \
		\nLevel 1:\
		\n+15 max health per level\
		\nRegen 6 health when ally incaps per level\
		\n \
		\n \
		\n		Bind 1: Improvised Explosives\
		\n			+1 use every other level\
		\n \
		\nLevel 1:\
		\nDrop +1 active pipebomb every other level\
		\n ", g_iDiehardLevel[iClient]);
	SetMenuTitle(menu, text);

	AddMenuItem(menu, "option1", "Back\
	\n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n ");
	
	SetMenuExitButton(menu, false);
	DisplayMenu(menu, iClient, MENU_TIME_FOREVER);

	return Plugin_Handled;
}

//Promotional Benefits Draw
Action:PromotionalMenuDraw(iClient) 
{
	decl String:text[512];
	
	DeleteAllMenuParticles(iClient);
	if(g_bEnabledVGUI[iClient] == true && g_iClientTeam[iClient] == TEAM_SURVIVORS && IsPlayerAlive(iClient) == true)
	{
		g_iPID_MD_Bill_Promotional[iClient] = WriteParticle(iClient, "md_bill_promotional", 0.0);
		g_bShowingVGUI[iClient] =  true;
	}
	
	Menu menu = CreateMenu(PromotionalMenuHandler);
	
	FormatEx(text, sizeof(text), "\
		\n \
		\n		Promotional Benefits(Level %d):\
		\n			   Requires Level 26\
		\n \
		\nLevel 1:\
		\n+8%%%% reload speed & cloaking per level\
		\n+20 rifle clip size per level\
		\n+20%%%% M60 damage per level\
		\nAutomatic laser sight\
		\nHide glow from SI\
		\n \
		\n \
		\n				Bind 2: First Blood\
		\n			+1 use every other level\
		\n \
		\nLevel 1:\
		\nSpawn M60\
		\n ",
		g_iPromotionalLevel[iClient]);
	SetMenuTitle(menu, text);

	AddMenuItem(menu, "option1", "Back\
	\n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n ");
	
	SetMenuExitButton(menu, false);
	DisplayMenu(menu, iClient, MENU_TIME_FOREVER);

	return Plugin_Handled;
}

//Handlers//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Bill Menu Handler
SupportMenuHandler(Menu menu, MenuAction:action, iClient, itemNum)
{
	if (action == MenuAction_End)
	{
		delete menu;
	}
	else if (action == MenuAction_Select) 
	{
		switch (itemNum)
		{
			case 0: //Inspirational
			{
				InspirationalMenuDraw(iClient);
			}
			case 1: //Ghillie Tactics
			{
				GhillieMenuDraw(iClient);
			}
			case 2: //Will to Live
			{
				WillMenuDraw(iClient);
			}
			case 3: //Exorcism in a Barrel
			{
				ExorcismMenuDraw(iClient);
			}
			case 4: //Die Hard
			{
				DiehardMenuDraw(iClient);
			}
			case 5: //Promotional Benefits
			{
				PromotionalMenuDraw(iClient);
			}
			case 6: //Open In Website
			{
				OpenMOTDPanel(iClient, "", "http://xpmod.net/talents/survivors/ceda%20files/bill/xpmod_ig_talents_survivors_bill.html", MOTDPANEL_TYPE_URL);
				SupportMenuDraw(iClient);
			}
			case 8: //Back
			{
				TopSurvivorMenuDraw(iClient);
			}
		}
	}
}


//Inspirational Handler
InspirationalMenuHandler(Menu menu, MenuAction:action, iClient, itemNum)
{
	if (action == MenuAction_End)
	{
		delete menu;
	}
	else if (action == MenuAction_Select) 
	{
		switch (itemNum)
		{
			case 0: //Back
			{
				SupportMenuDraw(iClient);
			}
		}
	}
}

//Ghillie Tactics Menu Handler
GhillieMenuHandler(Menu menu, MenuAction:action, iClient, itemNum)
{
	if (action == MenuAction_End)
	{
		delete menu;
	}
	else if (action == MenuAction_Select)
	{
		switch (itemNum)
		{
            case 0: //Back
            {
				SupportMenuDraw(iClient);
            }
        }
    }
}


//Will to Live Handler
WillMenuHandler(Menu menu, MenuAction:action, iClient, itemNum)
{
	if (action == MenuAction_End)
	{
		delete menu;
	}
	else if (action == MenuAction_Select) 
	{
		switch (itemNum)
		{
			case 0: //Back
			{
				SupportMenuDraw(iClient);
			}
		}
	}
}


//Exorcism in a Barrel Handler
ExorcismMenuHandler(Menu menu, MenuAction:action, iClient, itemNum)
{
	if (action == MenuAction_End)
	{
		delete menu;
	}
	else if (action == MenuAction_Select)
	{
		switch (itemNum)
		{
			case 0: //Back
			{
				SupportMenuDraw(iClient);
			}
		}
	}
}

//Die Hard Handler
DiehardMenuHandler(Menu menu, MenuAction:action, iClient, itemNum)
{
	if (action == MenuAction_End)
	{
		delete menu;
	}
	else if (action == MenuAction_Select) 
	{
		switch (itemNum)
		{
			case 0: //Back
			{
				SupportMenuDraw(iClient);
			}
		}
	}
}

//Promotional Benefit Handler
PromotionalMenuHandler(Menu menu, MenuAction:action, iClient, itemNum)
{
	if (action == MenuAction_End)
	{
		delete menu;
	}
	else if (action == MenuAction_Select) 
	{
		switch (itemNum)
		{
			case 0: //Back
			{
				SupportMenuDraw(iClient);
			}
		}
	}
}