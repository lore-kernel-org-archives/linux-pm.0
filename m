From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 6/8] power: bq27xxx_battery: Fix typos and change naming
 for state of charge functions
Date: Thu, 23 Jul 2015 18:15:34 +0200
Message-ID: <20150723161534.GG29125@pali>
References: <1437601920-13045-1-git-send-email-afd@ti.com>
 <1437601920-13045-7-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:36411 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923AbbGWQPi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2015 12:15:38 -0400
Content-Disposition: inline
In-Reply-To: <1437601920-13045-7-git-send-email-afd@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Murphy <dmurphy@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 22 July 2015 16:51:58 Andrew F. Davis wrote:
> Fix typos and change "relative state of charge" to "state of charge" =
as not
> all supported devices use relative state of charge.
>=20
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  drivers/power/bq27xxx_battery.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/power/bq27xxx_battery.c b/drivers/power/bq27xxx_=
battery.c
> index f5d7a137..5686da6 100644
> --- a/drivers/power/bq27xxx_battery.c
> +++ b/drivers/power/bq27xxx_battery.c
> @@ -231,26 +231,26 @@ static bool bq27xxx_is_chip_version_higher(stru=
ct bq27xxx_device_info *di)
>  }
> =20
>  /*
> - * Return the battery Relative State-of-Charge
> + * Return the battery State-of-Charge
>   * Or < 0 if something fails.
>   */
> -static int bq27xxx_battery_read_rsoc(struct bq27xxx_device_info *di)
> +static int bq27xxx_battery_read_soc(struct bq27xxx_device_info *di)
>  {
> -	int rsoc;
> +	int soc;
> =20
>  	if (di->chip =3D=3D BQ27500 || di->chip =3D=3D BQ27742)
> -		rsoc =3D bq27xxx_read(di, BQ27500_REG_SOC, false);
> +		soc =3D bq27xxx_read(di, BQ27500_REG_SOC, false);
>  	else if (di->chip =3D=3D BQ27510)
> -		rsoc =3D bq27xxx_read(di, BQ27510_REG_SOC, false);
> +		soc =3D bq27xxx_read(di, BQ27510_REG_SOC, false);
>  	else if (di->chip =3D=3D BQ27425)
> -		rsoc =3D bq27xxx_read(di, BQ27425_REG_SOC, false);
> +		soc =3D bq27xxx_read(di, BQ27425_REG_SOC, false);
>  	else
> -		rsoc =3D bq27xxx_read(di, BQ27000_REG_RSOC, true);
> +		soc =3D bq27xxx_read(di, BQ27000_REG_RSOC, true);
> =20
> -	if (rsoc < 0)
> -		dev_dbg(di->dev, "error reading relative State-of-Charge\n");
> +	if (soc < 0)
> +		dev_dbg(di->dev, "error reading State-of-Charge\n");
> =20
> -	return rsoc;
> +	return soc;
>  }
> =20

It is good idea to have name function name "read_soc" with description
"Return State-of-Charge" and for some chips that function returns RSOC
(Relative)? For me it is quite misleading.

>  /*
> @@ -277,7 +277,7 @@ static int bq27xxx_battery_read_charge(struct bq2=
7xxx_device_info *di, u8 reg)
>  }
> =20
>  /*
> - * Return the battery Nominal available capaciy in =C2=B5Ah
> + * Return the battery Nominal available capacity in =C2=B5Ah
>   * Or < 0 if something fails.
>   */
>  static inline int bq27xxx_battery_read_nac(struct bq27xxx_device_inf=
o *di)
> @@ -418,7 +418,7 @@ static int bq27xxx_battery_read_time(struct bq27x=
xx_device_info *di, u8 reg)
>  }
> =20
>  /*
> - * Read a power avg register.
> + * Read an average power register.
>   * Return < 0 if something fails.
>   */
>  static int bq27xxx_battery_read_pwr_avg(struct bq27xxx_device_info *=
di, u8 reg)
> @@ -500,7 +500,7 @@ static void bq27xxx_battery_update(struct bq27xxx=
_device_info *di)
>  			cache.charge_full =3D -ENODATA;
>  			cache.health =3D -ENODATA;
>  		} else {
> -			cache.capacity =3D bq27xxx_battery_read_rsoc(di);
> +			cache.capacity =3D bq27xxx_battery_read_soc(di);
>  			if (is_bq27742 || is_bq27510)
>  				cache.time_to_empty =3D
>  					bq27xxx_battery_read_time(di,

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
