From: Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH 2/5] power: supply: bq27xxx: Register power supply with
 devm
Date: Sun, 07 May 2017 19:43:10 +0200
Message-ID: <1494178990.13734.2.camel@paulk.fr>
References: <20170430182727.24412-1-contact@paulk.fr>
         <20170430182727.24412-2-contact@paulk.fr>
         <20170501105537.3ghbjcxxychxm52n@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-5R9WGkaSMPyoC3UQKRmy"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gagarine.paulk.fr ([109.190.93.129]:57734 "EHLO
        gagarine.paulk.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751726AbdEGWbR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 May 2017 18:31:17 -0400
In-Reply-To: <20170501105537.3ghbjcxxychxm52n@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, "Andrew F . Davis" <afd@ti.com>, Chris Lapa <chris@lapa.com.au>, Matt Ranostay <mranostay@gmail.com>


--=-5R9WGkaSMPyoC3UQKRmy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lundi 01 mai 2017 =C3=A0 12:55 +0200, Sebastian Reichel a =C3=A9crit=C2=
=A0:
> Hi,
>=20
> On Sun, Apr 30, 2017 at 08:27:24PM +0200, Paul Kocialkowski wrote:
> > This uses the managed devices resources version of the
> > power_supply_register_no_ws function to register the power supply.
> >=20
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > ---
> > =C2=A0drivers/power/supply/bq27xxx_battery.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/power/supply/bq27xxx_battery.c
> > b/drivers/power/supply/bq27xxx_battery.c
> > index 6ef95442a918..be476e0bc85d 100644
> > --- a/drivers/power/supply/bq27xxx_battery.c
> > +++ b/drivers/power/supply/bq27xxx_battery.c
> > @@ -1371,7 +1371,7 @@ int bq27xxx_battery_setup(struct bq27xxx_device_i=
nfo
> > *di)
> > =C2=A0	psy_desc->get_property =3D bq27xxx_battery_get_property;
> > =C2=A0	psy_desc->external_power_changed =3D bq27xxx_external_power_chan=
ged;
> > =C2=A0
> > -	di->bat =3D power_supply_register_no_ws(di->dev, psy_desc, &psy_cfg);
> > +	di->bat =3D devm_power_supply_register_no_ws(di->dev, psy_desc,
> > &psy_cfg);
> > =C2=A0	if (IS_ERR(di->bat)) {
> > =C2=A0		dev_err(di->dev, "failed to register battery\n");
> > =C2=A0		return PTR_ERR(di->bat);
>=20
> That does not make sense if bq27xxx_battery_teardown() still calls
> power_supply_unregister().

That's a very good point, thanks! Will fix in v2.

--=20
Paul Kocialkowski, developer of free digital technology and hardware suppor=
t

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
--=-5R9WGkaSMPyoC3UQKRmy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAlkPXK4ACgkQhP3B6o/u
lQx02A//VnncNSAiinm1MkcPbQzLe/+YdpKfiyCTx8xdB0CSURHAhL+Iq6SwK4Sv
pk/BtQEWfCZj0VN9JnNXfvZG56qQaTXOkdsP0uxGR1Odqaz78OL+OIrBJbmZaSCq
Mge1wSKNGHp+/m3/1R0sQ9xYyw1+7dGpY2Urv/wX0AXaEKaHwN8DRNmvAKyI2Y5y
QFXoP4tdFhSTzlJ7DwH7JU7K8sYL8ire6RNa31j/Bp+WO3D+jvSoBjfTslvWBOm9
3JwlnlwGYG2uoPJ1TLAVDzgeoZLSKAnHhcPGZ/unn3KdXueXdoVM0+y9I/Zk111e
O6cEtQ0p6tebyI1xcWs8oAveYyr3oxomIh8OvIxRPasrYLxmLtnFcvw0lvFf884q
DHficH8y+BpngZq8THWaEwVvR2+ojD6aHhuLn414HFyT9Scd309UfgE8fg+LnRTv
lFybbOtkCQ8JuBso0NFDtXHtoMkvFec6Ndqcc8SADPkWEu8DTn5pfIPLv7aaHVWE
Rgis/tcs5ym1YmEjnGt9CavznnlL4aEh4nDQSsjVFBIdJ+U+fro3ggMRrKaPfGof
EII7K19Z3xpOQLrAp+yn3HirVSuSYpzNdNPrhBBqf+Yadgs79KUld2VGiU9ih72V
2Vj5Uc91klvbWZUr5nWvQA0F4n9cN6xsoszkHAUyG5RsX5iZS74=
=iP8f
-----END PGP SIGNATURE-----

--=-5R9WGkaSMPyoC3UQKRmy--
