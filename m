From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 4/7] cpufreq-dt: register cooling device from ->usable()
 callback
Date: Wed, 26 Nov 2014 13:59:43 -0400
Message-ID: <20141126175941.GE1826@developer>
References: <cover.1416980447.git.viresh.kumar@linaro.org>
 <89d112f34aaecd8c90486617d57ee5d605678d56.1416980448.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wchHw8dVAp53YPj8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:33907 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752882AbaKZR7v (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 12:59:51 -0500
Received: by mail-qa0-f48.google.com with SMTP id v10so2288564qac.35
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2014 09:59:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <89d112f34aaecd8c90486617d57ee5d605678d56.1416980448.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, l.majewski@samsung.com


--wchHw8dVAp53YPj8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2014 at 11:22:59AM +0530, Viresh Kumar wrote:
> Currently we are calling of_cpufreq_cooling_register() from ->init() call=
back.
> At this point of time cpufreq driver's policy isn't completely ready to b=
e used
> as few of its fields/structure/pointers aren't yet initialized.
>=20
> Because of_cpufreq_cooling_register() tries to access policy with help of
> cpufreq_cpu_get() and then tries to get freq-table as well, these calls f=
ail.
>=20
> To fix this, register the cooling device after the policy is ready to be =
used.
> And the right callback for it is the newly added ->usable() one.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Eduardo Valentin <edubezval@gmail.com>
Tested-by: Eduardo Valentin <edubezval@gmail.com>

> ---
>  drivers/cpufreq/cpufreq-dt.c | 51 +++++++++++++++++++++++++++-----------=
------
>  1 file changed, 32 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index 7374fc4..f7af5c8 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -186,7 +186,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  {
>  	struct cpufreq_dt_platform_data *pd;
>  	struct cpufreq_frequency_table *freq_table;
> -	struct thermal_cooling_device *cdev;
>  	struct device_node *np;
>  	struct private_data *priv;
>  	struct device *cpu_dev;
> @@ -269,20 +268,6 @@ static int cpufreq_init(struct cpufreq_policy *polic=
y)
>  		goto out_free_priv;
>  	}
> =20
> -	/*
> -	 * For now, just loading the cooling device;
> -	 * thermal DT code takes care of matching them.
> -	 */
> -	if (of_find_property(np, "#cooling-cells", NULL)) {
> -		cdev =3D of_cpufreq_cooling_register(np, policy->related_cpus);
> -		if (IS_ERR(cdev))
> -			dev_err(cpu_dev,
> -				"running cpufreq without cooling device: %ld\n",
> -				PTR_ERR(cdev));
> -		else
> -			priv->cdev =3D cdev;
> -	}
> -
>  	priv->cpu_dev =3D cpu_dev;
>  	priv->cpu_reg =3D cpu_reg;
>  	policy->driver_data =3D priv;
> @@ -292,7 +277,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  	if (ret) {
>  		dev_err(cpu_dev, "%s: invalid frequency table: %d\n", __func__,
>  			ret);
> -		goto out_cooling_unregister;
> +		goto out_free_cpufreq_table;
>  	}
> =20
>  	policy->cpuinfo.transition_latency =3D transition_latency;
> @@ -305,8 +290,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
> =20
>  	return 0;
> =20
> -out_cooling_unregister:
> -	cpufreq_cooling_unregister(priv->cdev);
> +out_free_cpufreq_table:
>  	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
>  out_free_priv:
>  	kfree(priv);
> @@ -324,7 +308,8 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
>  {
>  	struct private_data *priv =3D policy->driver_data;
> =20
> -	cpufreq_cooling_unregister(priv->cdev);
> +	if (priv->cdev)
> +		cpufreq_cooling_unregister(priv->cdev);
>  	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
>  	clk_put(policy->clk);
>  	if (!IS_ERR(priv->cpu_reg))
> @@ -334,6 +319,33 @@ static int cpufreq_exit(struct cpufreq_policy *polic=
y)
>  	return 0;
>  }
> =20
> +static void cpufreq_usable(struct cpufreq_policy *policy)
> +{
> +	struct private_data *priv =3D policy->driver_data;
> +	struct device_node *np =3D of_node_get(priv->cpu_dev->of_node);
> +
> +	if (WARN_ON(!np))
> +		return;
> +
> +	/*
> +	 * For now, just loading the cooling device;
> +	 * thermal DT code takes care of matching them.
> +	 */
> +	if (of_find_property(np, "#cooling-cells", NULL)) {
> +		priv->cdev =3D of_cpufreq_cooling_register(np,
> +							 policy->related_cpus);
> +		if (IS_ERR(priv->cdev)) {
> +			dev_err(priv->cpu_dev,
> +				"running cpufreq without cooling device: %ld\n",
> +				PTR_ERR(priv->cdev));
> +
> +			priv->cdev =3D NULL;
> +		}
> +	}
> +
> +	of_node_put(np);
> +}
> +
>  static struct cpufreq_driver dt_cpufreq_driver =3D {
>  	.flags =3D CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK,
>  	.verify =3D cpufreq_generic_frequency_table_verify,
> @@ -341,6 +353,7 @@ static struct cpufreq_driver dt_cpufreq_driver =3D {
>  	.get =3D cpufreq_generic_get,
>  	.init =3D cpufreq_init,
>  	.exit =3D cpufreq_exit,
> +	.usable =3D cpufreq_usable,
>  	.name =3D "cpufreq-dt",
>  	.attr =3D cpufreq_generic_attr,
>  };
> --=20
> 2.0.3.693.g996b0fd
>=20

--wchHw8dVAp53YPj8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdhUEAAoJEMLUO4d9pOJW6FsH/0bNSlb7Fr3MR7CXVRrLeSdI
TKbAOa35p0ehxMAn3Fju4eca4VBElDVU9atyuRJ1IIEPNZ8NzWNTXJu1mM7NAMpv
UgZsOZSfWycQO8mDY86vPPB1unNObpeLIcj0QGz6gNlFs3QgKBaW+t7y1ENYViaj
HkH0GJcNdQlNEA/EGslr0/m+yNRPPZHlRJv3lbkB+Y07XGTbUFb0J9mIRIIo9Ywb
ZSczX2SRRiHBjhAoAxEMYYdEqF2kA1wt0/shj4iJ2OBOSeq/Gewd0Ji5dwD0/ef8
Gd27dxm3wxN/sudR/YyNL2JPDUFLcDl70CK3lqlDZ/VFzSdi5onkEZmZcy2srqk=
=6Jxb
-----END PGP SIGNATURE-----

--wchHw8dVAp53YPj8--
