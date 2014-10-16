From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix setting max_perf_pct in performance policy
Date: Thu, 16 Oct 2014 10:50:37 +0200
Message-ID: <2380747.QvGFG8o86Z@vostro.rjw.lan>
References: <1413415011-31290-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413415011-31290-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, 'Dirk Brandewie' <dirk.j.brandewie@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 'Dirk Brandewie' <dirk.brandewie@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thursday, October 16, 2014 01:16:51 AM Pali Roh=C3=A1r wrote:
> Code which changes policy to powersave changes also max_policy_pct ba=
sed on
> max_freq. Code which change max_perf_pct has upper limit base on valu=
e
> max_policy_pct. When policy is changing from powersave back to perfor=
mance
> then max_policy_pct is not changed. Which means that changing max_per=
f_pct is
> not possible to high values if max_freq was too low in powersave poli=
cy.

Dirk, what do you think?

> Test case:
>=20
> $ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
> 800000
> $ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
> 3300000
> $ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
> performance
> $ cat /sys/devices/system/cpu/intel_pstate/max_perf_pct
> 100
>=20
> $ echo powersave > /sys/devices/system/cpu/cpu0/cpufreq/scaling_gover=
nor
> $ echo 800000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
> $ echo 20 > /sys/devices/system/cpu/intel_pstate/max_perf_pct
>=20
> $ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
> powersave
> $ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
> 800000
> $ cat /sys/devices/system/cpu/intel_pstate/max_perf_pct
> 20
>=20
> $ echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_gov=
ernor
> $ echo 3300000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_fre=
q
> $ echo 100 > /sys/devices/system/cpu/intel_pstate/max_perf_pct
>=20
> $ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
> performance
> $ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
> 3300000
> $ cat /sys/devices/system/cpu/intel_pstate/max_perf_pct
> 24
>=20
> And now intel_pstate driver allows to set maximal value for max_perf_=
pct based
> on max_policy_pct which is 24 for previous powersave max_freq 800000.
>=20
> This patch will set default value for max_policy_pct when setting pol=
icy to
> performance so it will allow to set also max value for max_perf_pct.
>=20
> Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/cpufreq/intel_pstate.c |    1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_p=
state.c
> index 0668b38..7547ab5 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -714,6 +714,7 @@ static int intel_pstate_set_policy(struct cpufreq=
_policy *policy)
>  	if (policy->policy =3D=3D CPUFREQ_POLICY_PERFORMANCE) {
>  		limits.min_perf_pct =3D 100;
>  		limits.min_perf =3D int_tofp(1);
> +		limits.max_policy_pct =3D 100;
>  		limits.max_perf_pct =3D 100;
>  		limits.max_perf =3D int_tofp(1);
>  		limits.no_turbo =3D limits.turbo_disabled;
>=20

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
