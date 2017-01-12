From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: axp20x_usb_power: fix warning on 64bit
Date: Thu, 12 Jan 2017 03:55:35 +0100
Message-ID: <20170112025535.nvw7ig53mvb6mcg2@earth>
References: <20170110174812.19026-1-msuchanek@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rnqry2hkn6sel7qw"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750701AbdALCzk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Jan 2017 21:55:40 -0500
Content-Disposition: inline
In-Reply-To: <20170110174812.19026-1-msuchanek@suse.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michal Suchanek <msuchanek@suse.de>
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee.jones@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--rnqry2hkn6sel7qw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Michal,

On Tue, Jan 10, 2017 at 06:48:12PM +0100, Michal Suchanek wrote:
> Casting of_device_get_match_data return value to int causes warning on 64=
bit
> architectures.
>=20
> ../drivers/power/supply/axp20x_usb_power.c: In function
> 'axp20x_usb_power_probe':
> ../drivers/power/supply/axp20x_usb_power.c:297:21: warning: cast from
> pointer to integer of different size [-Wpointer-to-int-cast]
>=20
> Fixes: 0dcc70ca8644 ("power: supply: axp20x_usb_power: use of_device_id
>     data field instead of device_is_compatible")
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  drivers/power/supply/axp20x_usb_power.c | 5 +++--
>  include/linux/mfd/axp20x.h              | 2 +-
>  2 files changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supp=
ly/axp20x_usb_power.c
> index 1bcb02551e02..632a33fe2d54 100644
> --- a/drivers/power/supply/axp20x_usb_power.c
> +++ b/drivers/power/supply/axp20x_usb_power.c
> @@ -48,7 +48,7 @@ struct axp20x_usb_power {
>  	struct device_node *np;
>  	struct regmap *regmap;
>  	struct power_supply *supply;
> -	int axp20x_id;
> +	enum axp20x_variants axp20x_id;
>  };
> =20
>  static irqreturn_t axp20x_usb_power_irq(int irq, void *devid)
> @@ -294,7 +294,8 @@ static int axp20x_usb_power_probe(struct platform_dev=
ice *pdev)
>  	if (!power)
>  		return -ENOMEM;
> =20
> -	power->axp20x_id =3D (int)of_device_get_match_data(&pdev->dev);
> +	power->axp20x_id =3D (enum axp20x_variants)of_device_get_match_data(
> +								&pdev->dev);
> =20
>  	power->np =3D pdev->dev.of_node;
>  	power->regmap =3D axp20x->regmap;
> diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
> index 0aa4ef7157b8..0d9a1ff38393 100644
> --- a/include/linux/mfd/axp20x.h
> +++ b/include/linux/mfd/axp20x.h
> @@ -13,7 +13,7 @@
> =20
>  #include <linux/regmap.h>
> =20
> -enum {
> +enum axp20x_variants {
>  	AXP152_ID =3D 0,
>  	AXP202_ID,
>  	AXP209_ID,

Thanks, queued into power-supply's for-next branch.

-- Sebastian

--rnqry2hkn6sel7qw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlh28CcACgkQ2O7X88g7
+prA7BAAlLMAg7/K5sUp9ju/Vb7FFZb+xaYuH4RUuKTex1rhcyI/6gfEwWaKwrIa
x3VUbwz7qqYwr620k5aO0ekmb3M/jz7YxsCAu69m2/I1HYEhdA+bR4ie5XrcCz3a
eeSu4UCU8adIv8+0XKlBYgELN8OO36oUR4ydoZBppZs99rO4pAFifiOrRnQQbShB
hpljr/Xx8bS0e1wNhGqkszmv7Iqgt1olYTgjiXx5epAOj9L62woR9dgZ37xL2N39
4AvVsM8ssNVgI4AChLdPUO0VBU0f2J9fOMURVYGiDErN9fWK8efSPlYcWJHY0bSQ
3gvGo3fnGWNtVg2VL0b2GLbHSX6LqzsNxSxwx8iQeBebnHOtY5MyaBGFO6WfTThq
qeVishMHFix5GslmBabFV127QRW8nSybBY8B9ZxfB/M0YhpS5zN3678oFL170Iym
6Vf0VKPGNcTFcILJzhd8TXnvtragNsUMbUAsd198UIMjpHvIk9iZXFqOYrJ9ysZI
SCJuggfW1rSd3mSHGYscvKuTc0YdiQci9qnR1FkAEmNivWtRVidYNArzyBgKvD/X
c05/du7O9yswRevnI2ccWzYHyomyoTigzYCE+/1J91WWFGfBc6+ts5UyaX5O1zA+
5IaFxKVljHi1WqQCnhRHO+vxh7ktTzogiSRDy04AqZW8E0WVMp8=
=PAZ0
-----END PGP SIGNATURE-----

--rnqry2hkn6sel7qw--
