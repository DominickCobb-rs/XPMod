//Coach Menu////////////////////////////////////////////////////////////////

//Coach Menu Draw
public Action:CoachMenuDraw(iClient)
{
	decl String:text[512];
	
	CheckMenu(iClient);
	
	DeleteAllMenuParticles(iClient);
	g_hMenu_XPM[iClient] = CreateMenu(CoachMenuHandler);
	SetMenuPagination(g_hMenu_XPM[iClient], MENU_NO_PAGINATION);
	
	FormatEx(text, sizeof(text), "Level %d   XP: %d/%d   Skill Points: %d\n=	=	=	=	=	=	=	=	=	=	=	=	=	=\n \n				Coach's Berserker Talents\n ", g_iClientLevel[iClient], g_iClientXP[iClient], g_iClientNextLevelXPAmount[iClient], g_iSkillPoints[iClient]);
	SetMenuTitle(g_hMenu_XPM[iClient], text);
	
	FormatEx(text, sizeof(text), "	[Level %d]	Bull Rush", g_iBullLevel[iClient]);
	AddMenuItem(g_hMenu_XPM[iClient], "option1", text);
	FormatEx(text, sizeof(text), "	[Level %d]	Wrecking Ball", g_iWreckingLevel[iClient]);
	AddMenuItem(g_hMenu_XPM[iClient], "option2", text);
	FormatEx(text, sizeof(text), "	[Level %d]	Spray n' Pray", g_iSprayLevel[iClient]);
	AddMenuItem(g_hMenu_XPM[iClient], "option3", text);
	FormatEx(text, sizeof(text), "	[Level %d]	Homerun!", g_iHomerunLevel[iClient]);
	AddMenuItem(g_hMenu_XPM[iClient], "option4", text);
	FormatEx(text, sizeof(text), "	[Level %d]	Lead by Example (Bind 1)", g_iLeadLevel[iClient]);
	AddMenuItem(g_hMenu_XPM[iClient], "option5", text);
	FormatEx(text, sizeof(text), "	[Level %d]	Strong Arm (Bind 2)\n ", g_iStrongLevel[iClient]);
	AddMenuItem(g_hMenu_XPM[iClient], "option6", text);
	
	AddMenuItem(g_hMenu_XPM[iClient], "option7", "Level Up All Talents\n ");
	
	AddMenuItem(g_hMenu_XPM[iClient], "option8", "Detailed Talent Descriptions\n ");
	
	AddMenuItem(g_hMenu_XPM[iClient], "option9", "Back\n \n=	=	=	=	=	=	=	=	=	=	=	=	=	=\n \n \n \n \n \n \n ");
	
	SetMenuExitButton(g_hMenu_XPM[iClient], false);
	DisplayMenu(g_hMenu_XPM[iClient], iClient, MENU_TIME_FOREVER);

	return Plugin_Handled;
}

//Level Up All Question for Coach
public Action:LevelUpAllCoachFunc(iClient) 
{
	CheckMenu(iClient);
	
	g_hMenu_XPM[iClient] = CreateMenu(LevelUpAllCoachHandler);
	
	SetMenuTitle(g_hMenu_XPM[iClient], "Are you sure you want to use all your skillpoints to level up talents for Coach?\n \n");
	AddMenuItem(g_hMenu_XPM[iClient], "option1", "Yes");
	AddMenuItem(g_hMenu_XPM[iClient], "option2", "No");
	SetMenuExitButton(g_hMenu_XPM[iClient], false);
	DisplayMenu(g_hMenu_XPM[iClient], iClient, MENU_TIME_FOREVER);

	return Plugin_Handled;
}

//Bull Rush
public Action:BullMenuDraw(iClient)
{
	decl String:text[512];
	
	CheckMenu(iClient);
	
	DeleteAllMenuParticles(iClient);
	if(g_bEnabledVGUI[iClient] == true && g_iClientTeam[iClient] == TEAM_SURVIVORS && IsPlayerAlive(iClient) == true)
	{
		g_iPID_MD_Coach_Bull[iClient] = WriteParticle(iClient, "md_coach_bull", 0.0);
		g_bShowingVGUI[iClient] =  true;
	}
	
	g_hMenu_XPM[iClient] = CreateMenu(BullMenuHandler);
	
	FormatEx(text, sizeof(text), "Level %d		Skill Points: %d\n=	=	=	=	=	=	=	=	=\n \n			Bull Rush(Level %d):\n \nLevel 1:\n+13 max health per level\nOn CI headshot with a melee weapon:\n+5%% speed per level for 3 seconds\n \n[WALK+USE] to rage! For 20 seconds:\n+4% speed per level\n+20 melee damage per level\nHealth regeneration\n60 second cooldown. During cooldown:\nCoach cannot regen or speed up\n \n=	=	=	=	=	=	=	=	=", g_iClientLevel[iClient], g_iSkillPoints[iClient], g_iBullLevel[iClient]);
	SetMenuTitle(g_hMenu_XPM[iClient], text);
	
	AddMenuItem(g_hMenu_XPM[iClient], "option1", "Level Up");
	AddMenuItem(g_hMenu_XPM[iClient], "option2", "Level Down");
	AddMenuItem(g_hMenu_XPM[iClient], "option3", "Back\n \n \n \n \n \n \n \n ");

	SetMenuExitButton(g_hMenu_XPM[iClient], false);
	DisplayMenu(g_hMenu_XPM[iClient], iClient, MENU_TIME_FOREVER);

	return Plugin_Handled;
}

//Wrecking Ball
public Action:WreckingMenuDraw(iClient) 
{
	decl String:text[512];
	
	CheckMenu(iClient);
	
	DeleteAllMenuParticles(iClient);
	if(g_bEnabledVGUI[iClient] == true && g_iClientTeam[iClient] == TEAM_SURVIVORS && IsPlayerAlive(iClient) == true)
	{
		g_iPID_MD_Coach_Wrecking[iClient] = WriteParticle(iClient, "md_coach_wrecking", 0.0);
		g_bShowingVGUI[iClient] =  true;
	}
	
	g_hMenu_XPM[iClient] = CreateMenu(WreckingMenuHandler);
	
	FormatEx(text, sizeof(text), "Level %d		Skill Points: %d\n=	=	=	=	=	=	=	=	=	=	=	=	=	=	=	=	=	=	=\n \n									Wrecking Ball(Level %d):\n \nLevel 1:\n(Charge) +100 melee damage per level\n+5 max health per level\n \nLevel 5:\nOn SI headshot w/ melee weapon && Wrecking Ball charged:\nInstantly recharge Wrecking Ball\n(Charge) +1 health regen every 0.75 seconds\n \n \nSkill Uses:\n(Charge) Melee damage bonus: Hold [CROUCH] to power up\n(Charge) Melee damage bonus expelled on next [MELEE] against SI\n(Charge) HP regen: Hold [CROUCH] to heal yourself\n \n=	=	=	=	=	=	=	=	=	=	=	=	=	=	=	=	=	=	=",g_iClientLevel[iClient], g_iSkillPoints[iClient], g_iWreckingLevel[iClient]);
	SetMenuTitle(g_hMenu_XPM[iClient], text);
	
	AddMenuItem(g_hMenu_XPM[iClient], "option1", "Level Up");
	AddMenuItem(g_hMenu_XPM[iClient], "option2", "Level Down");
	AddMenuItem(g_hMenu_XPM[iClient], "option3", "Back\n \n \n \n \n \n \n \n ");

	SetMenuExitButton(g_hMenu_XPM[iClient], false);
	DisplayMenu(g_hMenu_XPM[iClient], iClient, MENU_TIME_FOREVER);

	return Plugin_Handled;
}

//Spray n' Pray
public Action:SprayMenuDraw(iClient) 
{
	decl String:text[512];

	CheckMenu(iClient);
	
	DeleteAllMenuParticles(iClient);
	if(g_bEnabledVGUI[iClient] == true && g_iClientTeam[iClient] == TEAM_SURVIVORS && IsPlayerAlive(iClient) == true)
	{
		g_iPID_MD_Coach_Spray[iClient] = WriteParticle(iClient, "md_coach_spray", 0.0);
		g_bShowingVGUI[iClient] =  true;
	}
	
	g_hMenu_XPM[iClient] = CreateMenu(SprayMenuHandler);
	
	FormatEx(text, sizeof(text), "Level %d		Skill Points: %d\n=	=	=	=	=	=	=	=	=	=	=\n \n			Spray n' Pray(Level %d):\n \nLevel 1:\n+2 shotgun clip size per level\n+2 shotgun pellet damage per level\n \n=	=	=	=	=	=	=	=	=	=	=",g_iClientLevel[iClient], g_iSkillPoints[iClient], g_iSprayLevel[iClient]);
	SetMenuTitle(g_hMenu_XPM[iClient], text);
	
	AddMenuItem(g_hMenu_XPM[iClient], "option1", "Level Up");
	AddMenuItem(g_hMenu_XPM[iClient], "option2", "Level Down");
	AddMenuItem(g_hMenu_XPM[iClient], "option3", "Back\n \n \n \n \n \n \n \n ");

	SetMenuExitButton(g_hMenu_XPM[iClient], false);
	DisplayMenu(g_hMenu_XPM[iClient], iClient, MENU_TIME_FOREVER);

	return Plugin_Handled;
}

//Homerun
public Action:HomerunMenuDraw(iClient) 
{
	decl String:text[512];

	CheckMenu(iClient);
	
	DeleteAllMenuParticles(iClient);
	if(g_bEnabledVGUI[iClient] == true && g_iClientTeam[iClient] == TEAM_SURVIVORS && IsPlayerAlive(iClient) == true)
	{
		g_iPID_MD_Coach_Homerun[iClient] = WriteParticle(iClient, "md_coach_homerun", 0.0);
		g_bShowingVGUI[iClient] =  true;
	}
	
	g_hMenu_XPM[iClient] = CreateMenu(HomerunMenuHandler);
	
	FormatEx(text, sizeof(text), "Level %d		Skill Points: %d\n=	=	=	=	=	=	=	=	=	=	=\n \n				Homerun!(Level %d):\n \nLevel 1:\nOn SI headshot with melee weapon:\n+5%% speed per level for 6 seconds\n \n(Stacks) +2 melee damage per level\n \nLevel 5:\nNo melee fatigue\n \n \nSkill Uses:\n+1 (Stack) when decapitating infected\nMax 50 stacks\n \n=	=	=	=	=	=	=	=	=	=	=",g_iClientLevel[iClient], g_iSkillPoints[iClient], g_iHomerunLevel[iClient]);
	SetMenuTitle(g_hMenu_XPM[iClient], text);

	AddMenuItem(g_hMenu_XPM[iClient], "option1", "Level Up");
	AddMenuItem(g_hMenu_XPM[iClient], "option2", "Level Down");
	AddMenuItem(g_hMenu_XPM[iClient], "option3", "Back\n \n \n \n \n \n \n \n ");

	SetMenuExitButton(g_hMenu_XPM[iClient], false);
	DisplayMenu(g_hMenu_XPM[iClient], iClient, MENU_TIME_FOREVER);

	return Plugin_Handled;
}

//Lead by Example
public Action:LeadMenuDraw(iClient) 
{
	decl String:text[512];

	CheckMenu(iClient);
	
	DeleteAllMenuParticles(iClient);
	if(g_bEnabledVGUI[iClient] == true && g_iClientTeam[iClient] == TEAM_SURVIVORS && IsPlayerAlive(iClient) == true)
	{
		g_iPID_MD_Coach_Lead[iClient] = WriteParticle(iClient, "md_coach_lead", 0.0);
		g_bShowingVGUI[iClient] =  true;
	}
	
	g_hMenu_XPM[iClient] = CreateMenu(LeadMenuHandler);
	
	FormatEx(text, sizeof(text), "Level %d		Skill Points: %d\n=	=	=	=	=	=	=	=	=	=	=	=	=\n \n				Lead by Example(Level %d):\n					Requires Level 11\n \nLevel 1:\n(Team) +10%%%% chainsaw fuel per level\n(Stacks) (Team) +4 max health per level\n \nLevel 5:\n(Team) Prevent screen shaking on damage\n \n \n				 Bind 1: Heavy Gunner\n				+1 use every other level\n \nLevel 1:\nDeploy Turrets\n \n \nSkill Uses:\n(Team) max health (Stacks) with itself\n \n=	=	=	=	=	=	=	=	=	=	=	=	=",g_iClientLevel[iClient], g_iSkillPoints[iClient], g_iLeadLevel[iClient]);
	SetMenuTitle(g_hMenu_XPM[iClient], text);
	
	AddMenuItem(g_hMenu_XPM[iClient], "option1", "Level Up");
	AddMenuItem(g_hMenu_XPM[iClient], "option2", "Level Down");
	AddMenuItem(g_hMenu_XPM[iClient], "option3", "Back\n \n \n \n \n \n \n \n ");
	
	SetMenuExitButton(g_hMenu_XPM[iClient], false);
	DisplayMenu(g_hMenu_XPM[iClient], iClient, MENU_TIME_FOREVER);

	return Plugin_Handled;
}

//Strong Arm
public Action:StrongMenuDraw(iClient) 
{
	decl String:text[512];

	CheckMenu(iClient);
	
	DeleteAllMenuParticles(iClient);
	if(g_bEnabledVGUI[iClient] == true && g_iClientTeam[iClient] == TEAM_SURVIVORS && IsPlayerAlive(iClient) == true)
	{
		g_iPID_MD_Coach_Strong[iClient] = WriteParticle(iClient, "md_coach_strong", 0.0);
		g_bShowingVGUI[iClient] =  true;
	}
	
	g_hMenu_XPM[iClient] = CreateMenu(StrongMenuHandler);
	
	FormatEx(text, sizeof(text), "Level %d		Skill Points: %d\n=	=	=	=	=	=	=	=	=	=	=	=	=	=\n \n					Strong Arm(Level %d):\n					 Requires Level 26\n \nLevel 1:\n+30 melee damage per level\n+8 max health per level\n+20%%%% Jockey resistance per level\nStart the round with grenades\n \nLevel 2:\n+1 bomb storage every other level\n[WALK+ZOOM] to cycle grenades\n \n \n			Bind 2: D.E.A.D. Jetpack (Charge)\n						Limited Fuel\n \nLevel 1:\n+160 fuel per level\n \n \nSkill Uses:\n(Charge): Hold [WALK] to fly when jetpack is on\n \n=	=	=	=	=	=	=	=	=	=	=	=	=	=",g_iClientLevel[iClient], g_iSkillPoints[iClient], g_iStrongLevel[iClient]);
	SetMenuTitle(g_hMenu_XPM[iClient], text);
	
	AddMenuItem(g_hMenu_XPM[iClient], "option1", "Level Up");
	AddMenuItem(g_hMenu_XPM[iClient], "option2", "Level Down");
	AddMenuItem(g_hMenu_XPM[iClient], "option3", "Back\n \n \n \n \n \n \n \n ");
	
	SetMenuExitButton(g_hMenu_XPM[iClient], false);
	DisplayMenu(g_hMenu_XPM[iClient], iClient, MENU_TIME_FOREVER);

	return Plugin_Handled;
}

//Handlers//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Level Up All for Coach
public LevelUpAllCoachHandler(Handle:hmenu, MenuAction:action, iClient, itemNum)
{
	if(action==MenuAction_Select) 
	{
		switch (itemNum)
		{
			case 0: //Yes
			{
				LevelUpAllCoach(iClient);
			}
			case 1: //No
			{
				CoachMenuDraw(iClient);
			}
		}
	}
}


LevelUpAllCoach(iClient)
{
	if(g_iChosenSurvivor[iClient] != 2)
		g_iChosenSurvivor[iClient] = 2;
	ResetSkillPoints(iClient,iClient);
	if(g_iSkillPoints[iClient]>0)
	{
		if(g_iSkillPoints[iClient] > 4)
		{
			g_iSkillPoints[iClient] -= 5;
			g_iBullLevel[iClient] += 5;
		}
		else
		{
			g_iBullLevel[iClient] += g_iSkillPoints[iClient];
			g_iSkillPoints[iClient] = 0;
		}
		if(g_iSkillPoints[iClient] > 4)
		{
			g_iSkillPoints[iClient] -= 5;
			g_iWreckingLevel[iClient] += 5;
		}
		else
		{
			g_iWreckingLevel[iClient] += g_iSkillPoints[iClient];
			g_iSkillPoints[iClient] = 0;
		}
		if(g_iSkillPoints[iClient] > 4)
		{
			g_iSkillPoints[iClient] -= 5;
			g_iSprayLevel[iClient] += 5;
		}
		else
		{
			g_iSprayLevel[iClient] += g_iSkillPoints[iClient];
			g_iSkillPoints[iClient] = 0;
		}
		if(g_iSkillPoints[iClient] > 4)
		{
			g_iSkillPoints[iClient] -= 5;
			g_iHomerunLevel[iClient] += 5;
		}
		else
		{
			g_iHomerunLevel[iClient] += g_iSkillPoints[iClient];
			g_iSkillPoints[iClient] = 0;
		}
		if(g_iSkillPoints[iClient] > 4)
		{
			g_iSkillPoints[iClient] -= 5;
			g_iLeadLevel[iClient] += 5;
		}
		else
		{
			g_iLeadLevel[iClient] += g_iSkillPoints[iClient];
			g_iSkillPoints[iClient] = 0;
		}
		if(g_iSkillPoints[iClient] > 4)
		{
			g_iSkillPoints[iClient] -= 5;
			g_iStrongLevel[iClient] += 5;
		}
		else
		{
			g_iStrongLevel[iClient] += g_iSkillPoints[iClient];
			g_iSkillPoints[iClient] = 0;
		}
		PrintToChat(iClient, "\x03[XPMod] \x01All your skillpoints have been assigned to Coach.");
	}
	else
		PrintToChat(iClient, "\x03[XPMod] \x01You dont have any skillpoints.");
		
	CoachMenuDraw(iClient);
}

//Nick Menu Handler
public CoachMenuHandler(Handle:hmenu, MenuAction:action, iClient, itemNum)
{
	if(action==MenuAction_Select) 
	{
		switch (itemNum)
		{
			case 0: //Bull Rush
			{
				BullMenuDraw(iClient);
			}
			case 1: //Wrecking Ball
			{
				WreckingMenuDraw(iClient);
			}
			case 2: //Spray n' Pray
			{
				SprayMenuDraw(iClient);
			}
			case 3: //Homerun
			{
				HomerunMenuDraw(iClient);
			}
			case 4: //Lead by Example
			{
				LeadMenuDraw(iClient);
			}
			case 5: //Strong Arm
			{
				StrongMenuDraw(iClient);
			}
			case 6: //Level Up All
			{

				if(g_bTalentsConfirmed[iClient] == false || g_iChosenSurvivor[iClient] == COACH)
					LevelUpAllCoachFunc(iClient);
				else
				{
					CoachMenuDraw(iClient);
					PrintToChat(iClient, "\x03[XPMod] \x05You cannot change your character after confirming it for the round."); 
				}
			}
			case 7: //Detailed Talent Descriptions
			{
				OpenMOTDPanel(iClient, "", "http://xpmod.net/talents/survivors/ceda%20files/coach/xpmod_ig_talents_survivors_coach.html", MOTDPANEL_TYPE_URL);
				CoachMenuDraw(iClient);
			}
			case 8: //Back
			{
				ClassMenuDraw(iClient);
			}
		}
	}
}

//Bull Training Handler
public BullMenuHandler(Handle:hmenu, MenuAction:action, iClient, itemNum)
{
	if (action==MenuAction_Select ) 
	{
		switch(itemNum)
		{
			case 0: //Level up
			{
				if(g_bTalentsConfirmed[iClient] == false || g_iChosenSurvivor[iClient] == COACH)
				{
					if(g_iChosenSurvivor[iClient] == COACH)
					{
						if(g_iSkillPoints[iClient]>0)
						{
							if(g_iBullLevel[iClient] <=4)
							{
								g_iSkillPoints[iClient]--;
								g_iBullLevel[iClient]++;
							}
							else
								PrintToChat(iClient, "\x03[XPMod] This talent is already maxed out.");
						}
						else
								PrintToChat(iClient, "\x03[XPMod] No skill points remaining.");
						BullMenuDraw(iClient);
					}
					else
					{
						ChangeChar(iClient, 2);
						PrintToChat(iClient, "\x03[XPMod] You dont have Coach selected.");
					}
				}
				else
				{
					BullMenuDraw(iClient);
					PrintToChat(iClient, "\x03[XPMod] \x05You cannot change your character after confirming it for the round."); 
				}
			}
			case 1: //Drop Level
			{
				if(g_iChosenSurvivor[iClient] == COACH)
				{
					if(g_iBullLevel[iClient]>0)
					{
						if(g_bTalentsConfirmed[iClient] == false)
						{
							g_iSkillPoints[iClient]++;
							g_iBullLevel[iClient]--;
						}
						else
							PrintToChat(iClient, "\x03[XPMod] \x05You cannot drop any levels after confirming your talents for the round."); 
					}
					else
						PrintToChat(iClient, "\x03[XPMod] This talent level is already at zero.");
				}
				else
					PrintToChat(iClient, "\x03[XPMod] You don't have Coach selected.");
				
				BullMenuDraw(iClient);
			}
			case 2: //Back
			{
				CoachMenuDraw(iClient);
			}
		}
	}
}

//Wrecking Ball Handler
public WreckingMenuHandler(Handle:hmenu, MenuAction:action, iClient, itemNum)
{
	if (action==MenuAction_Select ) 
	{
		switch(itemNum)
		{
			case 0: //Level up
			{
				if(g_bTalentsConfirmed[iClient] == false || g_iChosenSurvivor[iClient] == COACH)
				{
					if(g_iChosenSurvivor[iClient] == COACH)
					{
						if(g_iSkillPoints[iClient]>0)
						{
							if(g_iWreckingLevel[iClient] <=4)
							{
								g_iSkillPoints[iClient]--;
								g_iWreckingLevel[iClient]++;
							}
							else
								PrintToChat(iClient, "\x03[XPMod] This talent is already maxed out.");
						}
						else
								PrintToChat(iClient, "\x03[XPMod] No skill points remaining.");
						WreckingMenuDraw(iClient);
					}
					else
					{
						ChangeChar(iClient, 2);
						PrintToChat(iClient, "\x03[XPMod] You dont have Coach selected.");
					}
				}
				else
				{
					WreckingMenuDraw(iClient);
					PrintToChat(iClient, "\x03[XPMod] \x05You cannot change your character after confirming it for the round."); 
				}
			}
			case 1: //Drop Level
			{
				if(g_iChosenSurvivor[iClient] == COACH)
				{
					if(g_iWreckingLevel[iClient]>0)
					{
						if(g_bTalentsConfirmed[iClient] == false)
						{
							g_iSkillPoints[iClient]++;
							g_iWreckingLevel[iClient]--;
						}
						else
							PrintToChat(iClient, "\x03[XPMod] \x05You cannot drop any levels after confirming your talents for the round."); 
					}
					else
						PrintToChat(iClient, "\x03[XPMod] This talent level is already at zero.");
				}
				else
					PrintToChat(iClient, "\x03[XPMod] You don't have Coach selected.");
				
				WreckingMenuDraw(iClient);
			}
			case 2: //Back
			{
				CoachMenuDraw(iClient);
			}
		}
	}
}

//Spray n' Pray Handler
public SprayMenuHandler(Handle:hmenu, MenuAction:action, iClient, itemNum)
{
	if (action==MenuAction_Select ) 
	{
		switch(itemNum)
		{
			case 0: //Level up
			{
				if(g_bTalentsConfirmed[iClient] == false || g_iChosenSurvivor[iClient] == COACH)
				{
					if(g_iChosenSurvivor[iClient] == COACH)
					{
						if(g_iSkillPoints[iClient]>0)
						{
							if(g_iSprayLevel[iClient] <=4)
							{
								g_iSkillPoints[iClient]--;
								g_iSprayLevel[iClient]++;
							}
							else
								PrintToChat(iClient, "\x03[XPMod] This talent is already maxed out.");
						}
						else
							PrintToChat(iClient, "\x03[XPMod] No skill points remaining.");
						SprayMenuDraw(iClient);
					}
					else
					{
						ChangeChar(iClient, 2);
						PrintToChat(iClient, "\x03[XPMod] You dont have Coach selected.");
					}
				}
				else
				{
					SprayMenuDraw(iClient);
					PrintToChat(iClient, "\x03[XPMod] \x05You cannot change your character after confirming it for the round."); 
				}
			}
			case 1: //Drop Level
			{
				if(g_iChosenSurvivor[iClient] == COACH)
				{
					if(g_iSprayLevel[iClient]>0)
					{
						if(g_bTalentsConfirmed[iClient] == false)
						{
							g_iSkillPoints[iClient]++;
							g_iSprayLevel[iClient]--;
						}
						else
							PrintToChat(iClient, "\x03[XPMod] \x05You cannot drop any levels after confirming your talents for the round."); 
					}
					else
						PrintToChat(iClient, "\x03[XPMod] This talent level is already at zero.");
				}
				else
					PrintToChat(iClient, "\x03[XPMod] You don't have Coach selected.");
				
				SprayMenuDraw(iClient);
			}
			case 2: //Back
			{
				CoachMenuDraw(iClient);
			}
		}
	}
}

//Homerun Handler
public HomerunMenuHandler(Handle:hmenu, MenuAction:action, iClient, itemNum)
{
	if (action==MenuAction_Select ) 
	{
		switch(itemNum)
		{
			case 0: //Level up
			{
				if(g_bTalentsConfirmed[iClient] == false || g_iChosenSurvivor[iClient] == COACH)
				{
					if(g_iChosenSurvivor[iClient] == COACH)
					{
						if(g_iSkillPoints[iClient]>0)
						{
							if(g_iHomerunLevel[iClient] <=4)
							{
								g_iSkillPoints[iClient]--;
								g_iHomerunLevel[iClient]++;
							}
							else
								PrintToChat(iClient, "\x03[XPMod] This talent is already maxed out.");
						}
						else
								PrintToChat(iClient, "\x03[XPMod] No skill points remaining.");
						HomerunMenuDraw(iClient);
					}
					else
					{
						ChangeChar(iClient, 2);
						PrintToChat(iClient, "\x03[XPMod] You dont have Coach selected.");
					}
				}
				else
				{
					HomerunMenuDraw(iClient);
					PrintToChat(iClient, "\x03[XPMod] \x05You cannot change your character after confirming it for the round."); 
				}
			}
			case 1: //Drop Level
			{
				if(g_iChosenSurvivor[iClient] == COACH)
				{
					if(g_iHomerunLevel[iClient]>0)
					{
						if(g_bTalentsConfirmed[iClient] == false)
						{
							g_iSkillPoints[iClient]++;
							g_iHomerunLevel[iClient]--;
						}
						else
							PrintToChat(iClient, "\x03[XPMod] \x05You cannot drop any levels after confirming your talents for the round."); 
					}
					else
						PrintToChat(iClient, "\x03[XPMod] This talent level is already at zero.");
				}
				else
					PrintToChat(iClient, "\x03[XPMod] You don't have Coach selected.");
				
				HomerunMenuDraw(iClient);
			}
			case 2: //Back
			{
				CoachMenuDraw(iClient);
			}
		}
	}
}

//Lead by Example Handler
public LeadMenuHandler(Handle:hmenu, MenuAction:action, iClient, itemNum)
{
	if (action==MenuAction_Select ) 
	{
		switch(itemNum)
		{
			case 0: //Level up
			{
				if(g_bTalentsConfirmed[iClient] == false || g_iChosenSurvivor[iClient] == COACH)
				{
					if(g_iChosenSurvivor[iClient] == COACH)
					{
						if(g_iSkillPoints[iClient]>0)
						{
							if(g_iLeadLevel[iClient] <=4)
							{
								if(g_iClientLevel[iClient] > 10 + g_iLeadLevel[iClient])
								{
									g_iSkillPoints[iClient]--;
									g_iLeadLevel[iClient]++;
								}
								else
									PrintToChat(iClient, "\x03[XPMod] \x05You must be \x04level %d \x05to level up this talent.", (11 + g_iLeadLevel[iClient]));
							}
							else
								PrintToChat(iClient, "\x03[XPMod] This talent is already maxed out.");
						}
						else
								PrintToChat(iClient, "\x03[XPMod] No skill points remaining.");
						LeadMenuDraw(iClient);
					}
					else
					{
						ChangeChar(iClient, 2);
						PrintToChat(iClient, "\x03[XPMod] You dont have Coach selected.");
					}
				}
				else
				{
					LeadMenuDraw(iClient);
					PrintToChat(iClient, "\x03[XPMod] \x05You cannot change your character after confirming it for the round."); 
				}
			}
			case 1: //Drop Level
			{
				if(g_iChosenSurvivor[iClient] == COACH)
				{
					if(g_iLeadLevel[iClient]>0)
					{
						if(g_bTalentsConfirmed[iClient] == false)
						{
							g_iSkillPoints[iClient]++;
							g_iLeadLevel[iClient]--;
						}
						else
							PrintToChat(iClient, "\x03[XPMod] \x05You cannot drop any levels after confirming your talents for the round."); 
					}
					else
						PrintToChat(iClient, "\x03[XPMod] This talent level is already at zero.");
				}
				else
					PrintToChat(iClient, "\x03[XPMod] You don't have Coach selected.");
				
				LeadMenuDraw(iClient);
			}
			case 2: //Back
			{
				CoachMenuDraw(iClient);
			}
		}
	}
}

//Strong Arm Handler
public StrongMenuHandler(Handle:hmenu, MenuAction:action, iClient, itemNum)
{
	if (action==MenuAction_Select ) 
	{
		switch(itemNum)
		{
			case 0: //Level up
			{
				if(g_bTalentsConfirmed[iClient] == false || g_iChosenSurvivor[iClient] == COACH)
				{
					if(g_iChosenSurvivor[iClient] == COACH)
					{
						if(g_iSkillPoints[iClient]>0)
						{
							if(g_iStrongLevel[iClient] <=4)
							{
								if(g_iClientLevel[iClient] > 25 + g_iDiehardLevel[iClient])
								{
									g_iSkillPoints[iClient]--;
									g_iStrongLevel[iClient]++;
								}
								else
									PrintToChat(iClient, "\x03[XPMod] \x05You must be \x04level %d \x05to level up this talent.", (26 + g_iStrongLevel[iClient]));
							}
							else
								PrintToChat(iClient, "\x03[XPMod] This talent is already maxed out.");
						}
						else
								PrintToChat(iClient, "\x03[XPMod] No skill points remaining.");
						StrongMenuDraw(iClient);
					}
					else
					{
						ChangeChar(iClient, 2);
						PrintToChat(iClient, "\x03[XPMod] You dont have Coach selected.");
					}
				}
				else
				{
					StrongMenuDraw(iClient);
					PrintToChat(iClient, "\x03[XPMod] \x05You cannot change your character after confirming it for the round."); 
				}
			}
			case 1: //Drop Level
			{
				if(g_iChosenSurvivor[iClient] == COACH)
				{
					if(g_iStrongLevel[iClient]>0)
					{
						if(g_bTalentsConfirmed[iClient] == false)
						{
							g_iSkillPoints[iClient]++;
							g_iStrongLevel[iClient]--;
						}
						else
							PrintToChat(iClient, "\x03[XPMod] \x05You cannot drop any levels after confirming your talents for the round."); 
					}
					else
						PrintToChat(iClient, "\x03[XPMod] This talent level is already at zero.");
				}
				else
					PrintToChat(iClient, "\x03[XPMod] You don't have Coach selected.");
				
				StrongMenuDraw(iClient);
			}
			case 2: //Back
			{
				CoachMenuDraw(iClient);
			}
		}
	}
}