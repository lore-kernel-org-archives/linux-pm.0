From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] power: bq27xxx_battery: Restore device name
Date: Tue, 2 Feb 2016 13:27:56 +0100
Message-ID: <20160202122756.GI4389@pali>
References: <1454415319-31380-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38193 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754317AbcBBM17 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2016 07:27:59 -0500
Content-Disposition: inline
In-Reply-To: <1454415319-31380-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 02 February 2016 14:15:19 Ivaylo Dimitrov wrote:
> Patch <703df6c097956d17a818e63961c82e8e9eef9fef> ("power: bq27xxx_bat=
tery:
>  Reorganize I2C into a module") has removed the device name numbering=
 from
> bq27xxx_battery_i2c_probe. Fix that by restoring the code.
>=20
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> ---
>  drivers/power/bq27xxx_battery_i2c.c | 32 +++++++++++++++++++++++++++=
++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/bq27xxx_battery_i2c.c b/drivers/power/bq27=
xxx_battery_i2c.c
> index b810e08..d98cdc5 100644
> --- a/drivers/power/bq27xxx_battery_i2c.c
> +++ b/drivers/power/bq27xxx_battery_i2c.c
> @@ -21,6 +21,9 @@
> =20
>  #include <linux/power/bq27xxx_battery.h>
> =20
> +static DEFINE_IDR(battery_id);
> +static DEFINE_MUTEX(battery_mutex);
> +
>  static irqreturn_t bq27xxx_battery_irq_handler_thread(int irq, void =
*data)
>  {
>  	struct bq27xxx_device_info *di =3D data;
> @@ -70,19 +73,32 @@ static int bq27xxx_battery_i2c_probe(struct i2c_c=
lient *client,
>  {
>  	struct bq27xxx_device_info *di;
>  	int ret;
> +	char *name;
> +	int num;
> +
> +	/* Get new ID for the new battery device */
> +	mutex_lock(&battery_mutex);
> +	num =3D idr_alloc(&battery_id, client, 0, 0, GFP_KERNEL);
> +	mutex_unlock(&battery_mutex);
> +	if (num < 0)
> +		return num;
> +
> +	name =3D devm_kasprintf(&client->dev, GFP_KERNEL, "%s-%d", id->name=
, num);
> +	if (!name)
> +		goto err_mem;
> =20
>  	di =3D devm_kzalloc(&client->dev, sizeof(*di), GFP_KERNEL);
>  	if (!di)
> -		return -ENOMEM;
> +		goto err_mem;
> =20
>  	di->dev =3D &client->dev;
>  	di->chip =3D id->driver_data;
> -	di->name =3D id->name;
> +	di->name =3D name;
>  	di->bus.read =3D bq27xxx_battery_i2c_read;
> =20
>  	ret =3D bq27xxx_battery_setup(di);
>  	if (ret)
> -		return ret;
> +		goto err_failed;
> =20
>  	/* Schedule a polling after about 1 min */
>  	schedule_delayed_work(&di->work, 60 * HZ);
> @@ -103,6 +119,16 @@ static int bq27xxx_battery_i2c_probe(struct i2c_=
client *client,
>  	}
> =20
>  	return 0;
> +
> +err_mem:
> +	ret =3D -ENOMEM;
> +
> +err_failed:
> +	mutex_lock(&battery_mutex);
> +	idr_remove(&battery_id, num);
> +	mutex_unlock(&battery_mutex);
> +
> +	return ret;
>  }
> =20
>  static int bq27xxx_battery_i2c_remove(struct i2c_client *client)

Hi! Should not we call idr_remove() also in bq27xxx_battery_i2c_remove(=
)?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
