From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] power: Destroy IDRs on module exit
Date: Tue, 14 Jul 2015 11:20:48 +0200
Message-ID: <20150714092048.GH12844@pali>
References: <1436865374-22027-1-git-send-email-jthumshirn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:34981 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbbGNJUv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2015 05:20:51 -0400
Content-Disposition: inline
In-Reply-To: <1436865374-22027-1-git-send-email-jthumshirn@suse.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 14 July 2015 11:16:14 Johannes Thumshirn wrote:
> Destroy IDRs on module exit, freeing the resources for
> * bq2415x_charger.c
> * ds2782_battery.c
> * ltc2941-battery-gauge.c
>=20
> The drivers had to be converted to "ordinary" module_init()/module_ex=
it()
> style drivers instead of using module_i2c_driver.
>=20
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  drivers/power/bq2415x_charger.c       | 20 +++++++++++++++++++-
>  drivers/power/ds2782_battery.c        | 20 +++++++++++++++++++-
>  drivers/power/ltc2941-battery-gauge.c | 20 +++++++++++++++++++-
>  3 files changed, 57 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/bq2415x_charger.c b/drivers/power/bq2415x_=
charger.c
> index e98dcb6..38f4208 100644
> --- a/drivers/power/bq2415x_charger.c
> +++ b/drivers/power/bq2415x_charger.c
> @@ -1773,7 +1773,25 @@ static struct i2c_driver bq2415x_driver =3D {
>  	.remove =3D bq2415x_remove,
>  	.id_table =3D bq2415x_i2c_id_table,
>  };
> -module_i2c_driver(bq2415x_driver);
> +
> +static int __init bq2415x_init(void)
> +{
> +	int ret;
> +
> +	ret =3D i2c_add_driver(&bq2415x_driver);
> +	if (ret)
> +		printk(KERN_ERR "Unable to register bq2415x-battery driver\n");
> +
> +	return ret;
> +}
> +module_init(bq2415x_init);
> +
> +static void __exit bq2415x_exit(void)
> +{
> +	i2c_del_driver(&bq2415x_driver);
> +	idr_destroy(&bq2415x_id);
> +}
> +module_exit(bq2415x_exit);
> =20
>  MODULE_AUTHOR("Pali Roh=C3=A1r <pali.rohar@gmail.com>");
>  MODULE_DESCRIPTION("bq2415x charger driver");
> diff --git a/drivers/power/ds2782_battery.c b/drivers/power/ds2782_ba=
ttery.c
> index ed4d756..410bc9d 100644
> --- a/drivers/power/ds2782_battery.c
> +++ b/drivers/power/ds2782_battery.c
> @@ -468,7 +468,25 @@ static struct i2c_driver ds278x_battery_driver =3D=
 {
>  	.remove		=3D ds278x_battery_remove,
>  	.id_table	=3D ds278x_id,
>  };
> -module_i2c_driver(ds278x_battery_driver);
> +
> +static int __init ds2782_init(void)
> +{
> +	int ret;
> +
> +	ret =3D i2c_add_driver(&ds278x_battery_driver);
> +	if (ret)
> +		printk(KERN_ERR "Unable to register ds2782-battery driver\n");
> +
> +	return ret;
> +}
> +module_init(ds2782_init);
> +
> +static void __exit ds2782_exit(void)
> +{
> +	i2c_del_driver(&ds278x_battery_driver);
> +	idr_destroy(&battery_id);
> +}
> +module_exit(ds2782_exit);
> =20
>  MODULE_AUTHOR("Ryan Mallon");
>  MODULE_DESCRIPTION("Maxim/Dallas DS2782 Stand-Alone Fuel Gauage IC d=
river");
> diff --git a/drivers/power/ltc2941-battery-gauge.c b/drivers/power/lt=
c2941-battery-gauge.c
> index daeb086..6fbbcd2 100644
> --- a/drivers/power/ltc2941-battery-gauge.c
> +++ b/drivers/power/ltc2941-battery-gauge.c
> @@ -544,7 +544,25 @@ static struct i2c_driver ltc294x_driver =3D {
>  	.remove		=3D ltc294x_i2c_remove,
>  	.id_table	=3D ltc294x_i2c_id,
>  };
> -module_i2c_driver(ltc294x_driver);
> +
> +static int __init ltc294x_init(void)
> +{
> +	int ret;
> +
> +	ret =3D i2c_add_driver(&ltc294x_driver);
> +	if (ret)
> +		printk(KERN_ERR "Unable to register bq2415x-battery driver\n");
> +
> +	return ret;
> +}
> +module_init(ltc294x_init);
> +
> +static void __exit ltc294x_exit(void)
> +{
> +	i2c_del_driver(&ltc294x_driver);
> +	idr_destroy(&ltc294x_id);
> +}
> +module_exit(ltc294x_exit);
> =20
>  MODULE_AUTHOR("Auryn Verwegen, Topic Embedded Systems");
>  MODULE_AUTHOR("Mike Looijmans, Topic Embedded Products");

I'm feeling that there is something wrong with idr API. There is no idr
code in __init functions, so why it is needed for __exit? idr functions
are used in devices, not in global module.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
