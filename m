From: Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH 4/5] power: supply: bq27xxx: Look for status change on
 external power change
Date: Sun, 07 May 2017 19:37:41 +0200
Message-ID: <1494178661.13734.1.camel@paulk.fr>
References: <20170430182727.24412-1-contact@paulk.fr>
         <20170430182727.24412-4-contact@paulk.fr> <20170505080458.GN15744@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-4tn8THuWxJkSoITtWij8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170505080458.GN15744@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>, Chris Lapa <chris@lapa.com.au>, Matt Ranostay <mranostay@gmail.com>
List-Id: linux-pm@vger.kernel.org


--=-4tn8THuWxJkSoITtWij8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le vendredi 05 mai 2017 =C3=A0 10:04 +0200, Pali Roh=C3=A1r a =C3=A9crit=C2=
=A0:
> On Sunday 30 April 2017 20:27:26 Paul Kocialkowski wrote:
> > This introduces a dedicated status change work to look for power
> > status change. It is triggered by external power change notifications
> > and periodically retries detecting a power status change for 5 seconds.
> >=20
> > This is largely inspired by a similar mechanism from the sbs-battery
> > driver.
>=20
> What is reason/motivation for such change? It should be written in
> commit message (to help understand; not only for me), because really I
> do not know why such patch is needed.

Well, I really don't understand how things can work out without this patch.

How exactly are external power notifications supposed to be handled with th=
e
current state of the driver?

=46rom my tests, changes on external status change notifications were unrelia=
ble
as they did not look for a status change at all and instead scheduled a pol=
l
work, which would not at any point call power_supply_changed, but instead u=
pdate
the status for later reads.

This is *not* the expected behavior. When an external power supply is
connected/disconnected, the driver should detect the status change and repo=
rt it
as soon as detected. This is precisely what this patch does (as is done alr=
eady
with the sbs battery driver).

Note that it is up to *the driver* to report that status change, it must no=
t
wait for userspace to query whether something changed.

Does that clarify why this is needed?

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
> > =C2=A0			status =3D POWER_SUPPLY_STATUS_CHARGING;
> > =C2=A0	}
> > =C2=A0
> > +	if (di->status_retry =3D=3D 0 && di->status_change_reference !=3D sta=
tus)
> > {
> > +		di->status_change_reference =3D status;
> > +		power_supply_changed(di->bat);
> > +	}
> > +
> > =C2=A0	val->intval =3D status;
> > =C2=A0
> > =C2=A0	return 0;
> > @@ -1340,12 +1345,38 @@ static int bq27xxx_battery_get_property(struct
> > power_supply *psy,
> > =C2=A0	return ret;
> > =C2=A0}
> > =C2=A0
> > +static void bq27xxx_status_change(struct work_struct *work)
> > +{
> > +	struct bq27xxx_device_info *di =3D
> > +			container_of(work, struct bq27xxx_device_info,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status_work.work);
> > +	union power_supply_propval val;
> > +	int ret;
> > +
> > +	bq27xxx_battery_update(di);
> > +
> > +	ret =3D bq27xxx_battery_status(di, &val);
> > +	if (ret < 0)
> > +		return;
> > +
> > +	if (di->status_change_reference !=3D val.intval) {
> > +		di->status_change_reference =3D val.intval;
> > +		power_supply_changed(di->bat);
> > +	}
> > +
> > +	if (di->status_retry > 0) {
> > +		di->status_retry--;
> > +		schedule_delayed_work(&di->status_work, HZ);
> > +	}
> > +}
> > +
> > =C2=A0static void bq27xxx_external_power_changed(struct power_supply *p=
sy)
> > =C2=A0{
> > =C2=A0	struct bq27xxx_device_info *di =3D power_supply_get_drvdata(psy)=
;
> > =C2=A0
> > -	cancel_delayed_work_sync(&di->poll_work);
> > -	schedule_delayed_work(&di->poll_work, 0);
> > +	cancel_delayed_work_sync(&di->status_work);
> > +	schedule_delayed_work(&di->status_work, HZ);
> > +	di->status_retry =3D 5;
> > =C2=A0}
> > =C2=A0
> > =C2=A0int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
> > @@ -1357,8 +1388,10 @@ int bq27xxx_battery_setup(struct bq27xxx_device_=
info
> > *di)
> > =C2=A0	psy_cfg.of_node =3D di->of_node;
> > =C2=A0
> > =C2=A0	INIT_DELAYED_WORK(&di->poll_work, bq27xxx_battery_poll);
> > +	INIT_DELAYED_WORK(&di->status_work, bq27xxx_status_change);
> > =C2=A0	mutex_init(&di->lock);
> > =C2=A0	di->regs =3D bq27xxx_regs[di->chip];
> > +	di->status_change_reference =3D POWER_SUPPLY_STATUS_UNKNOWN;
> > =C2=A0
> > =C2=A0	psy_desc =3D devm_kzalloc(di->dev, sizeof(*psy_desc), GFP_KERNEL=
);
> > =C2=A0	if (!psy_desc)
> > @@ -1400,6 +1433,7 @@ void bq27xxx_battery_teardown(struct
> > bq27xxx_device_info *di)
> > =C2=A0	poll_interval =3D 0;
> > =C2=A0
> > =C2=A0	cancel_delayed_work_sync(&di->poll_work);
> > +	cancel_delayed_work_sync(&di->status_work);
> > =C2=A0
> > =C2=A0	power_supply_unregister(di->bat);
> > =C2=A0
> > diff --git a/include/linux/power/bq27xxx_battery.h
> > b/include/linux/power/bq27xxx_battery.h
> > index 0a9af513165a..16d604681ace 100644
> > --- a/include/linux/power/bq27xxx_battery.h
> > +++ b/include/linux/power/bq27xxx_battery.h
> > @@ -67,6 +67,9 @@ struct bq27xxx_device_info {
> > =C2=A0	int charge_design_full;
> > =C2=A0	unsigned long last_update;
> > =C2=A0	struct delayed_work poll_work;
> > +	struct delayed_work status_work;
> > +	int status_retry;
> > +	int status_change_reference;
> > =C2=A0	struct power_supply *bat;
> > =C2=A0	struct list_head list;
> > =C2=A0	struct mutex lock;
>=20
>=20
--=20
Paul Kocialkowski, developer of free digital technology and hardware suppor=
t

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
--=-4tn8THuWxJkSoITtWij8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAlkPW2YACgkQhP3B6o/u
lQzbrw//YpXv/TH3Oy7GBdMORSfjClUgIuULWSIBEPLFjCAhGsCcQ8zK9n6aD4RQ
XchT16wyj4grwCXuEHAcH6gvv9GEQ6fn3mS0AmBQlXRpOCmY/zat3ExhHxBvrbc3
B9Vbb/xoNansacR33OKafqKXjiLnO7kIlyU1lAkc6fG+oN71Stbt7QtSHTYHmegv
BHHDlLSvsR8ZaX+KatKhF/72Gu7kArQlw734k1LeNgQ0RXvGInPcrYoz+bsnn+64
sc6ipwa8pQSJzlERs+jpZg7GbIJJ5ASXWLHp5ACAcw8r9NytfmxaIllvQ2zZbeSf
ooXlzUB77t89MLk8ddtPlqER2QU7TUMZb+7aMVfAKlZmogChHluzZLnqOw5e+Pg2
Pa2W3kxTXCUU8AB/Gja5iatx6/Gks5YYZTNuXDPTK/VM9zdj4wEJC7hSA8uH2Ue9
zHVdGUWiHboeo6V6Iu/kfan69dZqZYoGkonYUmXKjjOATfA9TLJnQXwyCfEcA46I
WGuOJIh1dvmK2sFkav3fA5GxMuInUTxcKCg3WUtSrWkx8rz3tToRuhu991hZP33h
tYcMxeRlgY9RCPAg8U+bGGA8c7Ld0fclKdsR/eIR8gCpCJgTt/N/7gttX9qsuST5
oxYFuwZ2q6Sg0gILAB6Mk9R1s7G23MP4v4f7GJybRnjTGRW/mZc=
=evJF
-----END PGP SIGNATURE-----

--=-4tn8THuWxJkSoITtWij8--
