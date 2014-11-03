From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 14/47] mfd: tps80031: Register with kernel power-off
 handler
Date: Mon, 3 Nov 2014 17:55:29 +0000
Message-ID: <20141103175529.GO12011@x1>
References: <1414425354-10359-1-git-send-email-linux@roeck-us.net>
 <1414425354-10359-15-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:63795 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509AbaKCRzf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Nov 2014 12:55:35 -0500
Received: by mail-qc0-f176.google.com with SMTP id x3so9382754qcv.7
        for <linux-pm@vger.kernel.org>; Mon, 03 Nov 2014 09:55:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1414425354-10359-15-git-send-email-linux@roeck-us.net>
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
> - Use dev_warn instead of dev_err
>=20
>  drivers/mfd/tps80031.c       | 30 ++++++++++++++++++------------
>  include/linux/mfd/tps80031.h |  2 ++
>  2 files changed, 20 insertions(+), 12 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/tps80031.c b/drivers/mfd/tps80031.c
> index ed6c5b0..6504959 100644
> --- a/drivers/mfd/tps80031.c
> +++ b/drivers/mfd/tps80031.c
> @@ -147,7 +147,6 @@ static const struct tps80031_pupd_data tps80031_p=
upds[] =3D {
>  	[TPS80031_CTLI2C_SCL]		=3D PUPD_DATA(4, 0,	BIT(2)),
>  	[TPS80031_CTLI2C_SDA]		=3D PUPD_DATA(4, 0,	BIT(3)),
>  };
> -static struct tps80031 *tps80031_power_off_dev;
> =20
>  int tps80031_ext_power_req_config(struct device *dev,
>  		unsigned long ext_ctrl_flag, int preq_bit,
> @@ -209,11 +208,17 @@ int tps80031_ext_power_req_config(struct device=
 *dev,
>  }
>  EXPORT_SYMBOL_GPL(tps80031_ext_power_req_config);
> =20
> -static void tps80031_power_off(void)
> +static int tps80031_power_off(struct notifier_block *this,
> +			      unsigned long unused1, void *unused2)
>  {
> -	dev_info(tps80031_power_off_dev->dev, "switching off PMU\n");
> -	tps80031_write(tps80031_power_off_dev->dev, TPS80031_SLAVE_ID1,
> -				TPS80031_PHOENIX_DEV_ON, TPS80031_DEVOFF);
> +	struct tps80031 *tps80031 =3D container_of(this, struct tps80031,
> +						 power_off_nb);
> +
> +	dev_info(tps80031->dev, "switching off PMU\n");
> +	tps80031_write(tps80031->dev, TPS80031_SLAVE_ID1,
> +		       TPS80031_PHOENIX_DEV_ON, TPS80031_DEVOFF);
> +
> +	return NOTIFY_DONE;
>  }
> =20
>  static void tps80031_pupd_init(struct tps80031 *tps80031,
> @@ -501,9 +506,13 @@ static int tps80031_probe(struct i2c_client *cli=
ent,
>  		goto fail_mfd_add;
>  	}
> =20
> -	if (pdata->use_power_off && !pm_power_off) {
> -		tps80031_power_off_dev =3D tps80031;
> -		pm_power_off =3D tps80031_power_off;
> +	if (pdata->use_power_off) {
> +		tps80031->power_off_nb.notifier_call =3D tps80031_power_off;
> +		tps80031->power_off_nb.priority =3D POWER_OFF_PRIORITY_LOW;
> +		ret =3D register_power_off_handler(&tps80031->power_off_nb);
> +		if (ret)
> +			dev_warn(&client->dev,
> +				 "Failed to register power-off handler\n");
>  	}
>  	return 0;
> =20
> @@ -523,10 +532,7 @@ static int tps80031_remove(struct i2c_client *cl=
ient)
>  	struct tps80031 *tps80031 =3D i2c_get_clientdata(client);
>  	int i;
> =20
> -	if (tps80031_power_off_dev =3D=3D tps80031) {
> -		tps80031_power_off_dev =3D NULL;
> -		pm_power_off =3D NULL;
> -	}
> +	unregister_power_off_handler(&tps80031->power_off_nb);
> =20
>  	mfd_remove_devices(tps80031->dev);
> =20
> diff --git a/include/linux/mfd/tps80031.h b/include/linux/mfd/tps8003=
1.h
> index 2c75c9c..2c6afc2 100644
> --- a/include/linux/mfd/tps80031.h
> +++ b/include/linux/mfd/tps80031.h
> @@ -24,6 +24,7 @@
>  #define __LINUX_MFD_TPS80031_H
> =20
>  #include <linux/device.h>
> +#include <linux/notifier.h>
>  #include <linux/regmap.h>
> =20
>  /* Pull-ups/Pull-downs */
> @@ -513,6 +514,7 @@ struct tps80031 {
>  	struct i2c_client	*clients[TPS80031_NUM_SLAVES];
>  	struct regmap		*regmap[TPS80031_NUM_SLAVES];
>  	struct regmap_irq_chip_data *irq_data;
> +	struct notifier_block	power_off_nb;
>  };
> =20
>  struct tps80031_pupd_init_data {

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
