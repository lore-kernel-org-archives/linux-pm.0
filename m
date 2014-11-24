From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] cpufreq-dt: register cooling device after validating
 cpufreq table
Date: Mon, 24 Nov 2014 14:10:51 -0400
Message-ID: <20141124181049.GB1449@developer>
References: <b4a56cad08c5ef701cf268881697caabe5229994.1416826729.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:63071 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753908AbaKXSKd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 24 Nov 2014 13:10:33 -0500
Received: by mail-qg0-f52.google.com with SMTP id a108so7033992qge.39
        for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2014 10:10:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <b4a56cad08c5ef701cf268881697caabe5229994.1416826729.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, l.majewski@samsung.com


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Viresh

On Mon, Nov 24, 2014 at 04:29:13PM +0530, Viresh Kumar wrote:
> of_cpufreq_cooling_register() can use frequency values from
> policy->min/max/cpuinfo.min_freq/cpuinfo.max_freq, which are available on=
ly
> after calling cpufreq_table_validate_and_show().
>=20
> The right order of calling should be: cpufreq_table_validate_and_show() f=
ollowed
> by of_cpufreq_cooling_register(). Fix it.
>=20
> Reported-by: Lukasz Majewski <l.majewski@samsung.com>
> Reported-by: Eduardo Valentin <edubezval@gmail.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>=20
> ---
> For 3.18.
> ---
>  drivers/cpufreq/cpufreq-dt.c | 35 +++++++++++++++++------------------
>  1 file changed, 17 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index 8cba13d..22eb6e5 100644
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
> -		cdev =3D of_cpufreq_cooling_register(np, cpu_present_mask);
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
> @@ -292,7 +277,22 @@ static int cpufreq_init(struct cpufreq_policy *polic=
y)
>  	if (ret) {
>  		dev_err(cpu_dev, "%s: invalid frequency table: %d\n", __func__,
>  			ret);
> -		goto out_cooling_unregister;
> +		goto out_free_cpufreq_table;
> +	}
> +
> +	/*
> +	 * For now, just loading the cooling device;
> +	 * thermal DT code takes care of matching them.
> +	 */
> +	if (of_find_property(np, "#cooling-cells", NULL)) {
> +		priv->cdev =3D of_cpufreq_cooling_register(np, cpu_present_mask);
> +		if (IS_ERR(priv->cdev)) {
> +			dev_err(cpu_dev,
> +				"running cpufreq without cooling device: %ld\n",
> +				PTR_ERR(priv->cdev));
> +
> +			priv->cdev =3D NULL;
> +		}

Is it possible to have this registration only when we have a
cpufreq driver up and running? The reasoning is that only after we have
a way to control cpu frequencies, it makes sense to have the cpu_cooling
device.

I am planing to have the following check in the cpu cooling code:
	if (!cpufreq_get_current_driver()) {
		dev_dbg(bgp->dev, "no cpufreq driver yet\n");
		return -EPROBE_DEFER;
	}

that is the way I think of checking if the cpufreq layer is ready to
have a cpu cooling on top of it. Currently, thermal drivers check this
before calling cpu cooling registration. But instead of having this
check in every driver, I would like to move it to cpu cooling.

However, for cpufreq-dt, the registration currently happens in the
init phase, not in probe, so cpufreq driver is not registered, and thus
the check won't work.

In this way, I believe the sequencing between cpu cooling and cpufreq-dt
would work fine.


>  	}
> =20
>  	policy->cpuinfo.transition_latency =3D transition_latency;
> @@ -305,8 +305,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
> =20
>  	return 0;
> =20
> -out_cooling_unregister:
> -	cpufreq_cooling_unregister(priv->cdev);
> +out_free_cpufreq_table:
>  	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
>  out_free_priv:
>  	kfree(priv);
> --=20
> 2.0.3.693.g996b0fd
>=20

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc3SgAAoJEMLUO4d9pOJWxjMH/3Nb3UZgYE+4TE1AFv/MlkqY
VnoVAdq8/8JgE8inXcVJ99nrGWZ7yIxmnWfikNTRzsDAMvenOSBDgXWm+1XFAOrW
fRz5uTM+dxoFX65FKY6ekvOrDNnlIgMXr+GMq8RiGpgo14Gwd9xOPvfZUqc+eIhl
1iXRPclBqi33O2xx5EzePIeOufqSyblLUrGXehlmLTEaReu3yN9NMQNein6R37sj
MaaGePMj0RcqTOL5QMeDQQoZtQ730IC9ZxfQElZwDlNVweDtssO/yQFd/Kjlw4uB
/aE0mfpv9bEertwcmxIlPfq7KL02ZA6cTks1zXEXy82Bi3+ki/SgW/Rl9wEX/vQ=
=hMDz
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
