From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCHv2] thermal: cut the spaces when user sets policy
Date: Wed, 8 May 2013 11:31:38 -0400
Message-ID: <518A6FDA.6040006@ti.com>
References: <1367936460-15257-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2CJVICMWEEDGMEXVFBOOF"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47471 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181Ab3EHPbw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 May 2013 11:31:52 -0400
In-Reply-To: <1367936460-15257-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, linux-pm@vger.kernel.org

------enig2CJVICMWEEDGMEXVFBOOF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Andy,



On 07-05-2013 10:21, Andy Shevchenko wrote:
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

This one was close..

> ---
> In v2:
>  - copy input string to a temporary buffer
>  drivers/thermal/thermal_core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_c=
ore.c
> index d755440..e256380 100644
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
> +	char *name[THERMAL_NAME_LENGTH];

I really believe you meant:
 +	char name[THERMAL_NAME_LENGTH];

> +
> +	snprintf(name, sizeof(name), "%s", buf);
> =20

Still there are compilation warnings.

>  	mutex_lock(&thermal_governor_lock);
> =20
> -	gov =3D __find_governor(buf);
> +	gov =3D __find_governor(strim(name));
>  	if (!gov)
>  		goto exit;
> =20
>=20



------enig2CJVICMWEEDGMEXVFBOOF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlGKb9sACgkQCXcVR3XQvP3YgwEArG51iuluotuBltUkRAXtTUKv
Wj8cxuhLAVbYxXZhcSkA/1N38L+yVC5qcvrRVhANn5TvZmAAcGpRdklYuYNONohf
=paii
-----END PGP SIGNATURE-----

------enig2CJVICMWEEDGMEXVFBOOF--
