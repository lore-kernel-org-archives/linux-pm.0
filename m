From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v4 3/7] power: bq27xxx_battery: Platform initialization
 must declare a device
Date: Mon, 21 Sep 2015 10:41:29 +0200
Message-ID: <20150921084129.GH20113@pali>
References: <1442265973-32261-1-git-send-email-afd@ti.com>
 <1442265973-32261-4-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:34534 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756121AbbIUIlb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Sep 2015 04:41:31 -0400
Content-Disposition: inline
In-Reply-To: <1442265973-32261-4-git-send-email-afd@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Murphy <dmurphy@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 14 September 2015 16:26:09 Andrew F. Davis wrote:
> When initialized as a platform device the initializer must now specif=
y
> a device. An empty device name is no longer valid.
>=20
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  drivers/power/bq27xxx_battery.c       | 9 ++++++---
>  drivers/w1/slaves/w1_bq27000.c        | 1 +
>  include/linux/power/bq27xxx_battery.h | 6 +++++-
>  3 files changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/power/bq27xxx_battery.c b/drivers/power/bq27xxx_=
battery.c
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
> @@ -1036,6 +1034,11 @@ static int bq27xxx_battery_platform_probe(stru=
ct platform_device *pdev)
>  		return -EINVAL;
>  	}
> =20
> +	if (!pdata->chip) {
> +		dev_err(&pdev->dev, "no device supplied\n");
> +		return -EINVAL;
> +	}
> +
>  	di =3D devm_kzalloc(&pdev->dev, sizeof(*di), GFP_KERNEL);
>  	if (!di)
>  		return -ENOMEM;
> @@ -1043,7 +1046,7 @@ static int bq27xxx_battery_platform_probe(struc=
t platform_device *pdev)
>  	platform_set_drvdata(pdev, di);
> =20
>  	di->dev =3D &pdev->dev;
> -	di->chip =3D BQ27000;
> +	di->chip =3D pdata->chip;
> =20
>  	name =3D pdata->name ?: dev_name(&pdev->dev);
>  	di->bus.read =3D &bq27xxx_battery_platform_read;
> diff --git a/drivers/w1/slaves/w1_bq27000.c b/drivers/w1/slaves/w1_bq=
27000.c
> index 8480531..9f4a86b 100644
> --- a/drivers/w1/slaves/w1_bq27000.c
> +++ b/drivers/w1/slaves/w1_bq27000.c
> @@ -42,6 +42,7 @@ static int w1_bq27000_read(struct device *dev, unsi=
gned int reg)
>  static struct bq27xxx_platform_data bq27000_battery_info =3D {
>  	.read   =3D w1_bq27000_read,
>  	.name   =3D "bq27000-battery",
> +	.chip   =3D BQ27000,
>  };
> =20
>  static int w1_bq27000_add_slave(struct w1_slave *sl)
> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/po=
wer/bq27xxx_battery.h
> index e70a93a..a4efb10 100644
> --- a/include/linux/power/bq27xxx_battery.h
> +++ b/include/linux/power/bq27xxx_battery.h
> @@ -3,7 +3,8 @@
> =20
>  /**
>   * struct bq27xxx_plaform_data - Platform data for bq27xxx devices
> - * @name: Name of the battery. If NULL the driver will fallback to "=
bq27000".
> + * @name: Name of the battery.
> + * @chip: Chip class number of this device.
>   * @read: HDQ read callback.
>   *	This function should provide access to the HDQ bus the battery is
>   *	connected to.
> @@ -11,8 +12,11 @@
>   *	register to be read. The return value should either be the conten=
t of
>   *	the passed register or an error value.
>   */
> +enum bq27xxx_chip { BQ27000 =3D 1, BQ27500, BQ27425, BQ27742, BQ2751=
0 };
> +
>  struct bq27xxx_platform_data {
>  	const char *name;
> +	enum bq27xxx_chip chip;

Do we still need name property if we have chip enum? And if yes who use
it and why?

>  	int (*read)(struct device *dev, unsigned int);
>  };
> =20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
