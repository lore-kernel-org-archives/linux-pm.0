From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: document Rockchip thermal
Date: Thu, 11 Sep 2014 10:36:52 +0800
Message-ID: <1410403012.25559.69.camel@rzhang1-toshiba>
References: <1409710239-19941-1-git-send-email-caesar.wang@rock-chips.com>
	 <1410310946.25559.12.camel@rzhang1-toshiba>
	 <CAC-25o9qcddZLy8fcwEqWp7g5fXk31xhaQCcALuH+sXDgn5n8w@mail.gmail.com>
	 <1487694.oyLYSrbpA8@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1487694.oyLYSrbpA8@diego>
Sender: linux-doc-owner@vger.kernel.org
To: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: "edubezval@gmail.com" <edubezval@gmail.com>, Caesar Wang <caesar.wang@rock-chips.com>, LKML <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Tao Huang <huangtao@rock-chips.com>, Eddie Cai <cf@rock-chips.com>, Douglas Anderson <dianders@chromium.org>, dtor <dtor@chromium.org>, Chris Zhong <zyw@rock-chips.com>, "addy.ke@rock-chips.com" <addy.ke@rock-chips.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, zhaoyifeng <zyf@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 2014-09-10 at 09:24 +0200, Heiko St=C3=BCbner wrote:
> Am Dienstag, 9. September 2014, 21:14:18 schrieb edubezval@gmail.com:
> > Hello,
> >=20
> > On Tue, Sep 9, 2014 at 9:02 PM, Zhang Rui <rui.zhang@intel.com> wro=
te:
> > > On Tue, 2014-09-09 at 11:09 -0400, Eduardo Valentin wrote:
> > >> Hello
> > >>=20
> > >> On Tue, Sep 09, 2014 at 01:35:31PM +0200, Heiko St=C3=BCbner wro=
te:
> > >> > Am Dienstag, 9. September 2014, 10:27:17 schrieb Zhang Rui:
> > >> > > On Thu, 2014-09-04 at 09:02 +0800, Caesar Wang wrote:
> > >> > > > =E5=9C=A8 2014=E5=B9=B409=E6=9C=8803=E6=97=A5 16:07, Heiko=
 St=C3=BCbner =E5=86=99=E9=81=93:
> > >> > > > > Am Mittwoch, 3. September 2014, 10:10:37 schrieb Caesar =
Wang:
> > >> > > > >> This add the necessary binding documentation for the th=
ermal
> > >> > > > >> found on Rockchip SoCs
> > >> > > > >>=20
> > >> > > > >> Signed-off-by: zhaoyifeng <zyf@rock-chips.com>
> > >> > > > >> Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
> > >> > > > >> ---
> > >> > > > >>=20
> > >> > > > >>   .../devicetree/bindings/thermal/rockchip-thermal.txt =
| 20
> > >> > > > >>=20
> > >> > > > >> ++++++++++++++++++++ 1 file changed, 20 insertions(+)
> > >> > > > >>=20
> > >> > > > >>   create mode 100644
> > >> > > > >>=20
> > >> > > > >> Documentation/devicetree/bindings/thermal/rockchip-ther=
mal.txt
> > >> > > > >>=20
> > >> > > > >> diff --git
> > >> > > > >> a/Documentation/devicetree/bindings/thermal/rockchip-th=
ermal.txt
> > >> > > > >> b/Documentation/devicetree/bindings/thermal/rockchip-th=
ermal.txt
> > >> > > > >> new
> > >> > > > >> file
> > >> > > > >> mode 100644
> > >> > > > >> index 0000000..1ed4d4c
> > >> > > > >> --- /dev/null
> > >> > > > >> +++
> > >> > > > >> b/Documentation/devicetree/bindings/thermal/rockchip-th=
ermal.tx
> > >> > > > >> t
> > >> > > > >> @@ -0,0 +1,20 @@
> > >> > > > >> +* Temperature Sensor ADC (TSADC) on rockchip SoCs
> > >> > > > >> +
> > >> > > > >> +Required properties:
> > >> > > > >> +- compatible: "rockchip,rk3288-tsadc"
> > >> > > > >> +- reg: physical base address of the controller and len=
gth of
> > >> > > > >> memory
> > >> > > > >> mapped
> > >> > > > >> +       region.
> > >> > > > >> +- interrupts: The interrupt number to the cpu. The int=
errupt
> > >> > > > >> specifier
> > >> > > > >> format +           depends on the interrupt controller.
> > >> > > > >> +- clocks: Must contain an entry for each entry in cloc=
k-names.
> > >> > > > >> +- clock-names: Shall be "tsadc" for the converter-cloc=
k, and
> > >> > > > >> "apb_pclk" for +            the peripheral clock.
> > >> > > > >=20
> > >> > > > > You're using the passive-temp, critical-temp and force-s=
hut-temp
> > >> > > > > properties in your driver without declaring them here.
> > >> > > >=20
> > >> > > > frankly,the about are need be declared. but  there are 4 t=
ypes[0]
> > >> > > > for
> > >> > > > trip in thermal framework,
> > >> > > > there is no force-shut for me. So I want to change it thre=
e
> > >> > > > additional
> > >> > > > properties in [PATCH V4 4/4],
> > >> > > >=20
> > >> > > >=20
> > >> > > > [0]
> > >> > > > {
> > >> > > >=20
> > >> > > >      THERMAL_TRIP_CRITICAL,
> > >> > > >      THERMAL_TRIP_HOT,
> > >> > > >      THERMAL_TRIP_PASSIVE,
> > >> > > >      THERMAL_TRIP_ACTIVE,
> > >> > > >=20
> > >> > > > }
> > >> > >=20
> > >> > > this sounds reasonable to me.
> > >> > >=20
> > >> > > > > But more importantly, please use the generic trip-points=
 for
> > >> > > > > this. I
> > >> > > > > guess it shouldn't be a problem to introduce a "forced-s=
hutdown"
> > >> > > > > trippoint [0] for the additional trip-point you have - t=
hermal
> > >> > > > > maintainers, please shout if I'm wrong :-)
> > >> > >=20
> > >> > > what is the difference between a critical trip point and a
> > >> > > "forced-shutdown" trip point?
> > >> > > Thermal core will do a shutdown in case the critical trip po=
int is
> > >> > > triggered.
> > >> >=20
> > >> > The forced-shutdown is where the thermal controller is suppose=
d to also
> > >> > do a>>=20
> > >> Currently, there is no discrimination between hardware configure=
d /
> > >> triggered thermal shutdown and software detected / triggered the=
rmal
> > >> shutdown. One way to implement it though is to reuse the critica=
l trip
> > >> type. Even if you use more than one trip type it is doable, it w=
ill
> > >> depend on the priorities you give to software triggered and hard=
ware
> > >> triggered.
> > >>=20
> > >> > shutdown in hardware. As you said the thermal core will also s=
hutdown
> > >> > at the critical trip point, I guess we could map Caesar's valu=
e like
> > >> >=20
> > >> > trip-point          tsadc
> > >> > critical            forced-shutdown (the 120 degrees in patch =
4)
> > >> >=20
> > >> > hot                 critical (the 100 degrees)
> > >> > ...
> > >>=20
> > >> In the case we are planing to expand the trip type range, adding=
 one
> > >> specific to hardware configurable shutdown makes sense to me too=
=2E
> > >=20
> > > hmmm, why? you don't want an orderly shutdown? I still do not und=
erstand
> > > why we need a hardware shutdown trip point.
> > > Say, if we expect the system to be shutdown at 100C, I don't thin=
k we
> > > have a chance to trigger the hardware shutdown trip point.
> > > Further more, if my understanding is right, thermal core won't do
> > > anything for the hardware shutdown trip point because the system =
will be
> > > shutdown automatically, right? If this is true, why bother introd=
ucing
> > > this to thermal core?
> >=20
> > Some ICs allow configuring the temperature when the shutdown will
> > happen. That is, you setup in registers the thermal shutdown
> > threshold, and one of the output pin of the IC is wired to, say, th=
e
> > processor reset pin. Some other ICs have the threshold hardwired, a=
nd
> > cannot be configured.
> >=20
> > Those options are a last chance to avoid processors to burn, in cas=
e
> > software really gets stuck at high temperatures.
> >=20
> > The only thing that the thermal driver would need to worry is the
> > configuration step, that is, writing the value to the registers. In
> > the case the thermal core would have a specific trip type for such
> > case, the core itself would not do anything, except allowing design=
ing
> > a thermal zone with hardware shutdown trips. And thus the thermal
> > driver would do the configuration.
> >=20
> >=20
> > Currently, the way I see to implement this is to interpret critical
> > trips as the threshold to be configured at the IC registers. That i=
s,
> > reusing critical trips as orderly power down and as the hardware
> > shutdown threshold.
>=20
> which was what I also meant to express above [but seemingly failed to=
 do=20
> properly :-) ].
>=20
> Critical is specified as "Hardware not reliable", so I'd think it wou=
ldn't=20
> matter how the hw is shut down (orderly/unorderly) as long as its don=
e.

Hmmm,

As what we want is to make thermal driver have a chance to configure th=
e
hardware shutdown registers, I'm thinking if we can do this without
representing the hardware shutdown value as a trip point.
Say,
1. parse DT, and get the hardware shutdown temperature value, and store
it somewhere, e.g. struct __thermal_zone.
2. introduce a new parameter, int (*set_hardware_trip)(void *, long *),
in thermal_zone_of_sensor_register().
3. invoke set_hard_trip(tz, hardware_shutdown_temperature_value) in
thermal_zone_of_sensor_register().

thanks,
rui

