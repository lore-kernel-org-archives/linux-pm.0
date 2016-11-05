From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] power: supply: bq27xxx_battery: Fix register map for BQ27510 and BQ27520
Date: Sat, 5 Nov 2016 18:36:02 +0100
Message-ID: <201611051836.07258@pali>
References: <20161104183313.2767-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4147127.NU57ZIdR0M";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34190 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752918AbcKERgK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 5 Nov 2016 13:36:10 -0400
In-Reply-To: <20161104183313.2767-1-afd@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

--nextPart4147127.NU57ZIdR0M
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 04 November 2016 19:33:13 Andrew F. Davis wrote:
> The BQ27510 and BQ27520 use a slightly different register map than
> the BQ27500, add a new type enum and add these gauges to it.
>=20
> Fixes: d74534c27775 ("power: bq27xxx_battery: Add support for
> additional bq27xxx family devices") Based-on-patch-by: Kenneth R.
> Crudup <kenny@panix.com>
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  drivers/power/supply/bq27xxx_battery.c     | 41
> +++++++++++++++++++++++++++++-
> drivers/power/supply/bq27xxx_battery_i2c.c |  4 +--
>  include/linux/power/bq27xxx_battery.h      |  3 ++-
>  3 files changed, 44 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c
> b/drivers/power/supply/bq27xxx_battery.c index 3b0dbc6..bccb3f5
> 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -164,6 +164,25 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
>  		[BQ27XXX_REG_DCAP] =3D 0x3c,
>  		[BQ27XXX_REG_AP] =3D INVALID_REG_ADDR,
>  	},
> +	[BQ27510] =3D {
> +		[BQ27XXX_REG_CTRL] =3D 0x00,
> +		[BQ27XXX_REG_TEMP] =3D 0x06,
> +		[BQ27XXX_REG_INT_TEMP] =3D 0x28,
> +		[BQ27XXX_REG_VOLT] =3D 0x08,
> +		[BQ27XXX_REG_AI] =3D 0x14,
> +		[BQ27XXX_REG_FLAGS] =3D 0x0a,
> +		[BQ27XXX_REG_TTE] =3D 0x16,
> +		[BQ27XXX_REG_TTF] =3D INVALID_REG_ADDR,
> +		[BQ27XXX_REG_TTES] =3D 0x1a,
> +		[BQ27XXX_REG_TTECP] =3D INVALID_REG_ADDR,
> +		[BQ27XXX_REG_NAC] =3D 0x0c,
> +		[BQ27XXX_REG_FCC] =3D 0x12,
> +		[BQ27XXX_REG_CYCT] =3D 0x1e,
> +		[BQ27XXX_REG_AE] =3D INVALID_REG_ADDR,
> +		[BQ27XXX_REG_SOC] =3D 0x20,
> +		[BQ27XXX_REG_DCAP] =3D 0x2e,
> +		[BQ27XXX_REG_AP] =3D INVALID_REG_ADDR,
> +	},
>  	[BQ27530] =3D {
>  		[BQ27XXX_REG_CTRL] =3D 0x00,
>  		[BQ27XXX_REG_TEMP] =3D 0x06,
> @@ -302,6 +321,24 @@ static enum power_supply_property
> bq27500_battery_props[] =3D { POWER_SUPPLY_PROP_MANUFACTURER,
>  };
>=20
> +static enum power_supply_property bq27510_battery_props[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
> +	POWER_SUPPLY_PROP_TEMP,
> +	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
> +	POWER_SUPPLY_PROP_TECHNOLOGY,
> +	POWER_SUPPLY_PROP_CHARGE_FULL,
> +	POWER_SUPPLY_PROP_CHARGE_NOW,
> +	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> +	POWER_SUPPLY_PROP_CYCLE_COUNT,
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_MANUFACTURER,
> +};
> +
>  static enum power_supply_property bq27530_battery_props[] =3D {
>  	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_PRESENT,
> @@ -385,6 +422,7 @@ static struct {
>  	BQ27XXX_PROP(BQ27000, bq27000_battery_props),
>  	BQ27XXX_PROP(BQ27010, bq27010_battery_props),
>  	BQ27XXX_PROP(BQ27500, bq27500_battery_props),
> +	BQ27XXX_PROP(BQ27510, bq27510_battery_props),
>  	BQ27XXX_PROP(BQ27530, bq27530_battery_props),
>  	BQ27XXX_PROP(BQ27541, bq27541_battery_props),
>  	BQ27XXX_PROP(BQ27545, bq27545_battery_props),
> @@ -635,7 +673,8 @@ static int bq27xxx_battery_read_pwr_avg(struct
> bq27xxx_device_info *di) */
>  static bool bq27xxx_battery_overtemp(struct bq27xxx_device_info *di,
> u16 flags) {
> -	if (di->chip =3D=3D BQ27500 || di->chip =3D=3D BQ27541 || di->chip =3D=
=3D
> BQ27545) +	if (di->chip =3D=3D BQ27500 || di->chip =3D=3D BQ27510 ||
> +	    di->chip =3D=3D BQ27541 || di->chip =3D=3D BQ27545)
>  		return flags & (BQ27XXX_FLAG_OTC | BQ27XXX_FLAG_OTD);
>  	if (di->chip =3D=3D BQ27530 || di->chip =3D=3D BQ27421)
>  		return flags & BQ27XXX_FLAG_OT;

This function should be converted to switch/case blocks... those=20
if/or/return conditions are now too big.

> diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c
> b/drivers/power/supply/bq27xxx_battery_i2c.c index 85d4ea2..5c5c3a6
> 100644
> --- a/drivers/power/supply/bq27xxx_battery_i2c.c
> +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
> @@ -149,8 +149,8 @@ static const struct i2c_device_id
> bq27xxx_i2c_id_table[] =3D { { "bq27200", BQ27000 },
>  	{ "bq27210", BQ27010 },
>  	{ "bq27500", BQ27500 },
> -	{ "bq27510", BQ27500 },
> -	{ "bq27520", BQ27500 },
> +	{ "bq27510", BQ27510 },
> +	{ "bq27520", BQ27510 },
>  	{ "bq27530", BQ27530 },
>  	{ "bq27531", BQ27530 },
>  	{ "bq27541", BQ27541 },
> diff --git a/include/linux/power/bq27xxx_battery.h
> b/include/linux/power/bq27xxx_battery.h index e30deb0..bed9557
> 100644
> --- a/include/linux/power/bq27xxx_battery.h
> +++ b/include/linux/power/bq27xxx_battery.h
> @@ -4,7 +4,8 @@
>  enum bq27xxx_chip {
>  	BQ27000 =3D 1, /* bq27000, bq27200 */
>  	BQ27010, /* bq27010, bq27210 */
> -	BQ27500, /* bq27500, bq27510, bq27520 */
> +	BQ27500, /* bq27500 */
> +	BQ27510, /* bq27510, bq27520 */
>  	BQ27530, /* bq27530, bq27531 */
>  	BQ27541, /* bq27541, bq27542, bq27546, bq27742 */
>  	BQ27545, /* bq27545 */


=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart4147127.NU57ZIdR0M
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlgeGIcACgkQi/DJPQPkQ1IUFgCeOPlnMRhVOnzvTsRWEXiRIe9h
FCMAnRN7oQKRioreORmUmWN+7JL+YjgT
=LQ3j
-----END PGP SIGNATURE-----

--nextPart4147127.NU57ZIdR0M--
