From: Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH 4/5] power: supply: bq27xxx: Look for status change on
 external power change
Date: Mon, 01 May 2017 20:34:23 +0200
Message-ID: <1493663663.4951.1.camel@paulk.fr>
References: <20170430203801.32357-1-contact@paulk.fr>
         <20170430203801.32357-4-contact@paulk.fr>
         <CAKvHMgRxC7VuU=_w10D4iu0zUC26gM=VgbA+6N-4abPskCEOww@mail.gmail.com>
         <1493635513.6493.9.camel@paulk.fr>
         <CAKvHMgTLi1bkhOPuzErp_JmvA23uGB_N4N3_Te_MxY=+asm7zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-zxJBahf7rPwt0wb4pV2y"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gagarine.paulk.fr ([109.190.93.129]:52584 "EHLO
        gagarine.paulk.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750983AbdEASf3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 May 2017 14:35:29 -0400
In-Reply-To: <CAKvHMgTLi1bkhOPuzErp_JmvA23uGB_N4N3_Te_MxY=+asm7zw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: linux-pm@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>


--=-zxJBahf7rPwt0wb4pV2y
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le lundi 01 mai 2017 =C3=A0 11:22 -0700, Liam Breck a =C3=A9crit=C2=A0:
> On Mon, May 1, 2017 at 3:45 AM, Paul Kocialkowski <contact@paulk.fr> wrot=
e:
> > Hi,
> >=20
> > Le dimanche 30 avril 2017 =C3=A0 15:13 -0700, Liam Breck a =C3=A9crit :
> > > Hi Paul,
> > >=20
> > > On Sun, Apr 30, 2017 at 1:38 PM, Paul Kocialkowski <contact@paulk.fr>
> > > wrote:
> > > > This introduces a dedicated status change work to look for power
> > > > status change. It is triggered by external power change notificatio=
ns
> > > > and periodically retries detecting a power status change for 5 seco=
nds.
> > > >=20
> > > > This is largely inspired by a similar mechanism from the sbs-batter=
y
> > > > driver.
> > >=20
> > > Maybe give an example which needs this? What can issue a notification=
,
> > > under what circumstances?
> >=20
> > The external_power_change function is called when a supplier to the bat=
tery
> > (in
> > most cases, an external charger) detected a status change (e.g. plug/un=
plug)
> > which will affect the battery (the state should change from charging/fu=
ll to
> > discharging).
> >=20
> > For the best user experience, we need to detect that change ASAP. Retri=
eving
> > the
> > status in the function directly is a bit too early, so a dedicated work=
 is
> > called a second after the change and it tries to detect a status change
> > ASAP.
> >=20
> > With that mechanism, battery status changes due to plug/unplug take a f=
ew
> > seconds to be reflected.
> >=20
> > > Also why should poll_work no longer be rescheduled on notify?
> >=20
> > poll_work only updates the current charge, it's not in charge of detect=
ing
> > status changes. The important point here is that the status change dete=
ction
> > work must be called seconds after the external power change (and actual=
ly,
> > it
> > must keep running for a few seconds to detect quick charging->full
> > transitions).
> >=20
> > Is that a bit more clear?
>=20
> Yes, can you add that to patch description?

Sure thing, will do that in v2.

Thanks!

> > > > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > > > ---
> > > > =C2=A0drivers/power/supply/bq27xxx_battery.c | 38
> > > > ++++++++++++++++++++++++++++++++--
> > > > =C2=A0include/linux/power/bq27xxx_battery.h=C2=A0=C2=A0|=C2=A0=C2=
=A03 +++
> > > > =C2=A02 files changed, 39 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/drivers/power/supply/bq27xxx_battery.c
> > > > b/drivers/power/supply/bq27xxx_battery.c
> > > > index 926bd58344d9..cade00df6162 100644
> > > > --- a/drivers/power/supply/bq27xxx_battery.c
> > > > +++ b/drivers/power/supply/bq27xxx_battery.c
> > > > @@ -1190,6 +1190,11 @@ static int bq27xxx_battery_status(struct
> > > > bq27xxx_device_info *di,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0status =3D POWER_SUPPLY_STATUS_CHARGING;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (di->status_retry =3D=
=3D 0 && di->status_change_reference !=3D
> > > > status)
> > > > {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0di->status_change_reference =3D status;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0power_supply_changed(di->bat);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > > +
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0val->intval =3D sta=
tus;
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > > > @@ -1340,12 +1345,38 @@ static int bq27xxx_battery_get_property(str=
uct
> > > > power_supply *psy,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;
> > > > =C2=A0}
> > > >=20
> > > > +static void bq27xxx_status_change(struct work_struct *work)
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct bq27xxx_device_in=
fo *di =3D
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0con=
tainer_of(work, struct bq27xxx_device_info,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
status_work.work);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0union power_supply_propv=
al val;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bq27xxx_battery_update(d=
i);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D bq27xxx_battery_=
status(di, &val);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret < 0)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (di->status_change_re=
ference !=3D val.intval) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0di->status_change_reference =3D val.intval;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0power_supply_changed(di->bat);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (di->status_retry > 0=
) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0di->status_retry--;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0schedule_delayed_work(&di->status_work, HZ);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > > +}
> > > > +
> > > > =C2=A0static void bq27xxx_external_power_changed(struct power_suppl=
y *psy)
> > > > =C2=A0{
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct bq27xxx_devi=
ce_info *di =3D power_supply_get_drvdata(psy);
> > > >=20
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cancel_delayed_work_sync=
(&di->poll_work);
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0schedule_delayed_work(&d=
i->poll_work, 0);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cancel_delayed_work_sync=
(&di->status_work);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0schedule_delayed_work(&d=
i->status_work, HZ);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0di->status_retry =3D 5;
> > > > =C2=A0}
> > > >=20
> > > > =C2=A0int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
> > > > @@ -1357,8 +1388,10 @@ int bq27xxx_battery_setup(struct
> > > > bq27xxx_device_info
> > > > *di)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0psy_cfg.of_node =3D=
 di->of_node;
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0INIT_DELAYED_WORK(&=
di->poll_work, bq27xxx_battery_poll);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0INIT_DELAYED_WORK(&di->s=
tatus_work, bq27xxx_status_change);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_init(&di->loc=
k);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0di->regs =3D bq27xx=
x_regs[di->chip];
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0di->status_change_refere=
nce =3D POWER_SUPPLY_STATUS_UNKNOWN;
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0psy_desc =3D devm_k=
zalloc(di->dev, sizeof(*psy_desc), GFP_KERNEL);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!psy_desc)
> > > > @@ -1400,6 +1433,7 @@ void bq27xxx_battery_teardown(struct
> > > > bq27xxx_device_info *di)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0poll_interval =3D 0=
;
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cancel_delayed_work=
_sync(&di->poll_work);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cancel_delayed_work_sync=
(&di->status_work);
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0power_supply_unregi=
ster(di->bat);
> > > >=20
> > > > diff --git a/include/linux/power/bq27xxx_battery.h
> > > > b/include/linux/power/bq27xxx_battery.h
> > > > index 0a9af513165a..16d604681ace 100644
> > > > --- a/include/linux/power/bq27xxx_battery.h
> > > > +++ b/include/linux/power/bq27xxx_battery.h
> > > > @@ -67,6 +67,9 @@ struct bq27xxx_device_info {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int charge_design_f=
ull;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long last_=
update;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct delayed_work=
 poll_work;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct delayed_work stat=
us_work;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int status_retry;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int status_change_refere=
nce;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct power_supply=
 *bat;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct list_head li=
st;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct mutex lock;
> > > > --
> > > > 2.12.2
> > > >=20
> >=20
> > --
> > Paul Kocialkowski, developer of free digital technology and hardware su=
pport
> >=20
> > Website: https://www.paulk.fr/
> > Coding blog: https://code.paulk.fr/
> > Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
--=20
Paul Kocialkowski, developer of free digital technology and hardware suppor=
t

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
--=-zxJBahf7rPwt0wb4pV2y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAlkHf68ACgkQhP3B6o/u
lQyofw//Q27tbQf8pfkujyoC/ap134yF1yLfp0yNTBxLC2HLaJKG+g/29LEhsc1+
kFOFujSrnGsKq8JbzuJuhZ8ConMHCfucXD8WXj+fac+DzYXy1RU4cdAIAf87hLkd
Uz935yRLc/ZzfEtwdIGvdt591cTdzKyrG43l/cB0RqgvvMpWIYK9SBhxo62VutNz
uDmFon86n34lcHd6cOdN8/2KX+n+LDJoDFAM4rE/YwTOCf8GPA6Y8XP2u9Z3k1DW
U9h9ThO2gfP3Bu8H6cBovF0QjEkqODUNGXlv4IAnsY23SdH7M9jbyYZrZ4zgFXKn
RbFzIydq1qpYR7bce227tnhIVykgewFh1uKtHuhfZFlw1Tpsu+uuEyFhREodTS+5
Ctr3URI/dqrPjDunIZA+hBSesFsgfoSCXZ1AMCkDZq9I+G7H4zCOcwMh+0kjrxYn
WCuEGRwwywml8sLv+jTuU6hbrZWvpB40joEBLUEHz7HjPI/qzXUE+gTsYTWG5JsU
274v9B3nKypv5yOU7nga5i2fJLAQKg+ANeE/TgAUFE+Tvv7OCMLKa9dcEJR4DZbE
/quMQQ3ZzGdkyVWPI63uvI23z3TBjD/TQQ6Yl3XYjBo9ik50qdUS0s6SPJOS/BGT
TGSUv+vX1cswTSTsAdoWru0VbEs3f5mbrNwgUHQd2vQ5GlyPiKg=
=DZ+a
-----END PGP SIGNATURE-----

--=-zxJBahf7rPwt0wb4pV2y--
