From: Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH 5/5] power: supply: bq27xxx: Correct supply status with
 current draw
Date: Wed, 31 May 2017 21:28:56 +0200
Message-ID: <1496258936.2038.8.camel@paulk.fr>
References: <20170430182727.24412-1-contact@paulk.fr>
         <20170430182727.24412-5-contact@paulk.fr>
         <20170528191619.GA20159@xo-6d-61-c0.localdomain>
         <1496249719.1774.1.camel@paulk.fr> <20170531173207.GA10763@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-DAuQ5bV4ZWVb3gmjsBBK"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gagarine.paulk.fr ([109.190.93.129]:58395 "EHLO
        gagarine.paulk.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbdEaT3Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 May 2017 15:29:25 -0400
In-Reply-To: <20170531173207.GA10763@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, "Andrew F . Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>, Chris Lapa <chris@lapa.com.au>, Matt Ranostay <mranostay@gmail.com>


--=-DAuQ5bV4ZWVb3gmjsBBK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mercredi 31 mai 2017 =C3=A0 19:32 +0200, Pavel Machek a =C3=A9crit :
> The status reported directly by the battery controller is not always
> > > > reliable and should be corrected based on the current draw informat=
ion.
> > > >=20
> > > > This implements such a correction with a dedicated function, called
> > > > when retrieving the supply status.
> > > > @@ -1182,6 +1196,8 @@ static int bq27xxx_battery_status(struct
> > > > bq27xxx_device_info *di,
> > > >  		else
> > > >  			status =3D POWER_SUPPLY_STATUS_DISCHARGING;
> > > >  	} else {
> > > > +		curr =3D (int)((s16)curr) * 1000;
> > >=20
> > > Umm.
>=20
> As in "two casts in one expression -- too ugly to live".

Oh, I had skipped that comment, sorry about that. Yeah I understand your
concern. However, this line was mostly inspired by another part of the code=
,
below the following comment: /* Other gauges return signed value */

I think we should fix the first occurence first and then used the fixed syn=
tax
in v2 of this patch. What do you think?

> > > > @@ -1190,6 +1206,18 @@ static int bq27xxx_battery_status(struct
> > > > bq27xxx_device_info *di,
> > > >  			status =3D POWER_SUPPLY_STATUS_CHARGING;
> > > >  	}
> > > > =20
> > > > +
> > > > +	if (curr =3D=3D 0 && status !=3D POWER_SUPPLY_STATUS_NOT_CHARGING=
)
> > > > +		status =3D POWER_SUPPLY_STATUS_FULL;
> > > > +
> > > > +	if (status =3D=3D POWER_SUPPLY_STATUS_FULL) {
> > > > +		/* Drawing or providing current when full */
> > > > +		if (curr > 0)
> > > > +			status =3D POWER_SUPPLY_STATUS_CHARGING;
> > > > +		else if (curr < 0)
> > > > +			status =3D POWER_SUPPLY_STATUS_DISCHARGING;
> > > > +	}
> > >=20
> > > Are you sure this works? On N900, we normally see small currents to/f=
rom
> > > "full" battery.
> >=20
> > In my case, this works perfectly and I am quite surprised of what you'r=
e
> > describing. Is it the case when the battery has a PSU connected?
>=20
> "PSU"? This is cellphone. It has USB connection and charges from that.
>=20
> It has been charging for long while now, and current_now fluctuates
> between 20706 and -2856. USB has limitted current, so I guess "draw
> current from battery if we need more than USB can provide" is quite commo=
n.

Ah right, I had forgotten about the USB current limitation thing. In this c=
ase,
I guess the battery is never actually full and IMO, it should be reported a=
s
such.

> pavel@n900:~$ cat /sys/class/power_supply/bq27200-0/current_now
> 5355
> pavel@n900:~$ cat /sys/class/power_supply/bq27200-0/current_now
> 5355
> pavel@n900:~$ cat /sys/class/power_supply/bq27200-0/current_now
> -4105
> pavel@n900:~$ cat /sys/class/power_supply/bq27200-0/current_now
> -4105
> pavel@n900:~$ cat /sys/class/power_supply/bq27200-0/current_now
> -7675
> pavel@n900:~$ cat /sys/class/power_supply/bq27200-0/current_now
> -5712
> pavel@n900:~$ #screen on
> pavel@n900:~$ cat /sys/class/power_supply/bq27200-0/current_now
> 4641
> pavel@n900:~$ cat /sys/class/power_supply/bq27200-0/current_now
> 4641
> pavel@n900:~$ cat /sys/class/power_supply/bq27200-0/current_now
> 37842
> pavel@n900:~$ cat /sys/class/power_supply/bq27200-0/current_now
> 16600
> pavel@n900:~$
>=20
> > I guess I would consider this a hardware issue (leak currents) and we c=
ould
> > definitely set some range (in device-tree) to distinguish between full =
+
> > leak
> > currents and bad reporting from the fuel gauge. That would work well in=
 my
> > case
> > too.
>=20
> I'd pass to userspace what the controller reports. Yes, I seldom see
> "STATUS_FULL" but that may be a problem we need to track down.

The controller is known, from my experience, to not be reliable in that reg=
ard,
so I don't think it makes sense to pass a state that doesn't reflect the ac=
tual
state of charging just because the chip tells us so.

Worst case, we could also have a dt property to enable that kind of fixup
workaround and let every device maintainer decide whether it is relevant fo=
r
their device.

What do you think?

--=20
Paul Kocialkowski, developer of free digital technology and hardware suppor=
t

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
--=-DAuQ5bV4ZWVb3gmjsBBK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAlkvGXgACgkQhP3B6o/u
lQxfAhAAkpjtPToXLi3gEWUZ6aSGrxCfox8+Ek2yvUHk/azMD0WoMHfCeQHWQZZ0
VvOfryFYK+lUZYEGucKLASZJpl23MjRYgh5mXSMqZtx9nDj3FO9TSrN0Ovckyr7x
aiPewH24ghKJmh4KRor+JEb6uPl6wWReDQqv35xNXt0TIokDHHe2U4HzcWi3iPPX
SunKw+MriatojgPl+XtuVqymIZBsSgCiYzlsseYJZkpNE5cuGd3NxTkm8fn9JPE0
ouE0pfp6ohOmpABl8RobWaedJ2nN2A1YPjIWt3E7uvXvv2y21EGneJe9eGc1ZGp7
hvRMTBILigoWf0sOztIizPpFmI6rdWPZs7gKpO+1vfItHs4/Ut1C54OsHiOepyiG
6ohw2gGv2oYMskL54IZjXqCn6cRQtb7sre75VG05FjoAQLfZ/NRMXldgvFy0DIC9
FFrfG9xYEiPW94E8WG9aZ3aPAe9YJBlJIml2ZvuijXofGvSjUMaJ1Bt9wcE5eQAM
ZtlN9jgJAO6Au9ddXcYVVcyAyN3bI/mih+C7gSuX4v44/+IP1tphbRiiCv0aYdkr
GYieUIr0vfO3L1S3i+sycxLRN/yGtvDp8y73iA2pC43oAgnoo5hQyS+4wE4A2MMz
AF1ezvqJSeduTQjChAM2c85GUc9id9xiY+/wjv6FWlG8cMS5/io=
=W+SJ
-----END PGP SIGNATURE-----

--=-DAuQ5bV4ZWVb3gmjsBBK--
