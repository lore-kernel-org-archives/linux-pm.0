From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 09/10] power: supply: olpc_battery: Add OLPC XO 1.75
 support
Date: Fri, 5 Apr 2019 15:50:25 +0200
Message-ID: <20190405135025.v4sn33mkgdrsjvtm@earth.universe>
References: <20190310162419.11861-1-lkundrak@v3.sk>
 <20190310162419.11861-10-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zr6rkb6gtz4ibzpy"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190310162419.11861-10-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Darren Hart <dvhart@infradead.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, x86@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--zr6rkb6gtz4ibzpy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Mar 10, 2019 at 05:24:18PM +0100, Lubomir Rintel wrote:
> The battery and the protocol are essentially the same as OLPC XO 1.5,
> but the responses from the EC are LSB first.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Pavel Machek <pavel@ucw.cz>
>=20
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

> Changes since v5:
> - s/int little_endian/bool little_endian/
>=20
> Changes since v2:
> - Fix the version conditional
>=20
> Changes since v1:
> - s/s16 ecword_to_cpu/u16 ecword_to_cpu/
> - s/u16 ec_byte/u16 ec_word/
>=20
>  drivers/power/supply/olpc_battery.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/o=
lpc_battery.c
> index 8be44c717d85..0d67158c13d6 100644
> --- a/drivers/power/supply/olpc_battery.c
> +++ b/drivers/power/supply/olpc_battery.c
> @@ -58,6 +58,7 @@ struct olpc_battery_data {
>  	struct power_supply *olpc_bat;
>  	char bat_serial[17];
>  	bool new_proto;
> +	bool little_endian;
>  };
> =20
>  /*********************************************************************
> @@ -323,6 +324,14 @@ static int olpc_bat_get_voltage_max_design(union pow=
er_supply_propval *val)
>  	return ret;
>  }
> =20
> +static u16 ecword_to_cpu(struct olpc_battery_data *data, u16 ec_word)
> +{
> +	if (data->little_endian)
> +		return le16_to_cpu(ec_word);
> +	else
> +		return be16_to_cpu(ec_word);
> +}
> +
>  /*********************************************************************
>   *		Battery properties
>   *********************************************************************/
> @@ -395,7 +404,7 @@ static int olpc_bat_get_property(struct power_supply =
*psy,
>  		if (ret)
>  			return ret;
> =20
> -		val->intval =3D (s16)be16_to_cpu(ec_word) * 9760L / 32;
> +		val->intval =3D ecword_to_cpu(data, ec_word) * 9760L / 32;
>  		break;
>  	case POWER_SUPPLY_PROP_CURRENT_AVG:
>  	case POWER_SUPPLY_PROP_CURRENT_NOW:
> @@ -403,7 +412,7 @@ static int olpc_bat_get_property(struct power_supply =
*psy,
>  		if (ret)
>  			return ret;
> =20
> -		val->intval =3D (s16)be16_to_cpu(ec_word) * 15625L / 120;
> +		val->intval =3D ecword_to_cpu(data, ec_word) * 15625L / 120;
>  		break;
>  	case POWER_SUPPLY_PROP_CAPACITY:
>  		ret =3D olpc_ec_cmd(EC_BAT_SOC, NULL, 0, &ec_byte, 1);
> @@ -434,21 +443,21 @@ static int olpc_bat_get_property(struct power_suppl=
y *psy,
>  		if (ret)
>  			return ret;
> =20
> -		val->intval =3D (s16)be16_to_cpu(ec_word) * 10 / 256;
> +		val->intval =3D ecword_to_cpu(data, ec_word) * 10 / 256;
>  		break;
>  	case POWER_SUPPLY_PROP_TEMP_AMBIENT:
>  		ret =3D olpc_ec_cmd(EC_AMB_TEMP, NULL, 0, (void *)&ec_word, 2);
>  		if (ret)
>  			return ret;
> =20
> -		val->intval =3D (int)be16_to_cpu(ec_word) * 10 / 256;
> +		val->intval =3D (int)ecword_to_cpu(data, ec_word) * 10 / 256;
>  		break;
>  	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
>  		ret =3D olpc_ec_cmd(EC_BAT_ACR, NULL, 0, (void *)&ec_word, 2);
>  		if (ret)
>  			return ret;
> =20
> -		val->intval =3D (s16)be16_to_cpu(ec_word) * 6250 / 15;
> +		val->intval =3D ecword_to_cpu(data, ec_word) * 6250 / 15;
>  		break;
>  	case POWER_SUPPLY_PROP_SERIAL_NUMBER:
>  		ret =3D olpc_ec_cmd(EC_BAT_SERIAL, NULL, 0, (void *)&ser_buf, 8);
> @@ -622,7 +631,11 @@ static int olpc_battery_probe(struct platform_device=
 *pdev)
>  	if (ret)
>  		return ret;
> =20
> -	if (ecver > 0x44) {
> +	if (of_find_compatible_node(NULL, NULL, "olpc,xo1.75-ec")) {
> +		/* XO 1.75 */
> +		data->new_proto =3D true;
> +		data->little_endian =3D true;
> +	} else if (ecver > 0x44) {
>  		/* XO 1 or 1.5 with a new EC firmware. */
>  		data->new_proto =3D true;
>  	} else if (ecver < 0x44) {
> --=20
> 2.20.1
>=20

--zr6rkb6gtz4ibzpy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlynXSEACgkQ2O7X88g7
+ppOKw//et6UMKFAZCoUWBKGPxze0tyeRPa/oo9hnQop3QzOHxAsyZRIpgJ9PYnE
PGzNvZc3/CNgaBjIt1HFS1A5NXWmW77Go8NrEo8R1y4bYJ7MyxAc9hD2FOS6b7/A
gRxexw9yf9RAq0s8xeUHOGcf2i9OwX2+StGkyMixPPh90R9hE7bPufCKzzoBabRx
inIZ3FT9UB8wP6aCgGhENHjKlZYnbIM4Jbd3G4u0d7ZiOVMxA2LnEuU7lQRx0sjw
o02bXLk0/UsECSDiq+wwhSI8S3p8KeRrI6EB5vNnfuvzGGPTGkbzr5guc8g1XMb6
Rkm+ZA0tgAO+PI4/KmQoyX3qbJxvEa/2fCOQBXrL200XFk/WuKNSyHameLY5HmKa
1YAirLEGjzo+e87HznGunCAxaoIQRM5eunh+yAbIybSlgb0Gr7FbrdpOB5Gcn3zr
D5KP/GEgGrk/7Z51cEfG5iuZ7PzaB+wVy8QoDWJ1hKl4AG3uANkw1zmogorljLyk
JuWOgGvRhAbATVkC83IWFZwTT6VyMWGAWHsb8SYqYT1SHTHl5HJv+xm0AMJWD3e3
g0Bb2QgPYQiDyw2vl56SYGMiMvHP4iWcDaNPI0eBRFk+Qt+y7Vw6wYcnGGqVDuuP
JxYvgJboBKXWIMqkddMyncOY1vEH5iRTUiWsPuZrGlBoTp9bKUE=
=mpI2
-----END PGP SIGNATURE-----

--zr6rkb6gtz4ibzpy--
