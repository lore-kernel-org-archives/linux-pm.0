From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [RFC PATCH 3/6] Thermal: fix step_wise handling of THERMAL_TREND_DROPPING
Date: Tue, 2 Jul 2013 16:57:13 -0400
Message-ID: <51D33EA9.7090005@ti.com>
References: <1371475468-5351-1-git-send-email-rui.zhang@intel.com> <1371475468-5351-4-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2BRGNHXGMKKDSNKUCURRA"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60587 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754283Ab3GBU5e (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Jul 2013 16:57:34 -0400
In-Reply-To: <1371475468-5351-4-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, eduardo.valentin@ti.com, durgadoss.r@intel.com, shawn.guo@linaro.org, ruslan.ruslichenko@ti.com

------enig2BRGNHXGMKKDSNKUCURRA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 17-06-2013 09:24, Zhang Rui wrote:
> Fixes two problems in the THERMAL_TREND_DROPPING
> handling code in step_wise governor.
> 1. When the temperature is higher than the trip point,
> we should not deactivate the thermal instance.

When temperature is higher than trip point, should it then get the
actions of the next trip point?

Does it mean that with this patch, all thermal instances assigned to
trip points below the cur temperature would be activated, right?

> 2. When the temperature is lower than the trip point,
> we should not activate the thermal instance.
>=20

When would they get activated then?


> Also rephrase the code a bit to make it more readable.
>=20
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/thermal/step_wise.c |   18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
> index d89e781..f0cc5e5 100644
> --- a/drivers/thermal/step_wise.c
> +++ b/drivers/thermal/step_wise.c
> @@ -75,13 +75,19 @@ static unsigned long get_target_state(struct therma=
l_instance *instance,
>  			next_target =3D instance->upper;
>  		break;
>  	case THERMAL_TREND_DROPPING:
> -		if (cur_state =3D=3D instance->lower) {
> -			if (!throttle)
> -				next_target =3D THERMAL_NO_TARGET;
> +		if (throttle) {
> +			if (cur_state <=3D instance->lower)
> +				next_target =3D instance->lower;
> +			else
> +				next_target =3D cur_state > instance->upper ?
> +					instance->upper : cur_state - 1;
>  		} else {
> -			next_target =3D cur_state - 1;
> -			if (next_target > instance->upper)
> -				next_target =3D instance->upper;
> +			if (cur_state <=3D instance->lower ||
> +			    instance->target =3D=3D THERMAL_NO_TARGET)
> +				next_target =3D THERMAL_NO_TARGET;
> +			else
> +				next_target =3D cur_state > instance->upper ?
> +					instance->upper : cur_state - 1;
>  		}
>  		break;
>  	case THERMAL_TREND_DROP_FULL:
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


------enig2BRGNHXGMKKDSNKUCURRA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlHTPqkACgkQCXcVR3XQvP1vvgEAt1UniA0voXdRY4YTyT0iSy5+
UeTs7XKQkovbCuyxwd8A/1lUZexAlKFibdz9ceEf7tS7/nr0v1alLt+9cEd9j3Q2
=s5QT
-----END PGP SIGNATURE-----

------enig2BRGNHXGMKKDSNKUCURRA--
