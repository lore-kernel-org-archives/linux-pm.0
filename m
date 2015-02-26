From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v2] cpufreq: exynos: Use simple approach to asses if cpu
 cooling can be used
Date: Thu, 26 Feb 2015 14:25:38 -0400
Message-ID: <20150226182536.GA4941@developer.amazonguestwifi.org>
References: <20150204100025.565ee2b0@amdc2363>
 <1423151689-27490-1-git-send-email-l.majewski@samsung.com>
 <20150226113624.2caa3b4c@amdc2363>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150226113624.2caa3b4c@amdc2363>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2015 at 11:36:24AM +0100, Lukasz Majewski wrote:
> Hi Eduardo,
>=20
> > Commit: e725d26c4857e5e41975b5e74e64ce6ab09a7121 provided possibility
> > to use device tree to asses if cpu can be used as cooling device.
> > Since the code was somewhat awkward, simpler approach has been
> > proposed.
> >=20
> > Test HW: Exynos 4412 - Odroid U3.
> >=20
> > Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>=20
> This patch is also missing from linux-thermal-soc tree.
>=20
> I will add it to samsung thermal tree, since Viresh has ACK'ed it.

Do we have any dependency with something which is only in the thermal
tree(s)? If not, I suggest the cpufreq changes go via cpufreq tree(s).


BR,

Eduardo Valentin

>=20
> > ---
> > Changes for v2:
> > - Remove superfluous *np pointer
> > ---
> >  drivers/cpufreq/exynos-cpufreq.c | 21 ++++++---------------
> >  1 file changed, 6 insertions(+), 15 deletions(-)
> >=20
> > diff --git a/drivers/cpufreq/exynos-cpufreq.c
> > b/drivers/cpufreq/exynos-cpufreq.c index 5e98c6b..82d2fbb 100644
> > --- a/drivers/cpufreq/exynos-cpufreq.c
> > +++ b/drivers/cpufreq/exynos-cpufreq.c
> > @@ -159,7 +159,7 @@ static struct cpufreq_driver exynos_driver =3D {
> > =20
> >  static int exynos_cpufreq_probe(struct platform_device *pdev)
> >  {
> > -	struct device_node *cpus, *np;
> > +	struct device_node *cpu0;
> >  	int ret =3D -EINVAL;
> > =20
> >  	exynos_info =3D kzalloc(sizeof(*exynos_info), GFP_KERNEL);
> > @@ -206,28 +206,19 @@ static int exynos_cpufreq_probe(struct
> > platform_device *pdev) if (ret)
> >  		goto err_cpufreq_reg;
> > =20
> > -	cpus =3D of_find_node_by_path("/cpus");
> > -	if (!cpus) {
> > -		pr_err("failed to find cpus node\n");
> > +	cpu0 =3D of_get_cpu_node(0, NULL);
> > +	if (!cpu0) {
> > +		pr_err("failed to find cpu0 node\n");
> >  		return 0;
> >  	}
> > =20
> > -	np =3D of_get_next_child(cpus, NULL);
> > -	if (!np) {
> > -		pr_err("failed to find cpus child node\n");
> > -		of_node_put(cpus);
> > -		return 0;
> > -	}
> > -
> > -	if (of_find_property(np, "#cooling-cells", NULL)) {
> > -		cdev =3D of_cpufreq_cooling_register(np,
> > +	if (of_find_property(cpu0, "#cooling-cells", NULL)) {
> > +		cdev =3D of_cpufreq_cooling_register(cpu0,
> >  						   cpu_present_mask);
> >  		if (IS_ERR(cdev))
> >  			pr_err("running cpufreq without cooling
> > device: %ld\n", PTR_ERR(cdev));
> >  	}
> > -	of_node_put(np);
> > -	of_node_put(cpus);
> > =20
> >  	return 0;
> > =20
>=20
>=20
>=20
> --=20
> Best regards,
>=20
> Lukasz Majewski
>=20
> Samsung R&D Institute Poland (SRPOL) | Linux Platform Group

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU72UYAAoJEMLUO4d9pOJWYagH/1NpwUrJ30nrMppeXG/bEzpa
sEKwhtn2QR6VBIU6I5/JKI+o3lVulh/+myUC5wK01X0ws6SkoZvmTW91XJZL0/21
iXIbu635QkhRpuskmQV7/flPwoIDGb/Zue6chHQwENoKC1E3xvaGQkpzHU3jWmZa
78V0yy93W9w7/nE/8tqaKKxDVU/kPa9daA76Gver+1GUe4jpK1ye7Vw7LExqIdOX
As99BivYAvjNHRZvlktEYYLbKxTM86xKhUGDUbySnNnQDV6/4J/LfIlRbsG9trXy
Bkr/C/YYmiLS4V3XAJBhO0WMOC0z1XFh8gu9FWhR+E00rkM2e6/2FyCVQmVDgVA=
=mqi/
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
