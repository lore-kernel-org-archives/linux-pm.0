From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 24/26] cpu_cooling: Store frequencies in descending order
Date: Tue, 2 Dec 2014 19:21:30 -0400
Message-ID: <20141202232128.GA3645@developer>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
 <ecb90bfbe1dd69ad73210630ce0a2f988d6210f1.1417167599.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:51235 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932722AbaLBXVj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Dec 2014 18:21:39 -0500
Received: by mail-qc0-f170.google.com with SMTP id x3so10339933qcv.1
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2014 15:21:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <ecb90bfbe1dd69ad73210630ce0a2f988d6210f1.1417167599.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, rui.zhang@intel.com


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Viresh,

On Fri, Nov 28, 2014 at 03:14:18PM +0530, Viresh Kumar wrote:
> CPUFreq framework *doesn't* guarantee that frequencies present in cpufreq=
 table
> will be in ascending or descending order. But cpu_cooling somehow assumes=
 that.
>=20
> Probably because most of current users are creating this list from DT, wh=
ich is
> done with the help of OPP layer. And OPP layer creates the list in ascend=
ing
> order of frequencies.
>=20
> But cpu_cooling can be used for other platforms too, which don't have
> frequencies arranged in any order.
>=20
> This patch tries to fix this issue by creating another list of valid freq=
uencies
> in descending order. Care is also taken to throw warnings for duplicate e=
ntries.
>=20
> Later patches would use it to simplify code.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/thermal/cpu_cooling.c | 41 +++++++++++++++++++++++++++++++++++++=
+++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 07414c5..9a4a323 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -65,6 +65,7 @@ struct cpufreq_cooling_device {
>  	unsigned int cpufreq_state;
>  	unsigned int cpufreq_val;
>  	unsigned int max_level;
> +	unsigned int *freq_table;	/* In descending order */
>  	struct cpumask allowed_cpus;
>  	struct list_head head;
>  };
> @@ -321,6 +322,20 @@ static struct notifier_block thermal_cpufreq_notifie=
r_block =3D {
>  	.notifier_call =3D cpufreq_thermal_notifier,
>  };
> =20
> +static unsigned int find_next_max(struct cpufreq_frequency_table *table,
> +				  unsigned int prev_max)
> +{
> +	struct cpufreq_frequency_table *pos;
> +	unsigned int max =3D 0;
> +
> +	cpufreq_for_each_valid_entry(pos, table) {
> +		if (pos->frequency > max && pos->frequency < prev_max)

What happens if, for some random reason, the cpufreq table is in
ascending order and this function is called with prev_max =3D=3D (unsigned
int) -1 ? What would be the returned max?

> +			max =3D pos->frequency;
> +	}
> +
> +	return max;
> +}
> +
>  /**
>   * __cpufreq_cooling_register - helper function to create cpufreq coolin=
g device
>   * @np: a valid struct device_node to the cooling device device tree node
> @@ -343,6 +358,7 @@ __cpufreq_cooling_register(struct device_node *np,
>  	struct cpufreq_cooling_device *cpufreq_dev;
>  	char dev_name[THERMAL_NAME_LENGTH];
>  	struct cpufreq_frequency_table *pos, *table;
> +	unsigned int freq, i;
> =20
>  	table =3D cpufreq_frequency_get_table(cpumask_first(clip_cpus));
>  	if (!table) {
> @@ -358,6 +374,14 @@ __cpufreq_cooling_register(struct device_node *np,
>  	cpufreq_for_each_valid_entry(pos, table)
>  		cpufreq_dev->max_level++;
> =20
> +	cpufreq_dev->freq_table =3D kmalloc(sizeof(*cpufreq_dev->freq_table) *
> +					  cpufreq_dev->max_level, GFP_KERNEL);
> +	if (!cpufreq_dev->freq_table) {
> +		return ERR_PTR(-ENOMEM);
> +		cool_dev =3D ERR_PTR(-ENOMEM);
> +		goto free_cdev;
> +	}
> +
>  	/* max_level is an index, not a counter */
>  	cpufreq_dev->max_level--;
> =20
> @@ -366,7 +390,7 @@ __cpufreq_cooling_register(struct device_node *np,
>  	cpufreq_dev->id =3D idr_alloc(&cpufreq_idr, NULL, 0, 0, GFP_KERNEL);
>  	if (unlikely(cpufreq_dev->id < 0)) {
>  		cool_dev =3D ERR_PTR(cpufreq_dev->id);
> -		goto free_cdev;
> +		goto free_table;
>  	}
> =20
>  	snprintf(dev_name, sizeof(dev_name), "thermal-cpufreq-%d",
> @@ -377,6 +401,18 @@ __cpufreq_cooling_register(struct device_node *np,
>  	if (IS_ERR(cool_dev))
>  		goto remove_idr;
> =20
> +	/* Fill freq-table in descending order of frequencies */
> +	for (i =3D 0, freq =3D -1; i <=3D cpufreq_dev->max_level; i++) {
> +		freq =3D find_next_max(table, freq);
> +		cpufreq_dev->freq_table[i] =3D freq;
> +
> +		/* Warn for duplicate entries */
> +		if (!freq)
> +			pr_warn("%s: table has duplicate entries\n", __func__);
> +		else
> +			pr_debug("%s: freq:%u KHz\n", __func__, freq);
> +	}
> +
>  	cpufreq_dev->cool_dev =3D cool_dev;
>  	INIT_LIST_HEAD(&cpufreq_dev->head);
> =20
> @@ -394,6 +430,8 @@ __cpufreq_cooling_register(struct device_node *np,
> =20
>  remove_idr:
>  	idr_remove(&cpufreq_idr, cpufreq_dev->id);
> +free_table:
> +	kfree(cpufreq_dev->freq_table);
>  free_cdev:
>  	kfree(cpufreq_dev);
> =20
> @@ -467,6 +505,7 @@ void cpufreq_cooling_unregister(struct thermal_coolin=
g_device *cdev)
> =20
>  	thermal_cooling_device_unregister(cpufreq_dev->cool_dev);
>  	idr_remove(&cpufreq_idr, cpufreq_dev->id);
> +	kfree(cpufreq_dev->freq_table);
>  	kfree(cpufreq_dev);
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_cooling_unregister);
> --=20
> 2.0.3.693.g996b0fd
>=20

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUfklwAAoJEMLUO4d9pOJWEgAH/3pT8GpQMglcJShobRrTgYfU
vfz3WX6oV426+TkPE0g3tDHbPQyR83aet7/xRl3IChASvP1L4y5pxyGfzJBYWBQp
bpFrs+hzK6pE2xObqwWkFyLYmRhCOfNXYJNK8Y54Rp9pMDR2vdm2GUD8vbMtTbbV
gf/0/eF5g2P58A8pNoTmsS7yAeeR/+I/gjvMIcJ+Je+13P0FQeEXmXm2mfBJ3etO
qJ8Kx1dHGmyR9j5Ua6dmUG2YnnbGZV0l9vHx2mZzCC46unywY98CMGkif6Ha4QTN
kOW3a4DIC7I735FVnlrTc/W0QGDJS/IZRZbg4z03eoXgcDUREG0pb7WFMUVYAh4=
=b+xF
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
