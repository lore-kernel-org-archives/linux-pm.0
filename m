From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add myself as a reviewer for the bq27xxx
 driver.
Date: Thu, 31 Dec 2015 22:06:38 +0100
Message-ID: <20151231210638.GA11763@earth>
References: <1451500541-2442-1-git-send-email-afd@ti.com>
 <201512311940.04886@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56477 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751619AbbLaVGp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 31 Dec 2015 16:06:45 -0500
Content-Disposition: inline
In-Reply-To: <201512311940.04886@pali>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 31, 2015 at 07:40:04PM +0100, Pali Roh=E1r wrote:
> On Wednesday 30 December 2015 19:35:41 Andrew F. Davis wrote:
> > Signed-off-by: Andrew F. Davis <afd@ti.com>
> > ---
> >  MAINTAINERS | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 44666b1..046d001 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -7605,10 +7605,8 @@ NOKIA N900 POWER SUPPLY DRIVERS
> >  M:	Pali Roh=E1r <pali.rohar@gmail.com>
> >  S:	Maintained
> >  F:	include/linux/power/bq2415x_charger.h
> > -F:	include/linux/power/bq27xxx_battery.h
> >  F:	include/linux/power/isp1704_charger.h
> >  F:	drivers/power/bq2415x_charger.c
> > -F:	drivers/power/bq27xxx_battery.c
> >  F:	drivers/power/isp1704_charger.c
> >  F:	drivers/power/rx51_battery.c
>=20
> I think it is not needed to remove files from this section as here are=20
> all power supply files for Nokia N900.
>
> > @@ -10710,6 +10708,14 @@ L:	linux-omap@vger.kernel.org
> >  S:	Maintained
> >  F:	drivers/thermal/ti-soc-thermal/
> >=20
> > +TI BQ27XXX POWER SUPPLY DRIVER
> > +M:	Pali Roh=E1r <pali.rohar@gmail.com>
> > +R:	Andrew F. Davis <afd@ti.com>
> > +S:	Maintained
> > +F:	include/linux/power/bq27xxx_battery.h
> > +F:	drivers/power/bq27xxx_battery.c
> > +F:	drivers/power/bq27xxx_battery_i2c.c

I think it would make sense to have it like this:

NOKIA N900 POWER SUPPLY DRIVERS
+R:	Pali Roh=E1r <pali.rohar@gmail.com>
-M:	Pali Roh=E1r <pali.rohar@gmail.com>
-S:	Maintained
F:	include/linux/power/bq2415x_charger.h
F:	include/linux/power/bq27xxx_battery.h
F:	include/linux/power/isp1704_charger.h
F:	drivers/power/bq2415x_charger.c
F:	drivers/power/bq27xxx_battery.c
F:	drivers/power/isp1704_charger.c
F:	drivers/power/rx51_battery.c

+TI BQ27XXX POWER SUPPLY DRIVER
+R:	Andrew F. Davis <afd@ti.com>
+F:	include/linux/power/bq27xxx_battery.h
+F:	drivers/power/bq27xxx_battery.c
+F:	drivers/power/bq27xxx_battery_i2c.c
+
POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS
M:	Sebastian Reichel <sre@kernel.org>
M:	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
M:	David Woodhouse <dwmw2@infradead.org>
L:	linux-pm@vger.kernel.org
T:	git git://git.infradead.org/battery-2.6.git
S:	Maintained
F:	include/linux/power_supply.h
F:	drivers/power/
X:	drivers/power/avs/

This would result in the following get_maintainer.pl output
for the bq27xxx driver.

sre@earth ~/src/linux [n950] % ./scripts/get_maintainer.pl -f drivers/power=
/bq27xxx_battery.c=20
"Andrew F. Davis" <afd@ti.com> (reviewer:TI BQ27XXX POWER SUPPLY DRIVER)
"Pali Roh=E1r" <pali.rohar@gmail.com> (reviewer:NOKIA N900 POWER SUPPLY DRI=
VERS)
Sebastian Reichel <sre@kernel.org> (maintainer:POWER SUPPLY CLASS/SUBSYSTEM=
 and DRIVERS)
Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> (maintainer:POWER SUPPLY CLA=
SS/SUBSYSTEM and DRIVERS)
David Woodhouse <dwmw2@infradead.org> (maintainer:POWER SUPPLY CLASS/SUBSYS=
TEM and DRIVERS)
linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVER=
S)
linux-kernel@vger.kernel.org (open list)

Pali, what do you think about the reviewer/maintainer change?
I think it makes it more clear, that the patches are queued in
the battery tree. If you think its a downgrade I don't mind not
changing it, though.

-- Sebastian

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWhZjcAAoJENju1/PIO/qa/WgP/RTdtR874BhP7zomOaahydMo
1zMQF2D99QUVWiUnwr1WNNIFNbeBeiBhh9c7qHgl35EDXbDrn/ZWmVIkF5wE2+H9
z55+3EmxRR1oUIvigoHJUFBVaZTPmd9nDOfPy3ah8mw/fyEEawtuEcd+ZuGCfUOY
gJ4FOiYPChWHp77C3vdhX9m+xIzPtOt1s4dpFgUWztvXDQy8d3rWQQmq5hynK4JY
pNuXUiy3CrVWDtsVnHRkb/mC8KIPlyn7fwvoJKRAyKlqEJlngF3WA9MNg0+TNlXz
aopX5bI+MCNAMW+LVwZpOgOEwONYOiX2pkoMReqvHRHudBQ53ShfRcaDexm6gHkQ
kuWAMDCL9myotG9ORPjeusSK245dvAddL3bIzxB20ri/UV/TVh4sweHnI4sZjgKU
WKMlebOTXM2s3zuzyGLsucbq+olB53OwHJTFe5z4i8HAQhvcEn5mcZ3vtOLPAOMs
U3M2yNQV5E+nQL4pFtntYmwArzit9Po24yMh/z2/YOrS7F3ttBoGJYv8tKd7JOV+
53nk58hcbaCfWjloPKkTerziy8gmpuiS47ehTMdNCoXFbKCnHPdQR6XwrDWdSUZD
WnDV3q+dit6fAz/gq4nV6nV4XB5CGB8piB8Yx9JZ9uzQRboDTuVQTyClRinDSTta
GavqC1P8HXYv4BGwsk9+
=bMe0
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
