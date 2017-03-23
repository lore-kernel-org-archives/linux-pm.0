From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v11 07/10] power: bq27xxx_battery: Keep track of specific
 chip id
Date: Thu, 23 Mar 2017 11:28:25 +0100
Message-ID: <20170323102825.vvxfzvuvvnhyzlna@earth>
References: <20170320094335.19224-1-liam@networkimprov.net>
 <20170320094335.19224-8-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hyj5ct76jh6ivvkh"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754294AbdCWK2c (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 Mar 2017 06:28:32 -0400
Content-Disposition: inline
In-Reply-To: <20170320094335.19224-8-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>


--hyj5ct76jh6ivvkh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 20, 2017 at 02:43:32AM -0700, Liam Breck wrote:
> From: Liam Breck <kernel@networkimprov.net>
>=20
> Pass actual chip ID into _setup(), which translates it to a group ID,
> to allow support for all chips by the power_supply_battery_info code.
> There are no functional changes to the driver.
>=20
> Signed-off-by: Liam Breck <kernel@networkimprov.net>

This is really ugly. If we need chip ID and group ID let's store
them in different variables. For example put the detailed chipid
into di->realchip and then do

switch(di->realchip) {
case FOO:
    di->chip =3D GRP_FOO;
    break;
case BAR:
    di->chip =3D GRP_BAR;
    break;
default:
    di->chip =3D di->realchip;
    break;
}

-- Sebastian

>  drivers/power/supply/bq27xxx_battery.c     | 27 ++++++++++++++++++++++++=
+++
>  drivers/power/supply/bq27xxx_battery_i2c.c | 16 ++++++++--------
>  include/linux/power/bq27xxx_battery.h      | 11 +++++++++++
>  3 files changed, 46 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/suppl=
y/bq27xxx_battery.c
> index f36a6f1..db1a388 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -1391,6 +1391,33 @@ int bq27xxx_battery_setup(struct bq27xxx_device_in=
fo *di)
>  	struct power_supply_desc *psy_desc;
>  	struct power_supply_config psy_cfg =3D { .drv_data =3D di, };
> =20
> +	switch(di->chip) {
> +	case BQ27000:
> +	case BQ27010:
> +	case BQ2750X:
> +	case BQ2751X:
> +	case BQ27500:
> +	case BQ27510G1:
> +	case BQ27510G2:
> +	case BQ27510G3:
> +	case BQ27520G1:
> +	case BQ27520G2:
> +	case BQ27520G3:
> +	case BQ27520G4:
> +	case BQ27530:
> +	case BQ27541:
> +	case BQ27545:
> +	case BQ27421: break;
> +	case BQ2752X: di->chip =3D BQ2751X; break;
> +	case BQ27531: di->chip =3D BQ27530; break;
> +	case BQ27542: di->chip =3D BQ27541; break;
> +	case BQ27546: di->chip =3D BQ27541; break;
> +	case BQ27742: di->chip =3D BQ27541; break;
> +	case BQ27425: di->chip =3D BQ27421; break;
> +	case BQ27441: di->chip =3D BQ27421; break;
> +	case BQ27621: di->chip =3D BQ27421; break;
> +	}
> +
>  	INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
>  	mutex_init(&di->lock);
>  	di->regs =3D bq27xxx_regs[di->chip];
> diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/s=
upply/bq27xxx_battery_i2c.c
> index c68fbc3..b3f2494 100644
> --- a/drivers/power/supply/bq27xxx_battery_i2c.c
> +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
> @@ -150,7 +150,7 @@ static const struct i2c_device_id bq27xxx_i2c_id_tabl=
e[] =3D {
>  	{ "bq27210", BQ27010 },
>  	{ "bq27500", BQ2750X },
>  	{ "bq27510", BQ2751X },
> -	{ "bq27520", BQ2751X },
> +	{ "bq27520", BQ2752X },
>  	{ "bq27500-1", BQ27500 },
>  	{ "bq27510g1", BQ27510G1 },
>  	{ "bq27510g2", BQ27510G2 },
> @@ -160,16 +160,16 @@ static const struct i2c_device_id bq27xxx_i2c_id_ta=
ble[] =3D {
>  	{ "bq27520g3", BQ27520G3 },
>  	{ "bq27520g4", BQ27520G4 },
>  	{ "bq27530", BQ27530 },
> -	{ "bq27531", BQ27530 },
> +	{ "bq27531", BQ27531 },
>  	{ "bq27541", BQ27541 },
> -	{ "bq27542", BQ27541 },
> -	{ "bq27546", BQ27541 },
> -	{ "bq27742", BQ27541 },
> +	{ "bq27542", BQ27542 },
> +	{ "bq27546", BQ27546 },
> +	{ "bq27742", BQ27742 },
>  	{ "bq27545", BQ27545 },
>  	{ "bq27421", BQ27421 },
> -	{ "bq27425", BQ27421 },
> -	{ "bq27441", BQ27421 },
> -	{ "bq27621", BQ27421 },
> +	{ "bq27425", BQ27425 },
> +	{ "bq27441", BQ27441 },
> +	{ "bq27621", BQ27621 },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, bq27xxx_i2c_id_table);
> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/=
bq27xxx_battery.h
> index c3369fa..96cec17 100644
> --- a/include/linux/power/bq27xxx_battery.h
> +++ b/include/linux/power/bq27xxx_battery.h
> @@ -2,6 +2,7 @@
>  #define __LINUX_BQ27X00_BATTERY_H__
> =20
>  enum bq27xxx_chip {
> +	/* categories; index for bq27xxx_regs[] */
>  	BQ27000 =3D 1, /* bq27000, bq27200 */
>  	BQ27010, /* bq27010, bq27210 */
>  	BQ2750X, /* bq27500 deprecated alias */
> @@ -18,6 +19,16 @@ enum bq27xxx_chip {
>  	BQ27541, /* bq27541, bq27542, bq27546, bq27742 */
>  	BQ27545, /* bq27545 */
>  	BQ27421, /* bq27421, bq27425, bq27441, bq27621 */
> +
> +	/* members of categories; translate these to category in _setup() */
> +	BQ2752X, /* deprecated alias */
> +	BQ27531,
> +	BQ27542,
> +	BQ27546,
> +	BQ27742,
> +	BQ27425,
> +	BQ27441,
> +	BQ27621,
>  };
> =20
>  /**
> --=20
> 2.9.3
>=20

--hyj5ct76jh6ivvkh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljTo0kACgkQ2O7X88g7
+poPpQ/+L00qV9K5uJ7de5t9M1hfsWw936uOfULmSvynmIhnRoQKPGZCHUhEaSYP
FnABU4vKfRFIU55pfb8NbP69MNGXlHcjIxi6hisNb4d56Qy9pwbqat2F6R2pf2Q9
mKnrQakqM504RWb1Gs8KuOdeSOOpFF7CkfyXehVPWJcYtqAWxSRF2iMXfTyvj/I0
10sTXJSgcEzfaPpLwpyBJBfzMy/EWOMqJxo2Kr7w0A0+5Dy4gzbr0NiPn73WJk/8
Wx/XGByOp7+TzbGBx6W4KDzRMmbLAiLPWwe6S0TBc3gIGXhXmOkV7f2k9Lxd2Tsf
cxJD/ISR7ldG73M1J8oJy5BMWkkc6a7pWUQwxSu5HXoZf+XyBK/gjKGwms1ZIPMu
XsYtN+mrrTaWEhggfIvNv5tHwyBDbAr/LlWajLSCvRMlNitE4MoqFgA56J114nmH
/kVnkNoLac9j3QqWsHtZd+CULIcC26ZuhgWUkKGQRWCId8F+t6uOhJH4VsFRfhLy
J7qYOcKrfVdJ+Nq928ZkKl/9+hLvX5BMbPSHt/iIMaQS947Ll0DUZXHFYw2PR+do
l2Y1sORmAhpLhdG5TrHiSXCaW6IgoGOFlvXhSGJa/8ysCsusy8kQ5HByoDzQp3qC
RICmrzBSMC6fjXIG4XawfZSMRXtM/fpN4B/ief7s9j0tVCdL/GM=
=Rdbu
-----END PGP SIGNATURE-----

--hyj5ct76jh6ivvkh--
