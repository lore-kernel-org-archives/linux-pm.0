From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 3/4] Thermal: kirkwood: Remove redundant use of of_match_ptr
Date: Thu, 23 May 2013 10:59:28 -0400
Message-ID: <519E2ED0.8070709@ti.com>
References: <1368700091-6084-1-git-send-email-sachin.kamat@linaro.org> <1368700091-6084-3-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2UCWBRKPPXPNSNQMWPDPD"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45997 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758416Ab3EWO7n (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 23 May 2013 10:59:43 -0400
In-Reply-To: <1368700091-6084-3-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pm@vger.kernel.org, eduardo.valentin@ti.com, rui.zhang@intel.com, patches@linaro.org, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

------enig2UCWBRKPPXPNSNQMWPDPD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rui,

On 16-05-2013 06:28, Sachin Kamat wrote:
> 'kirkwood_thermal_id_table' is always compiled in and the driver
> is dependent on OF. Hence use of of_match_ptr is unnecessary.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>



Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>


> ---
>  drivers/thermal/kirkwood_thermal.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/thermal/kirkwood_thermal.c b/drivers/thermal/kirkw=
ood_thermal.c
> index b57a45d..944ac49 100644
> --- a/drivers/thermal/kirkwood_thermal.c
> +++ b/drivers/thermal/kirkwood_thermal.c
> @@ -120,7 +120,7 @@ static struct platform_driver kirkwood_thermal_driv=
er =3D {
>  	.driver =3D {
>  		.name =3D "kirkwood_thermal",
>  		.owner =3D THIS_MODULE,
> -		.of_match_table =3D of_match_ptr(kirkwood_thermal_id_table),
> +		.of_match_table =3D kirkwood_thermal_id_table,
>  	},
>  };
> =20
>=20



------enig2UCWBRKPPXPNSNQMWPDPD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlGeLtAACgkQCXcVR3XQvP0uqQEAsLNcm2UsedulaYfZwsAl41ua
z6cX1mFb0brdxI2BGGEA/jZfxDQXSxKMvSrOBcXZvVF3TygINVXavb6hjOBXS8Rn
=iqUG
-----END PGP SIGNATURE-----

------enig2UCWBRKPPXPNSNQMWPDPD--
