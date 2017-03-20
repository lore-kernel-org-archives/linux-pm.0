From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 09/15] power: supply: bq24190_charger: Add
 voltage_max_design prop to battery
Date: Mon, 20 Mar 2017 06:12:25 +0100
Message-ID: <20170320051225.d4fsffx3updncdqd@earth>
References: <20170317095527.10487-1-hdegoede@redhat.com>
 <20170317095527.10487-10-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n6mfio3fwvnqn5gp"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750972AbdCTFMb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 Mar 2017 01:12:31 -0400
Content-Disposition: inline
In-Reply-To: <20170317095527.10487-10-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--n6mfio3fwvnqn5gp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 17, 2017 at 10:55:21AM +0100, Hans de Goede wrote:
> When combined with an external fuel-gauge, upower needs voltage_max_design
> as it internally does all its calculations in Watts and converts the
> charge_foo properties from A to Watts by using voltage_max_design.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Assuming, that my comment on patch 14 works POWER_SUPPLY_PROP_VOLTAGE_MAX_D=
ESIGN
is required in the fuel-gauge driver instead. As far as I understand
it the charger voltage was too high for your device anyways, so that
you capped it at 4.3V. So I assume, that you can just provide it via
device properties.

-- Sebastian

>  drivers/power/supply/bq24190_charger.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/suppl=
y/bq24190_charger.c
> index 9fe69a5..82cb33d 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -1103,6 +1103,13 @@ static int bq24190_battery_get_property(struct pow=
er_supply *psy,
>  		val->intval =3D POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
>  		ret =3D 0;
>  		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> +		/*
> +		 * Report charger configured voltage as max design voltage,
> +		 * not entirely correct, but userspace needs something here.
> +		 */
> +		ret =3D bq24190_charger_get_voltage(bdi, val);
> +		break;
>  	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
>  		ret =3D bq24190_battery_get_temp_alert_max(bdi, val);
>  		break;
> @@ -1169,6 +1176,7 @@ static enum power_supply_property bq24190_battery_p=
roperties[] =3D {
>  	POWER_SUPPLY_PROP_HEALTH,
>  	POWER_SUPPLY_PROP_ONLINE,
>  	POWER_SUPPLY_PROP_TECHNOLOGY,
> +	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
>  	POWER_SUPPLY_PROP_TEMP_ALERT_MAX,
>  	POWER_SUPPLY_PROP_SCOPE,
>  	/* Begin of extended battery properties */
> @@ -1186,7 +1194,7 @@ static const struct power_supply_desc bq24190_batte=
ry_desc =3D {
>  	.name			=3D "bq24190-battery",
>  	.type			=3D POWER_SUPPLY_TYPE_BATTERY,
>  	.properties		=3D bq24190_battery_properties,
> -	.num_properties		=3D 6,
> +	.num_properties		=3D 7,
>  	.get_property		=3D bq24190_battery_get_property,
>  	.set_property		=3D bq24190_battery_set_property,
>  	.property_is_writeable	=3D bq24190_battery_property_is_writeable,
> --=20
> 2.9.3
>=20

--n6mfio3fwvnqn5gp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljPZLkACgkQ2O7X88g7
+pqozA//WB8B7ZlYSz+ZNUNN/NpgjsYCV30hINT2n+0r1acdD64r+bEFQtOGbRJc
/Gm6YcOivBRqYEPIE5bjtuWlH9s8Kfbc/KrgPQEYYFDWWMBi9/u/pRTDd9FX0aZ3
SK6JVJxMB584miE0UqbKVjvMHCcxUlHb/mq75KsCioviuy1xiUhwQdQ6h32IlcDd
xe4lsIcPXd13UPuCwKXvv9nJqqgzJGo5LpL84Y3xEoUPs76osg0CXYXrlTX7Xj1p
zpFHm4apjSnXaFcchtiwwolSc6iv2CSoDPfVuHNyOyjbZcZ7YdeaDefEIhHA4QXb
rjQLUHpg7xq2aciPTksEr3AO7VLs/K71TR9a7JDLvOqMADCTSIibMsk7mwmKm7y1
I63fkUmnrTZARKbKRI0Hckowyrh6ShLuIwu0XP1BLb5mYizI0TXMfrULFNp+e1da
AMp7Z/PdR3oh2jdqR9oupqc0CXQc6w3CnvNxdOwj3vNBxRQM6+Y/+rkTJG7gcX0O
XotRcgCUYVLm5rLLJAiZcJY2YLciWrysXBEIYBaCjYqN2vxZhfPSovKQH/dtKCjL
RyyeUdifnpfGnoSvqmIyI+xrkJeEgMg8A9v+LXtumsbZGesM6W/lz/pJ6YWJ25Dg
2aYPTyEyFdBXB7Zjocc5aEH0hCEgdasu9KyfCmmuvhb3HfB2EuA=
=rwPB
-----END PGP SIGNATURE-----

--n6mfio3fwvnqn5gp--
