Action:AdminMenuDraw(iClient)
{
	CheckMenu(iClient);
	
	g_hMenu_XPM[iClient] = CreateMenu(AdminMenuHandler);
	SetMenuPagination(g_hMenu_XPM[iClient], MENU_NO_PAGINATION);
	SetMenuTitle(g_hMenu_XPM[iClient], "XPMod Admin Menu\n ");
	AddMenuItem(g_hMenu_XPM[iClient], "option1", "Switch Player's Team");
	AddMenuItem(g_hMenu_XPM[iClient], "option2", "Kick Player");
	AddMenuItem(g_hMenu_XPM[iClient], "option3", "Ban Player");
	AddMenuItem(g_hMenu_XPM[iClient], "option4", "Undo Griefing");
	AddMenuItem(g_hMenu_XPM[iClient], "option5", "", ITEMDRAW_NOTEXT);
	AddMenuItem(g_hMenu_XPM[iClient], "option6", "", ITEMDRAW_NOTEXT);
	AddMenuItem(g_hMenu_XPM[iClient], "option7", g_bGamePaused ? "Unpause Game": "Pause Game");
	AddMenuItem(g_hMenu_XPM[iClient], "option8", "", ITEMDRAW_NOTEXT);
	AddMenuItem(g_hMenu_XPM[iClient], "option9", "Back to Main Menu");
	SetMenuExitButton(g_hMenu_XPM[iClient], false);
	DisplayMenu(g_hMenu_XPM[iClient], iClient, MENU_TIME_FOREVER);

	return Plugin_Handled;
}

AdminMenuHandler(Handle:hmenu, MenuAction:action, iClient, itemNum)
{
	if(action==MenuAction_Select)
	{
		switch (itemNum)
		{
			case 0: //Switch Player Team
			{
				AdminMenuDraw(iClient);
			}
			case 1: //Kick Player
			{
				AdminMenuDraw(iClient);
			}
			case 2: //Ban Player
			{
				AdminMenuDraw(iClient);
			}
			case 3: //Undo Griefing
			{
				AdminMenuDraw(iClient);
			}
			case 6: //Pause Unpause Game
			{
				if (GetClientAdminLevel(iClient) > 0)
					ToggleGamePaused(iClient);
				
				AdminMenuDraw(iClient);
			}
			case 8: //Back to Main Menu
			{
				TopMenuDraw(iClient);
			}
		}
	}
}