From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH] thermal: cut the spaces when user sets policy
Date: Fri, 3 May 2013 11:33:59 -0400
Message-ID: <5183D8E7.8040708@ti.com>
References: <1367589128-19787-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2PCWOKFBXUTLQFWFDXDFK"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37305 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932944Ab3ECPeQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 3 May 2013 11:34:16 -0400
In-Reply-To: <1367589128-19787-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, linux-pm@vger.kernel.org

------enig2PCWOKFBXUTLQFWFDXDFK
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Andy,

On 03-05-2013 09:52, Andy Shevchenko wrote:
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
> ---
>  drivers/thermal/thermal_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_c=
ore.c
> index d755440..a637be5 100644
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
> @@ -716,7 +717,7 @@ policy_store(struct device *dev, struct device_attr=
ibute *attr,
> =20
>  	mutex_lock(&thermal_governor_lock);
> =20
> -	gov =3D __find_governor(buf);
> +	gov =3D __find_governor(strim(buf));

I am much happier with this approach, much cleaner and does the job. On
the other hand, this patch introduces a compilation warning that we want
to avoid:
drivers/thermal/thermal_sys.c: In function 'policy_store':
drivers/thermal/thermal_sys.c:708: warning: passing argument 1 of
'strim' discards qualifiers from pointer target type
include/linux/string.h:63: note: expected 'char *' but argument is of
type 'const char *'



>  	if (!gov)
>  		goto exit;
> =20
>=20



------enig2PCWOKFBXUTLQFWFDXDFK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlGD2OgACgkQCXcVR3XQvP0ooAD/fLoOToEcPAZPL8DS4KZTMXGq
zDZufeI4b7NIIXcjTSMBAJGquj8mLgGoP8ux0ao7Y/Db362tsBtM4XHbgIMP7yYh
=/eey
-----END PGP SIGNATURE-----

------enig2PCWOKFBXUTLQFWFDXDFK--
