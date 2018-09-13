From: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Subject: Re: [PATCH v3 3/3] dt-bindings: mfd: max8998: Add charger subnode binding
Date: Thu, 13 Sep 2018 16:55:48 +0200
Message-ID: <24790346.rcfynqLzho@acerlaptop>
References: <1531843509-3533-1-git-send-email-pawel.mikolaj.chmiel@gmail.com> <1531843509-3533-4-git-send-email-pawel.mikolaj.chmiel@gmail.com> <20180807175741.GA30886@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180807175741.GA30886@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org, lee.jones@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, August 7, 2018 11:57:42 AM CEST Rob Herring wrote:
> On Tue, Jul 17, 2018 at 06:05:09PM +0200, Pawe=C5=82 Chmiel wrote:
> > This patch adds devicetree bindings documentation for
> > battery charging controller as the subnode of MAX8998 PMIC.
> >=20
> > Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > ---
> > Changes from v2:
> >   - Make charge-restart-level-microvolt optional.
> >   - Make charge-timeout-hours optional.
> >=20
> > Changes from v1:
> >   - Removed unneeded Fixes tag
> >   - Correct description of all charger values
> >   - Added missing property unit
> > ---
> >  Documentation/devicetree/bindings/mfd/max8998.txt | 25 +++++++++++++++=
++++++++
> >  1 file changed, 25 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/mfd/max8998.txt b/Docume=
ntation/devicetree/bindings/mfd/max8998.txt
> > index 23a3650ff2a2..264040f4ad15 100644
> > --- a/Documentation/devicetree/bindings/mfd/max8998.txt
> > +++ b/Documentation/devicetree/bindings/mfd/max8998.txt
> > @@ -50,6 +50,24 @@ Additional properties required if max8998,pmic-buck2=
=2Ddvs-gpio is defined:
> >  - max8998,pmic-buck2-dvs-voltage: An array of 2 voltage values in micr=
ovolts
> >    for buck2 regulator that can be selected using dvs gpio.
> > =20
> > +Charger: Configuration for battery charging controller should be added
> > +inside a child node named 'charger'.
> > +  Required properties:
> > +  - max8998,charge-eoc-percent: Setup End of Charge Level.
>=20
> This should have a vendor prefix and max8998 is not a vendor. Don't=20
> continue that pattern even if we already have some properties like that.
>=20
> These seem like perhaps they should be common charger properties.
Where i could find such properties (or any other driver which is using thos=
e as an example) ?
Looking at few existing drivers, most of them have custom properties (that'=
s why i've followed the same pattern for max8998).

Thanks
>=20
> > +    If value equals 0, leave it unchanged.
> > +    Otherwise it should be value from 10 to 45 by 5 step.
> > +
> > +  Optional properties:
> > +  - max8998,charge-restart-level-microvolt: Setup Charge Restart Level.
> > +    If property is not present, this will be disabled.
> > +    If value equals 0, leave it unchanged.
> > +    Otherwise it should be one of following values: 100, 150, 200.
> > +
> > +  - max8998,charge-timeout-hours: Setup Charge Full Timeout.
> > +    If property is not present, this will be disabled.
> > +    If value equals 0, leave it unchanged.
> > +    Otherwise it should be one of following values: 5, 6, 7.
> > +
> >  Regulators: All the regulators of MAX8998 to be instantiated shall be
> >  listed in a child node named 'regulators'. Each regulator is represent=
ed
> >  by a child node of the 'regulators' node.
> > @@ -99,6 +117,13 @@ Example:
> >  		max8998,pmic-buck2-dvs-gpio =3D <&gpx0 0 3 0 0>; /* SET3 */
> >  		max8998,pmic-buck2-dvs-voltage =3D <1350000>, <1300000>;
> > =20
> > +		/* Charger configuration */
> > +		charger {
> > +			max8998,charge-eoc-percent =3D <0>;
> > +			max8998,charge-restart-level-microvolt =3D <100>;
> > +			max8998,charge-timeout-hours =3D <7>;
> > +		};
> > +
> >  		/* Regulators to instantiate */
> >  		regulators {
> >  			ldo2_reg: LDO2 {
>=20
