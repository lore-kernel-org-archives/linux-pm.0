From: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Subject: Re: [PATCH 4/4] dt-bindings: mfd: max8998: Add charger subnode binding
Date: Mon, 30 Apr 2018 16:59:48 +0200
Message-ID: <2163655.V5BWH1NDss@acerlaptop>
References: <1524844982-4714-1-git-send-email-pawel.mikolaj.chmiel@gmail.com> <1524844982-4714-5-git-send-email-pawel.mikolaj.chmiel@gmail.com> <20180430123036.GH5147@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180430123036.GH5147@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, April 30, 2018 1:30:36 PM CEST Lee Jones wrote:
> On Fri, 27 Apr 2018, Pawe=C5=82 Chmiel wrote:
>=20
> > This patch adds devicetree bindings documentation for
> > battery charging controller as the subnode of MAX8998 PMIC.
> > It's based on current behavior of driver.
> >=20
> > Fixes: ee999fb3f17f ("mfd: max8998: Add support for Device Tree")
>=20
> Why is this here?  This patch doesn't look like a fix to me.
Hi
I though that if previous patch, which is adding missing device tree parsin=
g into charger driver,
has fixes tag, this patch (which is documenting it), should also contain th=
at tag.
If it shouldn't be here, i can fix this in v2.

Thanks for feedback (this is my second patchset for Linux Kernel)
>=20
> > Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/mfd/max8998.txt | 22 +++++++++++++++=
+++++++
> >  1 file changed, 22 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/mfd/max8998.txt b/Docume=
ntation/devicetree/bindings/mfd/max8998.txt
> > index 23a3650ff2a2..f95610afb57f 100644
> > --- a/Documentation/devicetree/bindings/mfd/max8998.txt
> > +++ b/Documentation/devicetree/bindings/mfd/max8998.txt
> > @@ -50,6 +50,21 @@ Additional properties required if max8998,pmic-buck2=
=2Ddvs-gpio is defined:
> >  - max8998,pmic-buck2-dvs-voltage: An array of 2 voltage values in micr=
ovolts
> >    for buck2 regulator that can be selected using dvs gpio.
> > =20
> > +Charger: Configuration for battery charging controller should be added
> > +inside a child node named 'charger'.
> > +  Required properties:
> > +  - max8998,charge-eoc: Setup "End of Charge". If value equals 0,
> > +    remain value set from bootloader or default value will be used.
> > +    Valid values: 0, 10 - 45
> > +
> > +  - max8998,charge-restart: Setup "Charge Restart Level". If value equ=
als 0,
> > +    remain value set from bootloader or default value will be used.
> > +    Valid values: -1, 0, 100, 150, 200
> > +
> > +  - max8998,charge-timeout: Setup "Charge Full Timeout". If value equa=
ls 0,
> > +    remain value set from bootloader or default value will be used.
> > +    Valid values: -1, 0, 5, 6, 7
> > +
> >  Regulators: All the regulators of MAX8998 to be instantiated shall be
> >  listed in a child node named 'regulators'. Each regulator is represent=
ed
> >  by a child node of the 'regulators' node.
> > @@ -99,6 +114,13 @@ Example:
> >  		max8998,pmic-buck2-dvs-gpio =3D <&gpx0 0 3 0 0>; /* SET3 */
> >  		max8998,pmic-buck2-dvs-voltage =3D <1350000>, <1300000>;
> > =20
> > +		/* Charger configuration */
> > +		charger {
> > +			max8998,charge-eoc =3D <0>;
> > +			max8998,charge-restart =3D <(-1)>;
> > +			max8998,charge-timeout =3D <7>;
> > +		};
> > +
> >  		/* Regulators to instantiate */
> >  		regulators {
> >  			ldo2_reg: LDO2 {
>=20
>=20
