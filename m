From: Andy Tang <andy.tang@nxp.com>
Subject: RE: Ask for help on governor
Date: Fri, 15 Dec 2017 09:00:06 +0000
Message-ID: <HE1PR0402MB282849253906D2387281806FF30B0@HE1PR0402MB2828.eurprd04.prod.outlook.com>
References: <HE1PR0402MB282866171A847AE244A9F76CF3340@HE1PR0402MB2828.eurprd04.prod.outlook.com>
 <000801d37364$d48f6ed0$7dae4c70$@net> <000f01d373bf$deacca10$9c065e30$@net>
 <20171213061759.GT25177@vireshk-i7> P0QweRTHbuQ9TP0R1eouYx
 <000701d37479$e0570320$a1050960$@net> PJTJeNt3QC2CsPJTOebNwi
 <001f01d37544$5889d410$099d7c30$@net> PfELeWRWpC2CsPfENeiuYt
 <002001d37577$9706a730$c513f590$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-eopbgr10054.outbound.protection.outlook.com ([40.107.1.54]:22562
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753868AbdLOJAK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 15 Dec 2017 04:00:10 -0500
In-Reply-To: <002001d37577$9706a730$c513f590$@net>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Linux PM' <linux-pm@vger.kernel.org>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Stratos Karafotis' <stratosk@semaphore.gr>

Hi Doug,

> -----Original Message-----
> From: Doug Smythies [mailto:dsmythies@telus.net]
> Sent: Friday, December 15, 2017 3:38 PM
> To: Andy Tang <andy.tang@nxp.com>
> Cc: 'Rafael J. Wysocki' <rafael@kernel.org>; 'Rafael J. Wysocki'
> <rjw@rjwysocki.net>; 'Linux PM' <linux-pm@vger.kernel.org>; 'Viresh
> Kumar' <viresh.kumar@linaro.org>; 'Stratos Karafotis'
> <stratosk@semaphore.gr>
> Subject: RE: Ask for help on governor
>=20
> Hi Andy,
>=20
> Could you please try the below reversion patch.
> It is on top of kernel 4.15-rc3.
Tried, no any effects.

>=20
> On my system, and for the intel_cpufrequ scaling driver, the default
> sampling_rate goes back to 20000 (which works) from 500 uSec (which
> doesn't), for both the conservative and ondemand governors.
If I set the sampling_rate to 20,000 (actually 10,000 is enough), cpufreq w=
orks too for both the conservative and ondemand governors.
But on my platforms, the default rate is 1000 which leads to cpu load calcu=
lating issue.

Regards,
Andy

>=20
> From 2e914085991d02eb5e6a197aa75485f37742a535 Mon Sep 17 00:00:00
> 2001
> From: Doug Smythies <dsmythies@telus.net>
> Date: Thu, 14 Dec 2017 22:59:44 -0800
> Subject: [PATCH] Revert "cpufreq: Use transition_delay_us for legacy
> governors as well"
>=20
> This reverts commit aa7519af450d3c62a057aece24877c34562fa25a.
>=20
> There were issues with the default sampling_rate becoming to short for
> some versions of cpufreq conservative and ondemand governors to operate
> properly. The idle periods and load calculations broke down.
> ---
>  drivers/cpufreq/cpufreq.c          | 26 --------------------------
>  drivers/cpufreq/cpufreq_governor.c |  9 ++++++++-
>  include/linux/cpufreq.h            |  1 -
>  kernel/sched/cpufreq_schedutil.c   | 11 ++++++++++-
>  4 files changed, 18 insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c index
> 41d148a..9489901 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -530,32 +530,6 @@ unsigned int cpufreq_driver_resolve_freq(struct
> cpufreq_policy *policy,  }
> EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
>=20
> -unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy
> *policy) -{
> -       unsigned int latency;
> -
> -       if (policy->transition_delay_us)
> -               return policy->transition_delay_us;
> -
> -       latency =3D policy->cpuinfo.transition_latency / NSEC_PER_USEC;
> -       if (latency) {
> -               /*
> -                * For platforms that can change the frequency very fast =
(< 10
> -                * us), the above formula gives a decent transition delay=
. But
> -                * for platforms where transition_latency is in milliseco=
nds, it
> -                * ends up giving unrealistic values.
> -                *
> -                * Cap the default transition delay to 10 ms, which seems=
 to be
> -                * a reasonable amount of time after which we should reev=
aluate
> -                * the frequency.
> -                */
> -               return min(latency * LATENCY_MULTIPLIER, (unsigned int)10=
000);
> -       }
> -
> -       return LATENCY_MULTIPLIER;
> -}
> -EXPORT_SYMBOL_GPL(cpufreq_policy_transition_delay_us);
> -
>=20
> /**********************************************************
> ***********
>   *                          SYSFS INTERFACE                          *
>=20
> **********************************************************
> ***********/
> diff --git a/drivers/cpufreq/cpufreq_governor.c
> b/drivers/cpufreq/cpufreq_governor.c
> index 58d4f4e..6302eb4 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -392,6 +392,7 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy
> *policy)
>         struct dbs_governor *gov =3D dbs_governor_of(policy);
>         struct dbs_data *dbs_data;
>         struct policy_dbs_info *policy_dbs;
> +       unsigned int latency;
>         int ret =3D 0;
>=20
>         /* State should be equivalent to EXIT */ @@ -430,7 +431,13 @@ int
> cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
>         if (ret)
>                 goto free_policy_dbs_info;
>=20
> -       dbs_data->sampling_rate =3D cpufreq_policy_transition_delay_us(po=
licy);
> +       /* policy latency is in ns. Convert it to us first */
> +       latency =3D policy->cpuinfo.transition_latency / 1000;
> +       if (latency =3D=3D 0)
> +               latency =3D 1;
> +
> +       /* Bring kernel and HW constraints together */
> +       dbs_data->sampling_rate =3D LATENCY_MULTIPLIER * latency;
>=20
>         if (!have_governor_per_policy())
>                 gov->gdbs_data =3D dbs_data; diff --git a/include/linux/c=
pufreq.h
> b/include/linux/cpufreq.h index 065f3a8..75d5bd9 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -533,7 +533,6 @@ int __cpufreq_driver_target(struct cpufreq_policy
> *policy,
>                                    unsigned int relation);  unsigned int
> cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
>                                          unsigned int target_freq); -unsi=
gned int
> cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy);  int
> cpufreq_register_governor(struct cpufreq_governor *governor);  void
> cpufreq_unregister_governor(struct cpufreq_governor *governor);
>=20
> diff --git a/kernel/sched/cpufreq_schedutil.c
> b/kernel/sched/cpufreq_schedutil.c
> index 2f52ec0..a61d7fa 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -583,7 +583,16 @@ static int sugov_init(struct cpufreq_policy *policy)
>                 goto stop_kthread;
>         }
>=20
> -       tunables->rate_limit_us =3D cpufreq_policy_transition_delay_us(po=
licy);
> +       if (policy->transition_delay_us) {
> +               tunables->rate_limit_us =3D policy->transition_delay_us;
> +       } else {
> +               unsigned int lat;
> +
> +               tunables->rate_limit_us =3D LATENCY_MULTIPLIER;
> +               lat =3D policy->cpuinfo.transition_latency / NSEC_PER_USE=
C;
> +               if (lat)
> +                       tunables->rate_limit_us *=3D lat;
> +       }
>=20
>         policy->governor_data =3D sg_policy;
>         sg_policy->tunables =3D tunables;
> --
> 2.7.4
>=20
