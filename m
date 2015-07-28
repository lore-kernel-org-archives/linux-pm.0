From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v2 3/6] power: bq27xxx_battery: Platform initialization must declare a device
Date: Tue, 28 Jul 2015 22:13:37 +0200
Message-ID: <201507282213.37788@pali>
References: <1438112353-19704-1-git-send-email-afd@ti.com> <1438112353-19704-4-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3289540.TCki9DXBbK";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:38332 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbbG1UNl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2015 16:13:41 -0400
In-Reply-To: <1438112353-19704-4-git-send-email-afd@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Murphy <dmurphy@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

--nextPart3289540.TCki9DXBbK
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 28 July 2015 21:39:10 Andrew F. Davis wrote:
> When initialized as a platform device the initializer must now specify
> a device. An empty device name is no longer valid.
>=20
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  drivers/power/bq27xxx_battery.c       | 9 ++++++---
>  drivers/w1/slaves/w1_bq27000.c        | 1 +
>  include/linux/power/bq27xxx_battery.h | 6 +++++-
>  3 files changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/power/bq27xxx_battery.c b/drivers/power/bq27xxx_batt=
ery.c
> index e72055c..0734413 100644
> --- a/drivers/power/bq27xxx_battery.c
> +++ b/drivers/power/bq27xxx_battery.c
> @@ -91,8 +91,6 @@ struct bq27xxx_access_methods {
>  	int (*read)(struct bq27xxx_device_info *di, u8 reg, bool single);
>  };
> =20
> -enum bq27xxx_chip { BQ27000, BQ27500, BQ27425, BQ27742, BQ27510};
> -
>  struct bq27xxx_reg_cache {
>  	int temperature;
>  	int time_to_empty;
> @@ -1036,6 +1034,11 @@ static int bq27xxx_battery_platform_probe(struct p=
latform_device *pdev)
>  		return -EINVAL;
>  	}
> =20
> +	if (!pdata->chip) {

Will this work?

Is not first value of enum equal to zero? BQ27000 =3D=3D 0 ?

> +		dev_err(&pdev->dev, "no device supplied\n");
> +		return -EINVAL;
> +	}
> +
>  	di =3D devm_kzalloc(&pdev->dev, sizeof(*di), GFP_KERNEL);
>  	if (!di)
>  		return -ENOMEM;
> @@ -1043,7 +1046,7 @@ static int bq27xxx_battery_platform_probe(struct pl=
atform_device *pdev)
>  	platform_set_drvdata(pdev, di);
> =20
>  	di->dev =3D &pdev->dev;
> -	di->chip =3D BQ27000;
> +	di->chip =3D pdata->chip;
> =20
>  	name =3D pdata->name ?: dev_name(&pdev->dev);
>  	di->bus.read =3D &bq27xxx_battery_platform_read;
> diff --git a/drivers/w1/slaves/w1_bq27000.c b/drivers/w1/slaves/w1_bq2700=
0.c
> index 8480531..ba8bf3d 100644
> --- a/drivers/w1/slaves/w1_bq27000.c
> +++ b/drivers/w1/slaves/w1_bq27000.c
> @@ -42,6 +42,7 @@ static int w1_bq27000_read(struct device *dev, unsigned=
 int reg)
>  static struct bq27xxx_platform_data bq27000_battery_info =3D {
>  	.read   =3D w1_bq27000_read,
>  	.name   =3D "bq27000-battery",
> +	.chip	=3D BQ27000,
          ^
Just small problem, but for me visible different spacing of previous lines

>  };
> =20
>  static int w1_bq27000_add_slave(struct w1_slave *sl)
> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/=
bq27xxx_battery.h
> index e70a93a..70d3865 100644
> --- a/include/linux/power/bq27xxx_battery.h
> +++ b/include/linux/power/bq27xxx_battery.h
> @@ -3,7 +3,8 @@
> =20
>  /**
>   * struct bq27xxx_plaform_data - Platform data for bq27xxx devices
> - * @name: Name of the battery. If NULL the driver will fallback to "bq27=
000".
> + * @name: Name of the battery.

Now I'm trying to understand what name =3D NULL will do...

It is this above code?

  	name =3D pdata->name ?: dev_name(&pdev->dev);

Then it looks like it just set device name. Maybe stupid question, but do w=
e need such property? What other people think?

> + * @chip: Chip class number of this device.
>   * @read: HDQ read callback.
>   *	This function should provide access to the HDQ bus the battery is
>   *	connected to.
> @@ -11,8 +12,11 @@
>   *	register to be read. The return value should either be the content of
>   *	the passed register or an error value.
>   */
> +enum bq27xxx_chip { BQ27000, BQ27500, BQ27425, BQ27742, BQ27510 };
> +
>  struct bq27xxx_platform_data {
>  	const char *name;
> +	enum bq27xxx_chip chip;
>  	int (*read)(struct device *dev, unsigned int);
>  };
> =20
>=20

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart3289540.TCki9DXBbK
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlW34nEACgkQi/DJPQPkQ1KHjwCgx2QS0xiyOwnYntKtAfxMGZbB
t8cAniNZ92ab3reaGA8DJMJS9wPI8hWd
=VgKV
-----END PGP SIGNATURE-----

--nextPart3289540.TCki9DXBbK--
