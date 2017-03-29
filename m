From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [RFC PATCH 2/3] iio: adc: sun4i-gpadc-iio: add support for H3
 thermal sensor
Date: Wed, 29 Mar 2017 14:28:29 +0200
Message-ID: <20170329122829.23bezwgdywigxshh@lukather>
References: <20170329065717.D0AF37C1EFF@relay.mailchannels.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eqclnj4teheii7g7"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170329065717.D0AF37C1EFF-Y9/x5g2N/Tt0ykcd9G8QkxTxI0vvWBSX@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
Cc: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--eqclnj4teheii7g7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 29, 2017 at 02:57:02PM +0800, Icenowy Zheng wrote:
> > > @@ -691,6 +777,12 @@ static int sun4i_gpadc_remove(struct platform_de=
vice *pdev)=20
> > >=A0 if (!info->no_irq && IS_ENABLED(CONFIG_THERMAL_OF))=20
> > >=A0 iio_map_array_unregister(indio_dev);=20
> > >=A0=20
> > > + if (info->data->gen2_ths) {=20
> > > + clk_disable_unprepare(info->ths_clk);=20
> > > + clk_disable_unprepare(info->ths_bus_clk);=20
> > > + reset_control_deassert(info->reset);=20
> > > + }=20
> > > +=20
> >
> > I'm not really fond of using this boolean as I don't see it being=20
> > possibly reused for any other SoCs that has a GPADC or THS.=20
>=20
> Because you didn't care new SoCs :-)
>=20
> All SoCs after H3 (A64, H5, R40) uses the same THS architecture with
> H3.

That's not really Quentin's point. His point is that having things
like flags and/or variables to identify various behaviours that might
differ from one SoC to the other usually works better when you want to
support several of them.

For example, replacing the gen2_ths by one variable with the number of
clocks, one with the number of channels, a bool to say it has a reset,
etc. definitely works better for us when Allwinner does some mix and
match between each SoC. And this happen most of the time.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--eqclnj4teheii7g7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJY26hpAAoJEBx+YmzsjxAg54QP/3RoDQzmzpPlWUvTR00t+vK3
eIhkg+iWCr2gfqEKRQMx6KC7xQUh39vIpa6u16eOkIg06SWY032srY4lk7q7929K
bv+Hvj7VztFV/gcH6TizW/TyWwXqXxWV2LFc/GvFIZsRqUd3vdxvtfDdN1Xu45TE
w1nVGcz09LtZGdKy24iO8Q5E8cA9OHOy9SFidBURJZ7/U8bu7ApB+CKgXb685B3o
6NTzPZiQN2OLkCIqWpyzOPQgn6uHTj7kg1n6bOJypMY/t5oIQwhn+0PRxu8Jyprg
oQOj4N991ChuKi1LLMJDAqC4rcsupinMqFhsUlC6WM6bNjUMlDZl8vyhe/G1WTdY
ZUtDHPtTh8AhBrLoaKgvVAslS5DAA3r/VvjSmt7Fvip55N7BAop2L7Zu0DI5G+gZ
x6tg/gSazzdKvnhlef1Ipj5JITGot6xcUybUVprPMWVpzmvPvlbnB3n93DYxzKwJ
7yqqn53qimyBWULWRoPumUrtSdYfj1SysDmrlZ46nxW7PeuSxL5CYsfC5jPZRlH5
9QQG2Bl9vXdldn1yrGPKZWb9Pd7cuZxKiObq0yU5DyNYNufG/2BgENa9Vj8ITvUZ
JFjTqvB7ersA9pyKAHCaPkt6ykYh+QrjvWd2brHjiOKQTCO55AXwatvxPTBN2WXQ
ganghCIWcecj2qgDa6oR
=mudX
-----END PGP SIGNATURE-----

--eqclnj4teheii7g7--
