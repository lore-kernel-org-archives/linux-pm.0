From: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 2/4] dt-bindings: document Rockchip thermal
Date: Thu, 11 Sep 2014 08:18:43 -0400
Message-ID: <20140911121842.GB26715@developer>
References: <1409710239-19941-1-git-send-email-caesar.wang@rock-chips.com>
 <1410310946.25559.12.camel@rzhang1-toshiba>
 <CAC-25o9qcddZLy8fcwEqWp7g5fXk31xhaQCcALuH+sXDgn5n8w@mail.gmail.com>
 <1487694.oyLYSrbpA8@diego>
 <1410403012.25559.69.camel@rzhang1-toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1410403012.25559.69.camel@rzhang1-toshiba>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Caesar Wang <caesar.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tao Huang <huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Eddie Cai <cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, dtor <dtor-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Chris Zhong <zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org" <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, zhaoyifeng <zyf-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hello Rui,

On Thu, Sep 11, 2014 at 10:36:52AM +0800, Zhang Rui wrote:
> On Wed, 2014-09-10 at 09:24 +0200, Heiko St=C3=BCbner wrote:
> > Am Dienstag, 9. September 2014, 21:14:18 schrieb edubezval-Re5JQEeQqe8@public.gmane.org=
m:
> > > Hello,
> > >=20
> > > On Tue, Sep 9, 2014 at 9:02 PM, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> w=
rote:
> > > > On Tue, 2014-09-09 at 11:09 -0400, Eduardo Valentin wrote:
> > > >> Hello
> > > >>=20
> > > >> On Tue, Sep 09, 2014 at 01:35:31PM +0200, Heiko St=C3=BCbner w=
rote:
> > > >> > Am Dienstag, 9. September 2014, 10:27:17 schrieb Zhang Rui:
> > > >> > > On Thu, 2014-09-04 at 09:02 +0800, Caesar Wang wrote:
> > > >> > > > =E5=9C=A8 2014=E5=B9=B409=E6=9C=8803=E6=97=A5 16:07, Hei=
ko St=C3=BCbner =E5=86=99=E9=81=93:
> > > >> > > > > Am Mittwoch, 3. September 2014, 10:10:37 schrieb Caesa=
r Wang:
> > > >> > > > >> This add the necessary binding documentation for the =
thermal
> > > >> > > > >> found on Rockchip SoCs
> > > >> > > > >>=20
> > > >> > > > >> Signed-off-by: zhaoyifeng <zyf-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> > > >> > > > >> Signed-off-by: Caesar Wang <caesar.wang-TNX95d0MmH5qZ5pVbMyqKg@public.gmane.org=
m>
> > > >> > > > >> ---
> > > >> > > > >>=20
> > > >> > > > >>   .../devicetree/bindings/thermal/rockchip-thermal.tx=
t | 20
> > > >> > > > >>=20
> > > >> > > > >> ++++++++++++++++++++ 1 file changed, 20 insertions(+)
> > > >> > > > >>=20
> > > >> > > > >>   create mode 100644
> > > >> > > > >>=20
> > > >> > > > >> Documentation/devicetree/bindings/thermal/rockchip-th=
ermal.txt
> > > >> > > > >>=20
> > > >> > > > >> diff --git
> > > >> > > > >> a/Documentation/devicetree/bindings/thermal/rockchip-=
thermal.txt
> > > >> > > > >> b/Documentation/devicetree/bindings/thermal/rockchip-=
thermal.txt
> > > >> > > > >> new
> > > >> > > > >> file
> > > >> > > > >> mode 100644
> > > >> > > > >> index 0000000..1ed4d4c
> > > >> > > > >> --- /dev/null
> > > >> > > > >> +++
> > > >> > > > >> b/Documentation/devicetree/bindings/thermal/rockchip-=
thermal.tx
> > > >> > > > >> t
> > > >> > > > >> @@ -0,0 +1,20 @@
> > > >> > > > >> +* Temperature Sensor ADC (TSADC) on rockchip SoCs
> > > >> > > > >> +
> > > >> > > > >> +Required properties:
> > > >> > > > >> +- compatible: "rockchip,rk3288-tsadc"
> > > >> > > > >> +- reg: physical base address of the controller and l=
ength of
> > > >> > > > >> memory
> > > >> > > > >> mapped
> > > >> > > > >> +       region.
> > > >> > > > >> +- interrupts: The interrupt number to the cpu. The i=
nterrupt
> > > >> > > > >> specifier
> > > >> > > > >> format +           depends on the interrupt controlle=
r.
> > > >> > > > >> +- clocks: Must contain an entry for each entry in cl=
ock-names.
> > > >> > > > >> +- clock-names: Shall be "tsadc" for the converter-cl=
ock, and
> > > >> > > > >> "apb_pclk" for +            the peripheral clock.
> > > >> > > > >=20
> > > >> > > > > You're using the passive-temp, critical-temp and force=
-shut-temp
> > > >> > > > > properties in your driver without declaring them here.
> > > >> > > >=20
> > > >> > > > frankly,the about are need be declared. but  there are 4=
 types[0]
> > > >> > > > for
> > > >> > > > trip in thermal framework,
> > > >> > > > there is no force-shut for me. So I want to change it th=
ree
> > > >> > > > additional
> > > >> > > > properties in [PATCH V4 4/4],
> > > >> > > >=20
> > > >> > > >=20
> > > >> > > > [0]
> > > >> > > > {
> > > >> > > >=20
> > > >> > > >      THERMAL_TRIP_CRITICAL,
> > > >> > > >      THERMAL_TRIP_HOT,
> > > >> > > >      THERMAL_TRIP_PASSIVE,
> > > >> > > >      THERMAL_TRIP_ACTIVE,
> > > >> > > >=20
> > > >> > > > }
> > > >> > >=20
> > > >> > > this sounds reasonable to me.
> > > >> > >=20
> > > >> > > > > But more importantly, please use the generic trip-poin=
ts for
> > > >> > > > > this. I
> > > >> > > > > guess it shouldn't be a problem to introduce a "forced=
-shutdown"
> > > >> > > > > trippoint [0] for the additional trip-point you have -=
 thermal
> > > >> > > > > maintainers, please shout if I'm wrong :-)
> > > >> > >=20
> > > >> > > what is the difference between a critical trip point and a
> > > >> > > "forced-shutdown" trip point?
> > > >> > > Thermal core will do a shutdown in case the critical trip =
point is
> > > >> > > triggered.
> > > >> >=20
> > > >> > The forced-shutdown is where the thermal controller is suppo=
sed to also
> > > >> > do a>>=20
> > > >> Currently, there is no discrimination between hardware configu=
red /
> > > >> triggered thermal shutdown and software detected / triggered t=
hermal
> > > >> shutdown. One way to implement it though is to reuse the criti=
cal trip
> > > >> type. Even if you use more than one trip type it is doable, it=
 will
> > > >> depend on the priorities you give to software triggered and ha=
rdware
> > > >> triggered.
> > > >>=20
> > > >> > shutdown in hardware. As you said the thermal core will also=
 shutdown
> > > >> > at the critical trip point, I guess we could map Caesar's va=
lue like
> > > >> >=20
> > > >> > trip-point          tsadc
> > > >> > critical            forced-shutdown (the 120 degrees in patc=
h 4)
> > > >> >=20
> > > >> > hot                 critical (the 100 degrees)
> > > >> > ...
> > > >>=20
> > > >> In the case we are planing to expand the trip type range, addi=
ng one
> > > >> specific to hardware configurable shutdown makes sense to me t=
oo.
> > > >=20
> > > > hmmm, why? you don't want an orderly shutdown? I still do not u=
nderstand
> > > > why we need a hardware shutdown trip point.
> > > > Say, if we expect the system to be shutdown at 100C, I don't th=
ink we
> > > > have a chance to trigger the hardware shutdown trip point.
> > > > Further more, if my understanding is right, thermal core won't =
do
> > > > anything for the hardware shutdown trip point because the syste=
m will be
> > > > shutdown automatically, right? If this is true, why bother intr=
oducing
> > > > this to thermal core?
> > >=20
> > > Some ICs allow configuring the temperature when the shutdown will
> > > happen. That is, you setup in registers the thermal shutdown
> > > threshold, and one of the output pin of the IC is wired to, say, =
the
> > > processor reset pin. Some other ICs have the threshold hardwired,=
 and
> > > cannot be configured.
> > >=20
> > > Those options are a last chance to avoid processors to burn, in c=
ase
> > > software really gets stuck at high temperatures.
> > >=20
> > > The only thing that the thermal driver would need to worry is the
> > > configuration step, that is, writing the value to the registers. =
In
> > > the case the thermal core would have a specific trip type for suc=
h
> > > case, the core itself would not do anything, except allowing desi=
gning
> > > a thermal zone with hardware shutdown trips. And thus the thermal
> > > driver would do the configuration.
> > >=20
> > >=20
> > > Currently, the way I see to implement this is to interpret critic=
al
> > > trips as the threshold to be configured at the IC registers. That=
 is,
> > > reusing critical trips as orderly power down and as the hardware
> > > shutdown threshold.
> >=20
> > which was what I also meant to express above [but seemingly failed =
to do=20
> > properly :-) ].
> >=20
> > Critical is specified as "Hardware not reliable", so I'd think it w=
ouldn't=20
> > matter how the hw is shut down (orderly/unorderly) as long as its d=
one.
>=20
> Hmmm,
>=20
> As what we want is to make thermal driver have a chance to configure =
the
> hardware shutdown registers, I'm thinking if we can do this without
> representing the hardware shutdown value as a trip point.
> Say,
> 1. parse DT, and get the hardware shutdown temperature value, and sto=
re
> it somewhere, e.g. struct __thermal_zone.
> 2. introduce a new parameter, int (*set_hardware_trip)(void *, long *=
),
> in thermal_zone_of_sensor_register().
> 3. invoke set_hard_trip(tz, hardware_shutdown_temperature_value) in
> thermal_zone_of_sensor_register().


The only issue I have with the above proposal is that not all platforms
use DT. Some still boot with boardfiles, for instance. Thus, the
parameter to configure hardware thermal shutdown needs to be common on
thermal core, not specific to of-thermal. Do you agree?


>=20
> thanks,
> rui
>=20
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
