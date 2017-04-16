From: icenowy-h8G6r0blFSE@public.gmane.org
Subject: Re: [PATCH 4/5] ARM: sun8i: h3: add operating-points-v2
 table for CPU
Date: Mon, 17 Apr 2017 05:06:03 +0800
Message-ID: <847eab30a8f58aef9888df206c0536a4@aosc.io>
References: <20170408185025.53841-1-icenowy@aosc.io>
 <20170408185025.53841-5-icenowy@aosc.io>
 <20170411091346.mcwyskezadabsobn@lukather>
 <b37490ed1282f45542168701dea332bb@aosc.io>
 <20170416205740.b5pk3kcxwaegij6g@lukather>
Reply-To: icenowy-h8G6r0blFSE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDS6XAN6ZADRBPNZZ7DQKGQEQPTQMAQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170416205740.b5pk3kcxwaegij6g@lukather>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

=E5=9C=A8 2017-04-17 04:57=EF=BC=8CMaxime Ripard =E5=86=99=E9=81=93=EF=BC=
=9A
> On Tue, Apr 11, 2017 at 09:28:55PM +0800, icenowy-h8G6r0blFSE@public.gmane.org wrote:
>> =E5=9C=A8 2017-04-11 17:13=EF=BC=8CMaxime Ripard =E5=86=99=E9=81=93=EF=
=BC=9A
>> > On Sun, Apr 09, 2017 at 02:50:24AM +0800, Icenowy Zheng wrote:
>> > > The CPU on Allwinner H3 can do dynamic frequency scaling.
>> > >
>> > > Add a DVFS table based on the one tweaked by Armbian developers, whi=
ch
>> > > are proven to work stably on BSP kernels.
>> > >
>> > > Frequencies higher than 1008MHz are temporarily dropped in the
>> > > table, as
>> > > they may lead to over voltage on boards without proper regulator
>> > > settings or over temperature on boards with proper regulator setting=
s.
>> > > They will be added back once regulator settings are ready and therma=
l
>> > > sensor driver is merged.
>> > >
>> > > In order to satisfy all different regulators (SY8106A which is 50mV
>> > > per
>> > > level, SY8113B which have two states: 1.1V and 1.3V, and some board
>> > > with
>> > > non-tweakable regulators), all the OPPs are defined with a range
>> > > which has
>> > > the target value as the minimum allowed value, and 1.3V (the highest
>> > > VDD-CPUX voltage suggested by the datasheet) as the maximum allowed
>> > > value.
>> > > It's proven to work well with a board with SY8113B.
>> > >
>> > > Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
>> > > ---
>> > >  arch/arm/boot/dts/sun8i-h3.dtsi | 38
>> > > +++++++++++++++++++++++++++++++++++++-
>> > >  1 file changed, 37 insertions(+), 1 deletion(-)
>> > >
>> > > diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi
>> > > b/arch/arm/boot/dts/sun8i-h3.dtsi
>> > > index b36f9f423c39..a0cee17fe44b 100644
>> > > --- a/arch/arm/boot/dts/sun8i-h3.dtsi
>> > > +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
>> > > @@ -43,32 +43,68 @@
>> > >  #include "sunxi-h3-h5.dtsi"
>> > >
>> > >  / {
>> > > +	cpu0_opp_table: opp_table0 {
>> > > +		compatible =3D "operating-points-v2";
>> > > +		opp-shared;
>> > > +
>> > > +		opp@480000000 {
>> > > +			opp-hz =3D /bits/ 64 <480000000>;
>> > > +			opp-microvolt =3D <980000 980000 1300000>;
>> > > +			clock-latency-ns =3D <244144>; /* 8 32k periods */
>> > > +		};
>> > > +
>> > > +		opp@648000000 {
>> > > +			opp-hz =3D /bits/ 64 <816000000>;
>> > > +			opp-microvolt =3D <1020000 1020000 1300000>;
>> > > +			clock-latency-ns =3D <244144>; /* 8 32k periods */
>> > > +		};
>> > > +
>> > > +		opp@912000000 {
>> > > +			opp-hz =3D /bits/ 64 <960000000>;
>> > > +			opp-microvolt =3D <1080000 1080000 1300000>;
>> > > +			clock-latency-ns =3D <244144>; /* 8 32k periods */
>> > > +		};
>> > > +
>> > > +		opp@1008000000 {
>> > > +			opp-hz =3D /bits/ 64 <1008000000>;
>> > > +			opp-microvolt =3D <1140000 1140000 1300000>;
>> > > +			clock-latency-ns =3D <244144>; /* 8 32k periods */
>> > > +		};
>> > > +	};
>> > > +
>> >
>> > From your serie, I guess you never actually tested those OPPs on any
>> > board without SY8113B, right?
>>=20
>> Yes. But I will test them on an Orange Pi PC (newly got) soon.
>=20
> The orange pi pc also uses the SY8113B.

I checked the wiki, it says "The Orange Pi PC board uses the
SY8106A voltage regulator for providing the CPU core voltage
(VDD_CPUX). The default CPU voltage is 1.2V after power-on
(selected by the resistors on the PCB) and can be changed at
runtime by software via I2C interface. According to the table
above, this default voltage should be safe for using with the
CPU clock frequencies up to 1008MHz. The H3 datasheet specifies
1.5V as the absolute maximum for the VDD_CPUX voltage and
1.4V as the recommended maximum." in the "Xunlong Orange Pi PC"
page.

>=20
>> (After all PLL_CPUX-related things are well fixed)
>>=20
>> P.S. how to implement such a thing:
>>=20
>> - Before tweaking CPUX clock, first switch it to osc24M
>>   (implemented yet)
>> - Before tweaking PLL_CPUX clock (triggered by tweaking CPUX
>>   clock), first gate it
>> - After tweaking PLL_CPUX clock, ungate it and wait it to be stable
>> - After tweaking PLL_CPUX clock, change CPUX mux back to PLL_CPUX
>>   (implemented yet)
>>=20
>> I think notifiers on PLL_CPUX can be used to implement the second
>> and third part?
>=20
> Do you still have any issues with the code we merged?

No problem... But I think the H3 part of the patch is still not merged
yet...

>=20
> Maxime

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
