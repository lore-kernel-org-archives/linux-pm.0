From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V6 01/10] PM / Domains: Fix removal of a subdomain
Date: Mon, 29 Feb 2016 07:58:07 +0100
Message-ID: <20160229065807.GE23745@ulmo>
References: <1456501724-28477-1-git-send-email-jonathanh@nvidia.com>
 <1456501724-28477-2-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C94crkcyjafcjHxo"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1456501724-28477-2-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--C94crkcyjafcjHxo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 26, 2016 at 03:48:35PM +0000, Jon Hunter wrote:
> Commit 30e7a65b3fdb ("PM / Domains: Ensure subdomain is not in use
> before removing") added a test to ensure that a subdomain is not is not

Double "is not".

> a master to another subdomain or if any devices are using the subdomain
> before removing. This change incorrectly used the "slave_links" list to
> determine if the subdomain is a master to another subdomain, where it
> should have been using the "master_links" list instead. The
> "slave_links" list will never be empty for a subdomain and so a
> subdomain can never be removed. Fix this by testing if the
> "master_links" list is empty instead.
>=20
> Fixes: 30e7a65b3fdb ("PM / Domains: Ensure subdomain is not in use
>        before removing")
>=20
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

I think the Fixes: line is allowed to be longer than 72 characters (the
important bits are in the first few characters anyway) and it doesn't
need to be separated from other tags by a blank line. That said, I doubt
that any of the automation tools will be confused.

Other than that, the change looks correct:

Reviewed-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

> ---
>  drivers/base/power/domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index e8ca290dbf9d..ea9f2aa3fc33 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1382,7 +1382,7 @@ int pm_genpd_remove_subdomain(struct generic_pm_dom=
ain *genpd,
>  	mutex_lock(&subdomain->lock);
>  	mutex_lock_nested(&genpd->lock, SINGLE_DEPTH_NESTING);
> =20
> -	if (!list_empty(&subdomain->slave_links) || subdomain->device_count) {
> +	if (!list_empty(&subdomain->master_links) || subdomain->device_count) {
>  		pr_warn("%s: unable to remove subdomain %s\n", genpd->name,
>  			subdomain->name);
>  		ret =3D -EBUSY;
> --=20
> 2.1.4
>=20

--C94crkcyjafcjHxo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJW0+v/AAoJEN0jrNd/PrOhBQsQAL4aingDm5ZGthwZdxXxj0Z9
meJmEQ3UAphSwBXm1PFhTIprFZrPMiP2j8RvatGgvDJ1GyVPpgL8PBBrtNRVqw0J
0vEgJoaC09ZFIetcm2i+cktUP+8qy0q82S9v1NcO/YdD3QLtEHHYgW9kbvfkP7VF
zzHMHZ71wusZcoY4TG1kS9pY9IOqS6DXSWnIndZ3Y+Bjof5vOLG4OqItPOw9t2hX
g518xhowtDr5QEb6bb9t8efjC0v9fsClN9WDD0gLf1Wa+Zdnftc9uUXGnLYuNkWv
EdcVeus7QfdlS70BEUN4UXcLxU8yRFTQP7BCRnGyh2XRJUqy4CMDZnPMjFOTK7uI
rxPSOHw21wFPAT6mEXpaPBPIMAlzCoFFcsxNV3FRfW7N6ieX/Ngd9d33U3lfvrZY
jwsigsfIU5DiYTmBuo8TfySVXJeGd7gH4d+pxtXTw7ZJCofvPHkSHesUvin4+G8p
uGHForoAzgNoyrgNcQ4QzxgShm4Rc/nL0RNj+alrv3AiD0la7cFBruSMZauLOaMM
JaCcNmGVBkuXKdBLWCgtG3rNj8UnR0OxB+2GX6h6rEZWYwvwWJjWGLuQig3Kb/Nl
jso/whhLY4aV4M5UY4O3ghnRVoyjardmK8AbM/g1cqKMCRt1UsRSydeimeJrBLFK
SRqOHnGT1us5vBXYccjL
=RwsO
-----END PGP SIGNATURE-----

--C94crkcyjafcjHxo--
