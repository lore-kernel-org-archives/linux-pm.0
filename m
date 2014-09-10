From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: document Rockchip thermal
Date: Wed, 10 Sep 2014 09:02:26 +0800
Message-ID: <1410310946.25559.12.camel@rzhang1-toshiba>
References: <1409710239-19941-1-git-send-email-caesar.wang@rock-chips.com>
	 <5407BA10.2030402@rock-chips.com>
	 <1410229637.8085.158.camel@rzhang1-toshiba> <8397565.n78cHk4EtL@diego>
	 <20140909150916.GA6095@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20140909150916.GA6095@developer>
Sender: linux-doc-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Caesar Wang <caesar.wang@rock-chips.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, huangtao@rock-chips.com, cf@rock-chips.com, dianders@chromium.org, dtor@chromium.org, zyw@rock-chips.com, addy.ke@rock-chips.com, dmitry.torokhov@gmail.com, zhaoyifeng <zyf@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

On Tue, 2014-09-09 at 11:09 -0400, Eduardo Valentin wrote:
> Hello
>=20
> On Tue, Sep 09, 2014 at 01:35:31PM +0200, Heiko St=C3=BCbner wrote:
> > Am Dienstag, 9. September 2014, 10:27:17 schrieb Zhang Rui:
> > > On Thu, 2014-09-04 at 09:02 +0800, Caesar Wang wrote:
> > > > =E5=9C=A8 2014=E5=B9=B409=E6=9C=8803=E6=97=A5 16:07, Heiko St=C3=
=BCbner =E5=86=99=E9=81=93:
> > > > > Am Mittwoch, 3. September 2014, 10:10:37 schrieb Caesar Wang:
> > > > >> This add the necessary binding documentation for the thermal
> > > > >> found on Rockchip SoCs
> > > > >>=20
> > > > >> Signed-off-by: zhaoyifeng <zyf@rock-chips.com>
> > > > >> Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
> > > > >> ---
> > > > >>=20
> > > > >>   .../devicetree/bindings/thermal/rockchip-thermal.txt | 20
> > > > >>=20
> > > > >> ++++++++++++++++++++ 1 file changed, 20 insertions(+)
> > > > >>=20
> > > > >>   create mode 100644
> > > > >>=20
> > > > >> Documentation/devicetree/bindings/thermal/rockchip-thermal.t=
xt
> > > > >>=20
> > > > >> diff --git
> > > > >> a/Documentation/devicetree/bindings/thermal/rockchip-thermal=
=2Etxt
> > > > >> b/Documentation/devicetree/bindings/thermal/rockchip-thermal=
=2Etxt new
> > > > >> file
> > > > >> mode 100644
> > > > >> index 0000000..1ed4d4c
> > > > >> --- /dev/null
> > > > >> +++ b/Documentation/devicetree/bindings/thermal/rockchip-the=
rmal.txt
> > > > >> @@ -0,0 +1,20 @@
> > > > >> +* Temperature Sensor ADC (TSADC) on rockchip SoCs
> > > > >> +
> > > > >> +Required properties:
> > > > >> +- compatible: "rockchip,rk3288-tsadc"
> > > > >> +- reg: physical base address of the controller and length o=
f memory
> > > > >> mapped
> > > > >> +       region.
> > > > >> +- interrupts: The interrupt number to the cpu. The interrup=
t specifier
> > > > >> format +	      depends on the interrupt controller.
> > > > >> +- clocks: Must contain an entry for each entry in clock-nam=
es.
> > > > >> +- clock-names: Shall be "tsadc" for the converter-clock, an=
d
> > > > >> "apb_pclk" for +	       the peripheral clock.
> > > > >=20
> > > > > You're using the passive-temp, critical-temp and force-shut-t=
emp
> > > > > properties in your driver without declaring them here.
> > > >=20
> > > > frankly,the about are need be declared. but  there are 4 types[=
0] for
> > > > trip in thermal framework,
> > > > there is no force-shut for me. So I want to change it three add=
itional
> > > > properties in [PATCH V4 4/4],
> > > >=20
> > > >=20
> > > > [0]
> > > > {
> > > >=20
> > > >      THERMAL_TRIP_CRITICAL,
> > > >      THERMAL_TRIP_HOT,
> > > >      THERMAL_TRIP_PASSIVE,
> > > >      THERMAL_TRIP_ACTIVE,
> > > >=20
> > > > }
> > >=20
> > > this sounds reasonable to me.
> > >=20
> > > > > But more importantly, please use the generic trip-points for =
this. I
> > > > > guess it shouldn't be a problem to introduce a "forced-shutdo=
wn"
> > > > > trippoint [0] for the additional trip-point you have - therma=
l
> > > > > maintainers, please shout if I'm wrong :-)
> > >=20
> > > what is the difference between a critical trip point and a
> > > "forced-shutdown" trip point?
> > > Thermal core will do a shutdown in case the critical trip point i=
s
> > > triggered.
> >=20
> > The forced-shutdown is where the thermal controller is supposed to =
also do a=20
>=20
> Currently, there is no discrimination between hardware configured /
> triggered thermal shutdown and software detected / triggered thermal =
shutdown.
> One way to implement it though is to reuse the critical trip type. Ev=
en
> if you use more than one trip type it is doable, it will depend on th=
e
> priorities you give to software triggered and hardware triggered.
>=20
> > shutdown in hardware. As you said the thermal core will also shutdo=
wn at the=20
> > critical trip point, I guess we could map Caesar's value like
> >=20
> > trip-point		tsadc
> > critical		forced-shutdown (the 120 degrees in patch 4)
>=20
> > hot			critical (the 100 degrees)
> > ...
> >=20
> >=20
>=20
> In the case we are planing to expand the trip type range, adding one
> specific to hardware configurable shutdown makes sense to me too.
hmmm, why? you don't want an orderly shutdown? I still do not understan=
d
why we need a hardware shutdown trip point.
Say, if we expect the system to be shutdown at 100C, I don't think we
have a chance to trigger the hardware shutdown trip point.
=46urther more, if my understanding is right, thermal core won't do
anything for the hardware shutdown trip point because the system will b=
e
shutdown automatically, right? If this is true, why bother introducing
this to thermal core?

thanks,
rui
> Alhtough, as I mention, I believe with the current generic trip types=
,
> this situation can be covered already.
>  Besides, I believe
> 'forced-shutdown' does not sound a descriptive enough though. I would
> suggest something more specific, say 'hardware-shutdown'.=20
>=20
> > >=20
> > > thanks,
> > > rui
> > >=20
> > > > It's a good option.
> > > > I can send a patch,but I don't know whether the thermal maintai=
ners will
> > > > accept it.
> > > >=20
> > > > Maybe,they have a better way to suggest it.:-)
> > > >=20
> > > >=20
> > > > PS:I will sent a new patch If I still have no received their su=
ggestions
> > > > in two days.
> > > >=20
> > > > > Heiko
> > > > >=20
> > > > >=20
> > > > > [0] in a separate patch, changing
> > > > > - thermal_trip_type enum in include/linux/thermal.h
> > > > > - trip_types mapping in drivers/thermal/of-thermal.c
> > > > > - Documentation/devicetree/bindings/thermal/thermal.txt
> > > > >=20
> > > > >> +
> > > > >> +Example:
> > > > >> +tsadc: tsadc@ff280000 {
> > > > >> +	compatible =3D "rockchip,rk3288-tsadc";
> > > > >> +	reg =3D <0xff280000 0x100>;
> > > > >> +	interrupts =3D <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> > > > >> +	clocks =3D <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
> > > > >> +	clock-names =3D "tsadc", "apb_pclk";
> > > > >> +};
> >=20
>=20


