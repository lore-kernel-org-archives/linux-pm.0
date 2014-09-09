From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: document Rockchip thermal
Date: Tue, 09 Sep 2014 10:27:17 +0800
Message-ID: <1410229637.8085.158.camel@rzhang1-toshiba>
References: <1409710239-19941-1-git-send-email-caesar.wang@rock-chips.com>
	 <1409710239-19941-3-git-send-email-caesar.wang@rock-chips.com>
	 <11280986.L6lv82O8Qv@diego> <5407BA10.2030402@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:11177 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755486AbaIIC1d (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 8 Sep 2014 22:27:33 -0400
In-Reply-To: <5407BA10.2030402@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Caesar Wang <caesar.wang@rock-chips.com>
Cc: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>, edubezval@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, huangtao@rock-chips.com, cf@rock-chips.com, dianders@chromium.org, dtor@chromium.org, zyw@rock-chips.com, addy.ke@rock-chips.com, dmitry.torokhov@gmail.com, zhaoyifeng <zyf@rock-chips.com>

On Thu, 2014-09-04 at 09:02 +0800, Caesar Wang wrote:
> =E5=9C=A8 2014=E5=B9=B409=E6=9C=8803=E6=97=A5 16:07, Heiko St=C3=BCbn=
er =E5=86=99=E9=81=93:
> > Am Mittwoch, 3. September 2014, 10:10:37 schrieb Caesar Wang:
> >> This add the necessary binding documentation for the thermal
> >> found on Rockchip SoCs
> >>
> >> Signed-off-by: zhaoyifeng <zyf@rock-chips.com>
> >> Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
> >> ---
> >>   .../devicetree/bindings/thermal/rockchip-thermal.txt | 20
> >> ++++++++++++++++++++ 1 file changed, 20 insertions(+)
> >>   create mode 100644
> >> Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/thermal/rockchip-th=
ermal.txt
> >> b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt n=
ew file
> >> mode 100644
> >> index 0000000..1ed4d4c
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.t=
xt
> >> @@ -0,0 +1,20 @@
> >> +* Temperature Sensor ADC (TSADC) on rockchip SoCs
> >> +
> >> +Required properties:
> >> +- compatible: "rockchip,rk3288-tsadc"
> >> +- reg: physical base address of the controller and length of memo=
ry mapped
> >> +       region.
> >> +- interrupts: The interrupt number to the cpu. The interrupt spec=
ifier
> >> format +	      depends on the interrupt controller.
> >> +- clocks: Must contain an entry for each entry in clock-names.
> >> +- clock-names: Shall be "tsadc" for the converter-clock, and "apb=
_pclk" for
> >> +	       the peripheral clock.
> > You're using the passive-temp, critical-temp and force-shut-temp pr=
operties in
> > your driver without declaring them here.
>=20
> frankly,the about are need be declared. but  there are 4 types[0] for=
=20
> trip in thermal framework,
> there is no force-shut for me. So I want to change it three additiona=
l=20
> properties in [PATCH V4 4/4],
>=20
>=20
> [0]
> {
>      THERMAL_TRIP_CRITICAL,
>      THERMAL_TRIP_HOT,
>      THERMAL_TRIP_PASSIVE,
>      THERMAL_TRIP_ACTIVE,
> }
>=20
this sounds reasonable to me.

> > But more importantly, please use the generic trip-points for this. =
I guess it
> > shouldn't be a problem to introduce a "forced-shutdown" trippoint [=
0] for the
> > additional trip-point you have - thermal maintainers, please shout =
if I'm
> > wrong :-)
>=20
what is the difference between a critical trip point and a
"forced-shutdown" trip point?
Thermal core will do a shutdown in case the critical trip point is
triggered.

thanks,
rui
> It's a good option.
> I can send a patch,but I don't know whether the thermal maintainers w=
ill=20
> accept it.
>=20
> Maybe,they have a better way to suggest it.:-)
>=20
>=20
> PS:I will sent a new patch If I still have no received their suggesti=
ons=20
> in two days.
>=20
> >
> > Heiko
> >
> >
> > [0] in a separate patch, changing
> > - thermal_trip_type enum in include/linux/thermal.h
> > - trip_types mapping in drivers/thermal/of-thermal.c
> > - Documentation/devicetree/bindings/thermal/thermal.txt
> >
> >> +
> >> +Example:
> >> +tsadc: tsadc@ff280000 {
> >> +	compatible =3D "rockchip,rk3288-tsadc";
> >> +	reg =3D <0xff280000 0x100>;
> >> +	interrupts =3D <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> >> +	clocks =3D <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
> >> +	clock-names =3D "tsadc", "apb_pclk";
> >> +};
> >
> >
> >
>=20


