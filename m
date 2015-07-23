From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 5/8] power: bq27x00_battery: Renaming for consistency
Date: Thu, 23 Jul 2015 23:15:16 +0200
Message-ID: <201507232315.16467@pali>
References: <1437601920-13045-1-git-send-email-afd@ti.com> <201507232215.35603@pali> <CAAfyv342rHGazCqZ19oYfwR5E2NO65VhhstXBHdDVfjd7USbFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1642602.IU4OVs5DzX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33158 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753070AbbGWVPU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2015 17:15:20 -0400
In-Reply-To: <CAAfyv342rHGazCqZ19oYfwR5E2NO65VhhstXBHdDVfjd7USbFQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Belisko Marek <marek.belisko@gmail.com>
Cc: "Andrew F. Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Murphy <dmurphy@ti.com>, Linux PM mailing list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

--nextPart1642602.IU4OVs5DzX
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 23 July 2015 22:56:26 Belisko Marek wrote:
> Hi Pali,
>=20
> On Thu, Jul 23, 2015 at 10:15 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com>
> wrote:
> > On Thursday 23 July 2015 19:03:08 Andrew F. Davis wrote:
> >> >> -#ifdef CONFIG_BATTERY_BQ27X00_I2C
> >> >> -MODULE_ALIAS("i2c:bq27000-battery");
> >> >> +#ifdef CONFIG_BATTERY_BQ27XXX_I2C
> >> >> +MODULE_ALIAS("i2c:bq27xxx-battery");
> >> >>=20
> >> >>  #endif
> >> >=20
> >> > Why is this MODULE_ALIAS needed? Some lines upper there is
> >> >=20
> >> >  MODULE_DEVICE_TABLE(i2c, bq27xxx_id);
> >> >=20
> >> > which add proper i2c: module alias...
> >>=20
> >> Not sure, looks like it was added in commit
> >> 8ebb7e9c1a502cfc300618c19c3c6f06fc76d237 which claims that the
> >> "module won't get loaded automatically" without it, but I have not
> >> had this problem, so I'm not sure why it's there.
> >=20
> > git grep bq27000-battery show me that only one driver uses that
> > name: drivers/w1/slaves/w1_bq27000.c
> >=20
> > And more over, it is platform device, not i2c device. So that
> > commit 8ebb7e9c1a502cfc300618c19c3c6f06fc76d237 is wrong! CCing
> > Marek.
>=20
> If you look to power/bq27x00 driver then there is I2C part and
> platform part only
> both selectable by config. In
> 8ebb7e9c1a502cfc300618c19c3c6f06fc76d237 was added MODULE_ALIAS to
> have this driver working as module for both buses. Even if I2C isn't
> used anywhere
> I add MODULE_ALIAS also for that.
>=20
> > MODULE_ALIAS("platform:bq27000-battery") is really needed for
> > w1_bq27000.c but MODULE_ALIAS("i2c:bq27000-battery") should be
> > removed. It is not used by any board platform code or DT.
>=20
> Not sure if it's good idea to remove it. Somebody outside can use it.
>=20
> > Marek, correct me if I'm wrong.
> >=20
> > --
> > Pali Roh=C3=A1r
> > pali.rohar@gmail.com
>=20
> BR,
>=20
> marek

Who, where any why is using alias i2c:bq27000-battery??

It is obviously wrong to add that alias. MODULE_DEVICE_TABLE(i2c, ...=20
macro automatically adds all MODULE_ALIASes for all i2c devices.

If there is such device with needs i2c:bq27000-battery is should be=20
fixed to use i2c:bq27??? identifier exported by MODULE_DEVICE_TABLE.

git grep on kernel tree did not return anything, so there is no usage.

Of course alias for platform:bq27000-battery is needed.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1642602.IU4OVs5DzX
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlWxWWQACgkQi/DJPQPkQ1KeKgCgh3r9tmC85EIpQjONsv8zCYRa
8lYAoIBFHyC3vAEGj/duXxPj0pVnuOF8
=n9EG
-----END PGP SIGNATURE-----

--nextPart1642602.IU4OVs5DzX--
