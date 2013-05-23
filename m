From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 4/4] Thermal: spear: Remove redundant use of of_match_ptr
Date: Thu, 23 May 2013 11:01:24 -0400
Message-ID: <519E2F44.7030302@ti.com>
References: <1368700091-6084-1-git-send-email-sachin.kamat@linaro.org> <1368700091-6084-4-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2STFPOBSTQMOOAGDSRIQP"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46920 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759346Ab3EWPBm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 23 May 2013 11:01:42 -0400
In-Reply-To: <1368700091-6084-4-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pm@vger.kernel.org, eduardo.valentin@ti.com, rui.zhang@intel.com, patches@linaro.org, Vincenzo Frascino <vincenzo.frascino@st.com>, Viresh Kumar <viresh.kumar@linaro.org>

------enig2STFPOBSTQMOOAGDSRIQP
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rui,

On 16-05-2013 06:28, Sachin Kamat wrote:
> 'spear_thermal_id_table' is always compiled in and the driver
> is dependent on OF. Hence use of of_match_ptr is unnecessary.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Vincenzo Frascino <vincenzo.frascino@st.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>


Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>


> ---
>  drivers/thermal/spear_thermal.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_th=
ermal.c
> index 1a14eaa..dcb5f6f 100644
> --- a/drivers/thermal/spear_thermal.c
> +++ b/drivers/thermal/spear_thermal.c
> @@ -197,7 +197,7 @@ static struct platform_driver spear_thermal_driver =
=3D {
>  		.name =3D "spear_thermal",
>  		.owner =3D THIS_MODULE,
>  		.pm =3D &spear_thermal_pm_ops,
> -		.of_match_table =3D of_match_ptr(spear_thermal_id_table),
> +		.of_match_table =3D spear_thermal_id_table,
>  	},
>  };
> =20
>=20



------enig2STFPOBSTQMOOAGDSRIQP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlGeL0QACgkQCXcVR3XQvP0W0AD/bNHBp9vnvwpbOS74+IcckEFn
jzC7budQ6kPWjTgnC7oA/jG8De+7EBvFzxBk5cMNwXMU0SwauB+0LctbTdaQAErb
=ExVk
-----END PGP SIGNATURE-----

------enig2STFPOBSTQMOOAGDSRIQP--
