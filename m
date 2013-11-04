From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH] thermal: imx_thermal: add module device table
Date: Mon, 4 Nov 2013 12:09:04 -0400
Message-ID: <5277C6A0.80402@ti.com>
References: <E1VbfcJ-0003g5-SK@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OJXS98aLhwIaIXABW3tBKqXMKPNvKlXXg"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48909 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751151Ab3KDQJt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 4 Nov 2013 11:09:49 -0500
In-Reply-To: <E1VbfcJ-0003g5-SK@rmk-PC.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, linux-pm@vger.kernel.org

--OJXS98aLhwIaIXABW3tBKqXMKPNvKlXXg
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 30-10-2013 19:56, Russell King wrote:
> Add the module device table declaration so the module can be loaded
> automatically at boot time.
>=20
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>

> ---
>  drivers/thermal/imx_thermal.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_therma=
l.c
> index 1d6c801c1eb9..ab31552f0360 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -539,3 +539,4 @@ MODULE_AUTHOR("Freescale Semiconductor, Inc.");
>  MODULE_DESCRIPTION("Thermal driver for Freescale i.MX SoCs");
>  MODULE_LICENSE("GPL v2");
>  MODULE_ALIAS("platform:imx-thermal");
> +MODULE_DEVICE_TABLE(of, of_imx_thermal_match);
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--OJXS98aLhwIaIXABW3tBKqXMKPNvKlXXg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlJ3xqAACgkQCXcVR3XQvP0BOgEAkqfr6g5QvpwL6bs1RcI11LL4
C98V81lw+nndjeWC+LYA/jzah+mcVO+von+hzQ0u117c/ZsG6fAMVgyIz/cX4QsJ
=lMoL
-----END PGP SIGNATURE-----

--OJXS98aLhwIaIXABW3tBKqXMKPNvKlXXg--
