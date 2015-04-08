From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V4 1/3] Thermal: initialize thermal zone device correctly
Date: Wed, 8 Apr 2015 08:03:58 -0700
Message-ID: <20150408150356.GA28698@localhost.localdomain>
References: <1428373476-14257-1-git-send-email-rui.zhang@intel.com>
 <1428373476-14257-2-git-send-email-rui.zhang@intel.com>
 <20150407024709.GI4648@localhost.localdomain>
 <744357E9AAD1214791ACBA4B0B909263014CF6E2@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36616 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866AbbDHPDr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Apr 2015 11:03:47 -0400
Received: by pabsx10 with SMTP id sx10so117283060pab.3
        for <linux-pm@vger.kernel.org>; Wed, 08 Apr 2015 08:03:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <744357E9AAD1214791ACBA4B0B909263014CF6E2@SHSMSX101.ccr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Rui,

On Wed, Apr 08, 2015 at 01:01:08PM +0000, Zhang, Rui wrote:
>=20
>=20
> > -----Original Message-----
> > From: Eduardo Valentin [mailto:edubezval@gmail.com]
> > Sent: Tuesday, April 7, 2015 10:47 AM
> > To: Zhang, Rui
> > Cc: linux-pm@vger.kernel.org
> > Subject: Re: [PATCH V4 1/3] Thermal: initialize thermal zone device cor=
rectly
> > Importance: High
> >=20
> > On Tue, Apr 07, 2015 at 10:24:34AM +0800, Zhang Rui wrote:
> > > After thermal zone device registered, as we have not read any
> > > temperature before, thus tz->temperature should not be 0, which
> > > actually means 0C, and thermal trend is not available.
> > > In this case, we need specially handling for the first
> > > thermal_zone_device_update().
> > >
> > > Both thermal core framework and step_wise governor is enhanced to han=
dle
> > this.
> > >
> > > CC: <stable@vger.kernel.org> #3.18+
> > > Tested-by: Manuel Krause <manuelkrause@netscape.net>
> > > Tested-by: szegad <szegadlo@poczta.onet.pl>
> > > Tested-by: prash <prash.n.rao@gmail.com>
> > > Tested-by: amish <ammdispose-arch@yahoo.com>
> > > Tested-by: Matthias <morpheusxyz123@yahoo.de>
> > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> >=20
> > Can you please consider the comments I made on V3?
> >=20
> Sorry, I missed your previous comment.
>=20
> > Summary:
> >=20
> > 1. Change initialized to trend_valid
>=20
> I don't think it is proper to call it "trend_valid" because in the case t=
hat cooling device
> is registered after thermal zone (the problem pointed out in patch 3/3),
> the new created thermal_instance needs to be set properly, and the trend =
is valid
> at this time actually.

I see your point. But for the case of the problem solved by patch 3/3,
shouldn't the core part call then call thermal_zone_device_update only
for the thermal_zones that the cooling device has a thermal_instance
with ->initialized =3D=3D false?

I think in this case the thermal_core needs to be more aware of this
property, instead of leaving for governors to deal with it. And the way
it is put today, looks like the property is useful only for step_wise,
that is why it makes me feel like it is trend bounded.


>=20
> IMO, thermal_instance->initialized just means if the thermal instance is =
evaluated for
> the first time or not, and if yes, we need some special handling.

OK. Thanks for clarifying.=20

>=20
> > 2. return next_target earlier in the get_target_state, so the behavior =
is
> > consistent.
>=20
> Agreed. Will fix in next version.

OK. Thanks.

>=20
> Thanks,
> rui
> >=20
> > > ---
> > >  drivers/thermal/step_wise.c    | 15 +++++++++++++--
> > >  drivers/thermal/thermal_core.c | 19 +++++++++++++++++--
> > > drivers/thermal/thermal_core.h |  1 +
> > >  include/linux/thermal.h        |  3 +++
> > >  4 files changed, 34 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
> > > index 5a0f12d..c2bb37c 100644
> > > --- a/drivers/thermal/step_wise.c
> > > +++ b/drivers/thermal/step_wise.c
> > > @@ -63,6 +63,16 @@ static unsigned long get_target_state(struct
> > thermal_instance *instance,
> > >  	next_target =3D instance->target;
> > >  	dev_dbg(&cdev->device, "cur_state=3D%ld\n", cur_state);
> > >
> > > +	if (!instance->initialized) {
> > > +		if (throttle) {
> > > +			next_target =3D (cur_state + 1) >=3D instance->upper ?
> > > +					instance->upper :
> > > +					((cur_state + 1) < instance->lower ?
> > > +					instance->lower : (cur_state + 1));
> > > +		} else
> > > +			next_target =3D THERMAL_NO_TARGET;
> > > +	}
> > > +
> > >  	switch (trend) {
> > >  	case THERMAL_TREND_RAISING:
> > >  		if (throttle) {
> > > @@ -149,7 +159,8 @@ static void thermal_zone_trip_update(struct
> > thermal_zone_device *tz, int trip)
> > >  		dev_dbg(&instance->cdev->device, "old_target=3D%d,
> > target=3D%d\n",
> > >  					old_target, (int)instance->target);
> > >
> > > -		if (old_target =3D=3D instance->target)
> > > +		if (instance->initialized &&
> > > +		    old_target =3D=3D instance->target)
> > >  			continue;
> > >
> > >  		/* Activate a passive thermal instance */ @@ -161,7 +172,7
> > @@
> > > static void thermal_zone_trip_update(struct thermal_zone_device *tz, =
int trip)
> > >  			instance->target =3D=3D THERMAL_NO_TARGET)
> > >  			update_passive_instance(tz, trip_type, -1);
> > >
> > > -
> > > +		instance->initialized =3D true;
> > >  		instance->cdev->updated =3D false; /* cdev needs update */
> > >  	}
> > >
> > > diff --git a/drivers/thermal/thermal_core.c
> > > b/drivers/thermal/thermal_core.c index 174d3bc..9d6f71b 100644
> > > --- a/drivers/thermal/thermal_core.c
> > > +++ b/drivers/thermal/thermal_core.c
> > > @@ -469,8 +469,22 @@ static void update_temperature(struct
> > thermal_zone_device *tz)
> > >  	mutex_unlock(&tz->lock);
> > >
> > >  	trace_thermal_temperature(tz);
> > > -	dev_dbg(&tz->device, "last_temperature=3D%d,
> > current_temperature=3D%d\n",
> > > -				tz->last_temperature, tz->temperature);
> > > +	if (tz->last_temperature =3D=3D THERMAL_TEMP_INVALID)
> > > +		dev_dbg(&tz->device, "last_temperature N/A,
> > current_temperature=3D%d\n",
> > > +			tz->temperature);
> > > +	else
> > > +		dev_dbg(&tz->device, "last_temperature=3D%d,
> > current_temperature=3D%d\n",
> > > +			tz->last_temperature, tz->temperature); }
> > > +
> > > +static void thermal_zone_device_reset(struct thermal_zone_device *tz)
> > > +{
> > > +	struct thermal_instance *pos;
> > > +
> > > +	tz->temperature =3D THERMAL_TEMP_INVALID;
> > > +	tz->passive =3D 0;
> > > +	list_for_each_entry(pos, &tz->thermal_instances, tz_node)
> > > +		pos->initialized =3D false;
> > >  }
> > >
> > >  void thermal_zone_device_update(struct thermal_zone_device *tz) @@
> > > -1574,6 +1588,7 @@ struct thermal_zone_device
> > *thermal_zone_device_register(const char *type,
> > >  	if (!tz->ops->get_temp)
> > >  		thermal_zone_device_set_polling(tz, 0);
> > >
> > > +	thermal_zone_device_reset(tz);
> > >  	thermal_zone_device_update(tz);
> > >
> > >  	return tz;
> > > diff --git a/drivers/thermal/thermal_core.h
> > > b/drivers/thermal/thermal_core.h index 0531c75..6d9ffa5 100644
> > > --- a/drivers/thermal/thermal_core.h
> > > +++ b/drivers/thermal/thermal_core.h
> > > @@ -41,6 +41,7 @@ struct thermal_instance {
> > >  	struct thermal_zone_device *tz;
> > >  	struct thermal_cooling_device *cdev;
> > >  	int trip;
> > > +	bool initialized;
> > >  	unsigned long upper;	/* Highest cooling state for this trip point */
> > >  	unsigned long lower;	/* Lowest cooling state for this trip point */
> > >  	unsigned long target;	/* expected cooling state */
> > > diff --git a/include/linux/thermal.h b/include/linux/thermal.h index
> > > 5eac316..fb96b15 100644
> > > --- a/include/linux/thermal.h
> > > +++ b/include/linux/thermal.h
> > > @@ -40,6 +40,9 @@
> > >  /* No upper/lower limit requirement */
> > >  #define THERMAL_NO_LIMIT	((u32)~0)
> > >
> > > +/* use value, which < 0K, to indicate an invalid/uninitialized tempe=
rature */
> > > +#define THERMAL_TEMP_INVALID	-274000
> > > +
> > >  /* Unit conversion macros */
> > >  #define KELVIN_TO_CELSIUS(t)	(long)(((long)t-2732 >=3D 0) ?	\
> > >  				((long)t-2732+5)/10 : ((long)t-2732-5)/10)
> > > --
> > > 1.9.1
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> > > the body of a message to majordomo@vger.kernel.org More majordomo info
> > > at  http://vger.kernel.org/majordomo-info.html

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVJUNXAAoJEMLUO4d9pOJWQ0AH/1L94G/yWjbGqdTIO9bRfZhC
yMH5b2XSvP1DikmMQYqIwrWEoaOlK646jjMqVxWN1GZugnLOEQicf8HuMlv6Bnx1
el6q6tnGIaIr2f+fnuDbHa5RefwNnEtm+rBjdMI7YqakK+x2ncdrYeUNnMLMNPhE
GmF32bkZlMq8Iy63cx6JLpQ9SElFkurZNA0cg8UfiSkiSEBo/S47gwQ3lxFO4RRW
qhMTFmUu1dLZZtj9oP9+xMeJq0KJA85WPzaEoUFQp8jJ1hjdWbnSlTb5xqdiiZOo
w2ho3OK1drHhdrOJaH/0HougwgKizA8CY0JYu0RRNlZIB95Kci5EQJwdzChQl5M=
=vGaN
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
