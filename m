From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 08/22] power: supply: add AC power supply driver for
 AXP20X and AXP22X PMICs
Date: Fri, 27 Jan 2017 09:20:17 +0100
Message-ID: <20170127082017.ffvybk237ku2n5hu@lukather>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-9-quentin.schulz@free-electrons.com>
 <20170117030013.g5xhlmrxpthyfewa@earth>
 <6a3edb64-8ea9-cb14-b826-d6e8e2c4c4b7@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p6edpgvoug4j3ser"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6a3edb64-8ea9-cb14-b826-d6e8e2c4c4b7@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: Sebastian Reichel <sre@kernel.org>, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org, linux@armlinux.org.uk, lee.jones@linaro.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com, icenowy@aosc.xyz, bonbons@linux-vserver.org
List-Id: linux-pm@vger.kernel.org


--p6edpgvoug4j3ser
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 26, 2017 at 02:32:21PM +0100, Quentin Schulz wrote:
> I've come with this solution:
>=20
> ------------------------------------------------------------------------
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 012c064..117eacb 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -882,7 +882,7 @@ EXPORT_SYMBOL(axp20x_match_device);
>=20
>  int axp20x_device_probe(struct axp20x_dev *axp20x)
>  {
> -	int ret;
> +	int ret, irq_base;
>=20
>  	ret =3D regmap_add_irq_chip(axp20x->regmap, axp20x->irq,
>  				  IRQF_ONESHOT | IRQF_SHARED, -1,
> @@ -893,8 +893,9 @@ int axp20x_device_probe(struct axp20x_dev *axp20x)
>  		return ret;
>  	}
>=20
> +	irq_base =3D regmap_irq_chip_get_base(axp20x->regmap_irqc);
>  	ret =3D mfd_add_devices(axp20x->dev, -1, axp20x->cells,
> -			      axp20x->nr_cells, NULL, 0, NULL);
> +			      axp20x->nr_cells, NULL, irq_base, NULL);
>=20
>  	if (ret) {
>  		dev_err(axp20x->dev, "failed to add MFD devices: %d\n", ret);
> ------------------------------------------------------------------------
>=20
> However, this implies that all cells added by the mfd driver which are
> requesting irqs will need to be changed in the same commit to remove the
> regmap_irq_get_virq calls. If we don't modify the drivers, they will
> purely fail to request the irqs.
>=20
> The impacted drivers are the following:
>=20
>  - drivers/extcon/extcon-axp288.c
>  - drivers/input/misc/axp20x-pek.c
>  - drivers/power/supply/axp20x_usb_power.c
>  - drivers/power/supply/axp288_charger.c
>  - drivers/power/supply/axp288_fuel_gauge.c
>=20
> Is it really worth to do such a cleanup?

Yes. The current behaviour goes against what everyone is expecting
=66rom the API.

> I'm assuming that impacting four different subsystems at the same
> time might require a bit of time to make the patch into the
> kernel. I don't see also another way than doing one single patch for
> all changes since the changes in the mfd driver will break all
> aforementioned drivers.

However, I think that can be fixed in a later, independant serie. This
serie is quite big already and this has been long overdue, so I'd
really like not to delay it once again because of a dependency on a
cross-tree cleanup.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--p6edpgvoug4j3ser
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYiwLBAAoJEBx+YmzsjxAg7ZsQAKDMjib2vZGpD8DtTS6kXpN5
5vN2m6Hc5QEUJVsgXPmoYAW9ZZxsi9wwx9zqJiyVqGHYr4Md1b7q5w/4M11RqBt7
6VCLodDFhOwIKSUumuTVu5jDA+CkNf0MY9aJ4pl07Nr2K3LAXIN8j6wlIc5LqlMg
IneG0PwveFqOAh9ua8qMA8hwLg+2P7j+Xz4zluzk8+ayPn2EnmEi9RA9buuihOFo
QvxwWcROcKdlIeBV0JReNgZDN/VF/Nd4t7lBojEfvBHPLVayMouqLkwKQz8vj0sz
HPtBVEsIrvyw6MJAhETj3nD/lxJAgTkaR0WX0tPWj+vlz58rRrqR7dZ1qb8oexFQ
H9nSJHmQY3jduahPFnoX56hA7YkJKnc4lY310Oro3Sd7by6T9agQRnpSlImKNI8m
xesscn/eungfXxJvCs/eKQBQi2O3k9Z88yMdiKtSqwYUKv+jK9wi87J7avG/LQXK
E/ZCdkbltX4BJyfDxKa0LL5XsQyc4Ue2Jz3HguRh6VgygmeKAtdMafxZh6t4Erjd
joBFLHwKPp27yp8iyYVKOaHlhVKyrgjVEHZp4aCXCU74PDOCLiLuj7elPTKt/U6C
9mMVJ4mB7Arl8M2TTzmKEmIDpym8e6JMGDOgUjh56YkySPoEg/PcmUcX+fEaqjzG
nGr5xoarIJ+19XpIZM9W
=we+B
-----END PGP SIGNATURE-----

--p6edpgvoug4j3ser--
