From: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
Subject: Re: [RFC PATCH v2 1/4] dt-bindings: update the
 Allwinner GPADC device tree binding for H3
Date: Thu, 06 Apr 2017 03:11:38 +0800
Message-ID: <58e61093.8c9d810a.74942.1a49SMTPIN_ADDED_MISSING@gmr-mx.google.com>
Reply-To: icenowy-h8G6r0blFSE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDS6XAN6ZADRBFNBTDDQKGQEHHE62EI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


2017=E5=B9=B44=E6=9C=886=E6=97=A5 03:04=E4=BA=8E Rob Herring <robh@kernel.o=
rg>=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Apr 4, 2017 at 10:02 AM, Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org> wrote:=
=20
> >=20
> >=20
> > =E5=9C=A8 2017=E5=B9=B404=E6=9C=8804=E6=97=A5 22:47, Rob Herring =E5=86=
=99=E9=81=93:=20
> >>=20
> >> On Sun, Apr 02, 2017 at 09:33:01PM +0800, Icenowy Zheng wrote:=20
> >>>=20
> >>> Allwinner H3 features a thermal sensor like the one in A33, but has i=
ts=20
> >>> register re-arranged, the clock divider moved to CCU (originally the=
=20
> >>> clock divider is in ADC) and added a pair of bus clock and reset.=20
> >>>=20
> >>> Update the binding document to cover H3.=20
> >>>=20
> >>> Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>=20
> >>> ---=20
> >>>=C2=A0 .../devicetree/bindings/mfd/sun4i-gpadc.txt=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 23=20
> >>> ++++++++++++++++++++--=20
> >>>=C2=A0 1 file changed, 21 insertions(+), 2 deletions(-)=20
> >>>=20
> >>> diff --git a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt=20
> >>> b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt=20
> >>> index badff3611a98..7753133ca0ff 100644=20
> >>> --- a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt=20
> >>> +++ b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt=20
> >>> @@ -4,12 +4,20 @@ The Allwinner SoCs all have an ADC that can also ac=
t as=20
> >>> a thermal sensor=20
> >>>=C2=A0 and sometimes as a touchscreen controller.=20
> >>>=20
> >>>=C2=A0 Required properties:=20
> >>> -=C2=A0 - compatible: "allwinner,sun8i-a33-ths",=20
> >>> +=C2=A0 - compatible: must contain one of the following compatibles:=
=20
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 - "allwinner,sun8i-a33-ths"=20
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 - "allwinner,sun8i-h3-ths"=20
> >>>=C2=A0=C2=A0=C2=A0 - reg: mmio address range of the chip,=20
> >>>=C2=A0=C2=A0=C2=A0 - #thermal-sensor-cells: shall be 0,=20
> >>>=C2=A0=C2=A0=C2=A0 - #io-channel-cells: shall be 0,=20
> >>>=20
> >>> -Example:=20
> >>> +Required properties for the following compatibles:=20
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 - "allwinner,sun8i-h3-ths"=20
> >>> +=C2=A0 - clocks: the bus clock and the input clock of the ADC,=20
> >>> +=C2=A0 - clock-names: should be "bus" and "ths",=20
> >>> +=C2=A0 - resets: the bus reset of the ADC,=20
> >>> +=20
> >>> +Example for A33:=20
> >>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ths: ths@01c25000 {=
=20
> >>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "allwinner,sun8i-a33-ths";=20
> >>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x01c25000 0x100>;=20
> >>> @@ -17,6 +25,17 @@ Example:=20
> >>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 #io-channel-cells =3D <0>;=20
> >>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };=20
> >>>=20
> >>> +Example for H3:=20
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ths: ths@01c25000 {=20
> >>=20
> >>=20
> >> adc@...=20
> >=20
> >=20
> > It's a thermal sensor, so I think call it THS is more appropriate=20
> > here. It's implemented as an ADC driver just because the internal=20
> > code reusing of Linux. From device tree binding view I choose to=20
> > call it ths.=20
>
> There's numerous occurrences in this file and the filename that call it a=
n ADC.=20
>
> Furthermore, node names are supposed to be generic, not part #'s or=20
> whatever you decide to make up. So pick from adc or temperature-sensor=20
> as those are the standard names .=20

OK. I will make it :
ths: temperature-sensor@1c25000

(Calling it temperature sensor is according to the datasheet name)

>
> Rob=20

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
