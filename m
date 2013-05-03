From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 6/6] Thermal: spear: Remove redundant platform_set_drvdata()
Date: Fri, 3 May 2013 08:51:44 -0400
Message-ID: <5183B2E0.7040300@ti.com>
References: <1367575034-18432-1-git-send-email-sachin.kamat@linaro.org> <1367575034-18432-6-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2IEWRJTOMARHRLCQVSOTJ"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60956 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426Ab3ECMv5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 May 2013 08:51:57 -0400
In-Reply-To: <1367575034-18432-6-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pm@vger.kernel.org, eduardo.valentin@ti.com, rui.zhang@intel.com, patches@linaro.org, Vincenzo Frascino <vincenzo.frascino@st.com>

------enig2IEWRJTOMARHRLCQVSOTJ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03-05-2013 05:57, Sachin Kamat wrote:
> Commit 0998d06310 (device-core: Ensure drvdata =3D NULL when no
> driver is bound) removes the need to set driver data field to
> NULL.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Vincenzo Frascino <vincenzo.frascino@st.com>


Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>

> ---
>  drivers/thermal/spear_thermal.c |    1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_th=
ermal.c
> index 3c5ee56..1a14eaa 100644
> --- a/drivers/thermal/spear_thermal.c
> +++ b/drivers/thermal/spear_thermal.c
> @@ -174,7 +174,6 @@ static int spear_thermal_exit(struct platform_devic=
e *pdev)
>  	struct spear_thermal_dev *stdev =3D spear_thermal->devdata;
> =20
>  	thermal_zone_device_unregister(spear_thermal);
> -	platform_set_drvdata(pdev, NULL);
> =20
>  	/* Disable SPEAr Thermal Sensor */
>  	actual_mask =3D readl_relaxed(stdev->thermal_base);
>=20



------enig2IEWRJTOMARHRLCQVSOTJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlGDsuAACgkQCXcVR3XQvP1VIQD+O7nMsCTdv/l0OMfPdrEBCPWi
3OMa/28RbX2q/7qvHwQBANYQcyItqAZ9EIvjqp+zVbvCOnv/738jcr3S7LbtxNDC
=ydE+
-----END PGP SIGNATURE-----

------enig2IEWRJTOMARHRLCQVSOTJ--
