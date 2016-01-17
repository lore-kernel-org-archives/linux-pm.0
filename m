From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update bq27xxx driver
Date: Sun, 17 Jan 2016 21:53:53 +0100
Message-ID: <201601172153.53285@pali>
References: <1453063539-18483-1-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2202823.i7Mf4nQNCt";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35390 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbcAQUx4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 17 Jan 2016 15:53:56 -0500
Received: by mail-wm0-f54.google.com with SMTP id r129so29223700wmr.0
        for <linux-pm@vger.kernel.org>; Sun, 17 Jan 2016 12:53:56 -0800 (PST)
In-Reply-To: <1453063539-18483-1-git-send-email-sre@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>

--nextPart2202823.i7Mf4nQNCt
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sunday 17 January 2016 21:45:39 Sebastian Reichel wrote:
> Update reviewers for bq27xxx, so that Pali and Andrew
> are reviewers with status and maintainer inherited from
> the power supply subsystem entry.
>=20
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> Cc: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> Cc: Andrew F. Davis <afd@ti.com>

Acked-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

> ---
>  MAINTAINERS | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 04d62b1e8b17..6b0098f0a098 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7581,13 +7581,13 @@ S:	Maintained
>  F:	arch/nios2/
>=20
>  NOKIA N900 POWER SUPPLY DRIVERS
> -M:	Pali Roh=C3=A1r <pali.rohar@gmail.com>
> -S:	Maintained
> +R:	Pali Roh=C3=A1r <pali.rohar@gmail.com>
>  F:	include/linux/power/bq2415x_charger.h
>  F:	include/linux/power/bq27xxx_battery.h
>  F:	include/linux/power/isp1704_charger.h
>  F:	drivers/power/bq2415x_charger.c
>  F:	drivers/power/bq27xxx_battery.c
> +F:	drivers/power/bq27xxx_battery_i2c.c
>  F:	drivers/power/isp1704_charger.c
>  F:	drivers/power/rx51_battery.c
>=20
> @@ -9414,6 +9414,12 @@ M:	Andreas Noever <andreas.noever@gmail.com>
>  S:	Maintained
>  F:	drivers/thunderbolt/
>=20
> +TI BQ27XXX POWER SUPPLY DRIVER
> +R:	Andrew F. Davis <afd@ti.com>
> +F:	include/linux/power/bq27xxx_battery.h
> +F:	drivers/power/bq27xxx_battery.c
> +F:	drivers/power/bq27xxx_battery_i2c.c
> +
>  TIMEKEEPING, CLOCKSOURCE CORE, NTP, ALARMTIMER
>  M:	John Stultz <john.stultz@linaro.org>
>  M:	Thomas Gleixner <tglx@linutronix.de>

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2202823.i7Mf4nQNCt
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlab/2EACgkQi/DJPQPkQ1L6hACgu7JZNhBuNNrqTgg1t6PmAq+W
rVgAn3cV+JCta0KjnKhMigTvprmw+lev
=PsYI
-----END PGP SIGNATURE-----

--nextPart2202823.i7Mf4nQNCt--
