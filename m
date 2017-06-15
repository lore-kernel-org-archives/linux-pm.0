From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH 1/2] power: supply: sbs-battery: Prevent CAPACITY_MODE
 races
Date: Thu, 15 Jun 2017 18:43:53 +0200
Message-ID: <20170615164353.suitnkeiaorkj6cz@earth>
References: <1497376406-86470-1-git-send-email-shawnn@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2qoadlsi3vp4d74m"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1497376406-86470-1-git-send-email-shawnn@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Nematbakhsh <shawnn@chromium.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, groeck@chromium.org
List-Id: linux-pm@vger.kernel.org


--2qoadlsi3vp4d74m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 13, 2017 at 10:53:25AM -0700, Shawn Nematbakhsh wrote:
> A subset of smart battery commands return charge or energy depending on
> the CAPACITY_MODE bit setting of BatteryMode(). In order to
> unambiguously read a charge or energy value, it is necessary to ensure
> that CAPACITY_MODE is set as desired, and not changed for the duration
> of the attribute read.
>=20
> Signed-off-by: Shawn Nematbakhsh <shawnn@chromium.org>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/sbs-battery.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sb=
s-battery.c
> index e3a114e60f1a..d7e68fd97099 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -171,6 +171,7 @@ struct sbs_info {
>  	u32				i2c_retry_count;
>  	u32				poll_retry_count;
>  	struct delayed_work		work;
> +	struct mutex			mode_lock;
>  };
> =20
>  static char model_name[I2C_SMBUS_BLOCK_MAX + 1];
> @@ -623,7 +624,13 @@ static int sbs_get_property(struct power_supply *psy,
>  		if (ret < 0)
>  			break;
> =20
> +		/* sbs_get_battery_capacity() will change the battery mode
> +		 * temporarily to read the requested attribute. Ensure we stay
> +		 * in the desired mode for the duration of the attribute read.
> +		 */
> +		mutex_lock(&chip->mode_lock);
>  		ret =3D sbs_get_battery_capacity(client, ret, psp, val);
> +		mutex_unlock(&chip->mode_lock);
>  		break;
> =20
>  	case POWER_SUPPLY_PROP_SERIAL_NUMBER:
> @@ -808,6 +815,7 @@ static int sbs_probe(struct i2c_client *client,
>  	psy_cfg.of_node =3D client->dev.of_node;
>  	psy_cfg.drv_data =3D chip;
>  	chip->last_state =3D POWER_SUPPLY_STATUS_UNKNOWN;
> +	mutex_init(&chip->mode_lock);
> =20
>  	/* use pdata if available, fall back to DT properties,
>  	 * or hardcoded defaults if not
> --=20
> 2.13.1.508.gb3defc5cc-goog
>=20

--2qoadlsi3vp4d74m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllCuUkACgkQ2O7X88g7
+pqIdw/2MrHDSyyh22viDUFa2HoZidTZCYrstbCpzimk424vlcYeKOzBYoYq98Uv
5xFlZ0OwY7l8MhCAS1ffBzyUDhz9phS0FTJkzsMpWzKhGDc2muN/BXBGRmeUCJ/8
KL/D++cLbB+PFe1EQ+yKvUn9Bzmo141/zGoMUTGY08r4IUpdQJ9HmwtqRI5ogji4
Y6GRuEvtHXFPZ38veH43yMR5Ya+jGpjbeW2iDDq3nK7ppOBFmttaAVnMoOAZ+tLz
6+6Hp/NdWKzcKZH8TOxySxESB+uVZ887czhEnql5BvRRbtjnWQvSC0VwhCl5d3ab
29Z8UyBNjNBKEFbArbIHdPOjthZ2t7s53M0mVyrObIQtjMuaPPQRiwpGwqtw5p1g
5HKe4/sLO5AAaoGWxSFptb6MZ07u1TDbhpLTABrWsWfwBuyPlsphfCZ3dQl2uNrI
l7PU0ISnFndu8d+eV5R1mkG1pCSE+lKECgGQPZpLpuryAa0XUo+Qm0RbB5jtqzov
Kgiwp7n35bnMNftOK57b7JljJID9+EelJKzGIb6EQngme6TpMb3BiHOohvjZUDUP
S99emhv2CKB0TbdhobknuD2JB/bikLh+fpJRXirkavXlLu+VmhiHgcGLV0q79rFV
Vaf408dLeGOqV7T8l802TNdk92FNEQAYkxyQTfLvUvKB36YOhQ==
=1C7p
-----END PGP SIGNATURE-----

--2qoadlsi3vp4d74m--
