From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 4/5] power: supply: bq27xxx: Look for status change on external power change
Date: Mon, 8 May 2017 15:04:18 +0200
Message-ID: <201705081504.18780@pali>
References: <20170430182727.24412-1-contact@paulk.fr> <20170505080458.GN15744@pali> <1494178661.13734.1.camel@paulk.fr>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1734300.X6mLaZB5hR";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35945 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751326AbdEHNEW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2017 09:04:22 -0400
In-Reply-To: <1494178661.13734.1.camel@paulk.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Kocialkowski <contact@paulk.fr>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>, Chris Lapa <chris@lapa.com.au>, Matt Ranostay <mranostay@gmail.com>

--nextPart1734300.X6mLaZB5hR
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sunday 07 May 2017 19:37:41 Paul Kocialkowski wrote:
> Hi,
>=20
> Le vendredi 05 mai 2017 =C3=A0 10:04 +0200, Pali Roh=C3=A1r a =C3=A9crit :
> > On Sunday 30 April 2017 20:27:26 Paul Kocialkowski wrote:
> > > This introduces a dedicated status change work to look for power
> > > status change. It is triggered by external power change
> > > notifications and periodically retries detecting a power status
> > > change for 5 seconds.
> > >=20
> > > This is largely inspired by a similar mechanism from the
> > > sbs-battery driver.
> >=20
> > What is reason/motivation for such change? It should be written in
> > commit message (to help understand; not only for me), because
> > really I do not know why such patch is needed.
>=20
> Well, I really don't understand how things can work out without this
> patch.
>=20
> How exactly are external power notifications supposed to be handled
> with the current state of the driver?
>=20
> From my tests, changes on external status change notifications were
> unreliable as they did not look for a status change at all and
> instead scheduled a poll work, which would not at any point call
> power_supply_changed, but instead update the status for later reads.
>=20
> This is *not* the expected behavior. When an external power supply is
> connected/disconnected, the driver should detect the status change
> and report it as soon as detected. This is precisely what this patch
> does (as is done already with the sbs battery driver).
>=20
> Note that it is up to *the driver* to report that status change, it
> must not wait for userspace to query whether something changed.
>=20
> Does that clarify why this is needed?

Yea, now I see what is the reason... Problem is that bq27xxx does not=20
provide any notification mechanism and we can only poll for changes.

Question is if timeout 5 seconds is always enough and what happen if=20
not... Similarly if such additional wakeups does not increase=20
cpu/battery/power usage on small embedded devices...

On Nokia N900 we have other HW with drivers which detect charger=20
connection/disconnection and doing periodical polling for monitoring=20
charge current and temperature.

> > > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > > ---
> > >  drivers/power/supply/bq27xxx_battery.c | 38
> > > ++++++++++++++++++++++++++++++++--
> > >  include/linux/power/bq27xxx_battery.h  |  3 +++
> > >  2 files changed, 39 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/power/supply/bq27xxx_battery.c
> > > b/drivers/power/supply/bq27xxx_battery.c
> > > index 926bd58344d9..cade00df6162 100644
> > > --- a/drivers/power/supply/bq27xxx_battery.c
> > > +++ b/drivers/power/supply/bq27xxx_battery.c
> > > @@ -1190,6 +1190,11 @@ static int bq27xxx_battery_status(struct
> > > bq27xxx_device_info *di,
> > >  			status =3D POWER_SUPPLY_STATUS_CHARGING;
> > >  	}
> > > =20
> > > +	if (di->status_retry =3D=3D 0 && di->status_change_reference !=3D
> > > status) {
> > > +		di->status_change_reference =3D status;
> > > +		power_supply_changed(di->bat);
> > > +	}
> > > +
> > >  	val->intval =3D status;
> > > =20
> > >  	return 0;
> > > @@ -1340,12 +1345,38 @@ static int
> > > bq27xxx_battery_get_property(struct power_supply *psy,
> > >  	return ret;
> > >  }
> > > =20
> > > +static void bq27xxx_status_change(struct work_struct *work)
> > > +{
> > > +	struct bq27xxx_device_info *di =3D
> > > +			container_of(work, struct bq27xxx_device_info,
> > > +				     status_work.work);
> > > +	union power_supply_propval val;
> > > +	int ret;
> > > +
> > > +	bq27xxx_battery_update(di);
> > > +
> > > +	ret =3D bq27xxx_battery_status(di, &val);
> > > +	if (ret < 0)
> > > +		return;
> > > +
> > > +	if (di->status_change_reference !=3D val.intval) {
> > > +		di->status_change_reference =3D val.intval;
> > > +		power_supply_changed(di->bat);
> > > +	}
> > > +
> > > +	if (di->status_retry > 0) {
> > > +		di->status_retry--;
> > > +		schedule_delayed_work(&di->status_work, HZ);
> > > +	}
> > > +}
> > > +
> > >  static void bq27xxx_external_power_changed(struct power_supply
> > > *psy) {
> > >  	struct bq27xxx_device_info *di =3D
> > >  	power_supply_get_drvdata(psy);
> > > =20
> > > -	cancel_delayed_work_sync(&di->poll_work);
> > > -	schedule_delayed_work(&di->poll_work, 0);
> > > +	cancel_delayed_work_sync(&di->status_work);
> > > +	schedule_delayed_work(&di->status_work, HZ);
> > > +	di->status_retry =3D 5;
> > >  }
> > > =20
> > >  int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
> > > @@ -1357,8 +1388,10 @@ int bq27xxx_battery_setup(struct
> > > bq27xxx_device_info *di)
> > >  	psy_cfg.of_node =3D di->of_node;
> > > =20
> > >  	INIT_DELAYED_WORK(&di->poll_work, bq27xxx_battery_poll);
> > > +	INIT_DELAYED_WORK(&di->status_work, bq27xxx_status_change);
> > >  	mutex_init(&di->lock);
> > >  	di->regs =3D bq27xxx_regs[di->chip];
> > > +	di->status_change_reference =3D POWER_SUPPLY_STATUS_UNKNOWN;
> > > =20
> > >  	psy_desc =3D devm_kzalloc(di->dev, sizeof(*psy_desc),
> > > GFP_KERNEL); if (!psy_desc)
> > > @@ -1400,6 +1433,7 @@ void bq27xxx_battery_teardown(struct
> > > bq27xxx_device_info *di)
> > >  	poll_interval =3D 0;
> > > =20
> > >  	cancel_delayed_work_sync(&di->poll_work);
> > > +	cancel_delayed_work_sync(&di->status_work);
> > > =20
> > >  	power_supply_unregister(di->bat);
> > > =20
> > > diff --git a/include/linux/power/bq27xxx_battery.h
> > > b/include/linux/power/bq27xxx_battery.h
> > > index 0a9af513165a..16d604681ace 100644
> > > --- a/include/linux/power/bq27xxx_battery.h
> > > +++ b/include/linux/power/bq27xxx_battery.h
> > > @@ -67,6 +67,9 @@ struct bq27xxx_device_info {
> > >  	int charge_design_full;
> > >  	unsigned long last_update;
> > >  	struct delayed_work poll_work;
> > > +	struct delayed_work status_work;
> > > +	int status_retry;
> > > +	int status_change_reference;
> > >  	struct power_supply *bat;
> > >  	struct list_head list;
> > >  	struct mutex lock;

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1734300.X6mLaZB5hR
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlkQbNIACgkQi/DJPQPkQ1LqEQCglGAbs32dI+7j/YKmJOjcMLYM
nrsAoL5HaCKyY4lPTQkwdv80uRO6wRk+
=DhmI
-----END PGP SIGNATURE-----

--nextPart1734300.X6mLaZB5hR--
