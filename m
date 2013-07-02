From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [RFC PATCH 6/6] Thermal: step_wise: set next cooling target explicitly
Date: Tue, 2 Jul 2013 17:03:49 -0400
Message-ID: <51D34035.3000008@ti.com>
References: <1371475468-5351-1-git-send-email-rui.zhang@intel.com> <1371475468-5351-7-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2LXRHHBSBAGFOKRNNSGCU"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60866 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755124Ab3GBVD5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Jul 2013 17:03:57 -0400
In-Reply-To: <1371475468-5351-7-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, eduardo.valentin@ti.com, durgadoss.r@intel.com, shawn.guo@linaro.org, ruslan.ruslichenko@ti.com

------enig2LXRHHBSBAGFOKRNNSGCU
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 17-06-2013 09:24, Zhang Rui wrote:
> Set the next target state explicitly for each thermal trend,
> in step_wise governor, to provide more readability, and to
> follow the cooling algorithm description strictly.


How about merging this one with patch 05?

>=20
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/thermal/step_wise.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
> index 53b56e6..ffa553f 100644
> --- a/drivers/thermal/step_wise.c
> +++ b/drivers/thermal/step_wise.c
> @@ -60,7 +60,6 @@ static unsigned long get_target_state(struct thermal_=
instance *instance,
>  	 * cdev in use to determine the next_target.
>  	 */
>  	cdev->ops->get_cur_state(cdev, &cur_state);
> -	next_target =3D instance->target;
> =20
>  	switch (trend) {
>  	case THERMAL_TREND_RAISING:
> @@ -69,11 +68,14 @@ static unsigned long get_target_state(struct therma=
l_instance *instance,
>  				    (cur_state + 1) : instance->upper;
>  			if (next_target < instance->lower)
>  				next_target =3D instance->lower;
> -		}
> +		} else
> +			next_target =3D instance->target;
>  		break;
>  	case THERMAL_TREND_RAISE_FULL:
>  		if (throttle)
>  			next_target =3D instance->upper;
> +		else
> +			next_target =3D instance->target;
>  		break;
>  	case THERMAL_TREND_DROPPING:
>  		if (throttle) {
> @@ -99,7 +101,10 @@ static unsigned long get_target_state(struct therma=
l_instance *instance,
>  		break;
>  	case THERMAL_TREND_STABLE:
>  		/* Do nothing */
> +		next_target =3D instance->target;
> +		break;
>  	default:
> +		next_target =3D instance->target;
>  		break;


The above could be rewritten like this:
  	case THERMAL_TREND_STABLE:
  		/* Do nothing */
  	default:
 		next_target =3D instance->target;
  		break;

>  	}
> =20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


------enig2LXRHHBSBAGFOKRNNSGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlHTQDUACgkQCXcVR3XQvP3hFgEAyF0fZMuh6BdNTKpj7VLIGqeS
BPkbOAW3018QK71kDrUA/j2SBLUy3hZekMU4LJ99EojOzgr2N736/P/lHRWX4Rxk
=aVxb
-----END PGP SIGNATURE-----

------enig2LXRHHBSBAGFOKRNNSGCU--
