From: Lukasz Majewski <l.majewski@majess.pl>
Subject: Re: [PATCH v2] cpufreq: exynos: Use simple approach to asses if cpu
 cooling can be used
Date: Thu, 26 Feb 2015 22:23:02 +0100
Message-ID: <20150226222302.38adb3bd@jawa>
References: <20150204100025.565ee2b0@amdc2363>
	<1423151689-27490-1-git-send-email-l.majewski@samsung.com>
	<20150226113624.2caa3b4c@amdc2363>
	<20150226182536.GA4941@developer.amazonguestwifi.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/03qG/HPXUNi//tRCteDCNC7"; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:35151 "EHLO
	4.mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169AbbBZVXf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Feb 2015 16:23:35 -0500
Received: from mail645.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with SMTP id 86A60FFB202
	for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2015 22:23:33 +0100 (CET)
In-Reply-To: <20150226182536.GA4941@developer.amazonguestwifi.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>

--Sig_/03qG/HPXUNi//tRCteDCNC7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eduardo,

> On Thu, Feb 26, 2015 at 11:36:24AM +0100, Lukasz Majewski wrote:
> > Hi Eduardo,
> >=20
> > > Commit: e725d26c4857e5e41975b5e74e64ce6ab09a7121 provided
> > > possibility to use device tree to asses if cpu can be used as
> > > cooling device. Since the code was somewhat awkward, simpler
> > > approach has been proposed.
> > >=20
> > > Test HW: Exynos 4412 - Odroid U3.
> > >=20
> > > Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> >=20
> > This patch is also missing from linux-thermal-soc tree.
> >=20
> > I will add it to samsung thermal tree, since Viresh has ACK'ed it.
>=20
> Do we have any dependency with something which is only in the thermal
> tree(s)? If not, I suggest the cpufreq changes go via cpufreq tree(s).

As fair as I remember, Viresh didn't mind if this patch would go via
thermal tree, since it is an integral part of the thermal solution for
Exynos.

Frankly, I'm for keeping all "related" patches in one tree
(especially when somebody already ACKed the patch) and not split them
into several trees.

Look how bad things look now with thermal DTS patches .... If we would
have taken them all at once, we hadn't had current problems.

Best regards,
Lukasz Majewski

>=20
>=20
> BR,
>=20
> Eduardo Valentin
>=20
> >=20
> > > ---
> > > Changes for v2:
> > > - Remove superfluous *np pointer
> > > ---
> > >  drivers/cpufreq/exynos-cpufreq.c | 21 ++++++---------------
> > >  1 file changed, 6 insertions(+), 15 deletions(-)
> > >=20
> > > diff --git a/drivers/cpufreq/exynos-cpufreq.c
> > > b/drivers/cpufreq/exynos-cpufreq.c index 5e98c6b..82d2fbb 100644
> > > --- a/drivers/cpufreq/exynos-cpufreq.c
> > > +++ b/drivers/cpufreq/exynos-cpufreq.c
> > > @@ -159,7 +159,7 @@ static struct cpufreq_driver exynos_driver =3D {
> > > =20
> > >  static int exynos_cpufreq_probe(struct platform_device *pdev)
> > >  {
> > > -	struct device_node *cpus, *np;
> > > +	struct device_node *cpu0;
> > >  	int ret =3D -EINVAL;
> > > =20
> > >  	exynos_info =3D kzalloc(sizeof(*exynos_info), GFP_KERNEL);
> > > @@ -206,28 +206,19 @@ static int exynos_cpufreq_probe(struct
> > > platform_device *pdev) if (ret)
> > >  		goto err_cpufreq_reg;
> > > =20
> > > -	cpus =3D of_find_node_by_path("/cpus");
> > > -	if (!cpus) {
> > > -		pr_err("failed to find cpus node\n");
> > > +	cpu0 =3D of_get_cpu_node(0, NULL);
> > > +	if (!cpu0) {
> > > +		pr_err("failed to find cpu0 node\n");
> > >  		return 0;
> > >  	}
> > > =20
> > > -	np =3D of_get_next_child(cpus, NULL);
> > > -	if (!np) {
> > > -		pr_err("failed to find cpus child node\n");
> > > -		of_node_put(cpus);
> > > -		return 0;
> > > -	}
> > > -
> > > -	if (of_find_property(np, "#cooling-cells", NULL)) {
> > > -		cdev =3D of_cpufreq_cooling_register(np,
> > > +	if (of_find_property(cpu0, "#cooling-cells", NULL)) {
> > > +		cdev =3D of_cpufreq_cooling_register(cpu0,
> > >  						   cpu_present_mask);
> > >  		if (IS_ERR(cdev))
> > >  			pr_err("running cpufreq without cooling
> > > device: %ld\n", PTR_ERR(cdev));
> > >  	}
> > > -	of_node_put(np);
> > > -	of_node_put(cpus);
> > > =20
> > >  	return 0;
> > > =20
> >=20
> >=20
> >=20
> > --=20
> > Best regards,
> >=20
> > Lukasz Majewski
> >=20
> > Samsung R&D Institute Poland (SRPOL) | Linux Platform Group


--Sig_/03qG/HPXUNi//tRCteDCNC7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlTvjr0ACgkQf9/hG2YwgjGxuwCfa1kISckb1yeSZ2Ly3zOtGw4K
kJsAoJSfNodjUrGpKLE6pcuThd6mgnyp
=OD1D
-----END PGP SIGNATURE-----

--Sig_/03qG/HPXUNi//tRCteDCNC7--
