From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v4 6/8] power: bq27xxx_battery: add i2c bulk read/write
 functions
Date: Sun, 29 Jan 2017 19:38:26 +0100
Message-ID: <20170129183826.cyysprznipidkttb@earth>
References: <20170122071404.9654-1-matt@ranostay.consulting>
 <20170122071404.9654-7-matt@ranostay.consulting>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="he3qnjpbzot426ow"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751034AbdA2Sic (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 29 Jan 2017 13:38:32 -0500
Content-Disposition: inline
In-Reply-To: <20170122071404.9654-7-matt@ranostay.consulting>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Matt Ranostay <matt@ranostay.consulting>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, tony@atomide.com


--he3qnjpbzot426ow
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jan 21, 2017 at 11:14:02PM -0800, Matt Ranostay wrote:
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> ---
>  drivers/power/supply/bq27xxx_battery_i2c.c | 62 ++++++++++++++++++++++++=
++++++
>  include/linux/power/bq27xxx_battery.h      |  4 ++
>  2 files changed, 66 insertions(+)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/s=
upply/bq27xxx_battery_i2c.c
> index 2ea2d0b06948..feeb04ed88c8 100644
> --- a/drivers/power/supply/bq27xxx_battery_i2c.c
> +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
> @@ -68,6 +68,64 @@ static int bq27xxx_battery_i2c_read(struct bq27xxx_dev=
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
> +	unsigned char data[4];
> +
> +	if (!client->adapter)
> +		return -ENODEV;
> +
> +	data[0] =3D reg;
> +	if (single) {
> +		data[1] =3D (unsigned char) value;
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
> +	return i2c_transfer(client->adapter, &msg, 1) =3D=3D 1 ? 0 : -EINVAL;
> +}
> +
> +static int bq27xxx_battery_i2c_bulk_read(struct bq27xxx_device_info *di,=
 u8 reg,
> +					 u8 *data, int len)
> +{
> +	struct i2c_client *client =3D to_i2c_client(di->dev);
> +
> +	if (!client->adapter)
> +		return -ENODEV;
> +
> +	return i2c_smbus_read_i2c_block_data(client, reg, len, data);
> +}
> +
> +static int bq27xxx_battery_i2c_bulk_write(struct bq27xxx_device_info *di,
> +					  u8 reg, u8 *data, int len)
> +{
> +	struct i2c_client *client =3D to_i2c_client(di->dev);
> +	struct i2c_msg msg;
> +	u8 buf[33];
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
> +	return i2c_transfer(client->adapter, &msg, 1) =3D=3D 1 ? 0 : -EINVAL;
> +}
> +
>  static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
>  				     const struct i2c_device_id *id)
>  {
> @@ -95,7 +153,11 @@ static int bq27xxx_battery_i2c_probe(struct i2c_clien=
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
> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/=
bq27xxx_battery.h
> index 3f265dbf11af..581402380d6e 100644
> --- a/include/linux/power/bq27xxx_battery.h
> +++ b/include/linux/power/bq27xxx_battery.h
> @@ -41,6 +41,9 @@ struct bq27xxx_platform_data {
>  struct bq27xxx_device_info;
>  struct bq27xxx_access_methods {
>  	int (*read)(struct bq27xxx_device_info *di, u8 reg, bool single);
> +	int (*write)(struct bq27xxx_device_info *di, u8 reg, int value, bool si=
ngle);
> +	int (*read_bulk)(struct bq27xxx_device_info *di, u8 reg, u8 *data, int =
len);
> +	int (*write_bulk)(struct bq27xxx_device_info *di, u8 reg, u8 *data, int=
 len);

So I had a look at patch 8 and I think we should start with finally
converting bq27xxx to regmap API and probably a second regmap for
the block data stuff. That way you get all the debugging info in
debugfs and the driver looks much cleaner.

>  };
> =20
>  struct bq27xxx_reg_cache {
> @@ -71,6 +74,7 @@ struct bq27xxx_device_info {
>  	struct list_head list;
>  	struct mutex lock;
>  	u8 *regs;
> +	u8 buffer[32];

unrelated change.

>  };
> =20
>  void bq27xxx_battery_update(struct bq27xxx_device_info *di);

-- Sebastian

--he3qnjpbzot426ow
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAliONqAACgkQ2O7X88g7
+pqxWg/+Ij4EQ3PhwvzlC6Dh/XYGBaQ4m2CTnakbejoniZ35JFg0KwSpIoiVn1TN
G7ZfA5a2KqId8LNXvDdwb3pU6RDm0sYkOkgSOiRZx4JGhw/8RZ2BqaYCX0v9QNHn
mgx+Fe7osfUXw185OgMiGhczpppiOUkhFtJym/wXdUXAy+XS+8QVWwKkg+6uujp1
46/LCx4SThWwajumOjxJTzQmnj1YOK6EUj4vZIBNMl/SPL7Yc09gsvl2RWAUHF3+
rzTjaNpcTkeZqXHk99kEQ/+qtfU/OavO9oqaSd+qrHzN/9r64Dm385WZw7vX5Crr
T4EcHRavNKljvkTZXvLmL6qHkHZ2CMyZox6QRH86oBEOj8NtgqrYbmBV2H9+PQkh
BuS+pg2BuHDUIGw/Ol8UEPdavrEfJD26diWCUGh6mktgdzBmdCusADEtlBk2efBz
9/IzrnUmipOGq8gNVqvtvDwFAXUENDwwirq1YjYfvkr1fM3MLYNJGYMfV5UAwimN
Jfn2MhdW53cAJkfV4tE6GOJoc98QteQ1MYn4Yo/CBduxeEzCMuVNEp5m4NNnBqMW
c/BGfAr6uPczS6+WNjwoP7K5CuRGhuIG7vhdmhpl9j/bZv0P4rKMK2FWDTrOdOpd
keNxB56itvEMK0EggSm4LdATkSJR/VlbkPuFPhtm6ewb0Nw2Blg=
=BiXp
-----END PGP SIGNATURE-----

--he3qnjpbzot426ow--
