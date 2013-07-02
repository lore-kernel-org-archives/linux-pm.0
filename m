From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [RFC PATCH 4/6] Thermal: fix step_wise handling of THERMAL_TREND_DROP_EFULL
Date: Tue, 2 Jul 2013 17:11:17 -0400
Message-ID: <51D341F5.8080905@ti.com>
References: <1371475468-5351-1-git-send-email-rui.zhang@intel.com> <1371475468-5351-5-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2ECBQBKBCQXXFWAJHBXOO"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37185 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753510Ab3GBVLZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Jul 2013 17:11:25 -0400
In-Reply-To: <1371475468-5351-5-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, eduardo.valentin@ti.com, durgadoss.r@intel.com, shawn.guo@linaro.org, ruslan.ruslichenko@ti.com

------enig2ECBQBKBCQXXFWAJHBXOO
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On subject s/THERMAL_TREND_DROP_EFULL/THERMAL_TREND_DROP_FULL/g

On 17-06-2013 09:24, Zhang Rui wrote:
> Change the step_wise cooling algorithm to handle
> THERMAL_TREND_DROP_FULL a bit differently.
>=20
> When the temperature is higher than the trip point,
> we should always use the instance->lower as the next target state.
> When the temperature is lower than the trip point,
> we should always deactive the thermal instance.

s/deactive/deactivate/g


Are you expecting to optimize the system in which way by doing this
change? In which situation we would need to set to instance->lower if we
are at a state which trend is dropping fully?

>=20
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/thermal/step_wise.c |   12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
> index f0cc5e5..84d6e90 100644
> --- a/drivers/thermal/step_wise.c
> +++ b/drivers/thermal/step_wise.c
> @@ -42,9 +42,8 @@
>   *       state for this trip point, if the cooling state already
>   *       equals lower limit, deactivate the thermal instance
>   *    c. if the trend is THERMAL_TREND_RAISE_FULL, do nothing
> - *    d. if the trend is THERMAL_TREND_DROP_FULL, use lower limit,
> - *       if the cooling state already equals lower limit,
> - *       deactive the thermal instance
> + *    d. if the trend is THERMAL_TREND_DROP_FULL, deactive
> + *	 the thermal instance
>   */
>  static unsigned long get_target_state(struct thermal_instance *instanc=
e,
>  				enum thermal_trend trend, bool throttle)
> @@ -91,11 +90,10 @@ static unsigned long get_target_state(struct therma=
l_instance *instance,
>  		}
>  		break;
>  	case THERMAL_TREND_DROP_FULL:
> -		if (cur_state =3D=3D instance->lower) {
> -			if (!throttle)
> -				next_target =3D THERMAL_NO_TARGET;
> -		} else
> +		if (throttle)
>  			next_target =3D instance->lower;
> +		else
> +			next_target =3D THERMAL_NO_TARGET;
>  		break;
>  	default:
>  		break;
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


------enig2ECBQBKBCQXXFWAJHBXOO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlHTQfUACgkQCXcVR3XQvP3/hgD9HosoFXMEB6cB4PVrC7Ltbf3Y
2PruzAqEmpJO/yhHrDEBAKp44CGdEsednUivTkuNMYtnWiXrj9FPRHHrJWpJw+T5
=76qV
-----END PGP SIGNATURE-----

------enig2ECBQBKBCQXXFWAJHBXOO--
