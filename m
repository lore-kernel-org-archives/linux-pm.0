From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH 2/5] power: supply: bq27xxx: Register power supply with
 devm
Date: Mon, 1 May 2017 12:55:37 +0200
Message-ID: <20170501105537.3ghbjcxxychxm52n@earth>
References: <20170430182727.24412-1-contact@paulk.fr>
 <20170430182727.24412-2-contact@paulk.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hpg7qsve2jbfkdle"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57571 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937992AbdEAKzm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 May 2017 06:55:42 -0400
Content-Disposition: inline
In-Reply-To: <20170430182727.24412-2-contact@paulk.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Kocialkowski <contact@paulk.fr>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, "Andrew F . Davis" <afd@ti.com>, Chris Lapa <chris@lapa.com.au>, Matt Ranostay <mranostay@gmail.com>


--hpg7qsve2jbfkdle
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Apr 30, 2017 at 08:27:24PM +0200, Paul Kocialkowski wrote:
> This uses the managed devices resources version of the
> power_supply_register_no_ws function to register the power supply.
>=20
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  drivers/power/supply/bq27xxx_battery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/suppl=
y/bq27xxx_battery.c
> index 6ef95442a918..be476e0bc85d 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -1371,7 +1371,7 @@ int bq27xxx_battery_setup(struct bq27xxx_device_inf=
o *di)
>  	psy_desc->get_property =3D bq27xxx_battery_get_property;
>  	psy_desc->external_power_changed =3D bq27xxx_external_power_changed;
> =20
> -	di->bat =3D power_supply_register_no_ws(di->dev, psy_desc, &psy_cfg);
> +	di->bat =3D devm_power_supply_register_no_ws(di->dev, psy_desc, &psy_cf=
g);
>  	if (IS_ERR(di->bat)) {
>  		dev_err(di->dev, "failed to register battery\n");
>  		return PTR_ERR(di->bat);

That does not make sense if bq27xxx_battery_teardown() still calls
power_supply_unregister().

-- Sebastian

--hpg7qsve2jbfkdle
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkHFCYACgkQ2O7X88g7
+ppXUBAAlORGqz3e53P2z6oLVtW5PR07G5uGj7eJ1Yfa5RjXQllq7f6naF+A8n6q
3Vf4/WyxXAxPcncVLjlLAibngaR2dvnSpHqW6OeDKaSTbk6MagDBWJREz7A5CS14
PVDvGj8h2HiCxQTNgidKNrlfyjbqdyvZdz+lOMeZhM2Umi+EauVI7XsuviYYdVZQ
pEpZM53djLjhc0lQAXOfXRODXmzWvVO9x6/9Tq2+bYr+cPDDH/OBYAaxnQS8QxcB
oOvQyR89H/eMFuTTZUAF2ckSqQ7xdu2xEUcGvSD+aqPDj3SU4tOTaaMAnbyPwEKv
cvmOInZRhdMQkC9ay/uYWUNA5N3YzfroFPAPzXNOeMwV2/e0hiDAfy6+gbk5p3yT
hzISn/d4hlu5gIyzIloCHFpcTj6LV3OgBM5mCseEEyAxx6b5E3NmjinDx7Wdaz4j
24tjxx9v99Weg+i890jlr8Nji76W47ktGppdEVO7s9/6429fpW9Pw9xaZYa4Sm6X
s0MMnw06K3Syns6SmlCqzrORiBaDGs70zKyNbMug4S7svVB0ImVTf4KhY04mDyb7
BzDoQ2mCeYgjdNRHYLC/UfYb5OB0tkRPYy73WtXY9arKI/WCcQ1ADWiaqs+AqvSm
A+n7QMLzatA47KXdgXMcJkQ19y7nNC7Ts6XFpGy1f55sQ3F4og8=
=TgCw
-----END PGP SIGNATURE-----

--hpg7qsve2jbfkdle--
