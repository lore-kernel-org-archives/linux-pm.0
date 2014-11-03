From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 16/47] mfd: tps6586x: Register with kernel power-off
 handler
Date: Mon, 3 Nov 2014 17:54:53 +0000
Message-ID: <20141103175453.GM12011@x1>
References: <1414425354-10359-1-git-send-email-linux@roeck-us.net>
 <1414425354-10359-17-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1414425354-10359-17-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

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
> - Use dev_warn instead of dev_err
>=20
>  drivers/mfd/tps6586x.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
> index 8e1dbc4..1e97478 100644
> --- a/drivers/mfd/tps6586x.c
> +++ b/drivers/mfd/tps6586x.c
> @@ -21,10 +21,12 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/notifier.h>
>  #include <linux/slab.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm.h>
>  #include <linux/regmap.h>
>  #include <linux/of.h>
> =20
> @@ -133,6 +135,8 @@ struct tps6586x {
>  	u32			irq_en;
>  	u8			mask_reg[5];
>  	struct irq_domain	*irq_domain;
> +
> +	struct notifier_block	power_off_nb;
>  };
> =20
>  static inline struct tps6586x *dev_to_tps6586x(struct device *dev)
> @@ -472,13 +476,18 @@ static const struct regmap_config tps6586x_regm=
ap_config =3D {
>  	.cache_type =3D REGCACHE_RBTREE,
>  };
> =20
> -static struct device *tps6586x_dev;
> -static void tps6586x_power_off(void)
> +static int tps6586x_power_off(struct notifier_block *this,
> +			      unsigned long unused1, void *unused2)
>  {
> -	if (tps6586x_clr_bits(tps6586x_dev, TPS6586X_SUPPLYENE, EXITSLREQ_B=
IT))
> -		return;
> +	struct tps6586x *tps6586x =3D container_of(this, struct tps6586x,
> +						 power_off_nb);
> +
> +	if (tps6586x_clr_bits(tps6586x->dev, TPS6586X_SUPPLYENE, EXITSLREQ_=
BIT))
> +		return NOTIFY_DONE;
> =20
> -	tps6586x_set_bits(tps6586x_dev, TPS6586X_SUPPLYENE, SLEEP_MODE_BIT)=
;
> +	tps6586x_set_bits(tps6586x->dev, TPS6586X_SUPPLYENE, SLEEP_MODE_BIT=
);
> +
> +	return NOTIFY_DONE;
>  }
> =20
>  static void tps6586x_print_version(struct i2c_client *client, int ve=
rsion)
> @@ -575,9 +584,13 @@ static int tps6586x_i2c_probe(struct i2c_client =
*client,
>  		goto err_add_devs;
>  	}
> =20
> -	if (pdata->pm_off && !pm_power_off) {
> -		tps6586x_dev =3D &client->dev;
> -		pm_power_off =3D tps6586x_power_off;
> +	if (pdata->pm_off) {
> +		tps6586x->power_off_nb.notifier_call =3D tps6586x_power_off;
> +		tps6586x->power_off_nb.priority =3D POWER_OFF_PRIORITY_LOW;
> +		ret =3D register_power_off_handler(&tps6586x->power_off_nb);
> +		if (ret)
> +			dev_warn(&client->dev,
> +				 "failed to register power-off handler\n");
>  	}
> =20
>  	return 0;
> @@ -594,6 +607,8 @@ static int tps6586x_i2c_remove(struct i2c_client =
*client)
>  {
>  	struct tps6586x *tps6586x =3D i2c_get_clientdata(client);
> =20
> +	unregister_power_off_handler(&tps6586x->power_off_nb);
> +
>  	tps6586x_remove_subdevs(tps6586x);
>  	mfd_remove_devices(tps6586x->dev);
>  	if (client->irq)

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
