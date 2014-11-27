From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 5/7] cpu_cooling: Don't match min/max frequencies for all
 CPUs on cooling register
Date: Thu, 27 Nov 2014 11:35:49 -0400
Message-ID: <20141127153547.GB22851@developer>
References: <cover.1416980447.git.viresh.kumar@linaro.org>
 <4bb7d02f8267ad9efd4dab070d72c2f2659bc752.1416980448.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:61606 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbaK0Pf6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Nov 2014 10:35:58 -0500
Received: by mail-qc0-f178.google.com with SMTP id b13so4041268qcw.23
        for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2014 07:35:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4bb7d02f8267ad9efd4dab070d72c2f2659bc752.1416980448.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, l.majewski@samsung.com


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2014 at 11:23:00AM +0530, Viresh Kumar wrote:
> In __cpufreq_cooling_register() we try to match min/max frequencies for a=
ll CPUs
> passed in 'clip_cpus' mask. This mask is the cpumask of cpus where the fr=
equency
> constraints will be applied.
>=20
> Same frequency constraint can be applied only to the CPUs belonging to th=
e same
> cluster (i.e. CPUs sharing clock line). For all such CPUs we have a single
> 'struct cpufreq_policy' structure managing them and so getting policies f=
or all
> CPUs wouldn't make any sense as they will all return the same pointer.
>=20
> So, remove this useless check of checking min/max for all CPUs. Also upda=
te doc
> comment to make this more obvious that clip_cpus should be same as
> policy->related_cpus.

Shall we also review the users of this API then? Simple to double check
if they are passing the correct value?


>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Sorry if I don't understand cpu-cooling well, haven't done much work on i=
t :(
>=20
>  drivers/thermal/cpu_cooling.c | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 1ab0018..1193cc4 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -420,6 +420,7 @@ static struct notifier_block thermal_cpufreq_notifier=
_block =3D {
>   * __cpufreq_cooling_register - helper function to create cpufreq coolin=
g device
>   * @np: a valid struct device_node to the cooling device device tree node
>   * @clip_cpus: cpumask of cpus where the frequency constraints will happ=
en.
> + * Normally this should be same as cpufreq policy->related_cpus.
>   *
>   * This interface function registers the cpufreq cooling device with the=
 name
>   * "thermal-cpufreq-%x". This api can support multiple instances of cpuf=
req
> @@ -435,25 +436,9 @@ __cpufreq_cooling_register(struct device_node *np,
>  {
>  	struct thermal_cooling_device *cool_dev;
>  	struct cpufreq_cooling_device *cpufreq_dev =3D NULL;
> -	unsigned int min =3D 0, max =3D 0;
>  	char dev_name[THERMAL_NAME_LENGTH];
> -	int ret =3D 0, i;
> -	struct cpufreq_policy policy;
> +	int ret =3D 0;
> =20
> -	/* Verify that all the clip cpus have same freq_min, freq_max limit */
> -	for_each_cpu(i, clip_cpus) {
> -		/* continue if cpufreq policy not found and not return error */
> -		if (!cpufreq_get_policy(&policy, i))
> -			continue;
> -		if (min =3D=3D 0 && max =3D=3D 0) {
> -			min =3D policy.cpuinfo.min_freq;
> -			max =3D policy.cpuinfo.max_freq;
> -		} else {
> -			if (min !=3D policy.cpuinfo.min_freq ||
> -			    max !=3D policy.cpuinfo.max_freq)
> -				return ERR_PTR(-EINVAL);
> -		}
> -	}
>  	cpufreq_dev =3D kzalloc(sizeof(struct cpufreq_cooling_device),
>  			      GFP_KERNEL);
>  	if (!cpufreq_dev)
> --=20
> 2.0.3.693.g996b0fd
>=20

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUd0TLAAoJEMLUO4d9pOJWrdgH/0nasBDNwHo8UikgnswpoJNE
lOWFmGA4xrxPB+3asqTv4H01kwaObCz5LW5iVIwEr0EbdvhQBAzuVoBdRDo/A0wT
njBGKb3ne86YNBeFXMlcXpNkGR9RMTtuwarQi8xaZ/omPfQUcrkrPZW7idywiHVo
/ppNmIk+byznnqo5ezr4KFcEdqXUcd2xI+ynS78rjTlRVdjIinJN6LGX9AxlL4/p
NFrxcjnO81w9tCowkJ1GWvtjvwF9Guq96FgkpH9TPdugTUKubqP+mY/GXKpAlznf
ncA4+4LirTzdfznmEH4gV+SXuhNQhd5E/vexLrhA2N7jItfi0pAJU5XQpQ10/8U=
=lDbZ
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
