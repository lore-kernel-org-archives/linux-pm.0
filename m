From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] sbs-battery: correct capacity mode selection bits
Date: Mon, 24 Jul 2017 20:56:03 +0200
Message-ID: <20170724185603.ribnfn7nwwnjs7ao@earth>
References: <1a1c52f56a9e530ae2d0bf825e67f6a6@heine.so>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ungulu337dgnhyys"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753523AbdGXS4G (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 Jul 2017 14:56:06 -0400
Content-Disposition: inline
In-Reply-To: <1a1c52f56a9e530ae2d0bf825e67f6a6@heine.so>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Heinemann <posted@heine.so>
Cc: linux-pm@vger.kernel.org


--ungulu337dgnhyys
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 07, 2017 at 04:23:54PM +0200, Michael Heinemann wrote:
> The capacity mode bit is bit 15. Currently it is written as
> default initialized enum and never shifted. This leads to
> a behaviour where the BATTERY_MODE is not correctly
> recognized and set again.
>=20
> This commit initializes the enum accordingly.
>=20
> Signed-off-by: Michael Heinemann <committed@heine.so>
> ---

Thanks, applied to power-supply's fixes branch.

-- Sebastian

>  drivers/power/supply/sbs-battery.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/sbs-battery.c
> b/drivers/power/supply/sbs-battery.c
> index 8bb2eb3..498e9af 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -60,8 +60,8 @@ enum {
>  #define BATTERY_MODE_OFFSET		0x03
>  #define BATTERY_MODE_MASK		0x8000
>  enum sbs_battery_mode {
> -	BATTERY_MODE_AMPS,
> -	BATTERY_MODE_WATTS
> +	BATTERY_MODE_AMPS =3D 0,
> +	BATTERY_MODE_WATTS =3D 0x8000
>  };
>=20
>  /* manufacturer access defines */
> --=20
> 2.7.4
>=20

--ungulu337dgnhyys
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAll2QsMACgkQ2O7X88g7
+pqo1xAAlv9I4N47tcOGmKT+RMvC/PsuKGICNcHC2WU6x4ZI/jvaGXlQecaZiZzD
kf9oKpqfcXmelHlrZG4oNqo3sfKt7IO9JwZlE6Fy01OMHw37Wlj8fQkPMkgYv0qJ
TRi7kkPwIclaQi7JovSVmupU/+DgItQ39HH/IiU+rJSBIkAjwBy4mmZ4Pbx4s9hf
XfQQI/9/fDKCSBT6lavktkLtu3EjVn2Jyzk6KhrXGsArLJPjkvm9DjunxWgFah8N
oEpXMPnhB3QrRuf0XirIZuDpXAXRWBfOui4WVMq/CGprS+iN8Jke3G5G5hyQjzVP
GZYU5z+/P/lQBS7SskhLaAuQxK8+ynu7gPsXtEqxc335/n5O3pZAVIezblDWGgXK
umcmPhFP0KyMf+QdFWQWjL4u+zVUYR+s1Bw6+wRXMrxWYcKott/xyJoq5NbBujKT
BkKTI+sVW69PSYo8Kf6dkhT+1t/0XSCTgXBwwujKDKvv/gNb/6iQu+T2yxL2bP2m
M0nGQ0lgUopWiLR5MOLIm0DjeaykL+CEPkKaIXPKeiy0TpR1sIQPaUthmjHaVoRX
nfeUrZwyZ4AYmrnOXqP8wj8wgtc1g7yy6JD0fIs6dCPfyX3fBtsGKmH/caecw+cX
hBBxTvF0Eij9rBgD/StARTk3xI8vJYWE2Koo7ZB2BIx2rtFDZGk=
=YQap
-----END PGP SIGNATURE-----

--ungulu337dgnhyys--
