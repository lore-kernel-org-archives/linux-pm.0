From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 15/47] mfd: dm355evm_msp: Register with kernel
 power-off handler
Date: Mon, 3 Nov 2014 17:55:05 +0000
Message-ID: <20141103175505.GN12011@x1>
References: <1414425354-10359-1-git-send-email-linux@roeck-us.net>
 <1414425354-10359-16-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1414425354-10359-16-git-send-email-linux@roeck-us.net>
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
>  drivers/mfd/dm355evm_msp.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/dm355evm_msp.c b/drivers/mfd/dm355evm_msp.c
> index 4c826f7..63a1632 100644
> --- a/drivers/mfd/dm355evm_msp.c
> +++ b/drivers/mfd/dm355evm_msp.c
> @@ -14,6 +14,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/clk.h>
>  #include <linux/module.h>
> +#include <linux/notifier.h>
> +#include <linux/pm.h>
>  #include <linux/err.h>
>  #include <linux/gpio.h>
>  #include <linux/leds.h>
> @@ -352,14 +354,22 @@ static void dm355evm_command(unsigned command)
>  				command, status);
>  }
> =20
> -static void dm355evm_power_off(void)
> +static int dm355evm_power_off(struct notifier_block *this,
> +			      unsigned long unused1, void *unused2)
>  {
>  	dm355evm_command(MSP_COMMAND_POWEROFF);
> +
> +	return NOTIFY_DONE;
>  }
> =20
> +static struct notifier_block dm355evm_msp_power_off_nb =3D {
> +	.notifier_call =3D dm355evm_power_off,
> +	.priority =3D POWER_OFF_PRIORITY_LOW,
> +};
> +
>  static int dm355evm_msp_remove(struct i2c_client *client)
>  {
> -	pm_power_off =3D NULL;
> +	unregister_power_off_handler(&dm355evm_msp_power_off_nb);
>  	msp430 =3D NULL;
>  	return 0;
>  }
> @@ -398,7 +408,9 @@ dm355evm_msp_probe(struct i2c_client *client, con=
st struct i2c_device_id *id)
>  		goto fail;
> =20
>  	/* PM hookup */
> -	pm_power_off =3D dm355evm_power_off;
> +	status =3D register_power_off_handler(&dm355evm_msp_power_off_nb);
> +	if (status)
> +		dev_warn(&client->dev, "Failed to register power-off handler\n");
> =20
>  	return 0;
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
