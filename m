From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH] thermal: step_wise: cdev only needs update on a new target
 state
Date: Wed, 29 May 2013 18:11:51 -0400
Message-ID: <51A67D27.9050502@ti.com>
References: <1369724148-15087-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2QSPGKFNVJSWHFMLWBTUN"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41563 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935228Ab3E2WMX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 29 May 2013 18:12:23 -0400
In-Reply-To: <1369724148-15087-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, eduardo.valentin@ti.com

------enig2QSPGKFNVJSWHFMLWBTUN
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rui,

On 28-05-2013 02:55, Shawn Guo wrote:
> The cooling device only needs update on a new target state.  Since we
> already check old target in thermal_zone_trip_update(), we can do one
> more check to see if it's a new target state.  If not, we can reasonabl=
y
> save some uncecesary code execution.
>=20

typo above:
s/uncecesary/unnecessary

> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---

A part from the above typo, I believe we must have this change in:

Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>

>  drivers/thermal/step_wise.c |    3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
> index 4d4ddae..0afbd86 100644
> --- a/drivers/thermal/step_wise.c
> +++ b/drivers/thermal/step_wise.c
> @@ -133,6 +133,9 @@ static void thermal_zone_trip_update(struct thermal=
_zone_device *tz, int trip)
>  		old_target =3D instance->target;
>  		instance->target =3D get_target_state(instance, trend, throttle);
> =20
> +		if (old_target =3D=3D instance->target)
> +			continue;
> +
>  		/* Activate a passive thermal instance */
>  		if (old_target =3D=3D THERMAL_NO_TARGET &&
>  			instance->target !=3D THERMAL_NO_TARGET)
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


------enig2QSPGKFNVJSWHFMLWBTUN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlGmfScACgkQCXcVR3XQvP2AsQEAhgJg1O6Ua4c2wgxRmWVuce2c
DamC0/k92EJw/uC/W28BAPHEvrmc4dEmyapbimcBxaY9+Ts1IdaOGmJ99NHqOCdB
=yyp4
-----END PGP SIGNATURE-----

------enig2QSPGKFNVJSWHFMLWBTUN--
