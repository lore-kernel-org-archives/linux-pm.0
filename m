From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 20/47] mfd: rn5t618: Register power-off handler with
 kernel power-off handler
Date: Mon, 3 Nov 2014 17:54:13 +0000
Message-ID: <20141103175413.GJ12011@x1>
References: <1414425354-10359-1-git-send-email-linux@roeck-us.net>
 <1414425354-10359-21-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:61317 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722AbaKCRyV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Nov 2014 12:54:21 -0500
Received: by mail-qa0-f51.google.com with SMTP id f12so8740792qad.10
        for <linux-pm@vger.kernel.org>; Mon, 03 Nov 2014 09:54:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1414425354-10359-21-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Beniamino Galvani <b.galvani@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>

On Mon, 27 Oct 2014, Guenter Roeck wrote:

> Register with kernel power-off handler instead of setting pm_power_of=
f
> directly. Register with low priority to reflect that the original cod=
e
> only sets pm_power_off if it was not already set.
>=20
> Cc: Beniamino Galvani <b.galvani@gmail.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v3:
> - Replace poweroff in all newly introduced variables and in text
>   with power_off or power-off as appropriate
> - Replace POWEROFF_PRIORITY_xxx with POWER_OFF_PRIORITY_xxx
> v2:
> - New patch
>=20
>  drivers/mfd/rn5t618.c       | 32 ++++++++++++++++----------------
>  include/linux/mfd/rn5t618.h |  2 ++
>  2 files changed, 18 insertions(+), 16 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
> index 6668571..ed564d1 100644
> --- a/drivers/mfd/rn5t618.c
> +++ b/drivers/mfd/rn5t618.c
> @@ -15,6 +15,8 @@
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/rn5t618.h>
>  #include <linux/module.h>
> +#include <linux/notifier.h>
> +#include <linux/pm.h>
>  #include <linux/regmap.h>
> =20
>  static const struct mfd_cell rn5t618_cells[] =3D {
> @@ -47,16 +49,20 @@ static const struct regmap_config rn5t618_regmap_=
config =3D {
>  	.cache_type	=3D REGCACHE_RBTREE,
>  };
> =20
> -static struct rn5t618 *rn5t618_pm_power_off;
> -
> -static void rn5t618_power_off(void)
> +static int rn5t618_power_off(struct notifier_block *this,
> +			     unsigned long unused1, void *unused2)
>  {
> +	struct rn5t618 *rn5t618 =3D container_of(this, struct rn5t618,
> +					       power_off_nb);
> +
>  	/* disable automatic repower-on */
> -	regmap_update_bits(rn5t618_pm_power_off->regmap, RN5T618_REPCNT,
> +	regmap_update_bits(rn5t618->regmap, RN5T618_REPCNT,
>  			   RN5T618_REPCNT_REPWRON, 0);
>  	/* start power-off sequence */
> -	regmap_update_bits(rn5t618_pm_power_off->regmap, RN5T618_SLPCNT,
> +	regmap_update_bits(rn5t618->regmap, RN5T618_SLPCNT,
>  			   RN5T618_SLPCNT_SWPWROFF, RN5T618_SLPCNT_SWPWROFF);
> +
> +	return NOTIFY_DONE;
>  }
> =20
>  static int rn5t618_i2c_probe(struct i2c_client *i2c,
> @@ -85,23 +91,17 @@ static int rn5t618_i2c_probe(struct i2c_client *i=
2c,
>  		return ret;
>  	}
> =20
> -	if (!pm_power_off) {
> -		rn5t618_pm_power_off =3D priv;
> -		pm_power_off =3D rn5t618_power_off;
> -	}
> +	priv->power_off_nb.notifier_call =3D rn5t618_power_off;
> +	priv->power_off_nb.priority =3D POWER_OFF_PRIORITY_LOW;
> +	ret =3D devm_register_power_off_handler(&i2c->dev, &priv->power_off=
_nb);
> +	if (ret)
> +		dev_warn(&i2c->dev, "Failed to register power-off handler\n");
> =20
>  	return 0;
>  }
> =20
>  static int rn5t618_i2c_remove(struct i2c_client *i2c)
>  {
> -	struct rn5t618 *priv =3D i2c_get_clientdata(i2c);
> -
> -	if (priv =3D=3D rn5t618_pm_power_off) {
> -		rn5t618_pm_power_off =3D NULL;
> -		pm_power_off =3D NULL;
> -	}
> -
>  	mfd_remove_devices(&i2c->dev);
>  	return 0;
>  }
> diff --git a/include/linux/mfd/rn5t618.h b/include/linux/mfd/rn5t618.=
h
> index c72d534..21c9c39 100644
> --- a/include/linux/mfd/rn5t618.h
> +++ b/include/linux/mfd/rn5t618.h> @@ -14,6 +14,7 @@
>  #ifndef __LINUX_MFD_RN5T618_H
>  #define __LINUX_MFD_RN5T618_H
> =20
> +#include <linux/notifier.h>
>  #include <linux/regmap.h>
> =20
>  #define RN5T618_LSIVER			0x00
> @@ -223,6 +224,7 @@ enum {
> =20
>  struct rn5t618 {
>  	struct regmap *regmap;
> +	struct notifier_block power_off_nb;
>  };
> =20
>  #endif /* __LINUX_MFD_RN5T618_H */

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
