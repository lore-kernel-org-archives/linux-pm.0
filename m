From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 10/47] mfd: axp20x: Register with kernel power-off
 handler
Date: Mon, 3 Nov 2014 17:56:31 +0000
Message-ID: <20141103175631.GS12011@x1>
References: <1414425354-10359-1-git-send-email-linux@roeck-us.net>
 <1414425354-10359-11-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1414425354-10359-11-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 27 Oct 2014, Guenter Roeck wrote:

> Register with kernel power-off handler instead of setting pm_power_of=
f
> directly. Register with a low priority value of 64 to reflect that
> the original code only sets pm_power_off if it was not already set.
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
> - Use define to specify powroff handler priority
> - Use devm_register_power_off_handler
> - Use dev_warn instead of dev_err
>=20
>  drivers/mfd/axp20x.c       | 30 ++++++++++++++++--------------
>  include/linux/mfd/axp20x.h |  1 +
>  2 files changed, 17 insertions(+), 14 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 6231adb..f00db57 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -17,7 +17,8 @@
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/pm_runtime.h>
> +#include <linux/notifier.h>
> +#include <linux/pm.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
>  #include <linux/regulator/consumer.h>
> @@ -150,11 +151,16 @@ static struct mfd_cell axp20x_cells[] =3D {
>  	},
>  };
> =20
> -static struct axp20x_dev *axp20x_pm_power_off;
> -static void axp20x_power_off(void)
> +static int axp20x_power_off(struct notifier_block *this, unsigned lo=
ng unused1,
> +			    void *unused2)
> +
>  {
> -	regmap_write(axp20x_pm_power_off->regmap, AXP20X_OFF_CTRL,
> -		     AXP20X_OFF);
> +	struct axp20x_dev *axp20x =3D container_of(this, struct axp20x_dev,
> +						 power_off_nb);
> +
> +	regmap_write(axp20x->regmap, AXP20X_OFF_CTRL, AXP20X_OFF);
> +
> +	return NOTIFY_DONE;
>  }
> =20
>  static int axp20x_i2c_probe(struct i2c_client *i2c,
> @@ -204,10 +210,11 @@ static int axp20x_i2c_probe(struct i2c_client *=
i2c,
>  		return ret;
>  	}
> =20
> -	if (!pm_power_off) {
> -		axp20x_pm_power_off =3D axp20x;
> -		pm_power_off =3D axp20x_power_off;
> -	}
> +	axp20x->power_off_nb.notifier_call =3D axp20x_power_off;
> +	axp20x->power_off_nb.priority =3D POWER_OFF_PRIORITY_LOW;
> +	ret =3D devm_register_power_off_handler(&i2c->dev, &axp20x->power_o=
ff_nb);
> +	if (ret)
> +		dev_warn(&i2c->dev, "failed to register power-off handler\n");
> =20
>  	dev_info(&i2c->dev, "AXP20X driver loaded\n");
> =20
> @@ -218,11 +225,6 @@ static int axp20x_i2c_remove(struct i2c_client *=
i2c)
>  {
>  	struct axp20x_dev *axp20x =3D i2c_get_clientdata(i2c);
> =20
> -	if (axp20x =3D=3D axp20x_pm_power_off) {
> -		axp20x_pm_power_off =3D NULL;
> -		pm_power_off =3D NULL;
> -	}
> -
>  	mfd_remove_devices(axp20x->dev);
>  	regmap_del_irq_chip(axp20x->i2c_client->irq, axp20x->regmap_irqc);
> =20
> diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
> index d0e31a2..9b15482 100644
> --- a/include/linux/mfd/axp20x.h
> +++ b/include/linux/mfd/axp20x.h
> @@ -175,6 +175,7 @@ struct axp20x_dev {
>  	struct regmap			*regmap;
>  	struct regmap_irq_chip_data	*regmap_irqc;
>  	long				variant;
> +	struct notifier_block		power_off_nb;
>  };
> =20
>  #endif /* __LINUX_MFD_AXP20X_H */

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
