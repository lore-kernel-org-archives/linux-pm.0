From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 19/26] cpu_cooling: find max level during device
 registration
Date: Tue, 2 Dec 2014 19:39:38 -0400
Message-ID: <20141202233936.GB3969@developer>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
 <e2cb864949d833ab30c24b2bf039c682c8820040.1417167599.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:47738 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933163AbaLBXjr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Dec 2014 18:39:47 -0500
Received: by mail-qc0-f179.google.com with SMTP id c9so10454741qcz.10
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2014 15:39:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <e2cb864949d833ab30c24b2bf039c682c8820040.1417167599.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, rui.zhang@intel.com


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Viresh

On Fri, Nov 28, 2014 at 03:14:13PM +0530, Viresh Kumar wrote:
> CPU frequency tables don't update after the driver is registered and so w=
e don't
> need to iterate over them to find total number of states every time
> cpufreq_get_max_state() is called. Do it once at boot time.

Could you please update me regarding the story behind the opp del patch
set?

http://permalink.gmane.org/gmane.linux.power-management.general/53348

>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/thermal/cpu_cooling.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 5815abf..05712d5 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -52,6 +52,8 @@
>   *	cooling	devices.
>   * @cpufreq_val: integer value representing the absolute value of the cl=
ipped
>   *	frequency.
> + * @max_level: maximum cooling level. One less than total number of valid
> + *	cpufreq frequencies.
>   * @allowed_cpus: all the cpus involved for this cpufreq_cooling_device.
>   *
>   * This structure is required for keeping information of each registered
> @@ -62,6 +64,7 @@ struct cpufreq_cooling_device {
>  	struct thermal_cooling_device *cool_dev;
>  	unsigned int cpufreq_state;
>  	unsigned int cpufreq_val;
> +	unsigned int max_level;
>  	struct cpumask allowed_cpus;
>  };
>  static DEFINE_IDR(cpufreq_idr);
> @@ -246,19 +249,9 @@ static int cpufreq_get_max_state(struct thermal_cool=
ing_device *cdev,
>  				 unsigned long *state)
>  {
>  	struct cpufreq_cooling_device *cpufreq_device =3D cdev->devdata;
> -	struct cpumask *mask =3D &cpufreq_device->allowed_cpus;
> -	unsigned int cpu;
> -	unsigned int count =3D 0;
> -	int ret;
> =20
> -	cpu =3D cpumask_any(mask);
> -
> -	ret =3D get_property(cpu, 0, &count, GET_MAXL);
> -
> -	if (count > 0)
> -		*state =3D count;
> -
> -	return ret;
> +	*state =3D cpufreq_device->max_level;
> +	return 0;
>  }
> =20
>  /**
> @@ -351,11 +344,25 @@ __cpufreq_cooling_register(struct device_node *np,
>  	struct thermal_cooling_device *cool_dev;
>  	struct cpufreq_cooling_device *cpufreq_dev;
>  	char dev_name[THERMAL_NAME_LENGTH];
> +	struct cpufreq_frequency_table *pos, *table;
> +
> +	table =3D cpufreq_frequency_get_table(cpumask_first(clip_cpus));
> +	if (!table) {
> +		pr_debug("%s: CPUFreq table not found\n", __func__);
> +		return ERR_PTR(-EPROBE_DEFER);
> +	}
> =20
>  	cpufreq_dev =3D kzalloc(sizeof(*cool_dev), GFP_KERNEL);
>  	if (!cpufreq_dev)
>  		return ERR_PTR(-ENOMEM);
> =20
> +	/* Find max levels */
> +	cpufreq_for_each_valid_entry(pos, table)
> +		cpufreq_dev->max_level++;
> +
> +	/* max_level is an index, not a counter */
> +	cpufreq_dev->max_level--;
> +
>  	cpumask_copy(&cpufreq_dev->allowed_cpus, clip_cpus);
> =20
>  	cpufreq_dev->id =3D idr_alloc(&cpufreq_idr, NULL, 0, 0, GFP_KERNEL);
> --=20
> 2.0.3.693.g996b0fd
>=20

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUfk2kAAoJEMLUO4d9pOJWSoEH/jvxqC8tL4DLns9TzMWHRN58
xXOKwQtzR9B8t+XSdYxAoLts/rzz46W7ib382stNiHXvffoCsyQbQSBYbSG4mWay
UQue/IOaHbe9kYsV7C4bKt8Rcqdt/4vAIuTODCN2AGNlJgLu8ruFJfrml22WtBHJ
1ODEaQPHZ7pCfUT6XznlosM9Y26CH0xDMzDNbJXD0kFaUgl23GcooiGhl6pDetWO
2/au1bVLg9iCkttT3gkumS6/IkpKYvYWW+KxqNnBMFCIwEbZZ8M+MScEtX1oKMb9
zP39OHDqcLc+pr4/Qxhl5DYS+aEGdHhY3Zb1H/V2jwqT7CVB5q1emoQhP7/3KJs=
=PsJG
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
