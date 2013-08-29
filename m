From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 2/3] thermal: exynos: Fix potential NULL pointer dereference
Date: Thu, 29 Aug 2013 08:17:21 -0400
Message-ID: <521F3BD1.1010803@ti.com>
References: <1376893723-22138-1-git-send-email-sachin.kamat@linaro.org> <1376893723-22138-2-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UoV59grf9h4kDqIQ3qGi140mLCvefJJds"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43964 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751715Ab3H2MRc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 29 Aug 2013 08:17:32 -0400
In-Reply-To: <1376893723-22138-2-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pm@vger.kernel.org, jonghwa3.lee@samsung.com, eduardo.valentin@ti.com, rui.zhang@intel.com, amit.daniel@samsung.com, patches@linaro.org

--UoV59grf9h4kDqIQ3qGi140mLCvefJJds
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 19-08-2013 02:28, Sachin Kamat wrote:
> NULL pointer was being dereferenced in its own error message.
> Changed it to the correct device pointer.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>


Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>

> ---
>  drivers/thermal/samsung/exynos_thermal_common.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/thermal/samsung/exynos_thermal_common.c b/drivers/=
thermal/samsung/exynos_thermal_common.c
> index 4d8e444..f10a6ad 100644
> --- a/drivers/thermal/samsung/exynos_thermal_common.c
> +++ b/drivers/thermal/samsung/exynos_thermal_common.c
> @@ -53,7 +53,7 @@ static int exynos_set_mode(struct thermal_zone_device=
 *thermal,
>  {
>  	struct exynos_thermal_zone *th_zone =3D thermal->devdata;
>  	if (!th_zone) {
> -		dev_err(th_zone->sensor_conf->dev,
> +		dev_err(&thermal->device,
>  			"thermal zone not registered\n");
>  		return 0;
>  	}
> @@ -231,7 +231,7 @@ static int exynos_get_temp(struct thermal_zone_devi=
ce *thermal,
>  	void *data;
> =20
>  	if (!th_zone->sensor_conf) {
> -		dev_err(th_zone->sensor_conf->dev,
> +		dev_err(&thermal->device,
>  			"Temperature sensor not initialised\n");
>  		return -EINVAL;
>  	}
> @@ -251,7 +251,7 @@ static int exynos_set_emul_temp(struct thermal_zone=
_device *thermal,
>  	struct exynos_thermal_zone *th_zone =3D thermal->devdata;
> =20
>  	if (!th_zone->sensor_conf) {
> -		dev_err(th_zone->sensor_conf->dev,
> +		dev_err(&thermal->device,
>  			"Temperature sensor not initialised\n");
>  		return -EINVAL;
>  	}
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--UoV59grf9h4kDqIQ3qGi140mLCvefJJds
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlIfO9IACgkQCXcVR3XQvP1WmgD9EEhCxNGQDiC2XR0PdkR3YLzO
Bmvk+/tssBjW1XfQXEoBAIUEQ2LiSZOAV0snFkUAAEpROS11i/9Lr6SGhxW6U8uF
=IU6z
-----END PGP SIGNATURE-----

--UoV59grf9h4kDqIQ3qGi140mLCvefJJds--
