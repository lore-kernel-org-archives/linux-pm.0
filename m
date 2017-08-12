From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC v2 5/5] power: supply: bq27xxx: Remove duplicate chip data
 arrays
Date: Sat, 12 Aug 2017 12:22:21 -0400
Message-ID: <20170812162221.fmpmh65ksjpdzrsc@earth>
References: <20170807062216.19988-1-liam@networkimprov.net>
 <20170807062216.19988-6-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n7omm4f6wvv277wc"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750864AbdHLQWX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 12 Aug 2017 12:22:23 -0400
Content-Disposition: inline
In-Reply-To: <20170807062216.19988-6-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-pm@vger.kernel.org, Paul Kocialkowski <contact@paulk.fr>, Liam Breck <kernel@networkimprov.net>


--n7omm4f6wvv277wc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Aug 06, 2017 at 11:22:16PM -0700, Liam Breck wrote:
> From: Liam Breck <kernel@networkimprov.net>
>=20
> BQ2751X & BQ27510G3 have identical regs & props.
> BQ27500 & BQ27510G1 & BQ27510G2 have identical regs & props.
> Remove the duplicate arrays.
>=20
> No functional changes to the driver.

Looks fine to me.

-- Sebastian

> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> ---
>  drivers/power/supply/bq27xxx_battery.c | 129 ++-------------------------=
------
>  1 file changed, 8 insertions(+), 121 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/suppl=
y/bq27xxx_battery.c
> index d85f9ec2..b451d49a 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -201,27 +201,8 @@ static u8
>  		[BQ27XXX_REG_AP] =3D INVALID_REG_ADDR,
>  		BQ27XXX_DM_REG_ROWS,
>  	},
> -	bq2751x_regs[BQ27XXX_REG_MAX] =3D {
> -		[BQ27XXX_REG_CTRL] =3D 0x00,
> -		[BQ27XXX_REG_TEMP] =3D 0x06,
> -		[BQ27XXX_REG_INT_TEMP] =3D 0x28,
> -		[BQ27XXX_REG_VOLT] =3D 0x08,
> -		[BQ27XXX_REG_AI] =3D 0x14,
> -		[BQ27XXX_REG_FLAGS] =3D 0x0a,
> -		[BQ27XXX_REG_TTE] =3D 0x16,
> -		[BQ27XXX_REG_TTF] =3D INVALID_REG_ADDR,
> -		[BQ27XXX_REG_TTES] =3D 0x1a,
> -		[BQ27XXX_REG_TTECP] =3D INVALID_REG_ADDR,
> -		[BQ27XXX_REG_NAC] =3D 0x0c,
> -		[BQ27XXX_REG_FCC] =3D 0x12,
> -		[BQ27XXX_REG_CYCT] =3D 0x1e,
> -		[BQ27XXX_REG_AE] =3D INVALID_REG_ADDR,
> -		[BQ27XXX_REG_SOC] =3D 0x20,
> -		[BQ27XXX_REG_DCAP] =3D 0x2e,
> -		[BQ27XXX_REG_AP] =3D INVALID_REG_ADDR,
> -		BQ27XXX_DM_REG_ROWS,
> -	},
> -#define bq2752x_regs bq2751x_regs
> +#define bq2751x_regs bq27510g3_regs
> +#define bq2752x_regs bq27510g3_regs
>  	bq27500_regs[BQ27XXX_REG_MAX] =3D {
>  		[BQ27XXX_REG_CTRL] =3D 0x00,
>  		[BQ27XXX_REG_TEMP] =3D 0x06,
> @@ -242,46 +223,8 @@ static u8
>  		[BQ27XXX_REG_AP] =3D 0x24,
>  		BQ27XXX_DM_REG_ROWS,
>  	},
> -	bq27510g1_regs[BQ27XXX_REG_MAX] =3D {
> -		[BQ27XXX_REG_CTRL] =3D 0x00,
> -		[BQ27XXX_REG_TEMP] =3D 0x06,
> -		[BQ27XXX_REG_INT_TEMP] =3D INVALID_REG_ADDR,
> -		[BQ27XXX_REG_VOLT] =3D 0x08,
> -		[BQ27XXX_REG_AI] =3D 0x14,
> -		[BQ27XXX_REG_FLAGS] =3D 0x0a,
> -		[BQ27XXX_REG_TTE] =3D 0x16,
> -		[BQ27XXX_REG_TTF] =3D 0x18,
> -		[BQ27XXX_REG_TTES] =3D 0x1c,
> -		[BQ27XXX_REG_TTECP] =3D 0x26,
> -		[BQ27XXX_REG_NAC] =3D 0x0c,
> -		[BQ27XXX_REG_FCC] =3D 0x12,
> -		[BQ27XXX_REG_CYCT] =3D 0x2a,
> -		[BQ27XXX_REG_AE] =3D 0x22,
> -		[BQ27XXX_REG_SOC] =3D 0x2c,
> -		[BQ27XXX_REG_DCAP] =3D 0x3c,
> -		[BQ27XXX_REG_AP] =3D 0x24,
> -		BQ27XXX_DM_REG_ROWS,
> -	},
> -	bq27510g2_regs[BQ27XXX_REG_MAX] =3D {
> -		[BQ27XXX_REG_CTRL] =3D 0x00,
> -		[BQ27XXX_REG_TEMP] =3D 0x06,
> -		[BQ27XXX_REG_INT_TEMP] =3D INVALID_REG_ADDR,
> -		[BQ27XXX_REG_VOLT] =3D 0x08,
> -		[BQ27XXX_REG_AI] =3D 0x14,
> -		[BQ27XXX_REG_FLAGS] =3D 0x0a,
> -		[BQ27XXX_REG_TTE] =3D 0x16,
> -		[BQ27XXX_REG_TTF] =3D 0x18,
> -		[BQ27XXX_REG_TTES] =3D 0x1c,
> -		[BQ27XXX_REG_TTECP] =3D 0x26,
> -		[BQ27XXX_REG_NAC] =3D 0x0c,
> -		[BQ27XXX_REG_FCC] =3D 0x12,
> -		[BQ27XXX_REG_CYCT] =3D 0x2a,
> -		[BQ27XXX_REG_AE] =3D 0x22,
> -		[BQ27XXX_REG_SOC] =3D 0x2c,
> -		[BQ27XXX_REG_DCAP] =3D 0x3c,
> -		[BQ27XXX_REG_AP] =3D 0x24,
> -		BQ27XXX_DM_REG_ROWS,
> -	},
> +#define bq27510g1_regs bq27500_regs
> +#define bq27510g2_regs bq27500_regs
>  	bq27510g3_regs[BQ27XXX_REG_MAX] =3D {
>  		[BQ27XXX_REG_CTRL] =3D 0x00,
>  		[BQ27XXX_REG_TEMP] =3D 0x06,
> @@ -530,24 +473,8 @@ static enum power_supply_property bq2750x_props[] =
=3D {
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>  };
> =20
> -static enum power_supply_property bq2751x_props[] =3D {
> -	POWER_SUPPLY_PROP_STATUS,
> -	POWER_SUPPLY_PROP_PRESENT,
> -	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> -	POWER_SUPPLY_PROP_CURRENT_NOW,
> -	POWER_SUPPLY_PROP_CAPACITY,
> -	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
> -	POWER_SUPPLY_PROP_TEMP,
> -	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
> -	POWER_SUPPLY_PROP_TECHNOLOGY,
> -	POWER_SUPPLY_PROP_CHARGE_FULL,
> -	POWER_SUPPLY_PROP_CHARGE_NOW,
> -	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> -	POWER_SUPPLY_PROP_CYCLE_COUNT,
> -	POWER_SUPPLY_PROP_HEALTH,
> -	POWER_SUPPLY_PROP_MANUFACTURER,
> -};
> -#define bq2752x_props bq2751x_props
> +#define bq2751x_props bq27510g3_props
> +#define bq2752x_props bq27510g3_props
> =20
>  static enum power_supply_property bq27500_props[] =3D {
>  	POWER_SUPPLY_PROP_STATUS,
> @@ -569,48 +496,8 @@ static enum power_supply_property bq27500_props[] =
=3D {
>  	POWER_SUPPLY_PROP_HEALTH,
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>  };
> -
> -static enum power_supply_property bq27510g1_props[] =3D {
> -	POWER_SUPPLY_PROP_STATUS,
> -	POWER_SUPPLY_PROP_PRESENT,
> -	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> -	POWER_SUPPLY_PROP_CURRENT_NOW,
> -	POWER_SUPPLY_PROP_CAPACITY,
> -	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
> -	POWER_SUPPLY_PROP_TEMP,
> -	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
> -	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
> -	POWER_SUPPLY_PROP_TECHNOLOGY,
> -	POWER_SUPPLY_PROP_CHARGE_FULL,
> -	POWER_SUPPLY_PROP_CHARGE_NOW,
> -	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> -	POWER_SUPPLY_PROP_CYCLE_COUNT,
> -	POWER_SUPPLY_PROP_ENERGY_NOW,
> -	POWER_SUPPLY_PROP_POWER_AVG,
> -	POWER_SUPPLY_PROP_HEALTH,
> -	POWER_SUPPLY_PROP_MANUFACTURER,
> -};
> -
> -static enum power_supply_property bq27510g2_props[] =3D {
> -	POWER_SUPPLY_PROP_STATUS,
> -	POWER_SUPPLY_PROP_PRESENT,
> -	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> -	POWER_SUPPLY_PROP_CURRENT_NOW,
> -	POWER_SUPPLY_PROP_CAPACITY,
> -	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
> -	POWER_SUPPLY_PROP_TEMP,
> -	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
> -	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
> -	POWER_SUPPLY_PROP_TECHNOLOGY,
> -	POWER_SUPPLY_PROP_CHARGE_FULL,
> -	POWER_SUPPLY_PROP_CHARGE_NOW,
> -	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> -	POWER_SUPPLY_PROP_CYCLE_COUNT,
> -	POWER_SUPPLY_PROP_ENERGY_NOW,
> -	POWER_SUPPLY_PROP_POWER_AVG,
> -	POWER_SUPPLY_PROP_HEALTH,
> -	POWER_SUPPLY_PROP_MANUFACTURER,
> -};
> +#define bq27510g1_props bq27500_props
> +#define bq27510g2_props bq27500_props
> =20
>  static enum power_supply_property bq27510g3_props[] =3D {
>  	POWER_SUPPLY_PROP_STATUS,
> --=20
> 2.13.2
>=20

--n7omm4f6wvv277wc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmPKzsACgkQ2O7X88g7
+prLRg/+Jg942oDt2hfpEucz9L4bIH+6EWqAGGFu0cKO3efFDQIRfUbhLOLmHr+I
j0GMA6AypZE2lcAlo7g8H4JVve+/6AE5GzrmkFX/PXmRAUJ0Tj+XMU6GjfjcAIes
N+WRGa0OoYC8wJST5bL8STrwQ2mY3zCU6bdfcFcB/Uy1s3bxfCl6KvKkLsJXZl5S
D+/kyMQW5I7FB9VTOAR6tDsraBK8gaVFe/B5smVTjMLgx+58EJ4CYHrPQeXbhk8g
VEEKnf6yZAzqTJzj0EdreNI7HlOopiezwK0wI56AFbdz1RPcJDCytsV7xkzz73Pi
WPIcUaCxm7fNqNZ+aoxW+wJ6UGWwz8dcuRstZhFlA/MsCaHedth7gPMOeQEGDf/O
n6TMCl+BG+G9ET6w/kaElb9NtzFqMd33vD1Kh6W9hBY7iRcSYi36dREs1jYWKpQq
kmSNjz8XYg/R37RNy71wRsQ3n8+E0nk4cHUHuTwE1Gf3FZQjSpmYTIAVa6vzyuCc
wBsCSJp6pq1NMmtnxwkRoQyROx+nvdNzFFvIGp6oYyXhru3WU7/XRIp1d0vj9Txg
Mic/tRACC5vzGBv2oegM2IoMh98BsxoeD2ZyJEGMLq4TKKMwOLewgly/0xa9v8C7
LaDBoTxnzKLvEJ12Fi76WeQ4WN/1S2Lk9DLYjUDGg4W0AO9sRBg=
=Zg2x
-----END PGP SIGNATURE-----

--n7omm4f6wvv277wc--
