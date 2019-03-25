From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: Re: [PATCH] PM / devfreq: exynos-bus: Suspend all devices on
 system shutdown
Date: Mon, 25 Mar 2019 13:38:50 +0900
Message-ID: <20190325043850epcms1p7c55d5c6767779f4dc044118975cff560@epcms1p7>
References: <f41be303-0159-0730-501b-f465a1418861@samsung.com>
        <20190321090110.26506-1-m.szyprowski@samsung.com>
        <c2b39c36-a2f4-282e-1145-c61cfa18c6ce@samsung.com>
        <CGME20190321090120eucas1p1d5122777e84f4e3c965946a8c5aead8b@epcms1p7>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f41be303-0159-0730-501b-f465a1418861@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Luba <l.luba@partner.samsung.com>, Markus Reichl <m.reichl@fivetechno.de>
List-Id: linux-pm@vger.kernel.org

>Hi Chanwoo,
>
>On 2019-03-21 10:19, Chanwoo Choi wrote:
>> On 19. 3. 21. =EC=98=A4=ED=9B=84=206:01,=20Marek=20Szyprowski=20wrote:=
=0D=0A>>>=20Force=20all=20Exynos=20buses=20to=20safe=20operation=20points=
=20before=20doing=20the=20system=0D=0A>>>=20reboot=20operation.=20There=20a=
re=20board=20on=20which=20some=20aggressive=20power=20saving=0D=0A>>>=20ope=
ration=20points=20are=20behind=20the=20capabilities=20of=20the=20bootloader=
=20to=20properly=0D=0A>>>=20reset=20the=20hardware=20and=20boot=20the=20boa=
rd.=20This=20way=20one=20can=20avoid=20board=20crash=0D=0A>>>=20early=20aft=
er=20reboot.=0D=0A>>>=0D=0A>>>=20This=20fixes=20reboot=20issue=20on=20Odroi=
dU3=20board=20both=20with=20eMMC=20and=20SD=20boot.=0D=0A>>>=0D=0A>>>=20Rep=
orted-by:=20Markus=20Reichl=20<m.reichl=40fivetechno.de>=0D=0A>>>=20Signed-=
off-by:=20Marek=20Szyprowski=20<m.szyprowski=40samsung.com>=0D=0A>>>=20---=
=0D=0A>>>=20This=20is=20an=20alternative=20to=20https://patchwork.kernel.or=
g/patch/10781433/=0D=0A>>>=20limited=20only=20to=20Exynos-bus=20driver.=0D=
=0A>>>=20---=0D=0A>>>=20=20=20drivers/devfreq/exynos-bus.c=20=7C=208=20++++=
++++=0D=0A>>>=20=20=201=20file=20changed,=208=20insertions(+)=0D=0A>>>=0D=
=0A>>>=20diff=20--git=20a/drivers/devfreq/exynos-bus.c=20b/drivers/devfreq/=
exynos-bus.c=0D=0A>>>=20index=20c25658b26598..486cc5b422f1=20100644=0D=0A>>=
>=20---=20a/drivers/devfreq/exynos-bus.c=0D=0A>>>=20+++=20b/drivers/devfreq=
/exynos-bus.c=0D=0A>>>=20=40=40=20-514,6=20+514,13=20=40=40=20static=20int=
=20exynos_bus_probe(struct=20platform_device=20*pdev)=0D=0A>>>=20=20=20=09r=
eturn=20ret;=0D=0A>>>=20=20=20=7D=0D=0A>>>=20=20=20=0D=0A>>>=20+static=20vo=
id=20exynos_bus_shutdown(struct=20platform_device=20*pdev)=0D=0A>>>=20+=7B=
=0D=0A>>>=20+=09struct=20exynos_bus=20*bus=20=3D=20dev_get_drvdata(&pdev->d=
ev);=0D=0A>>>=20+=0D=0A>>>=20+=09devfreq_suspend_device(bus->devfreq);=0D=
=0A>>>=20+=7D=0D=0A>>>=20+=0D=0A>>>=20=20=20=23ifdef=20CONFIG_PM_SLEEP=0D=
=0A>>>=20=20=20static=20int=20exynos_bus_resume(struct=20device=20*dev)=0D=
=0A>>>=20=20=20=7B=0D=0A>>>=20=40=40=20-556,6=20+563,7=20=40=40=20MODULE_DE=
VICE_TABLE(of,=20exynos_bus_of_match);=0D=0A>>>=20=20=20=0D=0A>>>=20=20=20s=
tatic=20struct=20platform_driver=20exynos_bus_platdrv=20=3D=20=7B=0D=0A>>>=
=20=20=20=09.probe=09=09=3D=20exynos_bus_probe,=0D=0A>>>=20+=09.shutdown=09=
=3D=20exynos_bus_shutdown,=0D=0A>>>=20=20=20=09.driver=20=3D=20=7B=0D=0A>>>=
=20=20=20=09=09.name=09=3D=20=22exynos-bus=22,=0D=0A>>>=20=20=20=09=09.pm=
=09=3D=20&exynos_bus_pm,=0D=0A>>>=0D=0A>>=20Actually,=20I=20already=20agree=
d=20the=20previous=20patch.=0D=0A>>=20Also,=20it=20looks=20good=20to=20me.=
=0D=0A>=0D=0A>Yes,=20I=20know,=20but=20MyungJoo=20had=20some=20objections,=
=20that's=20why=20I=20prepared=20=0D=0A>alternative=20version.=0D=0A>=0D=0A=
>>=20Acked-by:=20Chanwoo=20Choi=20<cw00.choi=40samsung.com>=0D=0A>>=0D=0A=
=0D=0AThis=20has=20become=20looking=20good=20now=20:)=0D=0A=0D=0A=0D=0AAcke=
d-by:=20MyungJoo=20Ham=20<myungjoo.ham=40samsung.com>=0D=0A=0D=0A=0D=0AChee=
rs,=0D=0AMyungJoo=0D=0A
