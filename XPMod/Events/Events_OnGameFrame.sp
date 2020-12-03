/**************************************************************************************************************************
 *                                                    On Game Frame                                                       *
 **************************************************************************************************************************/
 
public OnGameFrame()
{
	if (IsServerProcessing() == false)
		return;
	
	for(new iClient=1;iClient < MaxClients; iClient++)
	{		
		if(IsClientInGame(iClient)==false) continue;
		if(IsFakeClient(iClient)==true) continue;
		if(IsPlayerAlive(iClient)==false) continue;

		// Survivors
		if(g_iClientTeam[iClient] == TEAM_SURVIVORS)		
		{			
			if(g_bIsSmokeInfected[iClient] == true)
			{
				if(IsValidEntity(g_iSmokerInfectionCloudEntity[iClient]))
				{
					decl String:entclass[16];
					GetEntityNetClass(g_iSmokerInfectionCloudEntity[iClient], entclass, 16);
					if(StrEqual(entclass,"CSmokeStack",true) == true)
					{
						if(g_bIsSmokeEntityOff == true)
						{
							//DispatchKeyValue(g_iSmokerInfectionCloudEntity[iClient],"Rate", "30");
							decl Float:vorigin[3], Float:vangles[3], Float:vdir[3];
							GetClientEyeAngles(iClient, vangles);	//Get clients Eye Angles to know get what direction to spawn gun
							GetAngleVectors(vangles, vdir, NULL_VECTOR, NULL_VECTOR);	//Get the direction the iClient is looking
							vangles[0] = 0.0;		//Lock x and z axis
							vangles[2] = 0.0;
							GetClientEyePosition(iClient, vorigin);	//Get clients location origin vectors
							vorigin[0] += (vdir[0] * 1.0);		//Place the minigun infront of the players view
							vorigin[1] += (vdir[1] * 1.0);
							vorigin[2] -= 25.0;
							//vorigin[2] += vdir[2] + 1.0;			//Raise it up slightly to prevent glitches
							
							TeleportEntity(g_iSmokerInfectionCloudEntity[iClient], vorigin, NULL_VECTOR, NULL_VECTOR);
							
							AcceptEntityInput(g_iSmokerInfectionCloudEntity[iClient], "TurnOn");
							g_bIsSmokeEntityOff =  false;
						}
						else
						{
							//DispatchKeyValue(g_iSmokerInfectionCloudEntity[iClient],"Rate", "0");
							decl Float:vorigin[3], Float:vangles[3], Float:vdir[3];
							GetClientEyeAngles(iClient, vangles);	//Get clients Eye Angles to know get what direction to spawn gun
							GetAngleVectors(vangles, vdir, NULL_VECTOR, NULL_VECTOR);	//Get the direction the iClient is looking
							vangles[0] = 0.0;		//Lock x and z axis
							vangles[2] = 0.0;
							GetClientEyePosition(iClient, vorigin);	//Get clients location origin vectors
							vorigin[0] += (vdir[0] * 100.0);		//Place the minigun infront of the players view
							vorigin[1] += (vdir[1] * 100.0);
							vorigin[2] -= 25.0;
							//vorigin[2] += vdir[2] + 1.0;			//Raise it up slightly to prevent glitches
							
							TeleportEntity(g_iSmokerInfectionCloudEntity[iClient], vorigin, NULL_VECTOR, NULL_VECTOR);
							AcceptEntityInput(g_iSmokerInfectionCloudEntity[iClient], "TurnOff");
							g_bIsSmokeEntityOff = true;
						}
					}
				}
			}
			
			if(g_bIsSurvivorVomiting[iClient] == true)
			{
				new victim = GetClientAimTarget(iClient, true);
				if(victim > 0)
				{
					if(IsClientInGame(victim))
						if(IsPlayerAlive(victim))
							if(g_iClientTeam[victim] == TEAM_SURVIVORS)
							{
								decl Float:clientVec[3],Float:victimVec[3];
								GetClientEyePosition(iClient, clientVec);
								GetClientEyePosition(victim, victimVec);
								if(GetVectorDistance(clientVec, victimVec) <= 310.0)
									if(g_bIsSurvivorVomiting[victim] == false)
									{
										SDKCall(g_hSDK_VomitOnPlayer, victim, iClient, true);
										CreateParticle("boomer_vomit", 2.0, victim, ATTACH_MOUTH, true);
										g_bIsSurvivorVomiting[victim] = true;
										g_iShowSurvivorVomitCounter[victim] = 3;
										CreateTimer(1.0, TimerConstantVomitDisplay, victim, TIMER_FLAG_NO_MAPCHANGE);
									}
							}
				}
			}
			
			if(g_bGameFrozen == true)
			{
				// Stop frozen player from using health items
				new weapon = GetEntDataEnt2(iClient,g_iOffset_ActiveWeapon);
				if(weapon > 0)
				{
					decl String:wclass[32];
					GetEntityNetClass(weapon,wclass,32);
					if((StrEqual(wclass,"CPainPills",false)==true) || (StrEqual(wclass,"CFirstAidKit",false)==true) || (StrEqual(wclass,"CItemDefibrillator",false)==true) || (StrEqual(wclass,"CItem_Adrenaline",false)==true))
					{
						ClientCommand(iClient, "slot0");
						ClientCommand(iClient, "slot2");
						PrintToChat(iClient, "\x03[XPMod]\x05 You cannot use health items when frozen");
					}
				}
			}
			
			// Handle Survivor On Game Frame Talents
			switch(g_iChosenSurvivor[iClient])
			{
				case BILL:		OnGameFrame_Bill(iClient);
				case ROCHELLE:	OnGameFrame_Rochelle(iClient);
				case COACH:		OnGameFrame_Coach(iClient);
				case ELLIS:		OnGameFrame_Ellis(iClient);
				case NICK:		OnGameFrame_Nick(iClient);
			}

			// OnGameFrame Reloads
			if(g_bClientIsReloading[iClient] == true)
			{
				g_iReloadFrameCounter[iClient]++;
				//PrintToChatAll("Frame counter %d", g_iReloadFrameCounter[iClient]);

				decl String:strCurrentWeapon[32];
				GetClientWeapon(iClient, strCurrentWeapon, sizeof(strCurrentWeapon));
				//PrintToChatAll("Current Weapon is %s", currentweapon);

				new iActiveWeaponID = GetEntDataEnt2(iClient, g_iOffset_ActiveWeapon);
				new iCurrentClipAmmo = 0;
				if (IsValidEntity(iActiveWeaponID))
					iCurrentClipAmmo = GetEntProp(iActiveWeaponID,Prop_Data,"m_iClip1");
				new iOffset_Ammo = FindDataMapInfo(iClient,"m_iAmmo");
				
				switch(g_iChosenSurvivor[iClient])
				{
					case BILL:		OGFSurvivorReload_Bill(iClient, strCurrentWeapon, iActiveWeaponID, iCurrentClipAmmo, iOffset_Ammo);
					case ROCHELLE:	OGFSurvivorReload_Rochelle(iClient, strCurrentWeapon, iActiveWeaponID, iCurrentClipAmmo, iOffset_Ammo);
					case COACH:		OGFSurvivorReload_Coach(iClient, strCurrentWeapon, iActiveWeaponID, iCurrentClipAmmo, iOffset_Ammo);
					case ELLIS:		OGFSurvivorReload_Ellis(iClient, strCurrentWeapon, iActiveWeaponID, iCurrentClipAmmo, iOffset_Ammo);
					case NICK:		OGFSurvivorReload_Nick(iClient, strCurrentWeapon, iActiveWeaponID, iCurrentClipAmmo);
				}

				if(g_iReloadFrameCounter[iClient] == 300)
				{
					g_bClientIsReloading[iClient] = false;
					g_iReloadFrameCounter[iClient] = 0;
					g_bCoachShotgunForceReload[iClient] = false;
				}
			}
		}
		// Infected
		else if(g_iClientTeam[iClient] == TEAM_INFECTED)
		{
			//Check if they are ghost first
			if(GetEntData(iClient, g_iOffset_IsGhost, 1) == 1)	
				continue;
			
			switch(g_iInfectedCharacter[iClient])
			{
				case SMOKER:	OnGameFrame_Smoker(iClient);
				case BOOMER:	OnGameFrame_Boomer(iClient);
				case HUNTER:	OnGameFrame_Hunter(iClient);
				case SPITTER:	OnGameFrame_Spitter(iClient);
				case JOCKEY:	OnGameFrame_Jockey(iClient);
				case CHARGER:	OnGameFrame_Charger(iClient);
				case TANK:		OnGameFrame_Tank(iClient);
			}
		}
	}
	
	//For faster shooting and melee attacks
	if (g_bSomeoneAttacksFaster == true)
		HandleFastAttackingClients();
}

HandleFastAttackingClients()
{
	new looper = 0; 
	while(g_iFastAttackingClientsArray[looper] != -1)
	{
		new iClient = g_iFastAttackingClientsArray[looper];
		if(g_bDoesClientAttackFast[iClient] == false || IsClientInGame(iClient)==false || IsFakeClient(iClient)==true)
		{
			pop(iClient, 1);
			continue;
		}
		
		looper++;

		g_fGameTime = GetGameTime();
		new iActiveWeapon = GetEntDataEnt2(iClient,g_iOffset_ActiveWeapon);

		if(iActiveWeapon == -1)
			continue;
		
		flNextTime_ret = GetEntDataFloat(iActiveWeapon,g_iOffset_NextPrimaryAttack);
		
		flNextTime2_ret = GetEntDataFloat(iActiveWeapon,g_iOffset_NextSecondaryAttack);
		
		if (g_iDTEntid[iClient] == iActiveWeapon && g_flDTNextTime[iClient] >= flNextTime_ret) continue;
		
		if(g_iMetalLevel[iClient] > 0)
			if (flNextTime2_ret > g_fGameTime) continue;
					
		if(g_bFirstShadowNinjaSwing[iClient] == false)
			if(g_iShadowLevel[iClient] > 0)
				if (flNextTime2_ret < g_fGameTime) continue;
		
		if (g_iDTEntid[iClient] == iActiveWeapon && g_flDTNextTime[iClient] < flNextTime_ret)
		{
			if((g_iMetalLevel[iClient] > 0) && (g_bIsEllisLimitBreaking[iClient] == false))		//For Ellis's firerate
			{
				flNextTime_calc = ( flNextTime_ret - g_fGameTime ) * (1.0 - (0.5 * g_fEllisFireRate[iClient] * (g_iMetalLevel[iClient] * 0.08 + g_iFireLevel[iClient] * 0.12))) + g_fGameTime;
			}
			else if(g_bIsEllisLimitBreaking[iClient] == true)		//For Ellis's firerate
			{
				flNextTime_calc = ( flNextTime_ret - g_fGameTime ) * (1.0 - (0.75)) + g_fGameTime;
			}
			
			if(g_iShadowLevel[iClient] > 0)	//For Rochelles ninja mode
			{
				if(g_bFirstShadowNinjaSwing[iClient])	//This makes it work on the first swing
				{
					g_bFirstShadowNinjaSwing[iClient] = false;
					flNextTime_calc = g_fGameTime;
				}
				else
					flNextTime_calc = ( flNextTime_ret - g_fGameTime ) * (1.0 - (g_iShadowLevel[iClient] * 0.1))  + g_fGameTime;
				
				WriteParticle(iClient, "rochelle_silhouette", 0.0, 0.4);
			}
			
			g_flDTNextTime[iClient] = flNextTime_calc;
			
			SetEntDataFloat(iActiveWeapon, g_iOffset_NextPrimaryAttack, flNextTime_calc, true);
			continue;
		}
		
		if (g_iDTEntid[iClient] != iActiveWeapon)
		{
			g_iDTEntid[iClient] = iActiveWeapon;
			g_flDTNextTime[iClient] = flNextTime_ret;
			continue;
		}
	}
}