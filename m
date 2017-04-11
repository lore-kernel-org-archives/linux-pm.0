From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 04/17] thermal: cpu_cooling: replace cool_dev with cdev
Date: Tue, 11 Apr 2017 10:35:13 -0700
Message-ID: <20170411173510.GB5528@localhost.localdomain>
References: <cover.1489639999.git.viresh.kumar@linaro.org>
 <7fd9ac075f06fb673c2e18b3c5aab9e41910ed12.1489640000.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33673 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751992AbdDKRfT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Apr 2017 13:35:19 -0400
Content-Disposition: inline
In-Reply-To: <7fd9ac075f06fb673c2e18b3c5aab9e41910ed12.1489640000.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 16, 2017 at 10:59:39AM +0530, Viresh Kumar wrote:
> Objects of "struct thermal_cooling_device" are named a bit
> inconsistently. Lets use cdev everywhere.

In this case, cpufreq_cdev is best option on patch 3. Too bad we lost
the "cool" dev here :-)

>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/thermal/cpu_cooling.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 7a19033d7f79..e2931c20c309 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -65,7 +65,7 @@ struct power_table {
>   * struct cpufreq_cooling_device - data for cooling device with cpufreq
>   * @id: unique integer value corresponding to each cpufreq_cooling_device
>   *	registered.
> - * @cool_dev: thermal_cooling_device pointer to keep track of the
> + * @cdev: thermal_cooling_device pointer to keep track of the
>   *	registered cooling device.
>   * @cpufreq_state: integer value representing the current state of cpufr=
eq
>   *	cooling	devices.
> @@ -90,7 +90,7 @@ struct power_table {
>   */
>  struct cpufreq_cooling_device {
>  	int id;
> -	struct thermal_cooling_device *cool_dev;
> +	struct thermal_cooling_device *cdev;
>  	unsigned int cpufreq_state;
>  	unsigned int clipped_freq;
>  	unsigned int max_level;
> @@ -243,7 +243,7 @@ static int build_dyn_power_table(struct cpufreq_cooli=
ng_device *cpufreq_dev,
>  	for_each_cpu(cpu, &cpufreq_dev->allowed_cpus) {
>  		dev =3D get_cpu_device(cpu);
>  		if (!dev) {
> -			dev_warn(&cpufreq_dev->cool_dev->device,
> +			dev_warn(&cpufreq_dev->cdev->device,
>  				 "No cpu device for cpu %d\n", cpu);
>  			continue;
>  		}
> @@ -770,7 +770,7 @@ __cpufreq_cooling_register(struct device_node *np,
>  			get_static_t plat_static_func)
>  {
>  	struct cpufreq_policy *policy;
> -	struct thermal_cooling_device *cool_dev;
> +	struct thermal_cooling_device *cdev;
>  	struct cpufreq_cooling_device *cpufreq_dev;
>  	char dev_name[THERMAL_NAME_LENGTH];
>  	struct cpufreq_frequency_table *pos, *table;
> @@ -786,20 +786,20 @@ __cpufreq_cooling_register(struct device_node *np,
>  	policy =3D cpufreq_cpu_get(cpumask_first(temp_mask));
>  	if (!policy) {
>  		pr_debug("%s: CPUFreq policy not found\n", __func__);
> -		cool_dev =3D ERR_PTR(-EPROBE_DEFER);
> +		cdev =3D ERR_PTR(-EPROBE_DEFER);
>  		goto free_cpumask;
>  	}
> =20
>  	table =3D policy->freq_table;
>  	if (!table) {
>  		pr_debug("%s: CPUFreq table not found\n", __func__);
> -		cool_dev =3D ERR_PTR(-ENODEV);
> +		cdev =3D ERR_PTR(-ENODEV);
>  		goto put_policy;
>  	}
> =20
>  	cpufreq_dev =3D kzalloc(sizeof(*cpufreq_dev), GFP_KERNEL);
>  	if (!cpufreq_dev) {
> -		cool_dev =3D ERR_PTR(-ENOMEM);
> +		cdev =3D ERR_PTR(-ENOMEM);
>  		goto put_policy;
>  	}
> =20
> @@ -808,7 +808,7 @@ __cpufreq_cooling_register(struct device_node *np,
>  					    sizeof(*cpufreq_dev->time_in_idle),
>  					    GFP_KERNEL);
>  	if (!cpufreq_dev->time_in_idle) {
> -		cool_dev =3D ERR_PTR(-ENOMEM);
> +		cdev =3D ERR_PTR(-ENOMEM);
>  		goto free_cdev;
>  	}
> =20
> @@ -816,7 +816,7 @@ __cpufreq_cooling_register(struct device_node *np,
>  		kcalloc(num_cpus, sizeof(*cpufreq_dev->time_in_idle_timestamp),
>  			GFP_KERNEL);
>  	if (!cpufreq_dev->time_in_idle_timestamp) {
> -		cool_dev =3D ERR_PTR(-ENOMEM);
> +		cdev =3D ERR_PTR(-ENOMEM);
>  		goto free_time_in_idle;
>  	}
> =20
> @@ -827,7 +827,7 @@ __cpufreq_cooling_register(struct device_node *np,
>  	cpufreq_dev->freq_table =3D kmalloc(sizeof(*cpufreq_dev->freq_table) *
>  					  cpufreq_dev->max_level, GFP_KERNEL);
>  	if (!cpufreq_dev->freq_table) {
> -		cool_dev =3D ERR_PTR(-ENOMEM);
> +		cdev =3D ERR_PTR(-ENOMEM);
>  		goto free_time_in_idle_timestamp;
>  	}
> =20
> @@ -841,7 +841,7 @@ __cpufreq_cooling_register(struct device_node *np,
> =20
>  		ret =3D build_dyn_power_table(cpufreq_dev, capacitance);
>  		if (ret) {
> -			cool_dev =3D ERR_PTR(ret);
> +			cdev =3D ERR_PTR(ret);
>  			goto free_table;
>  		}
> =20
> @@ -852,7 +852,7 @@ __cpufreq_cooling_register(struct device_node *np,
> =20
>  	ret =3D ida_simple_get(&cpufreq_ida, 0, 0, GFP_KERNEL);
>  	if (ret < 0) {
> -		cool_dev =3D ERR_PTR(ret);
> +		cdev =3D ERR_PTR(ret);
>  		goto free_power_table;
>  	}
>  	cpufreq_dev->id =3D ret;
> @@ -872,13 +872,13 @@ __cpufreq_cooling_register(struct device_node *np,
>  	snprintf(dev_name, sizeof(dev_name), "thermal-cpufreq-%d",
>  		 cpufreq_dev->id);
> =20
> -	cool_dev =3D thermal_of_cooling_device_register(np, dev_name, cpufreq_d=
ev,
> -						      cooling_ops);
> -	if (IS_ERR(cool_dev))
> +	cdev =3D thermal_of_cooling_device_register(np, dev_name, cpufreq_dev,
> +						  cooling_ops);
> +	if (IS_ERR(cdev))
>  		goto remove_ida;
> =20
>  	cpufreq_dev->clipped_freq =3D cpufreq_dev->freq_table[0];
> -	cpufreq_dev->cool_dev =3D cool_dev;
> +	cpufreq_dev->cdev =3D cdev;
> =20
>  	mutex_lock(&cooling_list_lock);
>  	list_add(&cpufreq_dev->node, &cpufreq_dev_list);
> @@ -907,7 +907,7 @@ __cpufreq_cooling_register(struct device_node *np,
>  	cpufreq_cpu_put(policy);
>  free_cpumask:
>  	free_cpumask_var(temp_mask);
> -	return cool_dev;
> +	return cdev;
>  }
> =20
>  /**
> @@ -1043,7 +1043,7 @@ void cpufreq_cooling_unregister(struct thermal_cool=
ing_device *cdev)
>  	list_del(&cpufreq_dev->node);
>  	mutex_unlock(&cooling_list_lock);
> =20
> -	thermal_cooling_device_unregister(cpufreq_dev->cool_dev);
> +	thermal_cooling_device_unregister(cpufreq_dev->cdev);
>  	ida_simple_remove(&cpufreq_ida, cpufreq_dev->id);
>  	kfree(cpufreq_dev->dyn_power_table);
>  	kfree(cpufreq_dev->time_in_idle_timestamp);
> --=20
> 2.7.1.410.g6faf27b
>=20

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY7RPGAAoJEA6VkvSQfF5TAPoP/i8TiATUBLo95j+ShbUbJYkF
pjOZKaNdCzXd0xCgJnjbwQH/fi81dgY7TUkuuAdBlnT2Mnxie5fRDGLpokimzanF
9/clyqagRdvBwagvHzRIRpwRGf5V8dcKr4TaViQG1JJzKCWdtohXG2DIr9FAYoxs
CaHU3Geo0/+dkoyPIhGwNdGU8UPzllvb0gmRMPIRMWwrKfykHOwx96HQMfHSjtBd
VfRdFe7qJO5T+AKxUbKzm0LdUnFKHZqQdioHcTWpviBKEsCh9Rx5qgIrrkl+9Vj9
yNFBAOY5FhZCJLdqCvc65lVskbhUpoikgJYxDHR4jWAQyzHeBpwaoLZimcIE3MkT
tHUPME9N7MJn7F37E6IOH7FzATpV9Kw4giSOqEDfGKIANmg3ORST7DmHQDAEXddS
U6H3uwF2Dc69XWDNSo4vC6xQfNeRT1QXN1WVflzvVwJvbDiJhIpz8MiXQNmyqsCn
BYu1omWkWqmG0tr2pDHDImPfMCrG/13SBgDxXYz3Hy/rfhooVdyeP7mkh1CW9wcT
1nfIs6XIDo33oQYm8sCnaysRjiyRofQh/HUnDkT1iBCk6IG9Sg9QSI92xGQrK/Cc
MjOW7HUz8SkONFBycBcXNnfY8rJMSoyeKuAt4Ln40QEibqMT3RMabyzxUtq7SlmR
upQMrv09AiI7cDHWQLNF
=nPb8
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
