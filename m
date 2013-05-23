From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 2/4] Thermal: dove: Remove redundant use of of_match_ptr
Date: Thu, 23 May 2013 10:58:59 -0400
Message-ID: <519E2EB3.2030502@ti.com>
References: <1368700091-6084-1-git-send-email-sachin.kamat@linaro.org> <1368700091-6084-2-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2CVIKQWPSJPHOSRHMELOM"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37629 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759346Ab3EWO7k (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 May 2013 10:59:40 -0400
In-Reply-To: <1368700091-6084-2-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pm@vger.kernel.org, eduardo.valentin@ti.com, rui.zhang@intel.com, patches@linaro.org, Andrew Lunn <andrew@lunn.ch>

------enig2CVIKQWPSJPHOSRHMELOM
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable


Rui,

On 16-05-2013 06:28, Sachin Kamat wrote:
> 'dove_thermal_id_table' is always compiled in and the driver
> is dependent on OF. Hence use of of_match_ptr is unnecessary.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Andrew Lunn <andrew@lunn.ch>

Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>


> ---



>  drivers/thermal/dove_thermal.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/thermal/dove_thermal.c b/drivers/thermal/dove_ther=
mal.c
> index 900479e..49f9a0a 100644
> --- a/drivers/thermal/dove_thermal.c
> +++ b/drivers/thermal/dove_thermal.c
> @@ -194,7 +194,7 @@ static struct platform_driver dove_thermal_driver =3D=
 {
>  	.driver =3D {
>  		.name =3D "dove_thermal",
>  		.owner =3D THIS_MODULE,
> -		.of_match_table =3D of_match_ptr(dove_thermal_id_table),
> +		.of_match_table =3D dove_thermal_id_table,
>  	},
>  };
> =20
>=20



------enig2CVIKQWPSJPHOSRHMELOM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlGeLrMACgkQCXcVR3XQvP1PLQEAyfRdy7A7w222JX6WSTpfavfB
rsRvIgUTLn7JjXO6RocBAK5XMZtv952dbN0MGqKRZFPAsbmTFei0iJ73yY0y4UzY
=QkIZ
-----END PGP SIGNATURE-----

------enig2CVIKQWPSJPHOSRHMELOM--
