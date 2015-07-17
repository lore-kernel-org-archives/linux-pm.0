From: ethan zhao <ethan.zhao@oracle.com>
Subject: Re: [PATCH RFC] intel_pstate: play well with frequency limits set
 by acpi
Date: Fri, 17 Jul 2015 14:00:04 +0800
Message-ID: <55A899E4.4030708@oracle.com>
References: <20150716181706.6500.64386.stgit@buzz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20150716181706.6500.64386.stgit@buzz>
Sender: linux-acpi-owner@vger.kernel.org
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Kristen Carlson Accardi <kristen@linux.intel.com>, Len Brown <lenb@kernel.org>
List-Id: linux-pm@vger.kernel.org


On 2015/7/17 2:17, Konstantin Khlebnikov wrote:
> IPMI can control CPU P-states remotely: configuration is reported via
> common ACPI interface (_PPC/_PSS/etc). This patch adds required minim=
al
> support in intel_pstate to receive and use these P-state limits.
>
> * ignore limit of top state in _PPC: it lower than turbo boost freque=
ncy
> * register intel_pstate in acpi-processor to get states from _PSS
> * link acpi_processor_get_bios_limit: this adds attribute "bios_limit=
"
>
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>   drivers/acpi/processor_perflib.c |    3 +-
>   drivers/cpufreq/intel_pstate.c   |   57 +++++++++++++++++++++++++++=
+++++++++++
>   2 files changed, 59 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processo=
r_perflib.c
> index cfc8aba72f86..781e328c9d5f 100644
> --- a/drivers/acpi/processor_perflib.c
> +++ b/drivers/acpi/processor_perflib.c
> @@ -98,7 +98,8 @@ static int acpi_processor_ppc_notifier(struct notif=
ier_block *nb,
>  =20
>   	ppc =3D (unsigned int)pr->performance_platform_limit;
>  =20
> -	if (ppc >=3D pr->performance->state_count)
> +	/* Ignore limit of top state: it lower than turbo boost frequency *=
/
> +	if (!ppc || ppc >=3D pr->performance->state_count)
  Perhaps the !ppc is wrong if we check it against ACPI spec.
  Zero value of ppc means:

  "0 =E2=80=93 States 0 through Nth state are available (all states ava=
ilable)"

>   		goto out;
>  =20
>   	cpufreq_verify_within_limits(policy, 0,
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_p=
state.c
> index 15ada47bb720..4a34ddf4fa73 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -26,6 +26,7 @@
>   #include <linux/fs.h>
>   #include <linux/debugfs.h>
>   #include <linux/acpi.h>
> +#include <acpi/processor.h>
>   #include <linux/vmalloc.h>
>   #include <trace/events/power.h>
>  =20
> @@ -113,6 +114,9 @@ struct cpudata {
>   	u64	prev_mperf;
>   	u64	prev_tsc;
>   	struct sample sample;
> +#ifdef CONFIG_ACPI_PROCESSOR
> +	struct acpi_processor_performance acpi_data;
> +#endif
>   };
>  =20
>   static struct cpudata **all_cpu_data;
> @@ -145,6 +149,7 @@ static int hwp_active;
>  =20
>   struct perf_limits {
>   	int no_turbo;
> +	int no_acpi;
>   	int turbo_disabled;
>   	int max_perf_pct;
>   	int min_perf_pct;
> @@ -158,6 +163,7 @@ struct perf_limits {
>  =20
>   static struct perf_limits limits =3D {
>   	.no_turbo =3D 0,
> +	.no_acpi =3D !IS_ENABLED(CONFIG_ACPI_PROCESSOR),
>   	.turbo_disabled =3D 0,
>   	.max_perf_pct =3D 100,
>   	.max_perf =3D int_tofp(1),
> @@ -449,6 +455,18 @@ static ssize_t store_min_perf_pct(struct kobject=
 *a, struct attribute *b,
>   	return count;
>   }
>  =20
> +static ssize_t store_no_acpi(struct kobject *a, struct attribute *b,
> +			     const char *buf, size_t count)
> +{
> +#ifdef CONFIG_ACPI_PROCESSOR
> +	return kstrtouint(buf, 0, &limits.no_acpi) ?: count;
> +#else
> +	return -ENODEV;
> +#endif
> +}
> +show_one(no_acpi, no_acpi);
> +define_one_global_rw(no_acpi);
> +
>   show_one(max_perf_pct, max_perf_pct);
>   show_one(min_perf_pct, min_perf_pct);
>  =20
> @@ -460,6 +478,7 @@ define_one_global_ro(num_pstates);
>  =20
>   static struct attribute *intel_pstate_attributes[] =3D {
>   	&no_turbo.attr,
> +	&no_acpi.attr,
>   	&max_perf_pct.attr,
>   	&min_perf_pct.attr,
>   	&turbo_pct.attr,
> @@ -1049,6 +1068,38 @@ static int intel_pstate_cpu_init(struct cpufre=
q_policy *policy)
>   	policy->cpuinfo.transition_latency =3D CPUFREQ_ETERNAL;
>   	cpumask_set_cpu(policy->cpu, policy->cpus);
>  =20
> +#ifdef CONFIG_ACPI_PROCESSOR
> +	if (!limits.no_acpi) {
> +		/*
> +		 * Minimum necessary to get acpi_processor_ppc_notifier() and
> +		 * acpi_processor_get_bios_limit() working.
> +		 */
> +		if (!zalloc_cpumask_var(&cpu->acpi_data.shared_cpu_map,
> +					GFP_KERNEL))
> +			rc =3D -ENOMEM;
> +		else
> +			rc =3D acpi_processor_register_performance(
> +					&cpu->acpi_data, policy->cpu);
> +		if (rc) {
> +			pr_err("intel_pstate: acpi init failed: %d\n", rc);
> +			free_cpumask_var(cpu->acpi_data.shared_cpu_map);
> +			limits.no_acpi =3D 1;
> +		}
> +	}
> +#endif
> +	return 0;
> +}
> +
> +static int intel_pstate_cpu_exit(struct cpufreq_policy *policy)
> +{
> +#ifdef CONFIG_ACPI_PROCESSOR
> +	struct cpudata *cpu =3D all_cpu_data[policy->cpu];
> +
> +	if (cpu->acpi_data.state_count)
> +		acpi_processor_unregister_performance(&cpu->acpi_data,
> +						      policy->cpu);
> +	free_cpumask_var(cpu->acpi_data.shared_cpu_map);
> +#endif
>   	return 0;
>   }
>  =20
> @@ -1057,7 +1108,11 @@ static struct cpufreq_driver intel_pstate_driv=
er =3D {
>   	.verify		=3D intel_pstate_verify_policy,
>   	.setpolicy	=3D intel_pstate_set_policy,
>   	.get		=3D intel_pstate_get,
> +#ifdef CONFIG_ACPI_PROCESSOR
> +	.bios_limit	=3D acpi_processor_get_bios_limit,
> +#endif
>   	.init		=3D intel_pstate_cpu_init,
> +	.exit		=3D intel_pstate_cpu_exit,
>   	.stop_cpu	=3D intel_pstate_stop_cpu,
>   	.name		=3D "intel_pstate",
>   };
> @@ -1286,6 +1341,8 @@ static int __init intel_pstate_setup(char *str)
>   		force_load =3D 1;
>   	if (!strcmp(str, "hwp_only"))
>   		hwp_only =3D 1;
> +	if (!strcmp(str, "no_acpi"))
> +		limits.no_acpi =3D 1;
>   	return 0;
>   }
>   early_param("intel_pstate", intel_pstate_setup);
>


  Thanks,
  Ethan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
