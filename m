From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 11/47] mfd: retu: Register with kernel power-off
 handler
Date: Mon, 3 Nov 2014 17:56:16 +0000
Message-ID: <20141103175616.GR12011@x1>
References: <1414425354-10359-1-git-send-email-linux@roeck-us.net>
 <1414425354-10359-12-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1414425354-10359-12-git-send-email-linux@roeck-us.net>
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
> - Use devm_register_power_off_handler
> - Use dev_warn instead of dev_err
>=20
>  drivers/mfd/retu-mfd.c | 33 +++++++++++++++++++--------------
>  1 file changed, 19 insertions(+), 14 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/retu-mfd.c b/drivers/mfd/retu-mfd.c
> index 663f8a3..7c657e6 100644
> --- a/drivers/mfd/retu-mfd.c
> +++ b/drivers/mfd/retu-mfd.c
> @@ -22,6 +22,8 @@
>  #include <linux/slab.h>
>  #include <linux/mutex.h>
>  #include <linux/module.h>
> +#include <linux/notifier.h>
> +#include <linux/pm.h>
>  #include <linux/regmap.h>
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/retu.h>
> @@ -43,6 +45,7 @@ struct retu_dev {
>  	struct device			*dev;
>  	struct mutex			mutex;
>  	struct regmap_irq_chip_data	*irq_data;
> +	struct notifier_block		power_off_nb;
>  };
> =20
>  static struct resource retu_pwrbutton_res[] =3D {
> @@ -81,9 +84,6 @@ static struct regmap_irq_chip retu_irq_chip =3D {
>  	.ack_base	=3D RETU_REG_IDR,
>  };
> =20
> -/* Retu device registered for the power off. */
> -static struct retu_dev *retu_pm_power_off;
> -
>  static struct resource tahvo_usb_res[] =3D {
>  	{
>  		.name	=3D "tahvo-usb",
> @@ -165,12 +165,14 @@ int retu_write(struct retu_dev *rdev, u8 reg, u=
16 data)
>  }
>  EXPORT_SYMBOL_GPL(retu_write);
> =20
> -static void retu_power_off(void)
> +static int retu_power_off(struct notifier_block *this, unsigned long=
 unused1,
> +			  void *unused2)
>  {
> -	struct retu_dev *rdev =3D retu_pm_power_off;
> +	struct retu_dev *rdev =3D container_of(this, struct retu_dev,
> +					     power_off_nb);
>  	int reg;
> =20
> -	mutex_lock(&retu_pm_power_off->mutex);
> +	mutex_lock(&rdev->mutex);
> =20
>  	/* Ignore power button state */
>  	regmap_read(rdev->regmap, RETU_REG_CC1, &reg);
> @@ -183,7 +185,9 @@ static void retu_power_off(void)
>  	for (;;)
>  		cpu_relax();
> =20
> -	mutex_unlock(&retu_pm_power_off->mutex);
> +	mutex_unlock(&rdev->mutex);
> +
> +	return NOTIFY_DONE;
>  }
> =20
>  static int retu_regmap_read(void *context, const void *reg, size_t r=
eg_size,
> @@ -279,9 +283,14 @@ static int retu_probe(struct i2c_client *i2c, co=
nst struct i2c_device_id *id)
>  		return ret;
>  	}
> =20
> -	if (i2c->addr =3D=3D 1 && !pm_power_off) {
> -		retu_pm_power_off =3D rdev;
> -		pm_power_off	  =3D retu_power_off;
> +	if (i2c->addr =3D=3D 1) {
> +		rdev->power_off_nb.notifier_call =3D retu_power_off;
> +		rdev->power_off_nb.priority =3D POWER_OFF_PRIORITY_LOW;
> +		ret =3D devm_register_power_off_handler(rdev->dev,
> +						      &rdev->power_off_nb);
> +		if (ret)
> +			dev_warn(rdev->dev,
> +				 "Failed to register power-off handler\n");
>  	}
> =20
>  	return 0;
> @@ -291,10 +300,6 @@ static int retu_remove(struct i2c_client *i2c)
>  {
>  	struct retu_dev *rdev =3D i2c_get_clientdata(i2c);
> =20
> -	if (retu_pm_power_off =3D=3D rdev) {
> -		pm_power_off	  =3D NULL;
> -		retu_pm_power_off =3D NULL;
> -	}
>  	mfd_remove_devices(rdev->dev);
>  	regmap_del_irq_chip(i2c->irq, rdev->irq_data);
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
