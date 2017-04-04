From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [RFC PATCH v2 1/4] dt-bindings: update the
 Allwinner GPADC device tree binding for H3
Date: Tue, 4 Apr 2017 15:20:01 +0200
Message-ID: <20170404132001.4et5yaovpnqmbe6v@lukather>
References: <20170402133304.56824-1-icenowy@aosc.io>
 <20170402133304.56824-2-icenowy@aosc.io>
 <20170403091523.6atl7nq4m2qkpn3d@lukather>
 <e4d50e78-afe7-6107-6d9a-15e4c732d79a@aosc.io>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="anxvhyjov4mrkalh"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBDF3R3DQKGQEECEU63Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <e4d50e78-afe7-6107-6d9a-15e4c732d79a-h8G6r0blFSE@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--anxvhyjov4mrkalh
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2017 at 05:31:11PM +0800, Icenowy Zheng wrote:
>=20
>=20
> =E5=9C=A8 2017=E5=B9=B404=E6=9C=8803=E6=97=A5 17:15, Maxime Ripard =E5=86=
=99=E9=81=93:
> > On Sun, Apr 02, 2017 at 09:33:01PM +0800, Icenowy Zheng wrote:
> > > Allwinner H3 features a thermal sensor like the one in A33, but has i=
ts
> > > register re-arranged, the clock divider moved to CCU (originally the
> > > clock divider is in ADC) and added a pair of bus clock and reset.
> > >=20
> > > Update the binding document to cover H3.
> > >=20
> > > Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
> > > ---
> > >  .../devicetree/bindings/mfd/sun4i-gpadc.txt        | 23 ++++++++++++=
++++++++--
> > >  1 file changed, 21 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt b/=
Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> > > index badff3611a98..7753133ca0ff 100644
> > > --- a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> > > +++ b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> > > @@ -4,12 +4,20 @@ The Allwinner SoCs all have an ADC that can also ac=
t as a thermal sensor
> > >  and sometimes as a touchscreen controller.
> > >=20
> > >  Required properties:
> > > -  - compatible: "allwinner,sun8i-a33-ths",
> > > +  - compatible: must contain one of the following compatibles:
> > > +		- "allwinner,sun8i-a33-ths"
> > > +		- "allwinner,sun8i-h3-ths"
> > >    - reg: mmio address range of the chip,
> > >    - #thermal-sensor-cells: shall be 0,
> > >    - #io-channel-cells: shall be 0,
> > >=20
> > > -Example:
> > > +Required properties for the following compatibles:
> > > +		- "allwinner,sun8i-h3-ths"
> > > +  - clocks: the bus clock and the input clock of the ADC,
> > > +  - clock-names: should be "bus" and "ths",
> >=20
> > I guess mod instead of ths would be more consistent.
>=20
> In fact I will prefer "sample" here if not "ths", as it's used
> for the sampling, not like other mod clocks, which controls
> all the IP block's logic.

All the other mod clocks control some sort of sampling. The audio mod
clocks will be used to sample data in capture, same thing for NAND,
MMC, SPI, etc.

Please remain consistent.

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

--anxvhyjov4mrkalh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJY4519AAoJEBx+YmzsjxAgwJIP/2Tc8hkHB4Jh1aLo9Rwax23D
J8hQLRMi3tEcP+FdmfJn8WPk462xNgYStRn/vJaFrOOxFvqkoQI5Yw89m8oCEdl7
iZVPc957vhSsdP9HhQDJwgIhfeWBHWMgU+5t+Mod5tqVaH885D6d6uhWvqJybdS4
pYZ1SKmZbE3IGqkvKnyyNTV2IcYzJHF2MnF7lQWnA8WQHStZ78syKC26RoU0zMM7
UIfBbGrh7K5flRWRtH82Vd53x8eZ9RM7HqJw3Fbe90ocpLPtmSCeOWLvGgSQuxJr
N09UacJJPNt8W5YcfPSRuJbNnEpbRtlWWN1BbBdFHjnCEuvDyjsxa6lsbsCYWazW
BtBlA2gl0ebgfqEwYYhkCMOp68PazAMl+LQMfcPWcX+tRTkxk4T+j8zCL4fyBGuB
RG5XDLHCMjmbfoMcWr+vstwJ3joykvXq6641lt7oYgedR3AEwbygE30Tv7YmNjr0
9cjDOqFLigCi0g9sKUWfw8lETRwN+TAq0aGIDLMztOmrQQvWAP3CUZRAXEcXqYmA
vHGFuwT+C062V906DlAGbFNumjyBCEkxaPw0HOt0K6iPVQuPKfWWR72vb04XfYV2
CKpW6jyP2hyGgSQFAx8xsvU6M+ou5WsD4cBmbQLWRXztVhtWxHk/4wPLfi8fD8AS
JLsLLPuy3qqGQy1AC1rW
=PqyA
-----END PGP SIGNATURE-----

--anxvhyjov4mrkalh--
