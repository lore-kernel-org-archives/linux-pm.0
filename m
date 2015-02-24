From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: Default OF created trip points to writable
Date: Tue, 24 Feb 2015 15:52:02 -0400
Message-ID: <20150224195201.GB353@developer.amazonguestwifi.org>
References: <1423592506-20620-1-git-send-email-punit.agrawal@arm.com>
 <20150216151432.GB8648@developer.hsd1.ca.comcast.net>
 <9hh1tloaj1l.fsf@e105922-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:33401 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245AbbBXTwL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 Feb 2015 14:52:11 -0500
Received: by pdjz10 with SMTP id z10so35738727pdj.0
        for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2015 11:52:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <9hh1tloaj1l.fsf@e105922-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2015 at 11:12:22AM +0000, Punit Agrawal wrote:
> Eduardo Valentin <edubezval@gmail.com> writes:
>=20
> > Hey Punit,
> >
> > On Tue, Feb 10, 2015 at 06:21:46PM +0000, Punit Agrawal wrote:
> >> When registering a thermal zone from device tree, default the trip
> >> points to writable. By default, only the root user can change these.
> >>=20
> >> This allows the trip points to be tweaked after the system has
> >> booted.
> >
> > Can you please elaborate more on why having default writable makes sense
> > against having default read only? The purpose of this patch seams to be
> > targeted to development/debugging systems, not productions systems. The
> > default has to make sense for production systems.
>=20
> Agreed about the default making sense for production systems.
>=20
> We've seen deployments in the field where the default value of the trip
> temperatures are modulated by a userspace component that has contextual
> knowledge about workloads and device margins. Using OF for thermal
> setup, it is not possible to get this functionality.
>=20
> I guess you are worried about safety - as you still need root privileges
> to be able to change the trip temperatures so it's not by-passing the
> security setup of the system.
>=20
> >
> >>=20
> >> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> >> ---
> >> Hi Eduardo,
> >>=20
> >> We've been using this patch internally and haven't run into any
> >>  issues. Without these changes there is no way to change trip points
> >>  from a running system.
> >
> > Ok. I see.
> >
> > So, the problem statement here is to be able to change the trip points
> > from a running system. What is the purpose? Do you have something in
> > userland that is benefiting of having these trips writable? Or is it
> > just for development fun?
>=20
> Sure it helps with development too. In a workflow where the development
> of the drivers and the tuning are separate activities, and not
> necessarily done by the same people, it is very helpful to be able to
> evaluate different parameters for power-performance-thermal tuning
> without having to rebuild the dtb and reboot the system.
>=20
> I think it makes it easier for folks to get up and running with OF and
> thermals. But I'll defer to your judgement here.


Punit,

I understand your concerns and thoughts. Let me make a counterproposal.
Instead of making the trip points populated by of-thermal writable by defau=
lt,
how about if we do the following?

(1) - Change thermal core to have a Kconfig option to allow system
integrator to choose if trip points are writable or not. So, on top of
the mask index flags for each trip, the Kconfig must be enabled at
compilation time. If the Kconfig option is disable, no trip points will
get write access, regardless the mask provided by the thermal drivers.
Here, I would prefer to have the default behavior as readonly.

(2) - Change of-thermal to provide writable trip points by default
(essentially, this present patch).

Although no changes in this patch are required, I would prefer to merge
first number (1) above.

In this way, we allow an option to system engineers that do not want user
space to mess with their kernel thermal policy. And we also allow people
who has userspace thermal policy to work properly. And, by grant, we
have an option to make development easier.

What is your optionion?

I am copying Srinivas here too. Srinivas, do you think that option (1)
above will break things in userspace on your side?

>=20
> Cheers,
> Punit
>=20
> >
> >
> > BR,
> >
> > Eduardo Valentin
> >
> >>=20
> >> Comments welcome.
> >>=20
> >> Cheers,
> >> Punit
> >>=20
> >>  drivers/thermal/of-thermal.c | 6 +++++-
> >>  1 file changed, 5 insertions(+), 1 deletion(-)
> >>=20
> >> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal=
=2Ec
> >> index 668fb1b..b7ad5c0 100644
> >> --- a/drivers/thermal/of-thermal.c
> >> +++ b/drivers/thermal/of-thermal.c
> >> @@ -865,6 +865,7 @@ int __init of_parse_thermal_zones(void)
> >>  	for_each_child_of_node(np, child) {
> >>  		struct thermal_zone_device *zone;
> >>  		struct thermal_zone_params *tzp;
> >> +		int i, mask =3D 0;
> >> =20
> >>  		/* Check whether child is enabled or not */
> >>  		if (!of_device_is_available(child))
> >> @@ -891,8 +892,11 @@ int __init of_parse_thermal_zones(void)
> >>  		/* No hwmon because there might be hwmon drivers registering */
> >>  		tzp->no_hwmon =3D true;
> >> =20
> >> +		for (i =3D 0; i < tz->ntrips; i++)
> >> +			mask |=3D 1 << i;
> >> +
> >>  		zone =3D thermal_zone_device_register(child->name, tz->ntrips,
> >> -						    0, tz,
> >> +						    mask, tz,
> >>  						    ops, tzp,
> >>  						    tz->passive_delay,
> >>  						    tz->polling_delay);
> >> --=20
> >> 2.1.4
> >>=20

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU7NZTAAoJEMLUO4d9pOJWNf0H/2xW5CJoDTCtzcuhb7R/pkSn
u071PMtiyyeJaaz94obVeag2wVeS36xmk2ZRoU6XRZ63SMpgOwstOQkVfaHLQDAi
VHsmJBzwWGcYzm84bnwk0pPYvQR9FMPp6dQjOEvivE6nsOkRGN1+ydnPigIUL1zk
uJG1m7jZSVJxSE/jujmBomUPDEhuYXJ4g0aWBhM0hL7UvyTOwB9YvtPlBvzis3gB
GqqxTBfrYPnSkxigiZHy5XIHhhMx83I5caOu1+nKPr4v8NwgqEQaBSVGgfLOaq5p
HIB3X/HMaBgWIg68EIawKkE24VYxM6d6+4AKLr+vUYMdE+52+i743mLekNf4TJE=
=Qrz7
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
