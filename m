From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v2 14/17] power: supply: olpc_battery: Move priv data to
 a struct
Date: Wed, 5 Dec 2018 21:57:06 +0100
Message-ID: <20181205205706.t2kvn2smjgsjmy2e@earth.universe>
References: <20181116162403.49854-1-lkundrak@v3.sk>
 <20181116162403.49854-15-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5726451453122118614=="
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20181116162403.49854-15-lkundrak@v3.sk>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, devel@driverdev.osuosl.org, Eric Miao <eric.y.miao@gmail.com>, James Cameron <quozl@laptop.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>, Andy Shevchenko <andy@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--===============5726451453122118614==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rvd4mgdiw6nkv3x6"
Content-Disposition: inline


--rvd4mgdiw6nkv3x6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 16, 2018 at 05:24:00PM +0100, Lubomir Rintel wrote:
> The global variables for private data are not too nice. I'd like some
> more, and that would clutter the global name space even further.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>=20
> ---
> Changes since v1:
> - Split out the move to devm_* into a separate patch
>=20
>  drivers/power/supply/olpc_battery.c | 68 +++++++++++++++++------------
>  1 file changed, 40 insertions(+), 28 deletions(-)
>=20
> diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/o=
lpc_battery.c
> index 5323987d9284..b091f897c1d4 100644
> --- a/drivers/power/supply/olpc_battery.c
> +++ b/drivers/power/supply/olpc_battery.c
> @@ -53,6 +53,12 @@
> =20
>  #define BAT_ADDR_MFR_TYPE	0x5F
> =20
> +struct olpc_battery_data {
> +	struct power_supply *olpc_ac;
> +	struct power_supply *olpc_bat;
> +	char bat_serial[17];
> +};
> +
>  /*********************************************************************
>   *		Power
>   *********************************************************************/
> @@ -91,11 +97,8 @@ static const struct power_supply_desc olpc_ac_desc =3D=
 {
>  	.get_property =3D olpc_ac_get_prop,
>  };
> =20
> -static struct power_supply *olpc_ac;
> -
> -static char bat_serial[17]; /* Ick */
> -
> -static int olpc_bat_get_status(union power_supply_propval *val, uint8_t =
ec_byte)
> +static int olpc_bat_get_status(struct olpc_battery_data *data,
> +		union power_supply_propval *val, uint8_t ec_byte)
>  {
>  	if (olpc_platform_info.ecver > 0x44) {
>  		if (ec_byte & (BAT_STAT_CHARGING | BAT_STAT_TRICKLE))
> @@ -326,6 +329,7 @@ static int olpc_bat_get_property(struct power_supply =
*psy,
>  				 enum power_supply_property psp,
>  				 union power_supply_propval *val)
>  {
> +	struct olpc_battery_data *data =3D power_supply_get_drvdata(psy);
>  	int ret =3D 0;
>  	__be16 ec_word;
>  	uint8_t ec_byte;
> @@ -347,7 +351,7 @@ static int olpc_bat_get_property(struct power_supply =
*psy,
> =20
>  	switch (psp) {
>  	case POWER_SUPPLY_PROP_STATUS:
> -		ret =3D olpc_bat_get_status(val, ec_byte);
> +		ret =3D olpc_bat_get_status(data, val, ec_byte);
>  		if (ret)
>  			return ret;
>  		break;
> @@ -450,8 +454,8 @@ static int olpc_bat_get_property(struct power_supply =
*psy,
>  		if (ret)
>  			return ret;
> =20
> -		sprintf(bat_serial, "%016llx", (long long)be64_to_cpu(ser_buf));
> -		val->strval =3D bat_serial;
> +		sprintf(data->bat_serial, "%016llx", (long long)be64_to_cpu(ser_buf));
> +		val->strval =3D data->bat_serial;
>  		break;
>  	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
>  		ret =3D olpc_bat_get_voltage_max_design(val);
> @@ -579,17 +583,17 @@ static struct power_supply_desc olpc_bat_desc =3D {
>  	.use_for_apm =3D 1,
>  };
> =20
> -static struct power_supply *olpc_bat;
> -
>  static int olpc_battery_suspend(struct platform_device *pdev,
>  				pm_message_t state)
>  {
> -	if (device_may_wakeup(&olpc_ac->dev))
> +	struct olpc_battery_data *data =3D platform_get_drvdata(pdev);
> +
> +	if (device_may_wakeup(&data->olpc_ac->dev))
>  		olpc_ec_wakeup_set(EC_SCI_SRC_ACPWR);
>  	else
>  		olpc_ec_wakeup_clear(EC_SCI_SRC_ACPWR);
> =20
> -	if (device_may_wakeup(&olpc_bat->dev))
> +	if (device_may_wakeup(&data->olpc_bat->dev))
>  		olpc_ec_wakeup_set(EC_SCI_SRC_BATTERY | EC_SCI_SRC_BATSOC
>  				   | EC_SCI_SRC_BATERR);
>  	else
> @@ -601,7 +605,8 @@ static int olpc_battery_suspend(struct platform_devic=
e *pdev,
> =20
>  static int olpc_battery_probe(struct platform_device *pdev)
>  {
> -	int ret;
> +	struct power_supply_config psy_cfg =3D {};
> +	struct olpc_battery_data *data;

^ uninitialized pointer

>  	uint8_t status;
> =20
>  	/*
> @@ -620,9 +625,13 @@ static int olpc_battery_probe(struct platform_device=
 *pdev)
> =20
>  	/* Ignore the status. It doesn't actually matter */
> =20
> -	olpc_ac =3D power_supply_register(&pdev->dev, &olpc_ac_desc, NULL);
> -	if (IS_ERR(olpc_ac))
> -		return PTR_ERR(olpc_ac);
> +	psy_cfg.of_node =3D pdev->dev.of_node;
> +	psy_cfg.drv_data =3D data;

^ usage of uninitialized pointer. You are missing a kmalloc call.

-- Sebastian

> +	data->olpc_ac =3D power_supply_register(&pdev->dev, &olpc_ac_desc, &psy=
_cfg);
> +	if (IS_ERR(data->olpc_ac))
> +		return PTR_ERR(data->olpc_ac);
> +
>  	if (of_property_match_string(pdev->dev.of_node, "compatible",
>  					"olpc,xo1.5-battery") >=3D 0) {
>  		/* XO-1.5 */
> @@ -634,42 +643,45 @@ static int olpc_battery_probe(struct platform_devic=
e *pdev)
>  		olpc_bat_desc.num_properties =3D ARRAY_SIZE(olpc_xo1_bat_props);
>  	}
> =20
> -	olpc_bat =3D power_supply_register(&pdev->dev, &olpc_bat_desc, NULL);
> +	data->olpc_bat =3D power_supply_register(&pdev->dev, &olpc_bat_desc, &p=
sy_cfg);
>  	if (IS_ERR(olpc_bat)) {
>  		ret =3D PTR_ERR(olpc_bat);
>  		goto battery_failed;
>  	}
> =20
> -	ret =3D device_create_bin_file(&olpc_bat->dev, &olpc_bat_eeprom);
> +	ret =3D device_create_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
>  	if (ret)
>  		goto eeprom_failed;
> =20
> -	ret =3D device_create_file(&olpc_bat->dev, &olpc_bat_error);
> +	ret =3D device_create_file(&data->olpc_bat->dev, &olpc_bat_error);
>  	if (ret)
>  		goto error_failed;
> =20
>  	if (olpc_ec_wakeup_available()) {
> -		device_set_wakeup_capable(&olpc_ac->dev, true);
> -		device_set_wakeup_capable(&olpc_bat->dev, true);
> +		device_set_wakeup_capable(&data->olpc_ac->dev, true);
> +		device_set_wakeup_capable(&data->olpc_bat->dev, true);
>  	}
> =20
>  	return 0;
> =20
>  error_failed:
> -	device_remove_bin_file(&olpc_bat->dev, &olpc_bat_eeprom);
> +	device_remove_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
>  eeprom_failed:
> -	power_supply_unregister(olpc_bat);
> +	power_supply_unregister(data->olpc_bat);
>  battery_failed:
> -	power_supply_unregister(olpc_ac);
> +	power_supply_unregister(data->olpc_ac);
>  	return ret;
>  }
> =20
>  static int olpc_battery_remove(struct platform_device *pdev)
>  {
> -	device_remove_file(&olpc_bat->dev, &olpc_bat_error);
> -	device_remove_bin_file(&olpc_bat->dev, &olpc_bat_eeprom);
> -	power_supply_unregister(olpc_bat);
> -	power_supply_unregister(olpc_ac);
> +	struct olpc_battery_data *data =3D platform_get_drvdata(pdev);
> +
> +	device_remove_file(&data->olpc_bat->dev, &olpc_bat_error);
> +	device_remove_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
> +	power_supply_unregister(data->olpc_bat);
> +	power_supply_unregister(data->olpc_ac);
> +
>  	return 0;
>  }
> =20
> --=20
> 2.19.1
>=20

--rvd4mgdiw6nkv3x6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwIO6IACgkQ2O7X88g7
+pqhYA//RSUMcU0wjb+mnFy4tyilv4+TTEXCNYzWLkAKzpROTlYxF9KlEuiQZmxB
+rhu+b9acrnQSMUY/Je79obIELNai3atL+GtcSirp//tsw7pXbBTWsfWc+9EW/8o
zIlAOnMFr1JiTHE/PcTT+LtGhRyqmhQyTmJD1gyS5Ijq7uEZ/NFqCZFX5YNnMpd3
sQSvpRngTMWThWlu6ULs/DYSYP/zECg5Ryf4C/y2hEWulnRsOAmBVtTb3iR1PaQh
ZWraLiSG/EzY/pNaJdIhsS4J3QAHmEPeowVJ8ByKZlL9VeZfrmVD+04rtLCZNtsz
h3uWqhrwlgHDEzKOEne/1YcoO1dVfJrv6xAHV3t5iQys8HSzFt//tuhzsIRnE2KD
KeodxUdIpEzewxv+InbwvUSlf5oAcV8GikL/6SaHMo2IJqa9+RdrG+1mRivYOZlZ
jTCCC+tK59gxL4nL2xV+nOyZS5fRH9FdMgKW97v+1JH6ZFKzHyLo+DrX5ma8HsHS
tfLFCL39aruNg+BemWin7KrcdicrpK5AygShajU37ak2FdXKg6i8ri2oPcHDuu1X
e28KqVfo9EYtrTw0i1kSLALciVILFdfaQgiJwyeM3f4LAAj9818gHDMUEa+RuAm/
3MHoCeGiPBy9p1oQRHyaFGIkWtVJFCfJw0dmDNAfZ8gcMOq3/mk=
=PvxI
-----END PGP SIGNATURE-----

--rvd4mgdiw6nkv3x6--

--===============5726451453122118614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============5726451453122118614==--
