From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 0/2] Hi all,
Date: Mon, 20 Mar 2017 02:18:04 +0100
Message-ID: <20170320011804.k4ir2x7wbz6g7gi5@earth>
References: <20170316160530.14956-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xl77ikvjkua7knbn"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752722AbdCTBTx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 19 Mar 2017 21:19:53 -0400
Content-Disposition: inline
In-Reply-To: <20170316160530.14956-1-afd@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Evgeniy Polyakov <zbr@ioremap.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--xl77ikvjkua7knbn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 16, 2017 at 11:05:28AM -0500, Andrew F. Davis wrote:
> To finish the work started in this patch[0] we needed to reorganize
> the 1-wire subsystem a bit, this is done here[1]. After that is taken
> this series can remove the need for a platform driver for supporting
> 1-wire connected BQ27xxx devices.
>=20
> Thanks,
> Andrew
>=20
> [0] https://patchwork.kernel.org/patch/7684371/
> [1] https://lkml.org/lkml/2017/3/16/604
>=20
> Andrew F. Davis (2):
>   power: supply: move HDQ interface for bq27xxx from w1 to power/supply
>   power: supply: bq27xxx: move platform driver code into
>     bq27xxx_battery_hdq.c
>=20
>  drivers/power/supply/Kconfig               |   9 ++
>  drivers/power/supply/Makefile              |   1 +
>  drivers/power/supply/bq27xxx_battery.c     | 104 ----------------------
>  drivers/power/supply/bq27xxx_battery_hdq.c | 135 +++++++++++++++++++++++=
++++++
>  drivers/w1/slaves/Kconfig                  |   6 --
>  drivers/w1/slaves/Makefile                 |   1 -
>  drivers/w1/slaves/w1_bq27000.c             | 117 -----------------------=
--
>  include/linux/power/bq27xxx_battery.h      |  17 ----
>  8 files changed, 145 insertions(+), 245 deletions(-)
>  create mode 100644 drivers/power/supply/bq27xxx_battery_hdq.c
>  delete mode 100644 drivers/w1/slaves/w1_bq27000.c

Acked-by: Sebastian Reichel <sre@kernel.org>

-- Sebastian

--xl77ikvjkua7knbn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljPLcYACgkQ2O7X88g7
+pomGg//fcU60OMNJjf2MPOeU2VKYTR7Y5G61i07WEOgVq6IuL03FLSEMkHt/8dl
UHv0+Cv9HisTGZX6Rwx03WJ1LsPMHnpMXpW7AyXwaRwGLYu79cRICowDxCKXjcqT
rPPev8DthOKIjRay/yhehtl7xhMjiUFTlygoB0PA+jwLse3Zo+DUe5NmNYlK4P1K
OFAXhtvVCqShGZ7Z9D2QAVQ3mwveoIA/qiNL1VfbGOFzeEV0AQW9/eDwSPJp7E54
bramHL+j0S3+5tg4o9hGCCveISK04gP76f1Gfu0iC+Ci6zV3XS6BEJvNO3/FXaOl
1rhZKNIHvUw1Vr1BCyL8+Rx0RbUHIcr1KC7uV66wKT+ICgX4SWvCScBoed2jJ1n8
rf7IjT62IRuRD1c+NwBZetcmTTFvKjAONvtXKrUy2GiCiVifePNrwUilEgvfggdL
XQsw4NQ9z/ZvfPyiRMxKO7qvH59/1lroTDoDox8dt8X+5oaR3oVLE2dvm7P3mXg3
VTVjGUdD2AekAAAN1URZX6BfgJVZpYaIqXQKAQ8ciCQBbGAZyESB02RrbZ8k0Zlk
ICKnuv5T0ZgZh86rTeGs2AAkkK9/cZ1a3gfT9m14jwXBJaYtdSNouFdpgsBOYOyy
dxSD50nX0X2gBqi1l0ivVzmtFNhNkwnJM50cgt3OwkzuElA4iFk=
=DnLO
-----END PGP SIGNATURE-----

--xl77ikvjkua7knbn--
