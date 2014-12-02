From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 25/26] cpu_cooling: Use cpufreq_dev->freq_table for
 finding level/freq
Date: Tue, 2 Dec 2014 19:36:28 -0400
Message-ID: <20141202233626.GA3969@developer>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
 <8c0412592bfd5524e638252a42edaf08f81f0976.1417167599.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:58027 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933163AbaLBXgh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Dec 2014 18:36:37 -0500
Received: by mail-qc0-f170.google.com with SMTP id x3so10356043qcv.1
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2014 15:36:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <8c0412592bfd5524e638252a42edaf08f81f0976.1417167599.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, rui.zhang@intel.com


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2014 at 03:14:19PM +0530, Viresh Kumar wrote:
> get_property() was an over complicated beast with BUGs. It used to believ=
e that
> cpufreq table is present in ascending or descending order, which might not
> always be true.
>=20
> Previous patch has created another freq table in descending order for us =
and we
> better use it now. With that get_property() simply goes away and another =
helper
> get_level() comes in.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/thermal/cpu_cooling.c | 96 +++++++------------------------------=
------
>  1 file changed, 14 insertions(+), 82 deletions(-)
>=20
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 9a4a323..db4c001 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -80,85 +80,27 @@ static struct cpufreq_cooling_device *notify_device;
> =20
>  /* Below code defines functions to be used for cpufreq as cooling device=
 */
> =20
> -enum cpufreq_cooling_property {
> -	GET_LEVEL,
> -	GET_FREQ,
> -};
> -
>  /**
> - * get_property - fetch a property of interest for a given cpu.
> + * get_level: Find the level for a particular frequency
>   * @cpufreq_dev: cpufreq_dev for which the property is required
> - * @input: query parameter
> - * @output: query return
> - * @property: type of query (frequency, level)
> - *
> - * This is the common function to
> - * 1. translate frequency to cooling state
> - * 2. translate cooling state to frequency
> + * @freq: Frequency
>   *
> - * Note that the code may be not in good shape
> - * but it is written in this way in order to:
> - * a) reduce duplicate code as most of the code can be shared.
> - * b) make sure the logic is consistent when translating between
> - *    cooling states and frequencies.
> - *
> - * Return: 0 on success, -EINVAL when invalid parameters are passed.
> + * Returns: level on success, THERMAL_CSTATE_INVALID on error.
>   */
> -static int get_property(struct cpufreq_cooling_device *cpufreq_dev,
> -			unsigned long input, unsigned int *output,
> -			enum cpufreq_cooling_property property)
> +static unsigned long get_level(struct cpufreq_cooling_device *cpufreq_de=
v,
> +			       unsigned int freq)
>  {
> -	int i;
> -	unsigned long level =3D 0;
> -	unsigned int freq =3D CPUFREQ_ENTRY_INVALID;
> -	int descend =3D -1;
> -	struct cpufreq_frequency_table *pos, *table;
> -
> -	if (!output)
> -		return -EINVAL;
> +	unsigned long level;
> =20
> -	table =3D cpufreq_frequency_get_table(cpumask_first(&cpufreq_dev->allow=
ed_cpus));
> -	if (!table)
> -		return -EINVAL;
> +	for (level =3D 0; level <=3D cpufreq_dev->max_level; level++) {
> +		if (freq =3D=3D cpufreq_dev->freq_table[level])
> +			return level;
> =20
> -	cpufreq_for_each_valid_entry(pos, table) {
> -		/* ignore duplicate entry */
> -		if (freq =3D=3D pos->frequency)
> -			continue;
> -
> -		/* get the frequency order */
> -		if (freq !=3D CPUFREQ_ENTRY_INVALID && descend =3D=3D -1)
> -			descend =3D freq > pos->frequency;
> -
> -		freq =3D pos->frequency;
> +		if (freq > cpufreq_dev->freq_table[level])
> +			break;
>  	}
> =20
> -	if (property =3D=3D GET_FREQ)
> -		level =3D descend ? input : (cpufreq_dev->max_level - input);
> -
> -	i =3D 0;
> -	cpufreq_for_each_valid_entry(pos, table) {
> -		/* ignore duplicate entry */
> -		if (freq =3D=3D pos->frequency)
> -			continue;
> -
> -		/* now we have a valid frequency entry */
> -		freq =3D pos->frequency;
> -
> -		if (property =3D=3D GET_LEVEL && (unsigned int)input =3D=3D freq) {
> -			/* get level by frequency */
> -			*output =3D descend ? i : (cpufreq_dev->max_level - i);
> -			return 0;
> -		}
> -		if (property =3D=3D GET_FREQ && level =3D=3D i) {
> -			/* get frequency by level */
> -			*output =3D freq;
> -			return 0;
> -		}
> -		i++;
> -	}
> -
> -	return -EINVAL;
> +	return THERMAL_CSTATE_INVALID;
>  }
> =20
>  /**
> @@ -179,14 +121,8 @@ unsigned long cpufreq_cooling_get_level(unsigned int=
 cpu, unsigned int freq)
>  	mutex_lock(&cooling_cpufreq_lock);
>  	list_for_each_entry(cpufreq_dev, &cpufreq_dev_list, head) {
>  		if (cpumask_test_cpu(cpu, &cpufreq_dev->allowed_cpus)) {
> -			unsigned int val;
> -
>  			mutex_unlock(&cooling_cpufreq_lock);
> -			if (get_property(cpufreq_dev, (unsigned long)freq, &val,
> -					 GET_LEVEL))
> -				return THERMAL_CSTATE_INVALID;
> -
> -			return (unsigned long)val;
> +			return get_level(cpufreq_dev, freq);
>  		}
>  	}
>  	mutex_unlock(&cooling_cpufreq_lock);
> @@ -289,16 +225,12 @@ static int cpufreq_set_cur_state(struct thermal_coo=
ling_device *cdev,
>  	struct cpufreq_cooling_device *cpufreq_device =3D cdev->devdata;
>  	unsigned int cpu =3D cpumask_any(&cpufreq_device->allowed_cpus);
>  	unsigned int clip_freq;
> -	int ret =3D 0;
> =20
>  	/* Check if the old cooling action is same as new cooling action */
>  	if (cpufreq_device->cpufreq_state =3D=3D state)
>  		return 0;
> =20
> -	ret =3D get_property(cpufreq_device, state, &clip_freq, GET_FREQ);
> -	if (ret)
> -		return ret;
> -
> +	clip_freq =3D cpufreq_device->freq_table[state];

There should be some check for valid state here..

>  	cpufreq_device->cpufreq_state =3D state;
>  	cpufreq_device->cpufreq_val =3D clip_freq;
>  	notify_device =3D cpufreq_device;
> --=20
> 2.0.3.693.g996b0fd
>=20

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUfkzxAAoJEMLUO4d9pOJW2r8H/ixGxYgc34y1quEaxMNvBiG1
P3DNd7gxhYXC8bYcThnLNaIjtt9U3KYX5mc08LO/8dIFRS2R0hYN0EhzP+kWm2m6
IkH32XmawG3tKJpCBSvmoFkxxPC1L41NnVA91axWmzzBorZkGLVLo81cblZ7eXxD
Ah+bxu4CuTyeLjTISA0UX6/QH8UgPjls7u1kbJ6VtHhUDQO2QqkdbVeYIgq87Dul
Ey7GcW+wUVnDoeOBNx8Thf9bV3XeA0syhr2Wh9ZGVlnMh8BP4+G2nR499WPGsZrg
fxP8sMz7LAse4b3mvWSZlYZYgJtRzS9TqRky5EnhfdUWNM2V9XRQ/CRm18jwWOs=
=z0DI
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
