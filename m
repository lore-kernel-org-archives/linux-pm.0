From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v14 10/11] power: supply: bq27xxx: Flag identical
 register maps when in debug mode
Date: Thu, 15 Jun 2017 18:06:02 +0200
Message-ID: <20170615160602.suuynekxkwhz7n6j@earth>
References: <20170607183759.20261-1-liam@networkimprov.net>
 <20170607183759.20261-11-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pt3dvkymsf3nhtgo"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45457 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbdFOQGG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Jun 2017 12:06:06 -0400
Content-Disposition: inline
In-Reply-To: <20170607183759.20261-11-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Pali Rohar <pali.rohar@gmail.com>, linux-pm@vger.kernel.org, Enric Balletbo <enric.balletbo@collabora.com>, Paul Kocialkowski <contact@paulk.fr>, Quentin Schulz <quentin.schulz@free-electrons.com>, Liam Breck <kernel@networkimprov.net>


--pt3dvkymsf3nhtgo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 07, 2017 at 11:37:58AM -0700, Liam Breck wrote:
> From: Liam Breck <kernel@networkimprov.net>
>=20
> We tie multiple chips to unique register maps. When supporting a new chip,
> it's easy to add a duplicate map by mistake.
>=20
> In debug mode we now scan the register maps for duplicates.
>=20
> Signed-off-by: Liam Breck <kernel@networkimprov.net>

This does not belong into the kernel, but into some static analyzer
tool.

-- Sebastian

>  drivers/power/supply/bq27xxx_battery.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/suppl=
y/bq27xxx_battery.c
> index a7014525..f4449aba 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -1931,6 +1931,25 @@ static void bq27xxx_external_power_changed(struct =
power_supply *psy)
>  	schedule_delayed_work(&di->work, 0);
>  }
> =20
> +#ifdef DEBUG
> +static void bq27xxx_battery_dbg_regs_dupes(struct bq27xxx_device_info *d=
i)
> +{
> +	const size_t max =3D ARRAY_SIZE(bq27xxx_regs);
> +	int a, b;
> +
> +	for (a =3D 1; a < max-1; a++) {
> +		for (b =3D a+1; b < max; b++) {
> +			if (!memcmp(bq27xxx_regs[a], bq27xxx_regs[b],
> +				    sizeof(bq27xxx_regs[0])))
> +				dev_warn(di->dev,
> +					"bq27xxx_regs[%d] & [%d] are identical\n", a, b);
> +		}
> +	}
> +}
> +#else
> +static inline void bq27xxx_battery_dbg_regs_dupes(struct bq27xxx_device_=
info *di) {}
> +#endif
> +
>  int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
>  {
>  	struct power_supply_desc *psy_desc;
> @@ -1939,6 +1958,8 @@ int bq27xxx_battery_setup(struct bq27xxx_device_inf=
o *di)
>  		.drv_data =3D di,
>  	};
> =20
> +	bq27xxx_battery_dbg_regs_dupes(di);
> +
>  	di->ram_chip =3D di->real_chip =3D=3D BQ27421 ||
>  		       di->real_chip =3D=3D BQ27441 ||
>  		       di->real_chip =3D=3D BQ27621;
> --=20
> 2.13.0
>=20

--pt3dvkymsf3nhtgo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllCsGoACgkQ2O7X88g7
+ppKhw//WxzCexKzCp4QdAl3Om/BjwdMfGQZY9yLqBJmmu53nIuBJfVin+pDg71z
a10J8tDYQn1QRhMJ9uAIppf6PcbMQ0D1djQlj03xvZYtc8z36HqTSKELyQ21pmTW
GVOLypqlP68QJV61NYEserxxTDuITPBYRhKMbAHf/X0XdG5mM/jdYNlzDqBXCMum
k6wpFmN8ZUyuUZ8xSwwtWHgi/a/ZfSolo9fCW/XmXtxiJwF+uhBu+VcJ5yUerklj
CHlTuO9c33R9/BrrxIvwOPoyRIDdo5puye/nhgRemKbPst/MVAKT4iTXkUo3+rx/
uQHUaHpHVkmUXSHIHpNEHqMu+R22Uox1goNw9nqn3NvVssXQZWjbDe4hUuOrU6s0
5/EAYT8caViOZRU1LIcKhmFYnulrCmsUMv6ygpzwv7IPEi0VnFLMhbAfH3w+q22u
DUNJFOOlyi+GvMhZJ9NTP7E8JyJAelqCAXgMisxRGgDcLfU8CwKLYuj+nl2T5wIN
ekKwz8M0rBAXvEhlAMagBrpB/CFCTjF6itDhHFcskcfsiZXz6Ck/0C5k+ek//bpX
W+pyKF3QJVDmfcc/mGaP5iEd9w5MXVk5gX0CD48UdIn05cnYUH3lxsDdqSMQ+W8j
NmWvIA4GmbMy5Cv6nILEPJnxuFx+0Wy2cB6M1XKX/Ul0c8CzGC0=
=enZk
-----END PGP SIGNATURE-----

--pt3dvkymsf3nhtgo--
