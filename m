From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add myself as a reviewer for the bq27xxx driver.
Date: Thu, 31 Dec 2015 22:11:32 +0100
Message-ID: <201512312211.32570@pali>
References: <1451500541-2442-1-git-send-email-afd@ti.com> <201512311940.04886@pali> <20151231210638.GA11763@earth>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2243547.Sxp0adD0MZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:33329 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483AbbLaVLl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Dec 2015 16:11:41 -0500
In-Reply-To: <20151231210638.GA11763@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

--nextPart2243547.Sxp0adD0MZ
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 31 December 2015 22:06:38 Sebastian Reichel wrote:
> Hi,
>=20
> On Thu, Dec 31, 2015 at 07:40:04PM +0100, Pali Roh=C3=A1r wrote:
> > On Wednesday 30 December 2015 19:35:41 Andrew F. Davis wrote:
> > > Signed-off-by: Andrew F. Davis <afd@ti.com>
> > > ---
> > >=20
> > >  MAINTAINERS | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 44666b1..046d001 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -7605,10 +7605,8 @@ NOKIA N900 POWER SUPPLY DRIVERS
> > >=20
> > >  M:	Pali Roh=C3=A1r <pali.rohar@gmail.com>
> > >  S:	Maintained
> > >  F:	include/linux/power/bq2415x_charger.h
> > >=20
> > > -F:	include/linux/power/bq27xxx_battery.h
> > >=20
> > >  F:	include/linux/power/isp1704_charger.h
> > >  F:	drivers/power/bq2415x_charger.c
> > >=20
> > > -F:	drivers/power/bq27xxx_battery.c
> > >=20
> > >  F:	drivers/power/isp1704_charger.c
> > >  F:	drivers/power/rx51_battery.c
> >=20
> > I think it is not needed to remove files from this section as here
> > are all power supply files for Nokia N900.
> >=20
> > > @@ -10710,6 +10708,14 @@ L:	linux-omap@vger.kernel.org
> > >=20
> > >  S:	Maintained
> > >  F:	drivers/thermal/ti-soc-thermal/
> > >=20
> > > +TI BQ27XXX POWER SUPPLY DRIVER
> > > +M:	Pali Roh=C3=A1r <pali.rohar@gmail.com>
> > > +R:	Andrew F. Davis <afd@ti.com>
> > > +S:	Maintained
> > > +F:	include/linux/power/bq27xxx_battery.h
> > > +F:	drivers/power/bq27xxx_battery.c
> > > +F:	drivers/power/bq27xxx_battery_i2c.c
>=20
> I think it would make sense to have it like this:
>=20
> NOKIA N900 POWER SUPPLY DRIVERS
> +R:	Pali Roh=C3=A1r <pali.rohar@gmail.com>
> -M:	Pali Roh=C3=A1r <pali.rohar@gmail.com>
> -S:	Maintained
> F:	include/linux/power/bq2415x_charger.h
> F:	include/linux/power/bq27xxx_battery.h
> F:	include/linux/power/isp1704_charger.h
> F:	drivers/power/bq2415x_charger.c
> F:	drivers/power/bq27xxx_battery.c
> F:	drivers/power/isp1704_charger.c
> F:	drivers/power/rx51_battery.c
>=20
> +TI BQ27XXX POWER SUPPLY DRIVER
> +R:	Andrew F. Davis <afd@ti.com>
> +F:	include/linux/power/bq27xxx_battery.h
> +F:	drivers/power/bq27xxx_battery.c
> +F:	drivers/power/bq27xxx_battery_i2c.c
> +
> POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS
> M:	Sebastian Reichel <sre@kernel.org>
> M:	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> M:	David Woodhouse <dwmw2@infradead.org>
> L:	linux-pm@vger.kernel.org
> T:	git git://git.infradead.org/battery-2.6.git
> S:	Maintained
> F:	include/linux/power_supply.h
> F:	drivers/power/
> X:	drivers/power/avs/
>=20
> This would result in the following get_maintainer.pl output
> for the bq27xxx driver.
>=20
> sre@earth ~/src/linux [n950] % ./scripts/get_maintainer.pl -f
> drivers/power/bq27xxx_battery.c "Andrew F. Davis" <afd@ti.com>
> (reviewer:TI BQ27XXX POWER SUPPLY DRIVER) "Pali Roh=C3=A1r"
> <pali.rohar@gmail.com> (reviewer:NOKIA N900 POWER SUPPLY DRIVERS)
> Sebastian Reichel <sre@kernel.org> (maintainer:POWER SUPPLY
> CLASS/SUBSYSTEM and DRIVERS) Dmitry Eremin-Solenikov
> <dbaryshkov@gmail.com> (maintainer:POWER SUPPLY CLASS/SUBSYSTEM and
> DRIVERS) David Woodhouse <dwmw2@infradead.org> (maintainer:POWER
> SUPPLY CLASS/SUBSYSTEM and DRIVERS) linux-pm@vger.kernel.org (open
> list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS)
> linux-kernel@vger.kernel.org (open list)
>=20
> Pali, what do you think about the reviewer/maintainer change?
> I think it makes it more clear, that the patches are queued in
> the battery tree. If you think its a downgrade I don't mind not
> changing it, though.
>=20
> -- Sebastian

Change is OK for me.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2243547.Sxp0adD0MZ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlaFmgQACgkQi/DJPQPkQ1Kc3ACfVI2DZt5VsHzwGvInu38gPyE3
pCQAoKnS0jsodlGBjyFwddcR/n+8IvJE
=T5Iy
-----END PGP SIGNATURE-----

--nextPart2243547.Sxp0adD0MZ--
