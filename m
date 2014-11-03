From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 18/47] mfd: twl4030-power: Register with kernel
 power-off handler
Date: Mon, 3 Nov 2014 17:54:27 +0000
Message-ID: <20141103175427.GK12011@x1>
References: <1414425354-10359-1-git-send-email-linux@roeck-us.net>
 <1414425354-10359-19-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1414425354-10359-19-git-send-email-linux@roeck-us.net>
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
> Make twl4030_power_off static as it is only called from the twl4030-p=
ower
> driver. Drop remove function as it is no longer needed.
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
> - Use devm_register_power_off_handler
> - Drop remove function as it is no longer needed.
>=20
>  drivers/mfd/twl4030-power.c | 29 +++++++++++++++++++----------
>  include/linux/i2c/twl.h     |  1 -
>  2 files changed, 19 insertions(+), 11 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.=
c
> index cf92a6d..e36eea9 100644
> --- a/drivers/mfd/twl4030-power.c
> +++ b/drivers/mfd/twl4030-power.c
> @@ -25,9 +25,10 @@
>   */
> =20
>  #include <linux/module.h>
> -#include <linux/pm.h>
> +#include <linux/notifier.h>
>  #include <linux/i2c/twl.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> =20
> @@ -611,7 +612,8 @@ twl4030_power_configure_resources(const struct tw=
l4030_power_data *pdata)
>   * After a successful execution, TWL shuts down the power to the SoC
>   * and all peripherals connected to it.
>   */
> -void twl4030_power_off(void)
> +static int twl4030_power_off(struct notifier_block *this, unsigned l=
ong unused1,
> +			     void *unused2)
>  {
>  	int err;
> =20
> @@ -619,8 +621,15 @@ void twl4030_power_off(void)
>  			       TWL4030_PM_MASTER_P1_SW_EVENTS);
>  	if (err)
>  		pr_err("TWL4030 Unable to power off\n");
> +
> +	return NOTIFY_DONE;
>  }
> =20
> +static struct notifier_block twl4030_power_off_nb =3D {
> +	.notifier_call =3D twl4030_power_off,
> +	.priority =3D POWER_OFF_PRIORITY_LOW,
> +};
> +
>  static bool twl4030_power_use_poweroff(const struct twl4030_power_da=
ta *pdata,
>  					struct device_node *node)
>  {
> @@ -839,7 +848,9 @@ static int twl4030_power_probe(struct platform_de=
vice *pdev)
>  	}
> =20
>  	/* Board has to be wired properly to use this feature */
> -	if (twl4030_power_use_poweroff(pdata, node) && !pm_power_off) {
> +	if (twl4030_power_use_poweroff(pdata, node)) {
> +		int ret;
> +
>  		/* Default for SEQ_OFFSYNC is set, lets ensure this */
>  		err =3D twl_i2c_read_u8(TWL_MODULE_PM_MASTER, &val,
>  				      TWL4030_PM_MASTER_CFG_P123_TRANSITION);
> @@ -856,7 +867,11 @@ static int twl4030_power_probe(struct platform_d=
evice *pdev)
>  			}
>  		}
> =20
> -		pm_power_off =3D twl4030_power_off;
> +		ret =3D devm_register_power_off_handler(&pdev->dev,
> +						      &twl4030_power_off_nb);
> +		if (ret)
> +			dev_warn(&pdev->dev,
> +				 "Failed to register power-off handler\n");
>  	}
> =20
>  relock:
> @@ -870,11 +885,6 @@ relock:
>  	return err;
>  }
> =20
> -static int twl4030_power_remove(struct platform_device *pdev)
> -{
> -	return 0;
> -}
> -
>  static struct platform_driver twl4030_power_driver =3D {
>  	.driver =3D {
>  		.name	=3D "twl4030_power",
> @@ -882,7 +892,6 @@ static struct platform_driver twl4030_power_drive=
r =3D {
>  		.of_match_table =3D of_match_ptr(twl4030_power_of_match),
>  	},
>  	.probe		=3D twl4030_power_probe,
> -	.remove		=3D twl4030_power_remove,
>  };
> =20
>  module_platform_driver(twl4030_power_driver);
> diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
> index 8cfb50f..f8544f1 100644
> --- a/include/linux/i2c/twl.h
> +++ b/include/linux/i2c/twl.h
> @@ -680,7 +680,6 @@ struct twl4030_power_data {
>  };
> =20
>  extern int twl4030_remove_script(u8 flags);
> -extern void twl4030_power_off(void);
> =20
>  struct twl4030_codec_data {
>  	unsigned int digimic_delay; /* in ms */

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
