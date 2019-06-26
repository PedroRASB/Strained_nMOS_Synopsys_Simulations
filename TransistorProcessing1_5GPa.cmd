math coord.ucs

# mesh
line y location= 0.0<um>   spacing= 0.25<um>   tag= mid
line y location= 1.8<um>   spacing= 0.01<um>
line y location= 3.0<um>   spacing= 0.01<um>
line y location= 4.0<um>   spacing= 0.2<um> 
line y location= 6.0<um>   spacing= 0.2<um>   tag= right

line x location= 0.0<um>   spacing= 0.01<um> tag= top
line x location= 0.80<um>  spacing= 0.01<um>
line x location= 2.50<um>  spacing= 0.25<um>
line x location= 5.00<um>  spacing= 1.00<um>
line x location= 10.0<um>  spacing= 4.00<um>   tag= bottom

#Domain
region silicon xlo=top xhi=bottom ylo=mid yhi=right

#init and waffer
init field=Boron concentration=4e15<cm-3>

#multithread
math numThreads=12

#SiO2 deposition
deposit Oxide type=isotropic thickness=0.5<um>

#opening active region
mask name=ActiveRegion left=0<um> right=4<um>
photo mask=ActiveRegion thickness=0.5<um>
etch material=oxide type=anisotropic time=2.6 rate= {0.2}
strip photoresist


#thermal gate oxidation
diffuse temperature=900<C> time=72<min> O2

#ionic implantation for Vt
implant Boron  dose=22e11<cm-2> energy=30<keV> tilt=0 rotation=0


#deposition of Si Poli
deposit PolySilicon type=anisotropic time=15<min> rate=0.0267 temperature=600<C>

#Boron diffusion to the Si Poli
diffuse temperature=900<C> time=20<min> N2

#siPoli definition over gate
mask name=PoliGate left=2.5<um> right=6<um>
photo mask=PoliGate thickness=0.5<um>
etch material=PolySilicon type=anisotropic time=15<min> rate=0.0267
strip photoresist

#source and drain implantation
implant Phosphorus dose=8e15<cm-2> energy=50<keV> tilt=0 rotation=0

#dopant activation
diffuse temperature=940<C> time=20<min> N2

#oxide deposition and densification
deposit Oxide type=anisotropic thickness=0.4<um>
diffuse temperature=940<C> time=10<min> N2

#contacts opening
mask name=contacts left=0 right=1.5<um> 
mask name=contacts left=3<um> right=4<um> 
photo mask=contacts thickness=0.5<um>
etch material=oxide type=anisotropic time=2.2 rate= {0.2}
strip photoresist

#titanium deposition
deposit Titanium type=isotropic thickness=0.1<um>

#Al deposition
deposit material=Aluminum type=anisotropic thickness=1<um>

#Al definition
mask name=al left=0 right=1.4<um> negative
mask name=al left=3.1<um> right=3.9<um> negative
photo mask=al thickness=0.5<um>
etch material=Aluminum type=anisotropic time=6 rate= {0.2}
strip photoresist
etch material=Titanium type=anisotropic time=6 rate= {0.02}
mask name=TiCorrection right=2<um> left=2.75<um>
photo mask=TiCorrection thickness=0.5<um>
etch material=Titanium type=isotropic time=6 rate= {0.02}
strip photoresist


#sinterization
diffuse temperature=420<C> time=30<min> N2


#Structure reflecting
transform reflect left


#contacts
contact name = "Substrate" bottom Silicon
contact name = "Source" Aluminum y=-3.5 x=-1.0
contact name = "Drain" Aluminum y=3.5 x=-1.0
contact name = "Gate" Aluminum y=0.0 x=-1.0

#stress: coloque valor desejado como sxxi
stressdata silicon sxxi=0 syyi=1.5<GPa> szzi=0

#save for sdevice
struct tdr=transistor15 !Gas

