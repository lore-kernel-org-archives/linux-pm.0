From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [RFC Patch 1/4] mfd: AXP20x: Add power supply
 bindings documentation
Date: Tue, 4 Nov 2014 15:31:17 +0100
Message-ID: <20141104143117.GC26729@lukather>
References: <20141020221959.2f312906@neptune.home>
 <20141020223314.0484f795@neptune.home>
 <20141021101503.GE26842@x1>
 <20141021180916.432f02e1@neptune.home>
 <20141021191905.GR21108@lukather>
 <20141103210244.1425e0c7@neptune.home>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E13BgyNx05feLLmH"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBF6I4ORAKGQEEKRI7JA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141103210244.1425e0c7-hY15tx4IgV39zxVx7UNMDg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Olliver Schinagl <oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--E13BgyNx05feLLmH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Bruno,

On Mon, Nov 03, 2014 at 09:02:44PM +0100, Bruno Pr=E9mont wrote:=20
> Doing something like this?:
>=20
> --- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> @@ -126,9 +126,11 @@
>                                 interrupt-controller;
>                                 #interrupt-cells =3D <1>;
> =20
> -                               backup =3D <3000000 200>;
> -                               battery.resistance =3D <100>;
> -                               battery.capacity =3D <2000>;
> +                               x-powers,backup =3D <3000000 200>;

I don't really remember what was that property used for. Would it make
sense to put it into the battery node?

> +                               battery: battery@0 {
> +                                       x-powers,resistance =3D <100>;
> +                                       x-powers,capacity =3D <2000>;
> +                               };
>                         };
>                 };
>=20
> What are the rules to define the label after the colon?
> Looking at the existing nodes it's either some address or a number...

It's not called the label, but the node name, and it's defined in the
ePAPR.

It's <device-class>[@<address>]

The address being something to identify the node on a bus, so it can
be a chip select number, a memory address, an i2c address,
etc. there's really no absolute answer here.

I don't think you really need one in this case.

> and then the following in driver code (also adjusting the other
> property names accessed)?:
>=20
> @@ -678,11 +677,11 @@ static int axp20x_battery_config(struct platform_de=
vice *pdev,
>         if (ret)
>                 return ret;
> =20
> -       np =3D of_node_get(axp20x->dev->of_node);
> +       np =3D of_find_node_by_name(axp20x->dev->of_node, "battery");
>         if (!np)
>                 return -ENODEV;
> =20
> -       ret =3D of_property_read_u32_array(np, "battery.ocv", ocv, 16);
> +       ret =3D of_property_read_u32_array(np, "x-powers,ocv", ocv, 16);
>         for (i =3D 0; ret =3D=3D 0 && i < ARRAY_SIZE(ocv); i++)
>                 if (ocv[i] > 100) {
>                         dev_warn(&pdev->dev, "OCV[%d] %u > 100\n", i, ocv=
[i]);

Yep, it looks sensible.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--E13BgyNx05feLLmH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUWOM1AAoJEBx+YmzsjxAg1WwQAMDbMeqLnmCtULwz/x0yQrZN
9mgu2+JFchfr7zPfWsO0dIQ4uj5bGQgzkswxBKawK/c4MG9BZvlBDF4mSGkbzHLK
C4FaHBHCjxFcsap8Iy8dl9/9hkJ54ZCYX7eRr69pJ+18Qa3sneNxBM/galD1rzpW
nP+a0oEtsT2I0BwYXsztQKyQkAbKGGXwHqQrhlNvp6z0nmUlu5ZLKLuGAff1yW3x
deccGCO51i2zI6+I+Y/1VikSt/4EbsqMqg+lM9ZikGPjOTz5J1s5oa102rJTD9Ij
ogH0rMD3tmovHzgQHhN4R4o17Cm2wxRFZglFRyLE7vqjdJYhe0L63cVJ3k7Rhjs6
WMaf1aBF7cjnUtGGiq8U0OxKXSu61Ghq+iAMjBTqaersF6BGy72P2LAovpb5XNcm
KY8/xhVJmuPE/tcT/Y8sUDL4FPPDF/rXn+Myem/pcJ3diBE24H5yPieveKhIVTQs
fwke802rQ/UWeQjEkojm0Fv5r0WV/HZOuHbwZHvgT8WJO1Jay/jLMzyD6Xhk8C1+
3TKrvGKBM/T0rmRybQv9IJEAcdVezdKEiSBneaITIbraCZDDPM0X7Czh9BZ0xjHs
tXVsDx3tA6D4x9bc9o84V/I2h8Ft/j/DpECIhlXnbNDp4aT0Ysq69DHE3EnxVh80
7Ke8BxUn4q1woTbAtgwA
=G5Yt
-----END PGP SIGNATURE-----

--E13BgyNx05feLLmH--
