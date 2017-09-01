From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] thermal: tegra: dereference the pointer after null check
Date: Fri, 1 Sep 2017 21:08:35 +0200
Message-ID: <20170901190835.GA14011@ulmo>
References: <1504223549-4152-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1504223549-4152-1-git-send-email-nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srikars-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 31, 2017 at 04:52:29PM -0700, Nicolin Chen wrote:
> The dev pointer is going through a null check after a dereference.
> So this patch just reverses that.
>=20
> Signed-off-by: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/thermal/tegra/soctherm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soc=
therm.c
> index 7d2db23..6718799 100644
> --- a/drivers/thermal/tegra/soctherm.c
> +++ b/drivers/thermal/tegra/soctherm.c
> @@ -478,7 +478,7 @@ static int throttrip_program(struct device *dev,
>  			     struct soctherm_throt_cfg *stc,
>  			     int trip_temp)
>  {
> -	struct tegra_soctherm *ts =3D dev_get_drvdata(dev);
> +	struct tegra_soctherm *ts;
>  	int temp, cpu_throt, gpu_throt;
>  	unsigned int throt;
>  	u32 r, reg_off;
> @@ -486,6 +486,8 @@ static int throttrip_program(struct device *dev,
>  	if (!dev || !sg || !stc || !stc->init)
>  		return -EINVAL;
> =20
> +	ts =3D dev_get_drvdata(dev);
> +
>  	temp =3D enforce_temp_range(dev, trip_temp) / ts->soc->thresh_grain;
> =20
>  	/* Hardcode LIGHT on LEVEL1 and HEAVY on LEVEL2 */

I don't see a case where dev is ever going to be NULL here. Therefore, I
think a better patch would be to just drop the !dev test and leave the
rest of the code as-is.

Thierry

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmpsDMACgkQ3SOs138+
s6EOOg/+IM+0UWG3Yx3S+2w7WKPD+DDOhYYdWZHCqZnTosfh8eLyKsb/pH/+Bv9d
uPI87R5fCSPSuhmnvTiwcG0F1bUfm9F9JwY9HUnn3APj6dlQuVlhmec9ZxajOjAQ
Pk4k3jC2ZZrMWyp4EchQ0RMlYJ2Ext391EiMuPYihGAmkQzgT+Y4SxeQ3SeMDNx8
Gyiij9yNSJ3CTX56oRDhTbctNpwUJqeIK0/eWcIecDiqS6cDU0o+vfbJ98z3MlhR
ZnIIqWyK2Fey3qHYBQNe6JaZ3LIyJ7pJLeLx6+2V8N3A+Yf2OerpgRJxq5TGRVYV
gubaKVWrWqFoRvnqE9EWa3GXCwjYaShshm+9tX6LthADrCdOyLNMflnsuEQHCneq
tUbZozIy+OWCZIApxJps834PJ4EK6uEUWre9ZXXRuVmNcaGYYGbBGVEJePS71eca
ekAP/pNEhx88Tm+tRALauUAMaSUqBEa0bARAjGLzOr288DE5rsTNWxOrAry0Pv+Q
H8C9aWB0MR6LvsI5DYSfFT2GcGECsTLUz9XFwl4dUXPrw/XjVFR6JlikGL2RVa00
XEoz531i6o/UAkTgTh/f8GdQYfZkY48vqRNZSRm7htOOzLHrCiTamEkcvQeMVB2T
ZcxkoauLy7zJN5F7xydtRZqXBJWAPaYTa+xreod9N0iIvxflL+w=
=MJSP
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
