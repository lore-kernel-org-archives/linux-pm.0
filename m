From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 4/5] ARM: sun8i: h3: add operating-points-v2
 table for CPU
Date: Sun, 16 Apr 2017 22:57:40 +0200
Message-ID: <20170416205740.b5pk3kcxwaegij6g@lukather>
References: <20170408185025.53841-1-icenowy@aosc.io>
 <20170408185025.53841-5-icenowy@aosc.io>
 <20170411091346.mcwyskezadabsobn@lukather>
 <b37490ed1282f45542168701dea332bb@aosc.io>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cm2i76qkahjar4av"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBRNVZ7DQKGQEEK6SQLI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <b37490ed1282f45542168701dea332bb-h8G6r0blFSE@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: icenowy-h8G6r0blFSE@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--cm2i76qkahjar4av
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 11, 2017 at 09:28:55PM +0800, icenowy-h8G6r0blFSE@public.gmane.org wrote:
> =E5=9C=A8 2017-04-11 17:13=EF=BC=8CMaxime Ripard =E5=86=99=E9=81=93=EF=BC=
=9A
> > On Sun, Apr 09, 2017 at 02:50:24AM +0800, Icenowy Zheng wrote:
> > > The CPU on Allwinner H3 can do dynamic frequency scaling.
> > >=20
> > > Add a DVFS table based on the one tweaked by Armbian developers, whic=
h
> > > are proven to work stably on BSP kernels.
> > >=20
> > > Frequencies higher than 1008MHz are temporarily dropped in the
> > > table, as
> > > they may lead to over voltage on boards without proper regulator
> > > settings or over temperature on boards with proper regulator settings=
.
> > > They will be added back once regulator settings are ready and thermal
> > > sensor driver is merged.
> > >=20
> > > In order to satisfy all different regulators (SY8106A which is 50mV
> > > per
> > > level, SY8113B which have two states: 1.1V and 1.3V, and some board
> > > with
> > > non-tweakable regulators), all the OPPs are defined with a range
> > > which has
> > > the target value as the minimum allowed value, and 1.3V (the highest
> > > VDD-CPUX voltage suggested by the datasheet) as the maximum allowed
> > > value.
> > > It's proven to work well with a board with SY8113B.
> > >=20
> > > Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
> > > ---
> > >  arch/arm/boot/dts/sun8i-h3.dtsi | 38
> > > +++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 37 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi
> > > b/arch/arm/boot/dts/sun8i-h3.dtsi
> > > index b36f9f423c39..a0cee17fe44b 100644
> > > --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> > > +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> > > @@ -43,32 +43,68 @@
> > >  #include "sunxi-h3-h5.dtsi"
> > >=20
> > >  / {
> > > +	cpu0_opp_table: opp_table0 {
> > > +		compatible =3D "operating-points-v2";
> > > +		opp-shared;
> > > +
> > > +		opp@480000000 {
> > > +			opp-hz =3D /bits/ 64 <480000000>;
> > > +			opp-microvolt =3D <980000 980000 1300000>;
> > > +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> > > +		};
> > > +
> > > +		opp@648000000 {
> > > +			opp-hz =3D /bits/ 64 <816000000>;
> > > +			opp-microvolt =3D <1020000 1020000 1300000>;
> > > +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> > > +		};
> > > +
> > > +		opp@912000000 {
> > > +			opp-hz =3D /bits/ 64 <960000000>;
> > > +			opp-microvolt =3D <1080000 1080000 1300000>;
> > > +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> > > +		};
> > > +
> > > +		opp@1008000000 {
> > > +			opp-hz =3D /bits/ 64 <1008000000>;
> > > +			opp-microvolt =3D <1140000 1140000 1300000>;
> > > +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> > > +		};
> > > +	};
> > > +
> >=20
> > From your serie, I guess you never actually tested those OPPs on any
> > board without SY8113B, right?
>=20
> Yes. But I will test them on an Orange Pi PC (newly got) soon.

The orange pi pc also uses the SY8113B.

> (After all PLL_CPUX-related things are well fixed)
>=20
> P.S. how to implement such a thing:
>=20
> - Before tweaking CPUX clock, first switch it to osc24M
>   (implemented yet)
> - Before tweaking PLL_CPUX clock (triggered by tweaking CPUX
>   clock), first gate it
> - After tweaking PLL_CPUX clock, ungate it and wait it to be stable
> - After tweaking PLL_CPUX clock, change CPUX mux back to PLL_CPUX
>   (implemented yet)
>=20
> I think notifiers on PLL_CPUX can be used to implement the second
> and third part?

Do you still have any issues with the code we merged?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--cm2i76qkahjar4av
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJY89rAAAoJEBx+YmzsjxAgOzwP/jpRJFjgp3aeBLtwStuz4uE9
uQzb2d/5yP2giFv0z0KAjzjjReebGO8TFBv963eq+tSOLtZbsPt5AK9EgL7PMB9h
2AVqQRbdDIAjFdVFKnfkbHm32ijsApn/y8+MKdj9Dbu11IiNUXbyKdOd604wXwK/
3GtL0mtnmskLjZpuENlZKa+DcHg/yxDSib4l5uzRmLtK8oAO75KhjF2958JGyI2N
KUbt1Qj/ULhMjSouQatxv34tA8bM8QZaJVVMBDIyeNTppTT875ZbmlPUSKJpjN0j
egDVsP5xJLJ2oJTP0xOYZoeY3X2MTqiIXTMlTmgJP3DyYRqZiu06YvEwcOOc6ZKj
II/JmDNuRMOFHTz5EfF9dTyYDvECjC6OggHgXlpc/n7xqOxrHe7cJ/a+wrLiX9Lq
WNazIF/1xKkPOM762+aoJULYnfCNTmbBHg/+dtv3X0oaYfRkCKIRJeuTeufOyCm3
3ChUy7wlmQ9IocOVRAQoj8JIz+niqs3HKujzeXYHkAz3sBBdLjwspuBYPnarr7dH
S1tVURcFMpIErSy0y9c23QaG5P53JSbzkqv3B9PKrGWdMUwLl4hlrI84x4H52LWt
NePTjGGl6k/lLbHvb047cX+x23bkOD0Fus3ExBFxlSrihEy2rKykbvxiDt/dQKBM
6hzKeBGgLYRpfZ5Y4Hip
=Tl9L
-----END PGP SIGNATURE-----

--cm2i76qkahjar4av--
