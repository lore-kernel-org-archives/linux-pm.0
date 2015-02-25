From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: Mess in the /sysfs: class/power_supply/bq2415x
Date: Wed, 25 Feb 2015 23:01:41 +0100
Message-ID: <201502252301.41633@pali>
References: <20150131213919.GA16133@amd> <20150225214441.GK13695@earth>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2148038.WZcW9J1vX2";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:42442 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932101AbbBYWBo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Feb 2015 17:01:44 -0500
In-Reply-To: <20150225214441.GK13695@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org

--nextPart2148038.WZcW9J1vX2
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 25 February 2015 22:44:42 Sebastian Reichel wrote:
> Hi Pavel,
>=20
> On Sat, Jan 31, 2015 at 10:39:19PM +0100, Pavel Machek wrote:
> > So we have multiple values in one sysfs file:
> >=20
> > root@n900:/sys/class/power_supply# cat bq24150a-0/registers
> > 0x00=3D0x50
> > 0x01=3D0xc8
> > 0x02=3D0x8e
> > 0x03=3D0x4b
> > 0x04=3D0x99
> >=20
> > (should this go to debugfs somewhere?)
>=20
> I guess this should be dropped in favour of debugfs. A
> standardized debugfs node will be exported automatically if
> the driver is converted to regmap.
>=20
> > Unobvious and undocumented entries:
> >=20
> > root@n900:/sys/class/power_supply# cat
> > bq24150a-0/boost_status 0
> > pavel@duo:/data/l/linux-n900$ grep -ri boost_status
> > Documentation/ pavel@duo:/data/l/linux-n900$ grep -ri
> > termination_current Documentation/
> > pavel@duo:/data/l/linux-n900$ grep -ri current_now
> > Documentation/ pavel@duo:/data/l/linux-n900$ grep -ri
> > time_to_empty_avg Documentation/
> > pavel@duo:/data/l/linux-n900$
>=20
> Anton seems to have missed making Pali to write a
> Documentation patch. Pali: Can you do so, please?
>=20

Some of properties are standard power_supply properties and those=20
are documented in Documentation/power/power_supply_class.txt

bq2415x specific are documented only in bq2415x_charger.c source=20
code. So probably we should move documentation into=20
Documentation/power/bq2415x_charer.txt

But I think there are other stuff with higher priority for N900=20
as moving comments/documentation...

> > And different units in different parts of tree:
> >=20
> > (these are mA)
> >=20
> > root@n900:/sys/class/power_supply# cat
> > bq24150a-0/current_limit 1800
> > root@n900:/sys/class/power_supply# cat
> > bq24150a-0/termination_current 100
> >=20

Those are non standard power-supply properties and so unit is not=20
defined.

> > (and this is in uA)
> >=20
> > root@n900:/sys/class/power_supply# cat bq27200-0/current_now
> > 12138
> >=20

This is power supply.

> > (I believe uA is right, so it is bq24150a that should be
> > fixed....?)
> >=20

Units
~~~~~
Quoting include/linux/power_supply.h:

  All voltages, currents, charges, energies, time and=20
temperatures in =C2=B5V,
  =C2=B5A, =C2=B5Ah, =C2=B5Wh, seconds and tenths of degree Celsius unless=
=20
otherwise
  stated. It's driver's job to convert its raw values to units in=20
which
  this class operates.

> > Ok, of course questions are: do we need to do something with
> > it? If so, what?
>=20
> For consistency it should be uA, but I guess this would
> introduce a regression for Maemo people. Pali?
>=20
> -- Sebastian

It looks like that in Maemo & CSSU we are using only:

/sys/class/power_supply/bq24150a-0/mode
/sys/class/power_supply/bq24150a-0/stat_pin_enable

But it does not mean that some other people do not use other=20
bq2415x sysfs nodes.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2148038.WZcW9J1vX2
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTuRkUACgkQi/DJPQPkQ1K6tQCcC4yoilJeMGDzZnglV2UfancR
7sMAoKcWhoUGmsCaT38Or37tatCSELqZ
=s32l
-----END PGP SIGNATURE-----

--nextPart2148038.WZcW9J1vX2--
