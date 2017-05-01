From: Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH 4/5] power: supply: bq27xxx: Look for status change on
 external power change
Date: Mon, 01 May 2017 12:45:13 +0200
Message-ID: <1493635513.6493.9.camel@paulk.fr>
References: <20170430203801.32357-1-contact@paulk.fr>
         <20170430203801.32357-4-contact@paulk.fr>
         <CAKvHMgRxC7VuU=_w10D4iu0zUC26gM=VgbA+6N-4abPskCEOww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-MfoFQnOI93qh0Bx9Mfn1"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gagarine.paulk.fr ([109.190.93.129]:53586 "EHLO
        gagarine.paulk.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S378802AbdEAKqF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 May 2017 06:46:05 -0400
In-Reply-To: <CAKvHMgRxC7VuU=_w10D4iu0zUC26gM=VgbA+6N-4abPskCEOww@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: linux-pm@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>


--=-MfoFQnOI93qh0Bx9Mfn1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le dimanche 30 avril 2017 =C3=A0 15:13 -0700, Liam Breck a =C3=A9crit=C2=A0=
:
> Hi Paul,
>=20
> On Sun, Apr 30, 2017 at 1:38 PM, Paul Kocialkowski <contact@paulk.fr> wro=
te:
> > This introduces a dedicated status change work to look for power
> > status change. It is triggered by external power change notifications
> > and periodically retries detecting a power status change for 5 seconds.
> >=20
> > This is largely inspired by a similar mechanism from the sbs-battery
> > driver.
>=20
> Maybe give an example which needs this? What can issue a notification,
> under what circumstances?

The external_power_change function is called when a supplier to the battery=
 (in
most cases, an external charger) detected a status change (e.g. plug/unplug=
)
which will affect the battery (the state should change from charging/full t=
o
discharging).

For the best user experience, we need to detect that change ASAP. Retrievin=
g the
status in the function directly is a bit too early, so a dedicated work is
called a second after the change and it tries to detect a status change ASA=
P.

With that mechanism, battery status changes due to plug/unplug take a few
seconds to be reflected.

> Also why should poll_work no longer be rescheduled on notify?

poll_work only updates the current charge, it's not in charge of detecting
status changes. The important point here is that the status change detectio=
n
work must be called seconds after the external power change (and actually, =
it
must keep running for a few seconds to detect quick charging->full transiti=
ons).

Is that a bit more clear?

> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > ---
> > =C2=A0drivers/power/supply/bq27xxx_battery.c | 38
> > ++++++++++++++++++++++++++++++++--
> > =C2=A0include/linux/power/bq27xxx_battery.h=C2=A0=C2=A0|=C2=A0=C2=A03 +=
++
> > =C2=A02 files changed, 39 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/power/supply/bq27xxx_battery.c
> > b/drivers/power/supply/bq27xxx_battery.c
> > index 926bd58344d9..cade00df6162 100644
> > --- a/drivers/power/supply/bq27xxx_battery.c
> > +++ b/drivers/power/supply/bq27xxx_battery.c
> > @@ -1190,6 +1190,11 @@ static int bq27xxx_battery_status(struct
> > bq27xxx_device_info *di,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
status =3D POWER_SUPPLY_STATUS_CHARGING;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (di->status_retry =3D=3D =
0 && di->status_change_reference !=3D status)
> > {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0di->status_change_reference =3D status;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0power_supply_changed(di->bat);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0val->intval =3D status;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > @@ -1340,12 +1345,38 @@ static int bq27xxx_battery_get_property(struct
> > power_supply *psy,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;
> > =C2=A0}
> >=20
> > +static void bq27xxx_status_change(struct work_struct *work)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct bq27xxx_device_info *=
di =3D
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0contai=
ner_of(work, struct bq27xxx_device_info,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sta=
tus_work.work);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0union power_supply_propval v=
al;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bq27xxx_battery_update(di);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D bq27xxx_battery_stat=
us(di, &val);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret < 0)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (di->status_change_refere=
nce !=3D val.intval) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0di->status_change_reference =3D val.intval;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0power_supply_changed(di->bat);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (di->status_retry > 0) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0di->status_retry--;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0schedule_delayed_work(&di->status_work, HZ);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +}
> > +
> > =C2=A0static void bq27xxx_external_power_changed(struct power_supply *p=
sy)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct bq27xxx_device_i=
nfo *di =3D power_supply_get_drvdata(psy);
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cancel_delayed_work_sync(&di=
->poll_work);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0schedule_delayed_work(&di->p=
oll_work, 0);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cancel_delayed_work_sync(&di=
->status_work);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0schedule_delayed_work(&di->s=
tatus_work, HZ);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0di->status_retry =3D 5;
> > =C2=A0}
> >=20
> > =C2=A0int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
> > @@ -1357,8 +1388,10 @@ int bq27xxx_battery_setup(struct bq27xxx_device_=
info
> > *di)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0psy_cfg.of_node =3D di-=
>of_node;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0INIT_DELAYED_WORK(&di->=
poll_work, bq27xxx_battery_poll);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0INIT_DELAYED_WORK(&di->statu=
s_work, bq27xxx_status_change);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_init(&di->lock);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0di->regs =3D bq27xxx_re=
gs[di->chip];
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0di->status_change_reference =
=3D POWER_SUPPLY_STATUS_UNKNOWN;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0psy_desc =3D devm_kzall=
oc(di->dev, sizeof(*psy_desc), GFP_KERNEL);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!psy_desc)
> > @@ -1400,6 +1433,7 @@ void bq27xxx_battery_teardown(struct
> > bq27xxx_device_info *di)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0poll_interval =3D 0;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cancel_delayed_work_syn=
c(&di->poll_work);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cancel_delayed_work_sync(&di=
->status_work);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0power_supply_unregister=
(di->bat);
> >=20
> > diff --git a/include/linux/power/bq27xxx_battery.h
> > b/include/linux/power/bq27xxx_battery.h
> > index 0a9af513165a..16d604681ace 100644
> > --- a/include/linux/power/bq27xxx_battery.h
> > +++ b/include/linux/power/bq27xxx_battery.h
> > @@ -67,6 +67,9 @@ struct bq27xxx_device_info {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int charge_design_full;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long last_upda=
te;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct delayed_work pol=
l_work;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct delayed_work status_w=
ork;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int status_retry;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int status_change_reference;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct power_supply *ba=
t;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct list_head list;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct mutex lock;
> > --
> > 2.12.2
> >=20
--=20
Paul Kocialkowski, developer of free digital technology and hardware suppor=
t

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
--=-MfoFQnOI93qh0Bx9Mfn1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAlkHEbkACgkQhP3B6o/u
lQwNGRAAnCtbAf1zu+vIRJmL/BwRO9wsfnkjXsr3rtLZ5zCDMVUr6K9y1tDpJ8M7
lMJLqA0iydAZkl1dZQFX29ZPpmxppkfVUFYEoXWZHQSy7M/sMpe/LldCGIoxso+Y
4Mur6sMSFX8zubZeIW4Ef8g1epI90KOWUMK5oAv+NQvmEG3fUMQ1BTRz3icELWeP
ZS5pCqvGA0Hn2MQPvc4svrhcdM/pVIhHulAnJCirlH+CW+rWVQ9aGN2vJgDSjPh8
VAwQ5dD7BhMzxJ7C7T7G98H4eG364SQAJxpr9UTg7aOGrpsjqzHCdZxJsqNQWlYI
y+KfaUYHCOZrMNTmvjji1FuCbMGb0r8HST8njhbY4T29EO21OhDbrq7e9WN9qspS
4aOU3m0fsdA77Ptub59GPZjclBhvCLNEoj0158gQf8+nipY8/UtI4n03TCeujU+N
V/MDsQbznJUh1drlupDBFXnzryfn6qTANv9ij6QFE9/Qj0v+WWGZJ8c8QqhU3Aa8
CIgxGcjvDJX3tUNTE037rx6S8IS7eU5AecdEEcbpzGIqOFTl1Mky2haaBraCXGIA
1SmQ20irZbHm5Zu5JR0QGmaxHzTSLA3FUrS5qWTJkTkxBwnA0JwYqPjL+RXifRIo
cJegZXmFoi9rGUzJXAH3WiZXY+uUwOakTSdJbKqGqmOA6mUDtPg=
=5eWx
-----END PGP SIGNATURE-----

--=-MfoFQnOI93qh0Bx9Mfn1--
