From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/3] soc/tegra: bpmp: Implement generic PM domains
Date: Wed, 15 Mar 2017 14:45:27 +0100
Message-ID: <20170315134527.GB29259@ulmo.ba.sec>
References: <20170314191516.13083-1-thierry.reding@gmail.com>
 <20170314191516.13083-4-thierry.reding@gmail.com>
 <709fd66d-b8ca-5cb7-ba58-a64ee3363c96@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <709fd66d-b8ca-5cb7-ba58-a64ee3363c96-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stefan Kristiansson <stefank-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 14, 2017 at 08:46:52PM +0000, Jon Hunter wrote:
> On 14/03/17 19:15, Thierry Reding wrote:
[...]
> > diff --git a/drivers/soc/tegra/powergate-bpmp.c b/drivers/soc/tegra/pow=
ergate-bpmp.c
[...]
> > +static struct tegra_powergate *
> > +tegra_powergate_add(struct tegra_bpmp *bpmp,
> > +		    const struct tegra_powergate_info *info)
> > +{
> > +	struct tegra_powergate *powergate;
> > +	bool off;
> > +
> > +	off =3D !tegra_bpmp_powergate_is_powered(bpmp, info->id);
> > +
> > +	powergate =3D devm_kzalloc(bpmp->dev, sizeof(*powergate), GFP_KERNEL);
> > +	if (!powergate)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	powergate->id =3D info->id;
> > +	powergate->bpmp =3D bpmp;
> > +
> > +	powergate->genpd.name =3D kstrdup(info->name, GFP_KERNEL);
> > +	powergate->genpd.power_on =3D tegra_powergate_power_on;
> > +	powergate->genpd.power_off =3D tegra_powergate_power_off;
> > +
> > +	pm_genpd_init(&powergate->genpd, NULL, off);
>=20
> There was a recent change made so that pm_genpd_init() now returns
> success/failure so we should check it.

Okay, will do.

> > +static void tegra_powergate_remove(struct tegra_powergate *powergate)
> > +{
> > +	struct generic_pm_domain *genpd =3D &powergate->genpd;
> > +	struct tegra_bpmp *bpmp =3D powergate->bpmp;
> > +	int err;
> > +
> > +	err =3D pm_genpd_remove(genpd);
> > +	if (err < 0)
> > +		dev_err(bpmp->dev, "failed to remove power domain %s: %d\n",
> > +			genpd->name, err);
> > +
> > +	kfree(genpd->name);
>=20
> Should we still free the memory here on failure?

I think at this point we loose either way. In all current cases this
should not fail, since we only use this to remove domains on probe
failure, so before the provider is registered and before any devices
actually start using the domains.

In the case where we want to remove upon driver unload, it's fairly
unlikely that freeing the memory or not would be relevant. Not freeing
it would mean leaking the memory because the driver will go away and
hence there won't be a chance to clean up afterwards. And given that
the driver will disappear anyway, further access to the genpd is very
likely to cause a crash, due to some other resources being cleaned up
as part of the driver removal.

[...]
> > +int tegra_bpmp_init_powergates(struct tegra_bpmp *bpmp)
> > +{
> > +	struct device_node *np =3D bpmp->dev->of_node;
> > +	struct tegra_powergate_info *powergates;
> > +	struct device *dev =3D bpmp->dev;
> > +	unsigned int count, i;
> > +	int err;
> > +
> > +	err =3D tegra_bpmp_probe_powergates(bpmp, &powergates);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	count =3D err;
> > +
> > +	dev_dbg(dev, "%u power domains probed\n", count);
> > +
> > +	err =3D tegra_bpmp_add_powergates(bpmp, powergates, count);
> > +	if (err < 0)
> > +		goto free;
> > +
> > +	bpmp->genpd.xlate =3D tegra_powergate_xlate;
> > +
> > +	err =3D of_genpd_add_provider_onecell(np, &bpmp->genpd);
> > +	if (err < 0) {
> > +		dev_err(dev, "failed to add power domain provider: %d\n", err);
> > +		goto remove;
> > +	}
> > +
> > +free:
> > +	for (i =3D 0; i < count; i++)
> > +		kfree(powergates[i].name);
> > +
> > +	kfree(powergates);
> > +	return err;
> > +
> > +remove:
> > +	tegra_bpmp_remove_powergates(bpmp);
> > +	goto free;
>=20
> Nit ... why not move the call to tegra_bpmp_remove_powergates() to where
> we have the 'goto remove' and avoid this extra jump?

Yeah, I can do that. The original motivation for doing it this way was
to make it less error prone to leak the domains if new code was added,
but that seems fairly unlikely and we can catch that during review.

Thierry

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAljJRXcACgkQ3SOs138+
s6HnYQ//YRnrzmgKroPwh2xmE1XR39BkhN4dS5pUKz2DkeA4U+sqml/mq2AHZVzR
Y4uHaeIOPl/4+LEAY/bT4kIiSlNV0wW6Zc8Siv2UYe6q0dbzNWii5B/Ov+bCvxus
ZeSER0N9vmDTKMxX+DI4C7LLMlN4jaEHg3Z8AHTHZNg8fgGe+glwRiWOl0VLWzxn
cWFqYz/WjcI/6nrlO/aoc2ZtsYKy3mbqFC69wLMgI7OMiCfUwymcQsQUEAfzuMVn
h6A5vI2xbrhccULjoudkEcVdyX5M79/ZQyBtr2Eq3S9gQtuqf8xjncU1RnK4VG1R
4BhNwSAcPEI+L+6ncytlQ/zCos7VAPGwkqqvXeeQb/Xc2tmUUXoTmJcNisbc7QGD
L7jUBM+xXvSWv9d6EbCi0qPz3oUoAQB4aLDeOaj9+msrwzgs0jFDHku9HFNf5KWl
UVH4oQ0/5s2lKbWmmiIEwf3DUpPcFmYfz7f0T4F/mXcvjeehN5R/zeJyebO7Udhy
w0l5gXBUFDpZugbK1KQ9WYs+R1+23bk588VoIkqlhY59fRDu32ar/MHCko1baVJs
AGwOOctFdtqKqk15aDdTc637kAHrP9BOP5WQtWJHvN5rR0Y2T9WkPPs51dTY1+ya
p5vh9Fit/R+ejjQJrM0ZcuPZSiOGuYtpct6ylAviRSVDKlKo6I4=
=HQFq
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--
