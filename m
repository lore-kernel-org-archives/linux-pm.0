From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v2 1/2] power: supply: move HDQ interface for bq27xxx
 from w1 to power/supply
Date: Tue, 25 Jul 2017 15:48:27 +0200
Message-ID: <20170725134827.wxlkoebcwh5ycnk3@earth>
References: <20170719170407.14005-1-afd@ti.com>
 <20170719170407.14005-2-afd@ti.com>
 <20170725133022.xjxqas7xy24v3pqa@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bov3w734gbtnwxoa"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33230 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750948AbdGYNsd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jul 2017 09:48:33 -0400
Content-Disposition: inline
In-Reply-To: <20170725133022.xjxqas7xy24v3pqa@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Evgeniy Polyakov <zbr@ioremap.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--bov3w734gbtnwxoa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg & Evgeniy,

Here is a signed immutable branch for Andrew's patch, which moves
bq27000 w1 driver to the power-supply subsystem. I guess git will
figure everything out without this, but better safe than sorry :)

The following changes since commit 520eccdfe187591a51ea9ab4c1a024ae4d0f68d9:

  Linux 4.13-rc2 (2017-07-23 16:15:17 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git =
tags/ib-w1-bq27000-4.14

for you to fetch changes up to 55a9db679183bcf85a6e5c44a4f92f158bb6f03d:

  power: supply: move HDQ interface for bq27xxx from w1 to power/supply (20=
17-07-25 15:17:39 +0200)

----------------------------------------------------------------
immutable branch moving bq2700 driver from w1 to power-supply

----------------------------------------------------------------
Andrew F. Davis (1):
      power: supply: move HDQ interface for bq27xxx from w1 to power/supply

 drivers/power/supply/Kconfig                                     | 9 +++++=
++++
 drivers/power/supply/Makefile                                    | 1 +
 .../slaves/w1_bq27000.c =3D> power/supply/bq27xxx_battery_hdq.c}   | 2 --
 drivers/w1/slaves/Kconfig                                        | 6 ------
 drivers/w1/slaves/Makefile                                       | 1 -
 5 files changed, 10 insertions(+), 9 deletions(-)
 rename drivers/{w1/slaves/w1_bq27000.c =3D> power/supply/bq27xxx_battery_h=
dq.c} (98%)

-- Sebastian

On Tue, Jul 25, 2017 at 03:30:22PM +0200, Sebastian Reichel wrote:
> Hi,
>=20
> On Wed, Jul 19, 2017 at 12:04:06PM -0500, Andrew F. Davis wrote:
> > The HDQ interface driver should be in this folder just like the I2C
> > interface driver. Move this driver out of drivers/w1/slave and into
> > drivers/power/supply.
> >=20
> > Signed-off-by: Andrew F. Davis <afd@ti.com>
> > Acked-by: Pali Roh=E1r <pali.rohar@gmail.com>
> > Acked-by: Sebastian Reichel <sre@kernel.org>
>=20
> Thanks, queued to power-supply's for-next branch. I prepared a
> immutable branch/tag for the w1 tree and will send a pull request
> for that in a minute.
>=20
> -- Sebastian
>=20
> >  drivers/power/supply/Kconfig                                     | 9 +=
++++++++
> >  drivers/power/supply/Makefile                                    | 1 +
> >  .../slaves/w1_bq27000.c =3D> power/supply/bq27xxx_battery_hdq.c}   | 2=
 --
> >  drivers/w1/slaves/Kconfig                                        | 6 -=
-----
> >  drivers/w1/slaves/Makefile                                       | 1 -
> >  5 files changed, 10 insertions(+), 9 deletions(-)
> >  rename drivers/{w1/slaves/w1_bq27000.c =3D> power/supply/bq27xxx_batte=
ry_hdq.c} (98%)
> >=20
> > diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> > index 969f5005669c..af6397224a82 100644
> > --- a/drivers/power/supply/Kconfig
> > +++ b/drivers/power/supply/Kconfig
> > @@ -198,6 +198,15 @@ config BATTERY_BQ27XXX_I2C
> >  	  Say Y here to enable support for batteries with BQ27xxx chips
> >  	  connected over an I2C bus.
> > =20
> > +config BATTERY_BQ27XXX_HDQ
> > +	tristate "BQ27xxx HDQ support"
> > +	depends on BATTERY_BQ27XXX
> > +	depends on W1
> > +	default y
> > +	help
> > +	  Say Y here to enable support for batteries with BQ27xxx chips
> > +	  connected over an HDQ bus.
> > +
> >  config BATTERY_BQ27XXX_DT_UPDATES_NVM
> >  	bool "BQ27xxx support for update of NVM/flash data memory"
> >  	depends on BATTERY_BQ27XXX_I2C
> > diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makef=
ile
> > index a41f40957847..946a5e6be860 100644
> > --- a/drivers/power/supply/Makefile
> > +++ b/drivers/power/supply/Makefile
> > @@ -38,6 +38,7 @@ obj-$(CONFIG_BATTERY_SBS)	+=3D sbs-battery.o
> >  obj-$(CONFIG_CHARGER_SBS)	+=3D sbs-charger.o
> >  obj-$(CONFIG_BATTERY_BQ27XXX)	+=3D bq27xxx_battery.o
> >  obj-$(CONFIG_BATTERY_BQ27XXX_I2C) +=3D bq27xxx_battery_i2c.o
> > +obj-$(CONFIG_BATTERY_BQ27XXX_HDQ) +=3D bq27xxx_battery_hdq.o
> >  obj-$(CONFIG_BATTERY_DA9030)	+=3D da9030_battery.o
> >  obj-$(CONFIG_BATTERY_DA9052)	+=3D da9052-battery.o
> >  obj-$(CONFIG_CHARGER_DA9150)	+=3D da9150-charger.o
> > diff --git a/drivers/w1/slaves/w1_bq27000.c b/drivers/power/supply/bq27=
xxx_battery_hdq.c
> > similarity index 98%
> > rename from drivers/w1/slaves/w1_bq27000.c
> > rename to drivers/power/supply/bq27xxx_battery_hdq.c
> > index 8046ac45381a..f4df67eb9d2c 100644
> > --- a/drivers/w1/slaves/w1_bq27000.c
> > +++ b/drivers/power/supply/bq27xxx_battery_hdq.c
> > @@ -1,6 +1,4 @@
> >  /*
> > - * drivers/w1/slaves/w1_bq27000.c
> > - *
> >   * Copyright (C) 2007 Texas Instruments, Inc.
> >   *
> >   * This file is licensed under the terms of the GNU General Public Lic=
ense
> > diff --git a/drivers/w1/slaves/Kconfig b/drivers/w1/slaves/Kconfig
> > index fb68465908f2..dc4437683956 100644
> > --- a/drivers/w1/slaves/Kconfig
> > +++ b/drivers/w1/slaves/Kconfig
> > @@ -140,10 +140,4 @@ config W1_SLAVE_DS28E04
> > =20
> >  	  If you are unsure, say N.
> > =20
> > -config W1_SLAVE_BQ27000
> > -	tristate "BQ27000 slave support"
> > -	help
> > -	  Say Y here if you want to use a hdq
> > -	  bq27000 slave support.
> > -
> >  endmenu
> > diff --git a/drivers/w1/slaves/Makefile b/drivers/w1/slaves/Makefile
> > index 54c63e420302..e59441a5e157 100644
> > --- a/drivers/w1/slaves/Makefile
> > +++ b/drivers/w1/slaves/Makefile
> > @@ -15,5 +15,4 @@ obj-$(CONFIG_W1_SLAVE_DS2438)	+=3D w1_ds2438.o
> >  obj-$(CONFIG_W1_SLAVE_DS2760)	+=3D w1_ds2760.o
> >  obj-$(CONFIG_W1_SLAVE_DS2780)	+=3D w1_ds2780.o
> >  obj-$(CONFIG_W1_SLAVE_DS2781)	+=3D w1_ds2781.o
> > -obj-$(CONFIG_W1_SLAVE_BQ27000)	+=3D w1_bq27000.o
> >  obj-$(CONFIG_W1_SLAVE_DS28E04)	+=3D w1_ds28e04.o
> > --=20
> > 2.13.0
> >=20



--bov3w734gbtnwxoa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAll3TCsACgkQ2O7X88g7
+pqg0A/+I92TmwKkvW1AUG5iWZFe4d28GTyIoO14InHIUHKGeuTU9VXxry2wClk0
OgTx031JdOaNw9Y4uregZD7so/o8KTYpZfy0mmLo8R1d1NepP5rcfWA8FuSHBy4l
IDX447PYwv7IcBnCPD/+8AZZzeMIfXod/DYca0uteP0QYsErHnI4cWR9Y1jw/vFl
6iSXi1FQMVgZg+J+gNaqZB1YTZny/jDvaxuVsstea6QgKVaC+88bPSpi2ApDy2pl
vwIrfO1GSKPzmsPGfqBvEcWb3NgIFM+NJ8xxT9l9aI2tpmuVHGCIKm+XixaluzZX
KWXRUg4NMt6RLr7OxF/SJla2gk+ZdU1U4Uoz7S3aPkrW75QoDpyXqhaA8XNGHH9A
r60f5eT9mI+WdT6edrlKs4U4f6+ZJTkWA8Ut7eiq5EewNhicJ3KCH30qXSdCZ3Sj
POd76Rt8XcT96Jc2OdacEnr3ZsfwhxKPpRAgiNSKd+5q+CM5tZ8cRRkkvOvrVBAV
ve+1T77x6M3pb5aSPDfDK46e8HTskcyMFfZj+0jMMKwKW9gbzrS5+LhGq179Ncne
CsuFZ4+O2pNRj2P+FH3teZqSQiMhQj3N005pFyd1B0We4chgXdLeupOBq0vmmf0S
QEEE/+vPo8wU9fg3Fy7tc4Xm0usvSu9h+7DhPdFwGgtRtY+kaTc=
=U58z
-----END PGP SIGNATURE-----

--bov3w734gbtnwxoa--
