file {
	grid="transistor15_fps.tdr"
	piezo="transistor15_fps.tdr"
	current="transistorOut15"
	plot="transistorOut15"
	output="transistorOut15"
	param="sdevice.par"
}

electrode {
    {name="Substrate" voltage=0}
    {name="Source" voltage=0}
    {name="Drain" voltage=0}
    {name="Gate" voltage=0}
}


Physics {
 Fermi
 EffectiveIntrinsicDensity(OldSlotboom )
}

Physics (material= "Silicon") {
  eQuantumPotential
  eMultiValley(MLDA kpDOS -Density)
  Mobility(
	Enormal ( IALMob( AutoOrientation ) Lombardi_highk )
	HighFieldSaturation( EparallelToInterface )
	)

  Piezo(
	Model(
  	DeformationPotential(ekp hkp minimum)
  	DOS( emass hmass )
 
  	Mobility( eSubband(Fermi  EffectiveMass Scattering(MLDA) )
   	eSaturationFactor= 0.0
  	)
	)
  

  Recombination(
	SRH(DopingDependence TempDependence)
  Auger
  Band2Band(Model=Schenk) )
}



Physics(Material="PolySilicon") {
 Mobility(
	PhuMob
	HighFieldSaturation( GradQuasiFermi )
	)
 
  Recombination(SRH(DopingDependence))
}

Physics(MaterialInterface="Oxide/Silicon"){
    Traps(Conc=1.e11 FixedCharge)
}

plot{
    eDensity hDensity eCurrent hCurrent
    Potential SpaceCharge ElectricField
    eMobility hMobility eVelocity hVelocity
    Doping DonorConcentration AcceptorConcentration
}

math{
    CoordinateSystem { AsIs }
    Number_of_threads=12
    Extrapolate
    RelErrControl
}
solve{
   Coupled(Iterations=100){ Poisson }
   Coupled{ Poisson Electron Hole }
   Quasistationary(
     InitialStep=0.01 MinStep=1e-10 MaxStep=0.2
     Goal{ Name="Drain" Voltage= 0.1 }
   ){ Coupled{ Poisson Electron Hole } }
   Quasistationary(
     InitialStep=1e-3 MinStep=1e-10 MaxStep=0.05 Increment=1.41 Decrement=2.
     Goal{ Name="Gate" Voltage= 1.5 }
   ){ Coupled{ Poisson Electron Hole } }

}


