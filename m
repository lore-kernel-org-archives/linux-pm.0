From: Andy Tang <andy.tang@nxp.com>
Subject: RE: [PATCH] cpufreq: governor: Ensure sufficiently large sampling
 intervals
Date: Mon, 18 Dec 2017 02:59:10 +0000
Message-ID: <HE1PR0402MB282810D71B9890FE90DADFCDF30E0@HE1PR0402MB2828.eurprd04.prod.outlook.com>
References: <HE1PR0402MB282866171A847AE244A9F76CF3340@HE1PR0402MB2828.eurprd04.prod.outlook.com>
 <002001d37577$9706a730$c513f590$@net> <002501d375d2$54f942c0$feebc840$@net>
 <5893809.nB6uDLgMiy@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-he1eur01on0054.outbound.protection.outlook.com ([104.47.0.54]:55168
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757810AbdLRC7N (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 17 Dec 2017 21:59:13 -0500
In-Reply-To: <5893809.nB6uDLgMiy@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Doug Smythies <dsmythies@telus.net>, 'Linux PM' <linux-pm@vger.kernel.org>
Cc: 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Stratos Karafotis' <stratosk@semaphore.gr>

Tested this patch on my platform, both conservative and ondemand governor w=
ork fine.
The default sampling_rate was updated from 1000 to 8000.

Thanks,
Andy

> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> Sent: Monday, December 18, 2017 9:16 AM
> To: Doug Smythies <dsmythies@telus.net>; Andy Tang
> <andy.tang@nxp.com>; 'Linux PM' <linux-pm@vger.kernel.org>
> Cc: 'Viresh Kumar' <viresh.kumar@linaro.org>; 'Stratos Karafotis'
> <stratosk@semaphore.gr>
> Subject: [PATCH] cpufreq: governor: Ensure sufficiently large sampling
> intervals
>=20
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> After commit aa7519af450d (cpufreq: Use transition_delay_us for legacy
> governors as well) the sampling_rate field of struct dbs_data may be less
> than the tick period which causes dbs_update() to produce incorrect resul=
ts,
> so make the code ensure that the value of that field will always be
> sufficiently large.
>=20
> Fixes: aa7519af450d (cpufreq: Use transition_delay_us for legacy governor=
s
> as well)
> Reported-by: Andy Tang <andy.tang@nxp.com>
> Reported-by: Doug Smythies <dsmythies@telus.net>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq_governor.c |   19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>=20
> Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
> +++ linux-pm/drivers/cpufreq/cpufreq_governor.c
> @@ -22,6 +22,8 @@
>=20
>  #include "cpufreq_governor.h"
>=20
> +#define CPUFREQ_DBS_MIN_SAMPLING_INTERVAL	(2 * TICK_NSEC /
> NSEC_PER_USEC)
> +
>  static DEFINE_PER_CPU(struct cpu_dbs_info, cpu_dbs);
>=20
>  static DEFINE_MUTEX(gov_dbs_data_mutex); @@ -47,11 +49,15 @@ ssize_t
> store_sampling_rate(struct gov_a  {
>  	struct dbs_data *dbs_data =3D to_dbs_data(attr_set);
>  	struct policy_dbs_info *policy_dbs;
> +	unsigned int sampling_interval;
>  	int ret;
> -	ret =3D sscanf(buf, "%u", &dbs_data->sampling_rate);
> -	if (ret !=3D 1)
> +
> +	ret =3D sscanf(buf, "%u", &sampling_interval);
> +	if (ret !=3D 1 || sampling_interval <
> CPUFREQ_DBS_MIN_SAMPLING_INTERVAL)
>  		return -EINVAL;
>=20
> +	dbs_data->sampling_rate =3D sampling_interval;
> +
>  	/*
>  	 * We are operating under dbs_data->mutex and so the list and its
>  	 * entries can't be freed concurrently.
> @@ -430,7 +436,14 @@ int cpufreq_dbs_governor_init(struct cpu
>  	if (ret)
>  		goto free_policy_dbs_info;
>=20
> -	dbs_data->sampling_rate =3D
> cpufreq_policy_transition_delay_us(policy);
> +	/*
> +	 * The sampling interval should not be less than the transition latency
> +	 * of the CPU and it also cannot be too small for dbs_update() to
> work
> +	 * correctly.
> +	 */
> +	dbs_data->sampling_rate =3D max_t(unsigned int,
> +
> 	CPUFREQ_DBS_MIN_SAMPLING_INTERVAL,
> +
> 	cpufreq_policy_transition_delay_us(policy));
>=20
>  	if (!have_governor_per_policy())
>  		gov->gdbs_data =3D dbs_data;
