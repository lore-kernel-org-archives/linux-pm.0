From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: bq27x00_battery: add bq27510 support
Date: Wed, 25 Feb 2015 23:17:48 +0100
Message-ID: <20150225221747.GP13695@earth>
References: <1424614111-28613-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gQt10JDuGyDb0HQ5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1424614111-28613-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--gQt10JDuGyDb0HQ5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

On Sun, Feb 22, 2015 at 03:08:31PM +0100, Alexandre Belloni wrote:
> Add support for bq27510 to the bq27x00 driver.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

patch looks mostly fine to me, I have two comments (inline).

-- Sebastian

> ---
>  drivers/power/bq27x00_battery.c | 50 +++++++++++++++++++++++++++++++++++=
+-----
>  1 file changed, 45 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/power/bq27x00_battery.c b/drivers/power/bq27x00_batt=
ery.c
> index a78ac201828e..1eac363bbc8e 100644
> --- a/drivers/power/bq27x00_battery.c
> +++ b/drivers/power/bq27x00_battery.c
> @@ -24,6 +24,7 @@
>   * http://focus.ti.com/docs/prod/folders/print/bq27500.html
>   * http://www.ti.com/product/bq27425-g1
>   * http://www.ti.com/product/BQ27742-G1
> + * http://www.ti.com/product/BQ27510-G3
>   */
> =20
>  #include <linux/device.h>
> @@ -74,6 +75,10 @@
> =20
>  #define BQ27742_POWER_AVG		0x76
> =20
> +#define BQ27510_REG_SOC			0x20
> +#define BQ27510_REG_DCAP		0x2E /* Design capacity */
> +#define BQ27510_REG_CYCT		0x1E /* Cycle count total */
> +
>  /* bq27425 register addresses are same as bq27x00 addresses minus 4 */
>  #define BQ27425_REG_OFFSET		0x04
>  #define BQ27425_REG_SOC			0x18 /* Register address plus offset */
> @@ -86,7 +91,7 @@ struct bq27x00_access_methods {
>  	int (*read)(struct bq27x00_device_info *di, u8 reg, bool single);
>  };
> =20
> -enum bq27x00_chip { BQ27000, BQ27500, BQ27425, BQ27742};
> +enum bq27x00_chip { BQ27000, BQ27500, BQ27425, BQ27742, BQ27510};
> =20
>  struct bq27x00_reg_cache {
>  	int temperature;
> @@ -173,6 +178,24 @@ static enum power_supply_property bq27742_battery_pr=
ops[] =3D {
>  	POWER_SUPPLY_PROP_HEALTH,
>  };
> =20
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
> +	POWER_SUPPLY_PROP_POWER_AVG,
> +	POWER_SUPPLY_PROP_HEALTH,
> +};
> +
>  static unsigned int poll_interval =3D 360;
>  module_param(poll_interval, uint, 0644);
>  MODULE_PARM_DESC(poll_interval, "battery poll interval in seconds - " \
> @@ -197,7 +220,8 @@ static inline int bq27x00_read(struct bq27x00_device_=
info *di, u8 reg,
>   */
>  static bool bq27xxx_is_chip_version_higher(struct bq27x00_device_info *d=
i)
>  {
> -	if (di->chip =3D=3D BQ27425 || di->chip =3D=3D BQ27500 || di->chip =3D=
=3D BQ27742)
> +	if (di->chip =3D=3D BQ27425 || di->chip =3D=3D BQ27500 || di->chip =3D=
=3D BQ27742
> +	    || di->chip =3D=3D BQ27510)
>  		return true;
>  	return false;
>  }
> @@ -212,6 +236,8 @@ static int bq27x00_battery_read_rsoc(struct bq27x00_d=
evice_info *di)
> =20
>  	if (di->chip =3D=3D BQ27500 || di->chip =3D=3D BQ27742)
>  		rsoc =3D bq27x00_read(di, BQ27500_REG_SOC, false);
> +	else if (di->chip =3D=3D BQ27510)
> +		rsoc =3D bq27x00_read(di, BQ27510_REG_SOC, false);
>  	else if (di->chip =3D=3D BQ27425)
>  		rsoc =3D bq27x00_read(di, BQ27425_REG_SOC, false);
>  	else
> @@ -282,7 +308,9 @@ static int bq27x00_battery_read_ilmd(struct bq27x00_d=
evice_info *di)
>  {
>  	int ilmd;
> =20
> -	if (bq27xxx_is_chip_version_higher(di))
> +	if (di->chip =3D=3D BQ27510)
> +		ilmd =3D bq27x00_read(di, BQ27510_REG_DCAP, false);
> +	else if (bq27xxx_is_chip_version_higher(di))
>  		ilmd =3D bq27x00_read(di, BQ27500_REG_DCAP, false);
>  	else
>  		ilmd =3D bq27x00_read(di, BQ27000_REG_ILMD, true);
> @@ -350,6 +378,9 @@ static int bq27x00_battery_read_cyct(struct bq27x00_d=
evice_info *di)
>  {
>  	int cyct;
> =20
> +

spurious newline.

> +	if (di->chip =3D=3D BQ27510)
> +		cyct =3D bq27x00_read(di, BQ27510_REG_CYCT, false);
>  	cyct =3D bq27x00_read(di, BQ27x00_REG_CYCT, false);

missing else?

>  	if (cyct < 0)
>  		dev_err(di->dev, "error reading cycle count total\n");
> @@ -421,6 +452,10 @@ static int bq27x00_battery_read_health(struct bq27x0=
0_device_info *di)
>  		else
>  			tval =3D POWER_SUPPLY_HEALTH_GOOD;
>  		return tval;
> +	} else if (di->chip =3D=3D BQ27510) {
> +		if (tval & BQ27500_FLAG_OTC)
> +			return POWER_SUPPLY_HEALTH_OVERHEAT;
> +		return POWER_SUPPLY_HEALTH_GOOD;
>  	} else {
>  		if (tval & BQ27000_FLAG_EDV1)
>  			tval =3D POWER_SUPPLY_HEALTH_DEAD;
> @@ -436,6 +471,7 @@ static void bq27x00_update(struct bq27x00_device_info=
 *di)
>  {
>  	struct bq27x00_reg_cache cache =3D {0, };
>  	bool is_bq27500 =3D di->chip =3D=3D BQ27500;
> +	bool is_bq27510 =3D di->chip =3D=3D BQ27510;
>  	bool is_bq27425 =3D di->chip =3D=3D BQ27425;
>  	bool is_bq27742 =3D di->chip =3D=3D BQ27742;
>  	bool flags_1b =3D !(is_bq27500 || is_bq27742);
> @@ -445,7 +481,7 @@ static void bq27x00_update(struct bq27x00_device_info=
 *di)
>  		/* read error */
>  		cache.flags =3D -1;
>  	if (cache.flags >=3D 0) {
> -		if (!is_bq27500 && !is_bq27425 && !is_bq27742
> +		if (!is_bq27500 && !is_bq27425 && !is_bq27742 && !is_bq27510
>  				&& (cache.flags & BQ27000_FLAG_CI)) {
>  			dev_info(di->dev, "battery is not calibrated! ignoring capacity value=
s\n");
>  			cache.capacity =3D -ENODATA;
> @@ -457,7 +493,7 @@ static void bq27x00_update(struct bq27x00_device_info=
 *di)
>  			cache.health =3D -ENODATA;
>  		} else {
>  			cache.capacity =3D bq27x00_battery_read_rsoc(di);
> -			if (is_bq27742)
> +			if (is_bq27742 || is_bq27510)
>  				cache.time_to_empty =3D
>  					bq27x00_battery_read_time(di,
>  							BQ27x00_REG_TTE);
> @@ -740,6 +776,9 @@ static int bq27x00_powersupply_init(struct bq27x00_de=
vice_info *di)
>  	} else if (di->chip =3D=3D BQ27742) {
>  		di->bat.properties =3D bq27742_battery_props;
>  		di->bat.num_properties =3D ARRAY_SIZE(bq27742_battery_props);
> +	} else if (di->chip =3D=3D BQ27510) {
> +		di->bat.properties =3D bq27510_battery_props;
> +		di->bat.num_properties =3D ARRAY_SIZE(bq27510_battery_props);
>  	} else {
>  		di->bat.properties =3D bq27x00_battery_props;
>  		di->bat.num_properties =3D ARRAY_SIZE(bq27x00_battery_props);
> @@ -897,6 +936,7 @@ static const struct i2c_device_id bq27x00_id[] =3D {
>  	{ "bq27500", BQ27500 },
>  	{ "bq27425", BQ27425 },
>  	{ "bq27742", BQ27742 },
> +	{ "bq27510", BQ27510 },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, bq27x00_id);
> --=20
> 2.1.0
>=20

--gQt10JDuGyDb0HQ5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU7koJAAoJENju1/PIO/qa27cP/jWj6O1syeA3NkGhUmPSuJzR
r2goRI4QuroO+DNkykAyilXqod1pwk3F31uYGqQRyyxB4qF1lQvXxuGGUxyr341Z
KRxyBk7/pGHoNhl3e2ig6xi2XVSG0QqFALB2KX8pZ82/VALinqs4b2vqfV+Qbq4A
ijQnD2K6hG3nA3Ph6MkHkCPze2o+0N5nWyozoJu5DmGW7Sanlgc5I1tjTas/6MwR
CT+sSZEfBIriOgmOuoifkPt8LBORfD2woS2AowRxKredZWRh5jaEvquJ4dGnR1DD
Wo9IHDkfNDsOTjpCZDgjhhOMx54DQbvqkPm8e38vaHWj9A9cimGY4GZaQ5fbFw8f
BaNoIpUGQvMSSphNT3qtkMU9ArhWxU+pCFarpVC4kBjQ7NHZGbgLSlLG97saJgx2
lKh+fibzjYbDevv2VNxa35EEqlPR598V7t3mmsvKZ7K5n0eLL0ZGFTLmh3lN+UJ9
/ruI50uecRu0kFzIGHgOcAu6xvNcKknstF8iBP7aK5zL28KQspgpsHVcTRYbWZOH
B4wucglp9vex6B/+JukFnCxVcOeU9jb9O6mtQ0ysW2oIkaI09iy3xwtZl86xayuj
MqeKucuPUdB6Pan6wdt/jl8cHt5XJ9vZT6eOIdLLpD3bSHhKeJH9fWAEAOuJOyn7
UliyQtZWmb9qbMwhpP2c
=xWn5
-----END PGP SIGNATURE-----

--gQt10JDuGyDb0HQ5--
