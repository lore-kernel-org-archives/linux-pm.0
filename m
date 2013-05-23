From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 1/4] Thermal: armada: Remove redundant use of of_match_ptr
Date: Thu, 23 May 2013 10:58:03 -0400
Message-ID: <519E2E7B.2070506@ti.com>
References: <1368700091-6084-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2RCPUFRCRSDWRKPRRHXUA"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37572 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758360Ab3EWO6i (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 May 2013 10:58:38 -0400
In-Reply-To: <1368700091-6084-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pm@vger.kernel.org, eduardo.valentin@ti.com, rui.zhang@intel.com, patches@linaro.org, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

------enig2RCPUFRCRSDWRKPRRHXUA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rui,

On 16-05-2013 06:28, Sachin Kamat wrote:
> 'armada_thermal_id_table' is always compiled in and the driver
> is dependent on OF. Hence use of of_match_ptr is unnecessary.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>

> ---
>  drivers/thermal/armada_thermal.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_=
thermal.c
> index 0d02d4e..9426bbd 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -220,7 +220,7 @@ static struct platform_driver armada_thermal_driver=
 =3D {
>  	.driver =3D {
>  		.name =3D "armada_thermal",
>  		.owner =3D THIS_MODULE,
> -		.of_match_table =3D of_match_ptr(armada_thermal_id_table),
> +		.of_match_table =3D armada_thermal_id_table,
>  	},
>  };
> =20
>=20



------enig2RCPUFRCRSDWRKPRRHXUA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlGeLnsACgkQCXcVR3XQvP1X1QD/aRPPhKhpXf3qEJIPb+dNUxzO
veZR40KeM4HEU5CBGxcA/A3WIfl2/EP74g4dffjtLM/S4mWlpJxobLlMNqjrinRY
=72bl
-----END PGP SIGNATURE-----

------enig2RCPUFRCRSDWRKPRRHXUA--
