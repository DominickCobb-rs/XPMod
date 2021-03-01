
ResetVariablesForMap(iClient)
{
	ResetTalentConfirmCountdown(iClient);
	
	g_iEllisMaxHealth[iClient] = 100;
	g_iNickMaxHealth[iClient] = 100;
	g_bTalentsGiven[iClient] = false;
	g_bPlayerInTeamChangeCoolDown[iClient] = false;
	g_fTimeStamp[iClient] = -1.0;
	g_iFastAttackingClientsArray[iClient] = -1;
	g_bDoesClientAttackFast[iClient] = false;
	g_iClientBindUses_1[iClient] = 0;
	g_iClientBindUses_2[iClient] = 0;
	g_iEllisSpeedBoostCounter[iClient] = 0;
	g_bIsFlyingWithJetpack[iClient] = false;
	g_iClientJetpackFuelUsed[iClient] = 0;
	g_bIsJetpackOn[iClient] = false;
	g_iCoachDecapitationCounter[iClient] = 0;
	g_iMeleeDamageCounter[iClient] = 0;
	g_bIsHighJumpCharged[iClient] = false;
	g_bIsWreckingBallCharged[iClient] = false;
	g_iExtraExplosiveUses[iClient] = 0;
	g_iBillSprintChargeCounter[iClient] = 0;
	g_bBillSprinting[iClient] = false;
	g_iSilentSorrowHeadshotCounter[iClient] = 0;
	g_bUsingFireStorm[iClient] = false;
	g_bUsingShadowNinja[iClient] = false;
	g_iStat_ClientInfectedKilled[iClient] = 0;
	g_iStat_ClientCommonKilled[iClient] = 0;
	g_iStat_ClientCommonHeadshots[iClient] = 0;
	g_iStat_ClientSurvivorsKilled[iClient] = 0;
	g_iStat_ClientSurvivorsIncaps[iClient] = 0;
	g_iStat_ClientDamageToSurvivors[iClient] = 0;
	g_bCanPlayHeadshotSound[iClient] = true;
	g_bUsingTongueRope[iClient]=false;
	g_iRopeCountDownTimer[iClient] = 0;
	canchangemovement[iClient]=true;
	g_bIsMovementTypeFly[iClient] = false;
	preledgehealth[iClient] = 1;
	g_bIsClientDown[iClient] = false;
	clienthanging[iClient] = false;
	g_iBillTeamHealCounter[iClient] = 0;
	g_iClientToHeal[iClient] = 1;
	g_bHunterGrappled[iClient] = false;
	g_bChargerGrappled[iClient] = false;
	g_iChargerVictim[iClient] = 0;
	g_bSmokerGrappled[iClient] = false;
	g_iNicksRamboWeaponID[iClient] = 0;
	g_bNickIsInvisible[iClient] = false;
	g_bCanDropPoopBomb[iClient] = true;
	g_bTankOnFire[iClient] = false;
	g_bShowingVGUI[iClient] = false;
	g_bExplosivesJustGiven[iClient] = false;
	g_iLaserUpgradeCounter[iClient] = 0;
	// Victim Health Meter
	g_bVictimHealthMeterActive[iClient] = false;
	g_iVictimHealthMeterWatchVictim[iClient] =  0;

	g_iInfectedCharacter[iClient] = UNKNOWN_INFECTED;
	RemoveAllEntitiesFromArrayList(g_listEnhancedCIEntities);
	g_bCanBeGhost[iClient] = true;
	g_bIsGhost[iClient] = false;
	g_iTankCounter = 0;
	g_bTankStartingHealthXPModSpawn = false;
	g_fTankStartingHealthMultiplier[iClient] = 1.0;
	RemoveAllEntitiesFromArrayList(g_listTankRockEntities);
	g_bAdhesiveGooActive[iClient] = false;
	
	g_bSomeoneAttacksFaster = false;
	
	//Bill
	gClone[iClient] = -1;
	
	//Rochelle
	g_bIsRochellePoisoned[iClient] = false;
	
	//Coach
	g_bShowingChargeHealParticle[iClient] = false;
	g_bCoachInCISpeed[iClient] = false;
	g_bCoachInSISpeed[iClient] = false;
	g_iCoachCIHeadshotCounter[iClient] = 0;
	g_iCoachSIHeadshotCounter[iClient] = 0;
	
	//Ellis
	g_bWalkAndUseToggler[iClient] = false;
	g_fEllisBringSpeed[iClient] = 0.0;
	g_fEllisOverSpeed[iClient] = 0.0;
	g_fEllisJamminSpeed[iClient] = 0.0;
	g_bEllisOverSpeedIncreased[iClient] = false;
	
	//Nick 
	g_bNickIsGettingBeatenUp[iClient] = false;
	g_iNickDesperateMeasuresStack = 0;

	//Louis
	g_bLouisTeleportCoolingDown[iClient] = false;
	g_bLouisTeleportActive[iClient] = false;
	g_iLouisTeleportChargeUses[iClient] = 0;
	g_iLouisCIHeadshotCounter[iClient] = 0;
	g_iLouisSIHeadshotCounter[iClient] = 0;
	
	//Infected Talents
	g_iInfectedConvarsSet[iClient] = false;
	
	//Smoker
	g_iChokingVictim[iClient] = -1;
	g_iMaxTongueLength = 0;
	g_iMaxDragSpeed = 0;
	g_bHasSmokersPoisonCloudOut[iClient] = false;
	g_bIsElectricuting[iClient] = false;
	g_bIsSmokeInfected[iClient] = false;
	g_iSmokerInfectionCloudEntity[iClient] = -1;
	g_bTeleportCoolingDown[iClient] = false;
	g_iSmokerTransparency[iClient] = 0;
	g_bElectricutionCooldown[iClient] = false;
	
	//Boomer
	g_bIsBoomerVomiting[iClient] = false;
	g_iVomitVictimAttacker[iClient] = 0;
	g_bIsServingHotMeal[iClient] = false;
	g_iVomitVictimCounter[iClient] = 0;
	g_iShowSurvivorVomitCounter[iClient] = 0;
	g_bIsSuicideBoomer[iClient] = false;
	g_bIsSuicideJumping[iClient] = false;
	g_bIsSurvivorVomiting[iClient] = false;
	g_bIsSuperSpeedBoomer[iClient] = false;

	//Hunter
	g_bIsCloakedHunter[iClient] = false;
	g_bCanHunterDismount[iClient] = true;
	g_bCanHunterPoisonVictim[iClient] = true;
	g_iHunterShreddingVictim[iClient] = -1;
	g_iHunterPounceDamageCharge[iClient] = 0;
	g_bIsHunterPoisoned[iClient] = false;
	
	//Jockey
	g_bCanJockeyPee[iClient] = true;
	g_bCanJockeyCloak[iClient] = true;
	g_bJockeyIsRiding[iClient] = false;
	g_iJockeyVictim[iClient] = -1;
	g_bCanJockeyJump[iClient] = false;
	g_fJockeyRideSpeed[iClient] = 1.0;
	g_fJockeyRideSpeedVanishingActBoost[iClient] = 0.0;
	
	//Spitter
	g_bBlockGooSwitching[iClient] = false;
	g_bJustSpawnedWitch[iClient] = false;
	g_bCanConjureWitch[iClient] = true;
	g_bHasDemiGravity[iClient] = false;
	g_bIsHallucinating[iClient] = false;
	g_iViralInfector[iClient] = 0;
	g_bIsImmuneToVirus[iClient] = false;
	g_iBagOfSpitsSelectedSpit[iClient] = BAG_OF_SPITS_NONE;
	g_bCanBePushedByRepulsion[iClient] = true;
	g_bIsStealthSpitter[iClient] = false;
	g_iStealthSpitterChargePower[iClient] =  0;
	g_iStealthSpitterChargeMana[iClient] =  0;
	g_xyzWitchConjureLocation[iClient][0] = 0.0;
	g_xyzWitchConjureLocation[iClient][1] = 0.0;
	g_xyzWitchConjureLocation[iClient][2] = 0.0;
	g_fAdhesiveAffectAmount[iClient] = 0.0;
	
	//Charger
	g_bCanChargerSuperCharge[iClient] = true;
	g_bIsSpikedCharged[iClient] = false;
	g_bCanChargerSpikedCharge[iClient] = true;
	g_bIsChargerCharging[iClient] = false;
	g_bIsHillbillyEarthquakeReady[iClient] = false;
	g_bIsSuperCharger[iClient] = false;
	g_bChargerCarrying[iClient] = false;
	g_bIsChargerHealing[iClient] = false;
	g_bCanChargerEarthquake[iClient] = true;
	
	//Tank
	g_fFireTankExtraSpeed[iClient] = 0.0;
	//g_bFireTankBaseSpeedIncreased[iClient] = false;
	
	ResetAllVariables(iClient);
	//Delete all the global timer handles at the end of the round
	DeleteAllGlobalTimerHandles(iClient);
	
	for(new j=1;j <= MaxClients;j++)
		g_bNickIsStealingLife[iClient][j] = false;
}

ResetAllVariables(iClient)
{
	g_iBanDurationInMinutes[iClient] = 0;
	g_bHunterGrappled[iClient] = false;
	g_bChargerGrappled[iClient] = false;
	g_bSmokerGrappled[iClient] = false;
	g_bUsingFireStorm[iClient] = false;
	g_bUsingTongueRope[iClient] = false;
	clienthanging[iClient] = false;
	g_bIsJetpackOn[iClient] = false;
	g_bIsFlyingWithJetpack[iClient] = false;
	g_bIsHighJumpCharged[iClient] = false;
	g_bIsWreckingBallCharged[iClient] = false;
	g_bIsMovementTypeFly[iClient] = false;
	g_iNicksRamboWeaponID[iClient] = 0;
	g_bUsingShadowNinja[iClient] = false;
	g_bBillSprinting[iClient] = false;
	g_iBillTeamHealCounter[iClient] = 0;
	g_bIsClientDown[iClient] = false;
	pop(iClient);
	g_bDoesClientAttackFast[iClient] = false;

	//Reset Tank (Needed here for changing teams)
	g_iTankChosen[iClient] = TANK_NOT_CHOSEN;
	ResetAllTankVariables(iClient);
}

DeleteAllGlobalTimerHandles(iClient)
{
	//delete g_hTimer_FreezeCountdown;
	delete g_hTimer_ShowingConfirmTalents[iClient];
	delete g_hTimer_VictimHealthMeterStop[iClient];
	delete g_hTimer_DrugPlayer[iClient];
	delete g_hTimer_HallucinatePlayer[iClient];
	delete g_hTimer_SlapPlayer[iClient];
	delete g_hTimer_RochellePoison[iClient];
	delete g_hTimer_HunterPoison[iClient];
	delete g_hTimer_NickLifeSteal[iClient];
	delete g_hTimer_BillDropBombs[iClient];
	delete g_hTimer_LouisTeleportRegenerate[iClient];
	delete g_hTimer_AdhesiveGooReset[iClient];
	delete g_hTimer_DemiGooReset[iClient];
	delete g_hTimer_ResetGlow[iClient];
	delete g_hTimer_ViralInfectionTick[iClient];
	delete g_hTimer_BlockGooSwitching[iClient];	
	delete g_hTimer_ExtinguishTank[iClient];
	delete g_hTimer_IceSphere[iClient];
	delete g_hTimer_WingDashChargeRegenerate[iClient];
}