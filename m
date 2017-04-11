From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 05/17] thermal: cpu_cooling: remove
 cpufreq_cooling_get_level()
Date: Tue, 11 Apr 2017 10:43:43 -0700
Message-ID: <20170411174342.GC5528@localhost.localdomain>
References: <cover.1489639999.git.viresh.kumar@linaro.org>
 <707918c88ce650ea11d160e31965482cdebc9a39.1489640000.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33141 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbdDKRns (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Apr 2017 13:43:48 -0400
Content-Disposition: inline
In-Reply-To: <707918c88ce650ea11d160e31965482cdebc9a39.1489640000.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 16, 2017 at 10:59:40AM +0530, Viresh Kumar wrote:
> There is only one user of cpufreq_cooling_get_level() and that already
> has pointer to the cpufreq_dev structure. It can directly call
> get_level() instead and we can get rid of cpufreq_cooling_get_level().
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/thermal/cpu_cooling.c | 33 +--------------------------------
>  include/linux/cpu_cooling.h   |  6 ------
>  2 files changed, 1 insertion(+), 38 deletions(-)
>=20
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index e2931c20c309..99dc6833de75 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -137,37 +137,6 @@ static unsigned long get_level(struct cpufreq_coolin=
g_device *cpufreq_dev,
>  }
> =20
>  /**
> - * cpufreq_cooling_get_level - for a given cpu, return the cooling level.
> - * @cpu: cpu for which the level is required
> - * @freq: the frequency of interest
> - *
> - * This function will match the cooling level corresponding to the
> - * requested @freq and return it.
> - *
> - * Return: The matched cooling level on success or THERMAL_CSTATE_INVALID
> - * otherwise.
> - */
> -unsigned long cpufreq_cooling_get_level(unsigned int cpu, unsigned int f=
req)
> -{
> -	struct cpufreq_cooling_device *cpufreq_dev;
> -
> -	mutex_lock(&cooling_list_lock);
> -	list_for_each_entry(cpufreq_dev, &cpufreq_dev_list, node) {
> -		if (cpumask_test_cpu(cpu, &cpufreq_dev->allowed_cpus)) {
> -			unsigned long level =3D get_level(cpufreq_dev, freq);
> -
> -			mutex_unlock(&cooling_list_lock);
> -			return level;
> -		}
> -	}
> -	mutex_unlock(&cooling_list_lock);
> -
> -	pr_err("%s: cpu:%d not part of any cooling device\n", __func__, cpu);
> -	return THERMAL_CSTATE_INVALID;
> -}
> -EXPORT_SYMBOL_GPL(cpufreq_cooling_get_level);
> -
> -/**
>   * cpufreq_thermal_notifier - notifier callback for cpufreq policy chang=
e.
>   * @nb:	struct notifier_block * with callback info.
>   * @event: value showing cpufreq event for which this function invoked.
> @@ -698,7 +667,7 @@ static int cpufreq_power2state(struct thermal_cooling=
_device *cdev,
>  	normalised_power =3D (dyn_power * 100) / last_load;
>  	target_freq =3D cpu_power_to_freq(cpufreq_dev, normalised_power);
> =20
> -	*state =3D cpufreq_cooling_get_level(cpu, target_freq);
> +	*state =3D get_level(cpufreq_dev, target_freq);

Did I miss something or we are loosing semantics here?

I guess the idea at this point is to get the level corresponding to the
frequency on a specific cpu. Let's have a look on get_level()..

I guess now we can rely on the freq table held in the
cpufreq_cooling_device..

>  	if (*state =3D=3D THERMAL_CSTATE_INVALID) {
>  		dev_err_ratelimited(&cdev->device,
>  				    "Failed to convert %dKHz for cpu %d into a cdev state\n",
> diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
> index c156f5082758..96c5e4c2f9c8 100644
> --- a/include/linux/cpu_cooling.h
> +++ b/include/linux/cpu_cooling.h
> @@ -82,7 +82,6 @@ of_cpufreq_power_cooling_register(struct device_node *n=
p,
>   */
>  void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev);
> =20
> -unsigned long cpufreq_cooling_get_level(unsigned int cpu, unsigned int f=
req);
>  #else /* !CONFIG_CPU_THERMAL */
>  static inline struct thermal_cooling_device *
>  cpufreq_cooling_register(const struct cpumask *clip_cpus)
> @@ -117,11 +116,6 @@ void cpufreq_cooling_unregister(struct thermal_cooli=
ng_device *cdev)
>  {
>  	return;
>  }
> -static inline
> -unsigned long cpufreq_cooling_get_level(unsigned int cpu, unsigned int f=
req)
> -{
> -	return THERMAL_CSTATE_INVALID;
> -}
>  #endif	/* CONFIG_CPU_THERMAL */
> =20
>  #endif /* __CPU_COOLING_H__ */
> --=20
> 2.7.1.410.g6faf27b
>=20

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY7RXHAAoJEA6VkvSQfF5TaMsQALDpgN3R+kAqj/1jIRxzweZA
vZ+OXAg65ctNxj8t8azJDeG4u87gcv4lsLUKgWaJ495N5BbzkEm6bIRdmZEk/+dX
hS7ILTAgeIvtuaeW26G8o1i1L/rpP28z1gMFsKAIrAEU8tajySoIIR0N7QMoWjYF
/J4TB/KQwH/EJ1G8Gr5U9qnD4khlZuBEUABPpFaF83muV9JtPsmh63c9NrKUFzRK
VuD9EOojvgz4RTUuZ/BqQEf6/uE8DCmJajsU1TzUG/cff5acFuWCd0SdMHEmjG+D
S9StJ8JcaCXWVFmWTMDDQdwo7e+pXuPD5J0gjeeb64mQbml/NQsqjwmgPIN06QV/
+HA++5pAWos3KEvGWHeaH1adqoIOkVPH1/ZtHCVBUvBv3ebuFPAyN50OPe13bCUp
bBkk+yVrnN1DKpH9HiFfm2Yk2hT+jMljvVoLgzPB8+FmPWguqJGbZv/rSdTBur4N
/W6zRB1c9z3EDw1F4lzZKe4FjO8OEJLUMRYBtF+TA5bKnl+owDL+kn+hkR0kUldO
xwyRh78c57YTbS/vxHTSi/kZB0dQL1uqioamjEsEvyVEoD1IxxcXlrjaheYJQaev
J9e4xGXnTeZra1FaBpBpNyoC2CQO/PNGutuoU9RFBHfASkMIC85zRitMZ0RLxTvf
BbQ3CC5B+YXtlBkpOZbR
=iSP8
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--
