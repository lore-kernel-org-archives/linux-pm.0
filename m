From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 21/26] cpu_cooling: create list of cpufreq_cooling_devices
Date: Tue, 2 Dec 2014 19:12:32 -0400
Message-ID: <20141202231230.GF3432@developer>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
 <451cea6e5f417b0e76747ea8d8f3aa852f8bbf54.1417167599.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3yNHWXBV/QO9xKNm"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:36181 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933373AbaLBXMl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Dec 2014 18:12:41 -0500
Received: by mail-qc0-f179.google.com with SMTP id c9so10091235qcz.24
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2014 15:12:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <451cea6e5f417b0e76747ea8d8f3aa852f8bbf54.1417167599.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, rui.zhang@intel.com


--3yNHWXBV/QO9xKNm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Viresh,

On Fri, Nov 28, 2014 at 03:14:15PM +0530, Viresh Kumar wrote:
> That will be used by later patches to iterate over all cpufreq cooling de=
vices.
>=20

Can you please refresh the series on top of latest Linus tree (material
for 3.18-rc7) ?


> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/thermal/cpu_cooling.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index ddb97aa..f76a665 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -66,8 +66,11 @@ struct cpufreq_cooling_device {
>  	unsigned int cpufreq_val;
>  	unsigned int max_level;
>  	struct cpumask allowed_cpus;
> +	struct list_head head;

Yadwinder has already introduced a list of cpu cooling devs:
commit 2dcd851fe4b4fe60c2f8520bf7668d7e9b2dd76b
Author: Yadwinder Singh Brar <yadi.brar@samsung.com>
Date:   Fri Nov 7 19:12:29 2014 +0530

    thermal: cpu_cooling: Update always cpufreq policy with thermal
    constraints
       =20
>  };
> +
>  static DEFINE_IDR(cpufreq_idr);
> +static LIST_HEAD(cpufreq_dev_list);
>  static DEFINE_MUTEX(cooling_cpufreq_lock);
> =20
>  static unsigned int cpufreq_dev_count;
> @@ -372,6 +375,7 @@ __cpufreq_cooling_register(struct device_node *np,
>  		goto remove_idr;
> =20
>  	cpufreq_dev->cool_dev =3D cool_dev;
> +	INIT_LIST_HEAD(&cpufreq_dev->head);
> =20
>  	mutex_lock(&cooling_cpufreq_lock);
> =20
> @@ -381,6 +385,7 @@ __cpufreq_cooling_register(struct device_node *np,
>  					  CPUFREQ_POLICY_NOTIFIER);
>  	cpufreq_dev_count++;
> =20
> +	list_add(&cpufreq_dev->head, &cpufreq_dev_list);
>  	mutex_unlock(&cooling_cpufreq_lock);
> =20
>  	return cool_dev;
> @@ -451,6 +456,7 @@ void cpufreq_cooling_unregister(struct thermal_coolin=
g_device *cdev)
>  	cpufreq_dev =3D cdev->devdata;
>  	mutex_lock(&cooling_cpufreq_lock);
>  	cpufreq_dev_count--;
> +	list_del(&cpufreq_dev->head);
> =20
>  	/* Unregister the notifier for the last cpufreq cooling device */
>  	if (cpufreq_dev_count =3D=3D 0)
> --=20
> 2.0.3.693.g996b0fd
>=20

--3yNHWXBV/QO9xKNm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUfkdVAAoJEMLUO4d9pOJWd4oIAKALYE+kT+ZnZOmMVOoHOC4+
Vw88yXqhsNpcx8iaiRe/G5RTxTDklZIqAa05Z/5axMO3MXuHjQn8ykq22xR7V7hN
zNifDMFmn1/TD+lNmRSoyLndXDMd4IvMP/hB3VVxOt+5r0G2qT3fbtWwQSRdJTuD
GXFT5ZkCKajQbA68mpGb5GmhC7OC/FNJscICmUvcsaqvCVSHbz+nn1t2sTA3HroV
ZToZdwp3xPSpjlOSCuNuo1z+eVVjm2yN5PS/p2IuTdzmnT4fZdQc26twtvCCN+mE
ywSkLJmYzJLXoalsIsV70Z05oyz7UOFtFTLhPEq/yuqOBDS2NjRg6PqOzQp8DPQ=
=Cr3a
-----END PGP SIGNATURE-----

--3yNHWXBV/QO9xKNm--
