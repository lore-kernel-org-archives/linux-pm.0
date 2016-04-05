From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 1/3] intel_pstate: Use pr_fmt
Date: Tue, 05 Apr 2016 14:43:39 -0700
Message-ID: <1459892619.7030.2.camel@linux.intel.com>
References: <cover.1459887986.git.joe@perches.com>
	 <710e23a9e0846d1aaa660849321e433b5f5dd4e7.1459887986.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:22219 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760304AbcDEV6F (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 5 Apr 2016 17:58:05 -0400
In-Reply-To: <710e23a9e0846d1aaa660849321e433b5f5dd4e7.1459887986.git.joe@perches.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joe Perches <joe@perches.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2016-04-05 at 13:28 -0700, Joe Perches wrote:
> Prefix the output using the more common kernel style.
>=20
> Signed-off-by: Joe Perches <joe@perches.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> =C2=A0drivers/cpufreq/intel_pstate.c | 18 ++++++++++--------
> =C2=A01 file changed, 10 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index a382195..e674db8 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -10,6 +10,8 @@
> =C2=A0 * of the License.
> =C2=A0 */
> =C2=A0
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> =C2=A0#include <linux/kernel.h>
> =C2=A0#include <linux/kernel_stat.h>
> =C2=A0#include <linux/module.h>
> @@ -436,7 +438,7 @@ static ssize_t store_no_turbo(struct kobject *a,
> struct attribute *b,
> =C2=A0
> =C2=A0	update_turbo_state();
> =C2=A0	if (limits->turbo_disabled) {
> -		pr_warn("intel_pstate: Turbo disabled by BIOS or
> unavailable on processor\n");
> +		pr_warn("Turbo disabled by BIOS or unavailable on
> processor\n");
> =C2=A0		return -EPERM;
> =C2=A0	}
> =C2=A0
> @@ -1107,7 +1109,7 @@ static int intel_pstate_init_cpu(unsigned int
> cpunum)
> =C2=A0
> =C2=A0	intel_pstate_busy_pid_reset(cpu);
> =C2=A0
> -	pr_debug("intel_pstate: controlling: cpu %d\n", cpunum);
> +	pr_debug("controlling: cpu %d\n", cpunum);
> =C2=A0
> =C2=A0	return 0;
> =C2=A0}
> @@ -1149,12 +1151,12 @@ static int intel_pstate_set_policy(struct
> cpufreq_policy *policy)
> =C2=A0
> =C2=A0	if (policy->policy =3D=3D CPUFREQ_POLICY_PERFORMANCE &&
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0policy->max >=3D policy->cpuinfo.max_f=
req) {
> -		pr_debug("intel_pstate: set performance\n");
> +		pr_debug("set performance\n");
> =C2=A0		limits =3D &performance_limits;
> =C2=A0		goto out;
> =C2=A0	}
> =C2=A0
> -	pr_debug("intel_pstate: set powersave\n");
> +	pr_debug("set powersave\n");
> =C2=A0	limits =3D &powersave_limits;
> =C2=A0	limits->min_policy_pct =3D (policy->min * 100) / policy-
> >cpuinfo.max_freq;
> =C2=A0	limits->min_policy_pct =3D clamp_t(int, limits-
> >min_policy_pct, 0 , 100);
> @@ -1206,7 +1208,7 @@ static void intel_pstate_stop_cpu(struct
> cpufreq_policy *policy)
> =C2=A0	int cpu_num =3D policy->cpu;
> =C2=A0	struct cpudata *cpu =3D all_cpu_data[cpu_num];
> =C2=A0
> -	pr_debug("intel_pstate: CPU %d exiting\n", cpu_num);
> +	pr_debug("CPU %d exiting\n", cpu_num);
> =C2=A0
> =C2=A0	intel_pstate_clear_update_util_hook(cpu_num);
> =C2=A0
> @@ -1451,7 +1453,7 @@ hwp_cpu_matched:
> =C2=A0	if (intel_pstate_platform_pwr_mgmt_exists())
> =C2=A0		return -ENODEV;
> =C2=A0
> -	pr_info("Intel P-state driver initializing.\n");
> +	pr_info("Intel P-state driver initializing\n");
> =C2=A0
> =C2=A0	all_cpu_data =3D vzalloc(sizeof(void *) *
> num_possible_cpus());
> =C2=A0	if (!all_cpu_data)
> @@ -1468,7 +1470,7 @@ hwp_cpu_matched:
> =C2=A0	intel_pstate_sysfs_expose_params();
> =C2=A0
> =C2=A0	if (hwp_active)
> -		pr_info("intel_pstate: HWP enabled\n");
> +		pr_info("HWP enabled\n");
> =C2=A0
> =C2=A0	return rc;
> =C2=A0out:
> @@ -1494,7 +1496,7 @@ static int __init intel_pstate_setup(char *str)
> =C2=A0	if (!strcmp(str, "disable"))
> =C2=A0		no_load =3D 1;
> =C2=A0	if (!strcmp(str, "no_hwp")) {
> -		pr_info("intel_pstate: HWP disabled\n");
> +		pr_info("HWP disabled\n");
> =C2=A0		no_hwp =3D 1;
> =C2=A0	}
> =C2=A0	if (!strcmp(str, "force"))
