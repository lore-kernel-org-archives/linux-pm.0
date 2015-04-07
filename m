From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add me as maintainer of Nokia N900 power supply drivers
Date: Tue, 7 Apr 2015 22:59:45 +0200
Message-ID: <201504072259.45809@pali>
References: <1427636154-20874-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6743766.psDfCv9aRJ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:34803 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548AbbDGU7t (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Apr 2015 16:59:49 -0400
In-Reply-To: <1427636154-20874-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>

--nextPart6743766.psDfCv9aRJ
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

=46orgot to mention reason in commit message:

I'm author of two of those drivers (bq2415x and rx51) and I added=20
more patches for other twos. Also I fished (proper) open source=20
power management software for Nokia N900 and those kernel drivers=20
are part of it.

On Sunday 29 March 2015 15:35:54 Pali Roh=C3=A1r wrote:
> Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> ---
>  MAINTAINERS |   11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 72a08ef..50df61e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6917,6 +6917,17 @@ T:	git
> git://git.rocketboards.org/linux-socfpga-next.git
> S:	Maintained
>  F:	arch/nios2/
>=20
> +NOKIA N900 POWER SUPPLY DRIVERS
> +M:	Pali Roh=C3=A1r <pali.rohar@gmail.com>
> +S:	Maintained
> +F:	include/linux/power/bq2415x_charger.h
> +F:	include/linux/power/bq27x00_battery.h
> +F:	include/linux/power/isp1704_charger.h
> +F:	drivers/power/bq2415x_charger.c
> +F:	drivers/power/bq27x00_battery.c
> +F:	drivers/power/isp1704_charger.c
> +F:	drivers/power/rx51_battery.c
> +
>  NTB DRIVER
>  M:	Jon Mason <jdmason@kudzu.us>
>  M:	Dave Jiang <dave.jiang@intel.com>

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart6743766.psDfCv9aRJ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlUkRUEACgkQi/DJPQPkQ1IEmwCeP17wlGKCXPa4LojKfYl6AMUD
M3cAoLTJuRy7H7y1g7pYlKy9t/Q63+Ih
=KFwu
-----END PGP SIGNATURE-----

--nextPart6743766.psDfCv9aRJ--
