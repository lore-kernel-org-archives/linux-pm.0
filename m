From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
Subject: Re: [RFC Patch 1/4] mfd: AXP20x: Add power supply
 bindings documentation
Date: Tue, 4 Nov 2014 22:08:27 +0100
Message-ID: <20141104220827.773c53d0@neptune.home>
References: <20141020221959.2f312906@neptune.home>
	<20141020223314.0484f795@neptune.home>
	<20141021101503.GE26842@x1>
	<20141021180916.432f02e1@neptune.home>
	<20141021191905.GR21108@lukather>
	<20141103210244.1425e0c7@neptune.home>
	<20141104143117.GC26729@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/Gqzk0vJrYu6YQjio3VNksv7"; protocol="application/pgp-signature"
Return-path: <linux-sunxi+bncBDCZ5GUK4UNRBZUA4WRAKGQE4R47IQA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20141104143117.GC26729@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Olliver Schinagl <oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--Sig_/Gqzk0vJrYu6YQjio3VNksv7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Maxime,

On Tue, 04 November 2014 Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> w=
rote:
> On Mon, Nov 03, 2014 at 09:02:44PM +0100, Bruno Pr=C3=A9mont wrote:=20
> > Doing something like this?:
> >=20
> > --- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> > +++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> > @@ -126,9 +126,11 @@
> >                                 interrupt-controller;
> >                                 #interrupt-cells =3D <1>;
> > =20
> > -                               backup =3D <3000000 200>;
> > -                               battery.resistance =3D <100>;
> > -                               battery.capacity =3D <2000>;
> > +                               x-powers,backup =3D <3000000 200>;
>=20
> I don't really remember what was that property used for. Would it make
> sense to put it into the battery node?

The backup/rtc battery is completely distinct from main battery.

It's presence is in no way related to that of the main battery,
thus I would not put it into the same node.
As all the information needed is included in the property I see
no reason to move it into a separate node.

> > +                               battery: battery@0 {
> > +                                       x-powers,resistance =3D <100>;
> > +                                       x-powers,capacity =3D <2000>;
> > +                               };
> >                         };
> >                 };
> >=20
> > What are the rules to define the label after the colon?
> > Looking at the existing nodes it's either some address or a number...
>=20
> It's not called the label, but the node name, and it's defined in the
> ePAPR.
>=20
> It's <device-class>[@<address>]
>=20
> The address being something to identify the node on a bus, so it can
> be a chip select number, a memory address, an i2c address,
> etc. there's really no absolute answer here.
>=20
> I don't think you really need one in this case.

In that case, I better omit it completely.

> > and then the following in driver code (also adjusting the other
> > property names accessed)?:
> >=20
> > @@ -678,11 +677,11 @@ static int axp20x_battery_config(struct platform_=
device *pdev,
> >         if (ret)
> >                 return ret;
> > =20
> > -       np =3D of_node_get(axp20x->dev->of_node);
> > +       np =3D of_find_node_by_name(axp20x->dev->of_node, "battery");
> >         if (!np)
> >                 return -ENODEV;
> > =20
> > -       ret =3D of_property_read_u32_array(np, "battery.ocv", ocv, 16);
> > +       ret =3D of_property_read_u32_array(np, "x-powers,ocv", ocv, 16);
> >         for (i =3D 0; ret =3D=3D 0 && i < ARRAY_SIZE(ocv); i++)
> >                 if (ocv[i] > 100) {
> >                         dev_warn(&pdev->dev, "OCV[%d] %u > 100\n", i, o=
cv[i]);
>=20
> Yep, it looks sensible.

Thanks,
Bruno

--Sig_/Gqzk0vJrYu6YQjio3VNksv7
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBAgAGBQJUWUBaAAoJECnQXSfLoWYAxToMAKWCBK/DChJwjnaGpCAMTlaw
WzP1KW9RGovmAxuxUEtxB+5V+LGCp+CT/BUQQlR50WeAZpml2ctaypruZdaK341H
bNn0Tzla8etB5U7WMJc9n7b3kbfXVRB+K4DYiRrDLC8ieP4/OlGpeEVlwclr6A88
J3WkPVf2laZjPsAkDQDWK1uyYXA6tqOiJN2S0JQFC5KCAA7YXj8+A0C2Dt1e0PD9
3Vai7jVbolEJ9mODMmryLz6yOFi2a0FPXPThtnlsgsMWAXqnNcEXakKeDicVXdgE
7MZ++GTIKTDXrB2DB8a9U9uBq7huUoOVIEDAVevXtXfmahG32M1TZIXRQIrbflcw
E2g1vojsiN/+plBvHKUwFpH/1OzRH+eDPEZcyiLAvnUYxoj27SAneBfh6j1GyPQ/
tPjWDH4BY1gDa4OY2o0Cs3Wco6nx2sWXzXN/Qyycxm6DsW+nVLJuXwNLZBlERA9Y
T5uPfhyFMXcynzbOKPU/i8COlrvZaB1tevOV5fXAiQ==
=12DF
-----END PGP SIGNATURE-----

--Sig_/Gqzk0vJrYu6YQjio3VNksv7--
