From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 13/47] mfd: max8907: Register with kernel power-off
 handler
Date: Mon, 3 Nov 2014 17:56:02 +0000
Message-ID: <20141103175602.GQ12011@x1>
References: <1414425354-10359-1-git-send-email-linux@roeck-us.net>
 <1414425354-10359-14-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:38469 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753571AbaKCR4J (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Nov 2014 12:56:09 -0500
Received: by mail-qg0-f50.google.com with SMTP id a108so9251580qge.9
        for <linux-pm@vger.kernel.org>; Mon, 03 Nov 2014 09:56:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1414425354-10359-14-git-send-email-linux@roeck-us.net>
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
> Note that this patch fixes a problem on driver unload as side effect:
> The old code did not restore or clean up pm_power_off on remove,
> meaning the pointer was left in an undefined state.
>=20
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v3:
> - Replace poweroff in all newly introduced variables and in text
>   with power_off or power-off as appropriate
> - Replace POWEROFF_PRIORITY_xxx with POWER_OFF_PRIORITY_xxx
> v2:
> - Use define to specify poweroff handler priority
> - Use dev_warn instead of dev_err
>=20
>  drivers/mfd/max8907.c       | 24 ++++++++++++++++++------
>  include/linux/mfd/max8907.h |  2 ++
>  2 files changed, 20 insertions(+), 6 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/max8907.c b/drivers/mfd/max8907.c
> index 232749c..a159230 100644
> --- a/drivers/mfd/max8907.c
> +++ b/drivers/mfd/max8907.c
> @@ -19,6 +19,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/pm.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> =20
> @@ -177,11 +178,16 @@ static const struct regmap_irq_chip max8907_rtc=
_irq_chip =3D {
>  	.num_irqs =3D ARRAY_SIZE(max8907_rtc_irqs),
>  };
> =20
> -static struct max8907 *max8907_pm_off;
> -static void max8907_power_off(void)
> +static int max8907_power_off(struct notifier_block *this, unsigned l=
ong unused1,
> +			     void *unused2)
>  {
> -	regmap_update_bits(max8907_pm_off->regmap_gen, MAX8907_REG_RESET_CN=
=46G,
> +	struct max8907 *max8907 =3D container_of(this, struct max8907,
> +					       power_off_nb);
> +
> +	regmap_update_bits(max8907->regmap_gen, MAX8907_REG_RESET_CNFG,
>  			MAX8907_MASK_POWER_OFF, MAX8907_MASK_POWER_OFF);
> +
> +	return NOTIFY_DONE;
>  }
> =20
>  static int max8907_i2c_probe(struct i2c_client *i2c,
> @@ -267,9 +273,13 @@ static int max8907_i2c_probe(struct i2c_client *=
i2c,
>  		goto err_add_devices;
>  	}
> =20
> -	if (pm_off && !pm_power_off) {
> -		max8907_pm_off =3D max8907;
> -		pm_power_off =3D max8907_power_off;
> +	if (pm_off) {
> +		max8907->power_off_nb.notifier_call =3D max8907_power_off;
> +		max8907->power_off_nb.priority =3D POWER_OFF_PRIORITY_LOW;
> +		ret =3D register_power_off_handler(&max8907->power_off_nb);
> +		if (ret)
> +			dev_warn(&i2c->dev,
> +				 "Failed to register power-off handler");
>  	}
> =20
>  	return 0;
> @@ -293,6 +303,8 @@ static int max8907_i2c_remove(struct i2c_client *=
i2c)
>  {
>  	struct max8907 *max8907 =3D i2c_get_clientdata(i2c);
> =20
> +	unregister_power_off_handler(&max8907->power_off_nb);
> +
>  	mfd_remove_devices(max8907->dev);
> =20
>  	regmap_del_irq_chip(max8907->i2c_gen->irq, max8907->irqc_rtc);
> diff --git a/include/linux/mfd/max8907.h b/include/linux/mfd/max8907.=
h
> index b06f7a6..d8a341d 100644
> --- a/include/linux/mfd/max8907.h
> +++ b/include/linux/mfd/max8907.h
> @@ -13,6 +13,7 @@
>  #define __LINUX_MFD_MAX8907_H
> =20
>  #include <linux/mutex.h>
> +#include <linux/notifier.h>
>  #include <linux/pm.h>
> =20
>  #define MAX8907_GEN_I2C_ADDR		(0x78 >> 1)
> @@ -247,6 +248,7 @@ struct max8907 {
>  	struct regmap_irq_chip_data	*irqc_chg;
>  	struct regmap_irq_chip_data	*irqc_on_off;
>  	struct regmap_irq_chip_data	*irqc_rtc;
> +	struct notifier_block		power_off_nb;
>  };
> =20
>  #endif

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
