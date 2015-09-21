From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v4 1/7] power: bq27x00_battery: Remove unneeded i2c
 MODULE_ALIAS
Date: Mon, 21 Sep 2015 10:33:45 +0200
Message-ID: <20150921083345.GE20113@pali>
References: <1442265973-32261-1-git-send-email-afd@ti.com>
 <1442265973-32261-2-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:33859 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756176AbbIUIdr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Sep 2015 04:33:47 -0400
Content-Disposition: inline
In-Reply-To: <1442265973-32261-2-git-send-email-afd@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Murphy <dmurphy@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 14 September 2015 16:26:07 Andrew F. Davis wrote:
> The MODULE_DEVICE_TABLE macro automatically adds all needed
> i2c MODULE_ALIASes so remove the extra MODULE_ALIAS.
>=20
> Signed-off-by: Andrew F. Davis <afd@ti.com>

Acked-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

> ---
>  drivers/power/bq27x00_battery.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/drivers/power/bq27x00_battery.c b/drivers/power/bq27x00_=
battery.c
> index 8287261f..d0b2f3b 100644
> --- a/drivers/power/bq27x00_battery.c
> +++ b/drivers/power/bq27x00_battery.c
> @@ -1120,10 +1120,6 @@ module_exit(bq27x00_battery_exit);
>  MODULE_ALIAS("platform:bq27000-battery");
>  #endif
> =20
> -#ifdef CONFIG_BATTERY_BQ27X00_I2C
> -MODULE_ALIAS("i2c:bq27000-battery");
> -#endif
> -
>  MODULE_AUTHOR("Rodolfo Giometti <giometti@linux.it>");
>  MODULE_DESCRIPTION("BQ27x00 battery monitor driver");
>  MODULE_LICENSE("GPL");

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
