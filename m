From: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Subject: Re: [PATCH v3] cpufreq: s5pv210: Defer probe if getting regulators fail
Date: Sun, 13 Jan 2019 20:54:08 +0100
Message-ID: <2003903.RuZpVZK7nJ@acerlaptop>
References: <20190111194244.2439-1-pawel.mikolaj.chmiel@gmail.com> <20190113131624.GA2672@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190113131624.GA2672@kozik-lap>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: kgene@kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On niedziela, 13 stycznia 2019 14:16:24 CET Krzysztof Kozlowski wrote:
> On Fri, Jan 11, 2019 at 08:42:44PM +0100, Pawe=C5=82 Chmiel wrote:
> > There is possibility, that when probing driver, regulators are not yet
> > initialized. In this case we should return EPROBE_DEFER and wait till
> > they're initialized, since they're required currently for cpufreq driver
> > to work. Also move regulator initialization code at beginning of probe,
> > so we can defer as fast as posibble.
> >=20
> > Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > ---
> > Changes from v2:
> >   - Handle all error paths in probe
> >=20
> > Changes from v1:
> >   - Fix compilation error
> >   - Reorganize code so it's smaller
> > ---
> >  drivers/cpufreq/s5pv210-cpufreq.c | 68 ++++++++++++++++++++++---------
> >  1 file changed, 49 insertions(+), 19 deletions(-)
> >=20
> > diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv21=
0-cpufreq.c
> > index f51697f1e0b3..627b132e3e61 100644
> > --- a/drivers/cpufreq/s5pv210-cpufreq.c
> > +++ b/drivers/cpufreq/s5pv210-cpufreq.c
> > @@ -584,7 +584,7 @@ static struct notifier_block s5pv210_cpufreq_reboot=
_notifier =3D {
> >  static int s5pv210_cpufreq_probe(struct platform_device *pdev)
> >  {
> >  	struct device_node *np;
> > -	int id;
> > +	int id, result =3D 0;
> > =20
> >  	/*
> >  	 * HACK: This is a temporary workaround to get access to clock
> > @@ -594,18 +594,40 @@ static int s5pv210_cpufreq_probe(struct platform_=
device *pdev)
> >  	 * this whole driver as soon as S5PV210 gets migrated to use
> >  	 * cpufreq-dt driver.
> >  	 */
> > +	arm_regulator =3D regulator_get(NULL, "vddarm");
> > +	if (IS_ERR(arm_regulator)) {
> > +		if (PTR_ERR(arm_regulator) =3D=3D -EPROBE_DEFER)
> > +			pr_debug("vddarm regulator not ready, defer\n");
> > +		else
> > +			pr_err("failed to get regulator vddarm\n");
> > +		result =3D PTR_ERR(arm_regulator);
> > +		goto err_arm_regulator;
>=20
> Just return here.
=46ixed.
>=20
> > +	}
> > +
> > +	int_regulator =3D regulator_get(NULL, "vddint");
> > +	if (IS_ERR(int_regulator)) {
> > +		if (PTR_ERR(int_regulator) =3D=3D -EPROBE_DEFER)
> > +			pr_debug("vddint regulator not ready, defer\n");
> > +		else
> > +			pr_err("failed to get regulator vddint\n");
> > +		result =3D PTR_ERR(int_regulator);
> > +		goto err_int_regulator;
> > +	}
> > +
> >  	np =3D of_find_compatible_node(NULL, NULL, "samsung,s5pv210-clock");
> >  	if (!np) {
> >  		pr_err("%s: failed to find clock controller DT node\n",
> >  			__func__);
> > -		return -ENODEV;
> > +		result =3D -ENODEV;
> > +		goto err_clock;
> >  	}
> > =20
> >  	clk_base =3D of_iomap(np, 0);
> >  	of_node_put(np);
> >  	if (!clk_base) {
> >  		pr_err("%s: failed to map clock registers\n", __func__);
> > -		return -EFAULT;
> > +		result =3D -EFAULT;
> > +		goto err_clock;
> >  	}
> > =20
> >  	for_each_compatible_node(np, NULL, "samsung,s5pv210-dmc") {
> > @@ -614,7 +636,8 @@ static int s5pv210_cpufreq_probe(struct platform_de=
vice *pdev)
> >  			pr_err("%s: failed to get alias of dmc node '%pOFn'\n",
> >  				__func__, np);
> >  			of_node_put(np);
> > -			return id;
> > +			result =3D id;
> > +			goto err_clk_base;
> >  		}
> > =20
> >  		dmc_base[id] =3D of_iomap(np, 0);
> > @@ -622,33 +645,40 @@ static int s5pv210_cpufreq_probe(struct platform_=
device *pdev)
> >  			pr_err("%s: failed to map dmc%d registers\n",
> >  				__func__, id);
> >  			of_node_put(np);
> > -			return -EFAULT;
> > +			result =3D -EFAULT;
> > +			goto err_dmc;
> >  		}
> >  	}
> > =20
> >  	for (id =3D 0; id < ARRAY_SIZE(dmc_base); ++id) {
> >  		if (!dmc_base[id]) {
> >  			pr_err("%s: failed to find dmc%d node\n", __func__, id);
> > -			return -ENODEV;
> > +			result =3D -ENODEV;
> > +			goto err_dmc;
> >  		}
> >  	}
> > =20
> > -	arm_regulator =3D regulator_get(NULL, "vddarm");
> > -	if (IS_ERR(arm_regulator)) {
> > -		pr_err("failed to get regulator vddarm\n");
> > -		return PTR_ERR(arm_regulator);
> > -	}
> > -
> > -	int_regulator =3D regulator_get(NULL, "vddint");
> > -	if (IS_ERR(int_regulator)) {
> > -		pr_err("failed to get regulator vddint\n");
> > -		regulator_put(arm_regulator);
> > -		return PTR_ERR(int_regulator);
> > -	}
> > -
> >  	register_reboot_notifier(&s5pv210_cpufreq_reboot_notifier);
> > =20
> >  	return cpufreq_register_driver(&s5pv210_driver);
> > +
> > +err_dmc:
> > +	for (id =3D 0; id < ARRAY_SIZE(dmc_base); ++id)
> > +		if (dmc_base[id])
> > +			iounmap(dmc_base[id]);
>=20
> You will iounmap the same pointer twice, if first device bind failed
> while following this error path and someone tries to bind second time
> (again with error leading to this error path). You zero the pointer
> either at beginning of probe or after iounmapping.
Good catch, also fixed in v4.
Thanks
>=20
> Best regards,
> Krzysztof
>=20
>=20
> > +
> > +err_clk_base:
> > +	iounmap(clk_base);
> > +
> > +err_clock:
> > +	regulator_put(int_regulator);
> > +
> > +err_int_regulator:
> > +	regulator_put(arm_regulator);
> > +
> > +err_arm_regulator:
> > +
> > +	return result;
> >  }
> > =20
> >  static struct platform_driver s5pv210_cpufreq_platdrv =3D {
>=20
