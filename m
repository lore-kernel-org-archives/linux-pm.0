From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add myself as a reviewer for the bq27xxx driver.
Date: Thu, 31 Dec 2015 19:40:04 +0100
Message-ID: <201512311940.04886@pali>
References: <1451500541-2442-1-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1483571.PmOYaIfeCu";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:33890 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857AbbLaSkI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Dec 2015 13:40:08 -0500
In-Reply-To: <1451500541-2442-1-git-send-email-afd@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

--nextPart1483571.PmOYaIfeCu
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 30 December 2015 19:35:41 Andrew F. Davis wrote:
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  MAINTAINERS | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 44666b1..046d001 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7605,10 +7605,8 @@ NOKIA N900 POWER SUPPLY DRIVERS
>  M:	Pali Roh=C3=A1r <pali.rohar@gmail.com>
>  S:	Maintained
>  F:	include/linux/power/bq2415x_charger.h
> -F:	include/linux/power/bq27xxx_battery.h
>  F:	include/linux/power/isp1704_charger.h
>  F:	drivers/power/bq2415x_charger.c
> -F:	drivers/power/bq27xxx_battery.c
>  F:	drivers/power/isp1704_charger.c
>  F:	drivers/power/rx51_battery.c
>=20

I think it is not needed to remove files from this section as here are=20
all power supply files for Nokia N900.

> @@ -10710,6 +10708,14 @@ L:	linux-omap@vger.kernel.org
>  S:	Maintained
>  F:	drivers/thermal/ti-soc-thermal/
>=20
> +TI BQ27XXX POWER SUPPLY DRIVER
> +M:	Pali Roh=C3=A1r <pali.rohar@gmail.com>
> +R:	Andrew F. Davis <afd@ti.com>
> +S:	Maintained
> +F:	include/linux/power/bq27xxx_battery.h
> +F:	drivers/power/bq27xxx_battery.c
> +F:	drivers/power/bq27xxx_battery_i2c.c
> +
>  TI CDCE706 CLOCK DRIVER
>  M:	Max Filippov <jcmvbkbc@gmail.com>
>  S:	Maintained


=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1483571.PmOYaIfeCu
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlaFdoQACgkQi/DJPQPkQ1LlnACdF1LfOAcWnsUNrJWxIw5ywxs8
1a4AoIKfEXVIzcnxuRChRyXv7So22R3D
=3XcW
-----END PGP SIGNATURE-----

--nextPart1483571.PmOYaIfeCu--
