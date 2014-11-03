From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 09/47] mfd: palmas: Register with kernel power-off
 handler
Date: Mon, 3 Nov 2014 17:56:45 +0000
Message-ID: <20141103175645.GT12011@x1>
References: <1414425354-10359-1-git-send-email-linux@roeck-us.net>
 <1414425354-10359-10-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:54683 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753682AbaKCR4w (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Nov 2014 12:56:52 -0500
Received: by mail-qg0-f54.google.com with SMTP id q108so9326707qgd.27
        for <linux-pm@vger.kernel.org>; Mon, 03 Nov 2014 09:56:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1414425354-10359-10-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

On Mon, 27 Oct 2014, Guenter Roeck wrote:

> Register with kernel power-off handler instead of setting pm_power_of=
f
> directly. Register with low priority to reflect that the original cod=
e
> only sets pm_power_off if it was not already set.
>=20
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v3:
> - Replace poweroff in all newly introduced variables and in text
>   with power_off or power-off as appropriate
> - Replace POWEROFF_PRIORITY_xxx with POWER_OFF_PRIORITY_xxx
> v2:
> - Use define to specify poweroff handler priority
> - Use devm_register_power_off_handler
> - Use dev_warn instead of dev_err
>=20
>  drivers/mfd/palmas.c       | 31 +++++++++++++++++--------------
>  include/linux/mfd/palmas.h |  3 +++
>  2 files changed, 20 insertions(+), 14 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
> index 28cb048..99c488e 100644
> --- a/drivers/mfd/palmas.c
> +++ b/drivers/mfd/palmas.c
> @@ -19,6 +19,7 @@
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> +#include <linux/pm.h>
>  #include <linux/regmap.h>
>  #include <linux/err.h>
>  #include <linux/mfd/core.h>
> @@ -425,20 +426,18 @@ static void palmas_dt_to_pdata(struct i2c_clien=
t *i2c,
>  			"ti,system-power-controller");
>  }
> =20
> -static struct palmas *palmas_dev;
> -static void palmas_power_off(void)
> +static int palmas_power_off(struct notifier_block *this, unsigned lo=
ng unused1,
> +			    void *unused2)
>  {
> +	struct palmas *palmas =3D container_of(this, struct palmas, power_o=
ff_nb);
>  	unsigned int addr;
>  	int ret, slave;
> =20
> -	if (!palmas_dev)
> -		return;
> -
>  	slave =3D PALMAS_BASE_TO_SLAVE(PALMAS_PMU_CONTROL_BASE);
>  	addr =3D PALMAS_BASE_TO_REG(PALMAS_PMU_CONTROL_BASE, PALMAS_DEV_CTR=
L);
> =20
>  	ret =3D regmap_update_bits(
> -			palmas_dev->regmap[slave],
> +			palmas->regmap[slave],
>  			addr,
>  			PALMAS_DEV_CTRL_DEV_ON,
>  			0);
> @@ -446,6 +445,8 @@ static void palmas_power_off(void)
>  	if (ret)
>  		pr_err("%s: Unable to write to DEV_CTRL_DEV_ON: %d\n",
>  				__func__, ret);
> +
> +	return NOTIFY_DONE;
>  }
> =20
>  static unsigned int palmas_features =3D PALMAS_PMIC_FEATURE_SMPS10_B=
OOST;
> @@ -668,9 +669,16 @@ no_irq:
>  		ret =3D of_platform_populate(node, NULL, NULL, &i2c->dev);
>  		if (ret < 0) {
>  			goto err_irq;
> -		} else if (pdata->pm_off && !pm_power_off) {
> -			palmas_dev =3D palmas;
> -			pm_power_off =3D palmas_power_off;
> +		} else if (pdata->pm_off) {
> +			int ret2;
> +
> +			palmas->power_off_nb.notifier_call =3D palmas_power_off;
> +			palmas->power_off_nb.priority =3D POWER_OFF_PRIORITY_LOW;
> +			ret2 =3D devm_register_power_off_handler(palmas->dev,
> +							&palmas->power_off_nb);
> +			if (ret2)
> +				dev_warn(palmas->dev,
> +					 "Failed to register power-off handler");
>  		}
>  	}
> =20
> @@ -698,11 +706,6 @@ static int palmas_i2c_remove(struct i2c_client *=
i2c)
>  			i2c_unregister_device(palmas->i2c_clients[i]);
>  	}
> =20
> -	if (palmas =3D=3D palmas_dev) {
> -		pm_power_off =3D NULL;
> -		palmas_dev =3D NULL;
> -	}
> -
>  	return 0;
>  }
> =20
> diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.h
> index fb0390a..7dbfe24 100644
> --- a/include/linux/mfd/palmas.h
> +++ b/include/linux/mfd/palmas.h
> @@ -18,6 +18,7 @@
> =20
>  #include <linux/usb/otg.h>
>  #include <linux/leds.h>
> +#include <linux/notifier.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/driver.h>
>  #include <linux/extcon.h>
> @@ -68,6 +69,8 @@ struct palmas {
>  	struct i2c_client *i2c_clients[PALMAS_NUM_CLIENTS];
>  	struct regmap *regmap[PALMAS_NUM_CLIENTS];
> =20
> +	struct notifier_block power_off_nb;
> +
>  	/* Stored chip id */
>  	int id;
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
