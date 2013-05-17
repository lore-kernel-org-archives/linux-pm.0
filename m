From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH v3] thermal: cut the spaces when user sets policy
Date: Fri, 17 May 2013 08:43:01 -0400
Message-ID: <519625D5.7030002@ti.com>
References: <1368791522-12231-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2KMKTOHASENKNGMSFXIGX"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59665 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004Ab3EQMnX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 17 May 2013 08:43:23 -0400
In-Reply-To: <1368791522-12231-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, linux-pm@vger.kernel.org

------enig2KMKTOHASENKNGMSFXIGX
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 17-05-2013 07:52, Andy Shevchenko wrote:
> Setting policy results in invalid value error.
> 	% echo "step_wise" > policy
> 	% echo: write error: Invalid argument
>=20
> Need clean up of the buffer which "echo" may add based on the arguments=
, before
> comparing aganist list of governor names.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reported-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>
Tested-by: Eduardo Valentin <eduardo.valentin@ti.com>

Tested on panda OMAP4430. As this is not platform dependent, I am fine
with the test I did.

> ---
> Since v2:
>  - fix typo in variable definition block
>  drivers/thermal/thermal_core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_c=
ore.c
> index d755440..1067fb0 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -33,6 +33,7 @@
>  #include <linux/idr.h>
>  #include <linux/thermal.h>
>  #include <linux/reboot.h>
> +#include <linux/string.h>
>  #include <net/netlink.h>
>  #include <net/genetlink.h>
> =20
> @@ -713,10 +714,13 @@ policy_store(struct device *dev, struct device_at=
tribute *attr,
>  	int ret =3D -EINVAL;
>  	struct thermal_zone_device *tz =3D to_thermal_zone(dev);
>  	struct thermal_governor *gov;
> +	char name[THERMAL_NAME_LENGTH];
> +
> +	snprintf(name, sizeof(name), "%s", buf);
> =20
>  	mutex_lock(&thermal_governor_lock);
> =20
> -	gov =3D __find_governor(buf);
> +	gov =3D __find_governor(strim(name));
>  	if (!gov)
>  		goto exit;
> =20
>=20



------enig2KMKTOHASENKNGMSFXIGX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlGWJdUACgkQCXcVR3XQvP0qRQEAuVAKTYQ2GWQDRC4L1gM9FKu5
mb1eIxsp4rTXOA9za0IA/iP8e6NSHAbB0sx96Abct45fvqAfvREbXvi11ljBq7q3
=DBza
-----END PGP SIGNATURE-----

------enig2KMKTOHASENKNGMSFXIGX--
