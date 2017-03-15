From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v10 8/8] power: bq27xxx_battery_i2c: Add I2C bulk
 read/write functions
Date: Wed, 15 Mar 2017 23:14:14 +0100
Message-ID: <20170315221414.mcig3c6bp44bitcu@earth>
References: <20170315192653.26799-1-liam@networkimprov.net>
 <20170315192653.26799-9-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fxxc5iomt3ff3ekg"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751416AbdCOWOU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Mar 2017 18:14:20 -0400
Content-Disposition: inline
In-Reply-To: <20170315192653.26799-9-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>


--fxxc5iomt3ff3ekg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 15, 2017 at 12:26:53PM -0700, Liam Breck wrote:
> From: Matt Ranostay <matt@ranostay.consulting>
>=20
> write(), read_bulk(), write_bulk() are required by bq27xxx_battery
> power_supply_battery_info code.
>=20
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> Signed-off-by: Liam Breck <kernel@networkimprov.net>

This is required by the previous patch, so your order is not bisect
safe. Please just merge it with Patch 5.

-- Sebastian

>  drivers/power/supply/bq27xxx_battery_i2c.c | 82 ++++++++++++++++++++++++=
+++++-
>  1 file changed, 81 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/s=
upply/bq27xxx_battery_i2c.c
> index 13def59..abdc266 100644
> --- a/drivers/power/supply/bq27xxx_battery_i2c.c
> +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
> @@ -38,7 +38,7 @@ static int bq27xxx_battery_i2c_read(struct bq27xxx_devi=
ce_info *di, u8 reg,
>  {
>  	struct i2c_client *client =3D to_i2c_client(di->dev);
>  	struct i2c_msg msg[2];
> -	unsigned char data[2];
> +	u8 data[2];
>  	int ret;
> =20
>  	if (!client->adapter)
> @@ -68,6 +68,82 @@ static int bq27xxx_battery_i2c_read(struct bq27xxx_dev=
ice_info *di, u8 reg,
>  	return ret;
>  }
> =20
> +static int bq27xxx_battery_i2c_write(struct bq27xxx_device_info *di, u8 =
reg,
> +				     int value, bool single)
> +{
> +	struct i2c_client *client =3D to_i2c_client(di->dev);
> +	struct i2c_msg msg;
> +	u8 data[4];
> +	int ret;
> +
> +	if (!client->adapter)
> +		return -ENODEV;
> +
> +	data[0] =3D reg;
> +	if (single) {
> +		data[1] =3D (u8) value;
> +		msg.len =3D 2;
> +	} else {
> +		put_unaligned_le16(value, &data[1]);
> +		msg.len =3D 3;
> +	}
> +
> +	msg.buf =3D data;
> +	msg.addr =3D client->addr;
> +	msg.flags =3D 0;
> +
> +	ret =3D i2c_transfer(client->adapter, &msg, 1);
> +	if (ret < 0)
> +		return ret;
> +	if (ret !=3D 1)
> +		return -EINVAL;
> +	return 0;
> +}
> +
> +static int bq27xxx_battery_i2c_bulk_read(struct bq27xxx_device_info *di,=
 u8 reg,
> +					 u8 *data, int len)
> +{
> +	struct i2c_client *client =3D to_i2c_client(di->dev);
> +	int ret;
> +
> +	if (!client->adapter)
> +		return -ENODEV;
> +
> +	ret =3D i2c_smbus_read_i2c_block_data(client, reg, len, data);
> +	if (ret < 0)
> +		return ret;
> +	if (ret !=3D len)
> +		return -EINVAL;
> +	return 0;
> +}
> +
> +static int bq27xxx_battery_i2c_bulk_write(struct bq27xxx_device_info *di,
> +					  u8 reg, u8 *data, int len)
> +{
> +	struct i2c_client *client =3D to_i2c_client(di->dev);
> +	struct i2c_msg msg;
> +	u8 buf[33];
> +	int ret;
> +
> +	if (!client->adapter)
> +		return -ENODEV;
> +
> +	buf[0] =3D reg;
> +	memcpy(&buf[1], data, len);
> +
> +	msg.buf =3D buf;
> +	msg.addr =3D client->addr;
> +	msg.flags =3D 0;
> +	msg.len =3D len + 1;
> +
> +	ret =3D i2c_transfer(client->adapter, &msg, 1);
> +	if (ret < 0)
> +		return ret;
> +	if (ret !=3D 1)
> +		return -EINVAL;
> +	return 0;
> +}
> +
>  static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
>  				     const struct i2c_device_id *id)
>  {
> @@ -95,7 +171,11 @@ static int bq27xxx_battery_i2c_probe(struct i2c_clien=
t *client,
>  	di->dev =3D &client->dev;
>  	di->chip =3D id->driver_data;
>  	di->name =3D name;
> +
>  	di->bus.read =3D bq27xxx_battery_i2c_read;
> +	di->bus.write =3D bq27xxx_battery_i2c_write;
> +	di->bus.read_bulk =3D bq27xxx_battery_i2c_bulk_read;
> +	di->bus.write_bulk =3D bq27xxx_battery_i2c_bulk_write;
> =20
>  	ret =3D bq27xxx_battery_setup(di);
>  	if (ret)
> --=20
> 2.9.3
>=20

--fxxc5iomt3ff3ekg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljJvLYACgkQ2O7X88g7
+poDIg/+LEutW3eW0Stq5rfo3h+ET4XmOFhiHvPjBekOr6PMpA/Cyx4fSROzVKe8
bz+MZiJQCwOHFPBFIgoaCkgmsXq6xKlGiCU+0RTk4uYYHjRVhpiBNFbWN6b3l2Lr
tKQoJjJk9mVsDCmYHrkEhfCPRysQ1YOyldFokdCcKcqnmMHA8+1b1NxwY06t2x+V
7xE8yTlhTGUh8CKWAdz+01pmOTQA0PlvAOAny6Z4aUnenNCCW02/CpXUjp9cf+pi
728HJa4s18Vv/M1gQtJF7s4X/sQ3xVjbyRdj/giRxBTvYSeVQUlz75lVmUE7nSeP
Og+H/w7Z1bMkQ9lVAUh1IkQOviEut3vC+7X5HMGP1sgT/1cU8Ttv8GS1wOFR+kQK
cWJo4CptkHD6oLZOtuS5TQT7+oPPYopRf9N6T6m9aaltiAP3ucRFWpNxOqdUqfoz
rfHtdrWCzigrolPXIFliQpsKLeupebw/03HoMrGyN/JC812ZuryBur6F5+ahNmiW
Z4ISCuMkC0X3y5OLmv5X8MzIYwH5DMZeZ+5ek4H30FCvaVONdZpMN5dpH7NZyN9J
8B2fR8F2ilXxi6oB8+FK0Vt2FvW0Xj3kU1o/Q6SVwRqfXvslBl0DYA9nlGDCKZwS
2RSilL8+SFqlhFSX7ziUGK625iywpYifuTc30JzJDb/MINtcMkg=
=ldxP
-----END PGP SIGNATURE-----

--fxxc5iomt3ff3ekg--
