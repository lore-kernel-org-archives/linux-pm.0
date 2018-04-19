From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [GIT PULL V3] Thermal SoC management updates for v4.17-rc1
Date: Thu, 19 Apr 2018 12:41:42 +0200
Message-ID: <13169679.AINr0uuryx@amdc3058>
References: <20180414183051.GA27921@localhost.localdomain>
        <1524037889.2553.13.camel@intel.com>
        <20180418141027.GA3303@localhost.localdomain>
        <CGME20180419104145eucas1p2e64408e3340d5af7731765df0e82f1cd@eucas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180418141027.GA3303@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


Hi,

On Wednesday, April 18, 2018 07:10:30 AM Eduardo Valentin wrote:
> Hello,
>=20
> On Wed, Apr 18, 2018 at 03:51:29PM +0800, Zhang Rui wrote:
> > Hi, Eduardo,
> >=20
> > On =E5=85=AD,=202018-04-14=20at=2011:30=20-0700,=20Eduardo=20Valentin=
=20wrote:=0D=0A>=20>=20>=20Hello=20Linus,=0D=0A>=20>=20>=20=0D=0A>=20>=20>=
=20Please=20find=20thermal-soc=20changes=20for=20v4.17-rc1.=0D=0A>=20>=20>=
=20Rui=20asked=20me=20to=20send=20the=20pull=20request=20directly=20to=20yo=
u=0D=0A>=20>=20>=20as=20we=20are=20close=20to=20the=20end=20of=20the=20merg=
e=20window.=0D=0A>=20>=20>=20Essentially=20this=20pull=20removes=20the=20se=
ries=20that=20caused=0D=0A>=20>=20>=20warning=20regression.=20I=20will=20wo=
rk=20with=20the=20developer=0D=0A>=20>=20>=20to=20get=20that=20fixed=20late=
r=20on,=20but=20I=20am=20still=20sending=0D=0A>=20>=20>=20the=20other=20few=
=20patches=20that=20are=20unrelated=20to=20that.=0D=0A>=20>=20>=20Let=20me=
=20know=20if=20this=20causes=20any=20issues=20and=20can=20still=0D=0A>=20>=
=20>=20be=20pulled.=0D=0A>=20>=20>=20=0D=0A>=20>=20>=20Changelog:=0D=0A>=20=
>=20>=20-=20New=20i.MX7=20thermal=20sensor=0D=0A>=20>=20>=20-=20Mediatek=20=
driver=20now=20supports=20MT7622=20SoC=0D=0A>=20>=20>=20-=20Removal=20of=20=
min=20max=20cpu=20cooling=20DT=20property=0D=0A>=20>=20>=20=0D=0A>=20>=20>=
=20Differences=20in=20V3:=0D=0A>=20>=20>=20-=20Rebased=20on=20top=20current=
=20linus/master,=20to=20avoid=20and=20merge=20issues=0D=0A>=20>=20>=20from=
=20previous=20pulled=20thermal=20code.=0D=0A>=20>=20>=20=0D=0A>=20>=20>=20D=
ifferences=20in=20V2:=0D=0A>=20>=20>=20-=20Reordered=20the=20patches=20to=
=20drop=20exynos=20changes=20for=20now=20until=20we=20get=0D=0A>=20>=20>=20=
agreement=20on=20the=20fix=20on=20that=20driver=20for=20the=20compilation=
=20warns=0D=0A>=20>=20>=20caused=20by=20the=20confusing=20conversion=20func=
tions.=0D=0A>=20>=20>=20=0D=0A>=20>=20>=20=0D=0A>=20>=20>=20The=20following=
=20changes=20since=20commit=0D=0A>=20>=20>=2048023102b7078a6674516b1fe0d639=
669336049d:=0D=0A>=20>=20>=20=0D=0A>=20>=20>=20=C2=20=20Merge=20branch=20'o=
verlayfs-linus'=20of=0D=0A>=20>=20>=20git://git.kernel.org/pub/scm/linux/ke=
rnel/git/mszeredi/vfs=20(2018-04-=0D=0A>=20>=20>=2013=2016:55:41=20-0700)=
=0D=0A>=20>=20>=20=0D=0A>=20>=20>=20are=20available=20in=20the=20git=20repo=
sitory=20at:=0D=0A>=20>=20>=20=0D=0A>=20>=20>=20=C2=20=20git://git.kernel.o=
rg/pub/scm/linux/kernel/git/evalenti/linux-soc-=0D=0A>=20>=20>=20thermal=20=
linus=0D=0A>=20>=20>=20=0D=0A>=20>=20>=20for=20you=20to=20fetch=20changes=
=20up=20to=0D=0A>=20>=20>=2015a32df1918259be6c23fc36014fc26ee66c836c:=0D=0A=
>=20>=20>=20=0D=0A>=20>=20>=20=C2=20=20dt-bindings:=20thermal:=20Remove=20=
=22cooling-=7Bmin=7Cmax=7D-level=22=20properties=0D=0A>=20>=20>=20(2018-04-=
14=2009:37:55=20-0700)=0D=0A>=20>=20>=20=0D=0A>=20>=20This=20pull=20request=
=20does=20not=20catch=20this=20merge=20window.=0D=0A>=20>=20So=20do=20you=
=20want=20to=20split=20it=20into=202=20separate=20pull=20requests,=20one=20=
for=204.17-=0D=0A>=20>=20rc=20and=20another=20for=204.18-rc1?=0D=0A>=20=0D=
=0A>=20OK.=20Yeah,=20I=20am=20fine=20with=20that.=0D=0A>=20=0D=0A>=20>=20=
=0D=0A>=20>=20>=20---------------------------------------------------------=
-------=0D=0A>=20>=20>=20Anson=20Huang=20(1):=0D=0A>=20>=20>=20=C2=20=C2=20=
=C2=20=C2=20=C2=20=C2=20thermal:=20imx:=20add=20i.MX7=20thermal=20sensor=20=
support=0D=0A>=20>=20>=20=0D=0A>=20>=20>=20Bartlomiej=20Zolnierkiewicz=20(1=
):=0D=0A>=20>=20>=20=C2=20=C2=20=C2=20=C2=20=C2=20=C2=20dt-bindings:=20ther=
mal:=20remove=20no=20longer=20needed=20samsung=20thermal=0D=0A>=20>=20>=20p=
roperties=0D=0A>=20>=20>=20=0D=0A>=20>=20>=20Sean=20Wang=20(2):=0D=0A>=20>=
=20>=20=C2=20=C2=20=C2=20=C2=20=C2=20=C2=20dt-bindings:=20thermal:=20add=20=
binding=20for=20MT7622=20SoC=0D=0A>=20>=20>=20=C2=20=C2=20=C2=20=C2=20=C2=
=20=C2=20thermal:=20mediatek:=20add=20support=20for=20MT7622=20SoC=0D=0A>=
=20>=20>=20=0D=0A>=20>=20>=20Viresh=20Kumar=20(1):=0D=0A>=20>=20>=20=C2=20=
=C2=20=C2=20=C2=20=C2=20=C2=20dt-bindings:=20thermal:=20Remove=20=22cooling=
-=7Bmin=7Cmax=7D-level=22=0D=0A>=20>=20>=20properties=0D=0A>=20>=20>=20=0D=
=0A>=20>=20IMO,=20together=20with=20the=20refreshed=20exynos=20fixes,=20the=
=20one=20from=20Viresh=20and=0D=0A>=20>=20the=20one=20from=C2=20Bartlomiej=
=20can=20be=20queued=20for=204.17-rc,=20and=20the=20others=20have=0D=0A>=20=
>=20to=20wait=20until=20next=20merge=20window.=0D=0A>=20>=20=0D=0A>=20=0D=
=0A>=20Correct,=20the=20new=20chip=20support=20will=20need=20to=20wait=20fo=
r=20the=20next=20merge=0D=0A>=20window.=20I=20have=20already=20split=20the=
=20patches=20into=20the=20two=20categories.=0D=0A>=20The=20patches=20removi=
ng=20stuff=20are=20in=20my=20-fixes=20branch.=20All=20the=20other=20adding=
=0D=0A>=20new=20chip=20support=20are=20in=20my=20-linus=20branch.=0D=0A>=20=
=0D=0A>=20Now,=20Do=20you=20have=20anything=20for=20this=20-rc2=20?=20If=20=
not,=20I=20will=20send=20directly=0D=0A>=20to=20Linus=20the=20stuff=20in=20=
my=20-fixes=20branch.=20Let=20me=20know.=0D=0A=0D=0AWhat=20about=20refreshe=
d=20Exynos=20patches=20(https://lkml.org/lkml/2018/4/16/256)?=0D=0A=0D=0AFi=
xes=20from=20Marek=20(first=20two=20patches)=20are=20quite=20critical=20(wi=
thout=20them=0D=0Abooting=20with=20thermal=20enabled=20triggers=20critical=
=20temperature=20handling=20on=0D=0AExynos4210=20SoC).=0D=0A=0D=0ABest=20re=
gards,=0D=0A--=0D=0ABartlomiej=20Zolnierkiewicz=0D=0ASamsung=20R&D=20Instit=
ute=20Poland=0D=0ASamsung=20Electronics=0D=0A=0D=0A
