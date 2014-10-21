From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: [RFC Patch 1/4] mfd: AXP20x: Add power supply bindings
 documentation
Date: Tue, 21 Oct 2014 18:09:16 +0200
Message-ID: <20141021180916.432f02e1@neptune.home>
References: <20141020221959.2f312906@neptune.home>
	<20141020223314.0484f795@neptune.home>
	<20141021101503.GE26842@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hygieia.santi-shop.eu ([78.46.175.2]:43239 "EHLO
	hygieia.santi-shop.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755659AbaJUQJW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Oct 2014 12:09:22 -0400
In-Reply-To: <20141021101503.GE26842@x1>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-sunxi@googlegroups.com, maxime.ripard@free-electrons.com, linux-arm-kernel@lists.infradead.org, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, Olliver Schinagl <oliver+list@schinagl.nl>

On Tue, 21 October 2014 Lee Jones <lee.jones@linaro.org> wrote:
> On Mon, 20 Oct 2014, Bruno Pr=C3=A9mont wrote:
> > ---
> > Note: the OCV values seem to have some defaults build into the
> > PMIC though may need adjustment if the used battery has a different
> > open circuit voltage curve.
> > As far as understood (these values are set in vendor driver but not
> > mentioned in chip documentation) they represent charge percentage
> > for some predefined voltages.
> >=20
> > If prefixing these values with "x-power," is preferred the followin=
g
> > patch should becomes a dependency:
> >   http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/2=
67606.html
> > and users in patch 2/4, 4/4 need adjusting.
> >=20
> >=20
> >  Documentation/devicetree/bindings/mfd/axp20x.txt |   20 +
> >  1 files changed, 20 insertions(+), 0 deletion(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Doc=
umentation/devicetree/bindings/mfd/axp20x.txt
> > index cc9e01b..8ea681c 100644
> > --- a/Documentation/devicetree/bindings/mfd/axp20x.txt
> > +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> > @@ -28,6 +28,20 @@ Required properties:
> >  		      (range: 750-1875). Default: 1.5MHz
> > =20
> >  Optional properties for DCDCs:
> > +- backup: Settings for backup/RTC battery charger
> > +	  (Voltage in =C2=B5V, current in =C2=B5A)
> > +	  If not present, charger will be left untouched
> > +- battery.ocv: OCV capacity curve points (16 data values)
> > +- battery.resistance: internal battery resistance in m=CE=A9
> > +                      (defaults to 100m=CE=A9)
> > +- battery.capacity: Battery capacity in mAh
> > +		    If this attribute is missing, charger will be disabled
> > +		    unless there is a battery connected.
> > +- battery.temp_sensor: Description of temperautre sensor, 3 values
> > +		       - driver current (20=C2=B5A, 40=C2=B5A, 60=C2=B5A or 80=C2=
=B5A)
> > +		       - low temperature warning level (in =C2=B5V)
> > +		       - high temperature warning level (in =C2=B5V)
> > +		       If missing, temperature sensor gets disabled
> >  - x-powers,dcdc-workmode: 1 for PWM mode, 0 for AUTO mode
> >  			  Default: AUTO mode
> > =20
> > @@ -49,6 +63,12 @@ axp209: pmic@34 {
> >  	ldo3in-supply =3D <&axp_ipsout_reg>;
> >  	ldo5in-supply =3D <&axp_ipsout_reg>;
> > =20
> > +	backup =3D <3000000 200>;
> > +	battery.ocv =3D <0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0>;
> > +	battery.resistance =3D <0>;
> > +	battery.capacity =3D <2000>;
> > +	battery.temp_sensor =3D <20 1000000 4000000>;
>=20
> Since when do we use '.'s in property names?

I've not found guidelines on this, but whatever is the right way to
name them, I'm open for suggestions.

Bruno

> >  	regulators {
> >  		x-powers,dcdc-freq =3D <1500>;
> > =20
>=20
