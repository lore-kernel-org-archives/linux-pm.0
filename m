From: Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH 1/5] power: supply: bq27xxx: Pass of_node along to allow
 device-tree supply
Date: Mon, 01 May 2017 12:46:31 +0200
Message-ID: <1493635591.6493.10.camel@paulk.fr>
References: <20170430203801.32357-1-contact@paulk.fr>
         <CAKvHMgSijN8vQUePoTKRC5nqaW-Shh4_9ZKiKq0Uae3ZLkiDSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-2d20kZQ/BomxZLkm8mYL"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gagarine.paulk.fr ([109.190.93.129]:60459 "EHLO
        gagarine.paulk.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2996970AbdEAKrV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 May 2017 06:47:21 -0400
In-Reply-To: <CAKvHMgSijN8vQUePoTKRC5nqaW-Shh4_9ZKiKq0Uae3ZLkiDSA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>


--=-2d20kZQ/BomxZLkm8mYL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le dimanche 30 avril 2017 =C3=A0 15:03 -0700, Liam Breck a =C3=A9crit=C2=A0=
:
> [dropped some CCs]
>=20
>=20
> On Sun, Apr 30, 2017 at 1:37 PM, Paul Kocialkowski <contact@paulk.fr> wro=
te:
> > This passes the of_node from the bq27xxx i2c battery driver to the
> > common code, so that it can be registered and provide external supplies
> > linked with device-tree.
> >=20
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > ---
> > =C2=A0drivers/power/supply/bq27xxx_battery.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0| 5 ++++-
> > =C2=A0drivers/power/supply/bq27xxx_battery_i2c.c | 1 +
> > =C2=A0include/linux/power/bq27xxx_battery.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0| 1 +
> > =C2=A03 files changed, 6 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/power/supply/bq27xxx_battery.c
> > b/drivers/power/supply/bq27xxx_battery.c
> > index 398801a21b86..6ef95442a918 100644
> > --- a/drivers/power/supply/bq27xxx_battery.c
> > +++ b/drivers/power/supply/bq27xxx_battery.c
> > @@ -1351,7 +1351,10 @@ static void bq27xxx_external_power_changed(struc=
t
> > power_supply *psy)
> > =C2=A0int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct power_supply_des=
c *psy_desc;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct power_supply_config p=
sy_cfg =3D { .drv_data =3D di, };
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct power_supply_config p=
sy_cfg =3D {};
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0psy_cfg.drv_data =3D di;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0psy_cfg.of_node =3D di->of_n=
ode;
>=20
> I don't think you need di->of_node, just the following -- we do this
> to obtain data from devicetree via power_supply_get_battery_info()
> https://patchwork.kernel.org/patch/9692335/
>=20
> struct power_supply_config psy_cfg =3D {
> =C2=A0 .drv_data =3D di,
> =C2=A0 .of_node =3D di->dev->of_node,
> };

That's a good point, thanks! Should I prepare v2 with this or rebase on top=
 of
the series you mentioned previously?

> There is some (gcc?) bug on armv7 or omap which causes separate
> assignments to corrupt the stack.

That's weird, but definitely good to know.

> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0INIT_DELAYED_WORK(&di->=
work, bq27xxx_battery_poll);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_init(&di->lock);
> > diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c
> > b/drivers/power/supply/bq27xxx_battery_i2c.c
> > index c68fbc3fe50a..38a0422a4192 100644
> > --- a/drivers/power/supply/bq27xxx_battery_i2c.c
> > +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
> > @@ -96,6 +96,7 @@ static int bq27xxx_battery_i2c_probe(struct i2c_clien=
t
> > *client,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0di->chip =3D id->driver=
_data;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0di->name =3D name;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0di->bus.read =3D bq27xx=
x_battery_i2c_read;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0di->of_node =3D client->dev.=
of_node;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D bq27xxx_battery=
_setup(di);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret)
> > diff --git a/include/linux/power/bq27xxx_battery.h
> > b/include/linux/power/bq27xxx_battery.h
> > index b312bcef53da..94637b77ecbf 100644
> > --- a/include/linux/power/bq27xxx_battery.h
> > +++ b/include/linux/power/bq27xxx_battery.h
> > @@ -63,6 +63,7 @@ struct bq27xxx_device_info {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const char *name;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct bq27xxx_access_m=
ethods bus;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct bq27xxx_reg_cach=
e cache;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct device_node *of_node;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int charge_design_full;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long last_upda=
te;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct delayed_work wor=
k;
> > --
> > 2.12.2
> >=20
--=20
Paul Kocialkowski, developer of free digital technology and hardware suppor=
t

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
--=-2d20kZQ/BomxZLkm8mYL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAlkHEgcACgkQhP3B6o/u
lQze0w/8Cqr2mkKA2tH71KPvThH9+aQlHva+iFzbFYZ0gik2+CGl4ITbCadg5rVQ
IqnhbFTk8VTVm+sV+lAZXao32PsPvbmP1MPdYkddJkU7YDm1tc7j+GcVooOmE4jj
rKWqsSJFzyQpXQTbNWrhHmk0EpWNUmZDeSexG5i3jRZ0IY2+/jXXeYDsl6o4tree
/HZ2ErbS6N9KgvoKVDRK947VgyQ99VnqOXv5WCClIPqqPQbnJT4U38FBf2LhqtuJ
SJcNtgrEJfxwr0HdLqkiARZKl67Bpd3gapFtVsfn0S9B2fvlJF/yJArBXGxKf0QV
Jxeo6vg1DfSuq59Ny5/tXWqurE88fLT1F+AZ5KrgpI4yPTUc+AYwQXYLHi5yCfTL
hG5IqGeyCBPmBBaam5P9tomAe118tVIhcgv7qXB862dI4MbzDyhfooqYIP45wHeY
OxH+v4K5r5q5yJBY6YkttxFT5hhki+ehywLH/gs+JZB0d+D4P/xPMASIr3XugBt/
BDTh5Ny4xm/p5GvH0wiT8MP5p0KOdNC5R5ZH9lhSfQdmtL/Bnwyloyf0wAkEedwk
6tDafI59OUJVxs3fkKg/Szwr/3cBR2sy8Oxalvvb4ha9ksY7kLJtdv5gycxKk92Q
C1V/z9ZnzJj3yRl9WbB6OZGePmv5ZLSU+2YD/khD83HLDKnunIQ=
=W3C6
-----END PGP SIGNATURE-----

--=-2d20kZQ/BomxZLkm8mYL--
