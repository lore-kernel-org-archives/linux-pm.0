From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH] thermal: thermal_core: policy store via sysfs is broken
Date: Mon, 3 Jun 2013 10:59:36 -0400
Message-ID: <51ACAF58.9060301@ti.com>
References: <1370267943-13297-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2GQHXKPWGVENVQEWVUQXF"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48004 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757296Ab3FCPAT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jun 2013 11:00:19 -0400
In-Reply-To: <1370267943-13297-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, linux-arm-kernel@lists.infradead.org

------enig2GQHXKPWGVENVQEWVUQXF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Shawn,

On 03-06-2013 09:59, Shawn Guo wrote:
> When function __find_governor() gets called from policy_store(), the
> argument 'buf' has a '\n' character at the end.  This causes strnicmp()=

> mismatches all the time.  Consequently, policy_store() will always
> return -EINVAL, and hence the policy store via sysfs will always fail
> even when users store a correct policy name.
>=20
> Fix the problem by using strncasecmp() for policy name matching in
> __find_governor().
>=20
Thanks for your patch, but Andy has fixed this issue already here:

http://git.kernel.org/cgit/linux/kernel/git/rzhang/linux.git/commit/?h=3D=
next&id=3D42a5bf507d7f7ecbf606eb392dd9d2e4d009c36b

Patch is present in thermal/next.


> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/thermal/thermal_core.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_c=
ore.c
> index d755440..6ba869f 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -57,9 +57,10 @@ static struct thermal_governor *__find_governor(cons=
t char *name)
>  {
>  	struct thermal_governor *pos;
> =20
> -	list_for_each_entry(pos, &thermal_governor_list, governor_list)
> -		if (!strnicmp(name, pos->name, THERMAL_NAME_LENGTH))
> +	list_for_each_entry(pos, &thermal_governor_list, governor_list) {
> +		if (!strncasecmp(name, pos->name, strlen(pos->name)))
>  			return pos;
> +	}
> =20
>  	return NULL;
>  }
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


------enig2GQHXKPWGVENVQEWVUQXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlGsr1gACgkQCXcVR3XQvP3JUQEAtZW4CLUZe1ynfYsQQu2NOjA+
kuqAoFN4xvRG82LnHUIBAPwBqB7KIQyAX4mzGPcn5/gmlGGXwLCjHZ/pzS5p11fm
=a80V
-----END PGP SIGNATURE-----

------enig2GQHXKPWGVENVQEWVUQXF--
