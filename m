From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] CPUFreq: Add new sysfs attribute freqdomain_cpus for
 acpi-freq driver
Date: Tue, 25 Jun 2013 09:26:15 +0530
Message-ID: <CAKohpokUmvkkGwCDDa1d8OCz8YcsE2J0GQkA-dJ=EE+6REm7Mg@mail.gmail.com>
References: <1372126006-4950-1-git-send-email-tianyu.lan@intel.com>
	<1372126006-4950-2-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1372126006-4950-2-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: rjw@sisk.pl, lenb@kernel.org, jean-philippe.halimi@exascale-computing.eu, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 25 June 2013 07:36, Lan Tianyu <tianyu.lan@intel.com> wrote:
> diff --git a/Documentation/cpu-freq/user-guide.txt b/Documentation/cpu-freq/user-guide.txt
> index ff2f283..0cc72f7 100644
> --- a/Documentation/cpu-freq/user-guide.txt
> +++ b/Documentation/cpu-freq/user-guide.txt
> @@ -196,6 +196,10 @@ affected_cpus :                    List of Online CPUs that require software
>  related_cpus :                 List of Online + Offline CPUs that need software
>                                 coordination of frequency.
>
> +freqdomain_cpus :              List of Online + Offline CPUs in same CPU dependency
> +                               domain. (This is only available for acpi-cpufreq
> +                               driver)
> +

This is generic file, don't add this information here. Add this in
acpi-cpufreq file.

>  scaling_driver :               Hardware driver for cpufreq.
>
>  scaling_cur_freq :             Current frequency of the CPU as determined by
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 17e3496..b859997 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -176,6 +176,16 @@ static struct global_attr global_boost = __ATTR(boost, 0644,
>                                                 show_global_boost,
>                                                 store_global_boost);
>
> +static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
> +{
> +       struct acpi_cpufreq_data *data = per_cpu(acfreq_data, policy->cpu);
> +       struct acpi_processor_performance *perf = data->acpi_data;
> +
> +       return cpufreq_show_cpus(perf->shared_cpu_map, buf);
> +}

I am not sure if this is enough. Check this commit:

aa77a52764a92216b61a6c8079b5c01937c046cd

It had these changes:

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 937bc28..57a8774 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -730,7 +730,6 @@ static int acpi_cpufreq_cpu_init(struct
cpufreq_policy *policy)
            policy->shared_type == CPUFREQ_SHARED_TYPE_ANY) {
                cpumask_copy(policy->cpus, perf->shared_cpu_map);
        }
-       cpumask_copy(policy->related_cpus, perf->shared_cpu_map);

 #ifdef CONFIG_SMP
        dmi_check_system(sw_any_bug_dmi_table);
@@ -742,7 +741,6 @@ static int acpi_cpufreq_cpu_init(struct
cpufreq_policy *policy)
        if (check_amd_hwpstate_cpu(cpu) && !acpi_pstate_strict) {
                cpumask_clear(policy->cpus);
                cpumask_set_cpu(cpu, policy->cpus);
-               cpumask_copy(policy->related_cpus, cpu_sibling_mask(cpu));
                policy->shared_type = CPUFREQ_SHARED_TYPE_HW;
                pr_info_once(PFX "overriding BIOS provided _PSD data\n");
