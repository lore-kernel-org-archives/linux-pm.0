From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: Re: [PATCH] devfreq: Convert to using %pOFn instead of
 device_node.name
Date: Wed, 29 Aug 2018 11:10:14 +0900
Message-ID: <20180829021014epcms1p85b74efd54e73039e5a81629d8079e02e@epcms1p8>
References: <5B84AE40.50305@samsung.com>
        <20180828015252.28511-1-robh@kernel.org>
        <20180828015252.28511-15-robh@kernel.org>
        <CGME20180828015312epcas2p2fdb2ee1d1b292f212ec773dd8fb4bfc7@epcms1p8>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5B84AE40.50305@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

> Dear Rob,
>=20
> On 2018=EB=85=84=2008=EC=9B=94=2028=EC=9D=BC=2010:52,=20Rob=20Herring=20w=
rote:=0D=0A>=20>=20In=20preparation=20to=20remove=20the=20node=20name=20poi=
nter=20from=20struct=20device_node,=0D=0A>=20>=20convert=20printf=20users=
=20to=20use=20the=20%pOFn=20format=20specifier.=0D=0A>=20>=20=0D=0A>=20>=20=
Cc:=20Chanwoo=20Choi=20<cw00.choi=40samsung.com>=0D=0A>=20>=20Cc:=20MyungJo=
o=20Ham=20<myungjoo.ham=40samsung.com>=0D=0A>=20>=20Cc:=20Kyungmin=20Park=
=20<kyungmin.park=40samsung.com>=0D=0A>=20>=20Cc:=20Kukjin=20Kim=20<kgene=
=40kernel.org>=0D=0A>=20>=20Cc:=20Krzysztof=20Kozlowski=20<krzk=40kernel.or=
g>=0D=0A>=20>=20Cc:=20linux-pm=40vger.kernel.org=0D=0A>=20>=20Cc:=20linux-a=
rm-kernel=40lists.infradead.org=0D=0A>=20>=20Cc:=20linux-samsung-soc=40vger=
.kernel.org=0D=0A>=20>=20Signed-off-by:=20Rob=20Herring=20<robh=40kernel.or=
g>=0D=0A>=20>=20---=0D=0A>=20>=20=20drivers/devfreq/event/exynos-ppmu.c=20=
=7C=204=20++--=0D=0A>=20>=20=201=20file=20changed,=202=20insertions(+),=202=
=20deletions(-)=0D=0A>=20>=20=0D=0A=5B=5D=0D=0A>=20=0D=0A>=20Acked-by:=20Ch=
anwoo=20Choi=20<cw00.choi=40samsung.com>=0D=0A=0D=0AAcked-by:=20MyungJoo=20=
Ham=20<myungjoo.ham=40samsung.com>=0D=0A=0D=0A
