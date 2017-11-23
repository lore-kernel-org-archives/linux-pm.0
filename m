From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: Re: [PATCH 1/4] rk3399_dmc: Fix line continuation format
Date: Thu, 23 Nov 2017 01:21:00 +0000
Message-ID: <20171123012100epcms1p13f78950557de06dbbd65996c8b0645ee@epcms1p1>
References: <1511347280.6989.81.camel@perches.com>
        <cover.1510845910.git.joe@perches.com>
        <7d659960e45f66894126fba9e2d54cf25ae1185b.1510845910.git.joe@perches.com>
        <5A150792.6050104@samsung.com>
        <CGME20171116152742epcas2p22b17887a4d7f2adcd3beb414988dbce3@epcms1p1>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:32770 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751706AbdKWBVD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Nov 2017 20:21:03 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20171123012101epoutp022112c68d32f2b74ec22d8cb83cae3701~5klkUqbkc2581725817epoutp02M
        for <linux-pm@vger.kernel.org>; Thu, 23 Nov 2017 01:21:01 +0000 (GMT)
In-Reply-To: <1511347280.6989.81.camel@perches.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joe Perches <joe@perches.com>, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

> On Wed, 2017-11-22 at 14:13 +0900, Chanwoo Choi wrote:
> > On 2017=EB=85=84=2011=EC=9B=94=2017=EC=9D=BC=2000:27,=20Joe=20Perches=
=20wrote:=0D=0A>=20>=20>=20Line=20continuations=20with=20excess=20spacing=
=20causes=20unexpected=20output.=0D=0A>=20>=20>=20=0D=0A>=20>=20>=20Signed-=
off-by:=20Joe=20Perches=20<joe=40perches.com>=0D=0A>=20>=20>=20---=0D=0A>=
=20>=20>=20=20drivers/devfreq/rk3399_dmc.c=20=7C=204=20++--=0D=0A>=20>=20>=
=20=201=20file=20changed,=202=20insertions(+),=202=20deletions(-)=0D=0A>=20=
>=20>=20=0D=0A>=20>=20>=20diff=20--git=20a/drivers/devfreq/rk3399_dmc.c=20b=
/drivers/devfreq/rk3399_dmc.c=0D=0A>=20>=20>=20index=205dfbfa3cc878..0938c9=
7d46f0=20100644=0D=0A>=20>=20>=20---=20a/drivers/devfreq/rk3399_dmc.c=0D=0A=
>=20>=20>=20+++=20b/drivers/devfreq/rk3399_dmc.c=0D=0A>=20>=20>=20=40=40=20=
-146,8=20+146,8=20=40=40=20static=20int=20rk3399_dmcfreq_target(struct=20de=
vice=20*dev,=20unsigned=20long=20*freq,=0D=0A>=20>=20>=20=20=0D=0A>=20>=20>=
=20=20=09/*=20If=20get=20the=20incorrect=20rate,=20set=20voltage=20to=20old=
=20value.=20*/=0D=0A>=20>=20>=20=20=09if=20(dmcfreq->rate=20=21=3D=20target=
_rate)=20=7B=0D=0A>=20>=20>=20-=09=09dev_err(dev,=20=22Get=20wrong=20ddr=20=
frequency,=20Request=20frequency=20%lu,=5C=0D=0A>=20>=20>=20-=09=09=09Curre=
nt=20frequency=20%lu=5Cn=22,=20target_rate,=20dmcfreq->rate);=0D=0A>=20>=20=
>=20+=09=09dev_err(dev,=20=22Get=20wrong=20ddr=20frequency,=20Request=20fre=
quency=20%lu,=20Current=20frequency=20%lu=5Cn=22,=0D=0A>=20>=20>=20+=09=09=
=09target_rate,=20dmcfreq->rate);=0D=0A>=20>=20=0D=0A>=20>=20IMO,=20I=20don=
't=20like=20over=2080=20char=20in=20the=20one=20line.=0D=0A>=20=0D=0A>=20Fi=
x=20it=20as=20you=20chose,=20but=20the=20code=20I=20proposed=0D=0A>=20is=20=
what=20is=20preferred=20by=20CodingStyle.=0D=0A>=20=0D=0A>=20The=20current=
=20code=20is=20unintentional.=0D=0A>=20=0D=0A>=20Right=20now=20there=20are=
=203=20tabs=20between=20=22Request=20frequency=22=0D=0A>=20and=20=22Current=
=20frequency=22=20in=20the=20output.=0D=0A=0D=0AChanwoo,=20this=20is=20not=
=20a=20simple=20coding=20style=20issue.=0D=0AI'm=20seeing=20these=20uninten=
tional=20tabs=20as=20well.=0D=0A=0D=0AIf=20you=20want=20to=20keep=20it=2080=
=20cols=20with=20strings=20(which=20is=20not=20mandatory=20for=20strings=20=
in=20double=20quotes),=0D=0AWe'd=20better=20do:=0D=0A=0D=0A-=09=09dev_err(d=
ev,=20=22Get=20wrong=20ddr=20frequency,=20Request=20frequency=20%lu,=5C=0D=
=0A-=09=09=09Current=20frequency=20%lu=5Cn=22,=20target_rate,=20dmcfreq->ra=
te);=0D=0A+=09=09dev_err(dev,=20=22Get=20wrong=20ddr=20frequency,=20Request=
=20frequency=20%lu,=22=0D=0A+=09=09=09=22=20Current=20frequency=20%lu=5Cn=
=22,=20target_rate,=20dmcfreq->rate);=0D=0A=0D=0ACheers,=0D=0AMyungJoo=0D=
=0A=0D=0A>=20=0D=0A>=20>=20>=20=20=09=09regulator_set_voltage(dmcfreq->vdd_=
center,=20dmcfreq->volt,=0D=0A>=20>=20>=20=20=09=09=09=09=20=20=20=20=20=20=
dmcfreq->volt);=0D=0A>=20>=20>=20=20=09=09goto=20out;=0D=0A>=20>=20>=20=0D=
=0A>=20>=20=0D=0A>=20>=20=0D=0A>=20=0D=0A
