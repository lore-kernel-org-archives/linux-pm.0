From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v4 2/4] dt-bindings: document Rockchip thermal
Date: Tue, 09 Sep 2014 13:35:31 +0200
Message-ID: <8397565.n78cHk4EtL@diego>
References: <1409710239-19941-1-git-send-email-caesar.wang@rock-chips.com> <5407BA10.2030402@rock-chips.com> <1410229637.8085.158.camel@rzhang1-toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1410229637.8085.158.camel@rzhang1-toshiba>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Caesar Wang <caesar.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dtor-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org, addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, zhaoyifeng <zyf-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Am Dienstag, 9. September 2014, 10:27:17 schrieb Zhang Rui:
> On Thu, 2014-09-04 at 09:02 +0800, Caesar Wang wrote:
> > =E5=9C=A8 2014=E5=B9=B409=E6=9C=8803=E6=97=A5 16:07, Heiko St=C3=BC=
bner =E5=86=99=E9=81=93:
> > > Am Mittwoch, 3. September 2014, 10:10:37 schrieb Caesar Wang:
> > >> This add the necessary binding documentation for the thermal
> > >> found on Rockchip SoCs
> > >>=20
> > >> Signed-off-by: zhaoyifeng <zyf-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> > >> Signed-off-by: Caesar Wang <caesar.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> > >> ---
> > >>=20
> > >>   .../devicetree/bindings/thermal/rockchip-thermal.txt | 20
> > >>=20
> > >> ++++++++++++++++++++ 1 file changed, 20 insertions(+)
> > >>=20
> > >>   create mode 100644
> > >>=20
> > >> Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> > >>=20
> > >> diff --git
> > >> a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> > >> b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt=
 new
> > >> file
> > >> mode 100644
> > >> index 0000000..1ed4d4c
> > >> --- /dev/null
> > >> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal=
=2Etxt
> > >> @@ -0,0 +1,20 @@
> > >> +* Temperature Sensor ADC (TSADC) on rockchip SoCs
> > >> +
> > >> +Required properties:
> > >> +- compatible: "rockchip,rk3288-tsadc"
> > >> +- reg: physical base address of the controller and length of me=
mory
> > >> mapped
> > >> +       region.
> > >> +- interrupts: The interrupt number to the cpu. The interrupt sp=
ecifier
> > >> format +	      depends on the interrupt controller.
> > >> +- clocks: Must contain an entry for each entry in clock-names.
> > >> +- clock-names: Shall be "tsadc" for the converter-clock, and
> > >> "apb_pclk" for +	       the peripheral clock.
> > >=20
> > > You're using the passive-temp, critical-temp and force-shut-temp
> > > properties in your driver without declaring them here.
> >=20
> > frankly,the about are need be declared. but  there are 4 types[0] f=
or
> > trip in thermal framework,
> > there is no force-shut for me. So I want to change it three additio=
nal
> > properties in [PATCH V4 4/4],
> >=20
> >=20
> > [0]
> > {
> >=20
> >      THERMAL_TRIP_CRITICAL,
> >      THERMAL_TRIP_HOT,
> >      THERMAL_TRIP_PASSIVE,
> >      THERMAL_TRIP_ACTIVE,
> >=20
> > }
>=20
> this sounds reasonable to me.
>=20
> > > But more importantly, please use the generic trip-points for this=
=2E I
> > > guess it shouldn't be a problem to introduce a "forced-shutdown"
> > > trippoint [0] for the additional trip-point you have - thermal
> > > maintainers, please shout if I'm wrong :-)
>=20
> what is the difference between a critical trip point and a
> "forced-shutdown" trip point?
> Thermal core will do a shutdown in case the critical trip point is
> triggered.

The forced-shutdown is where the thermal controller is supposed to also=
 do a=20
shutdown in hardware. As you said the thermal core will also shutdown a=
t the=20
critical trip point, I guess we could map Caesar's value like

trip-point		tsadc
critical		forced-shutdown (the 120 degrees in patch 4)
hot			critical (the 100 degrees)
=2E..


>=20
> thanks,
> rui
>=20
> > It's a good option.
> > I can send a patch,but I don't know whether the thermal maintainers=
 will
> > accept it.
> >=20
> > Maybe,they have a better way to suggest it.:-)
> >=20
> >=20
> > PS:I will sent a new patch If I still have no received their sugges=
tions
> > in two days.
> >=20
> > > Heiko
> > >=20
> > >=20
> > > [0] in a separate patch, changing
> > > - thermal_trip_type enum in include/linux/thermal.h
> > > - trip_types mapping in drivers/thermal/of-thermal.c
> > > - Documentation/devicetree/bindings/thermal/thermal.txt
> > >=20
> > >> +
> > >> +Example:
> > >> +tsadc: tsadc@ff280000 {
> > >> +	compatible =3D "rockchip,rk3288-tsadc";
> > >> +	reg =3D <0xff280000 0x100>;
> > >> +	interrupts =3D <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> > >> +	clocks =3D <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
> > >> +	clock-names =3D "tsadc", "apb_pclk";
> > >> +};

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
