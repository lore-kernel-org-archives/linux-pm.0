From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4] cpufreq: acpi_cpufreq: base frequency attribute support
Date: Thu, 03 Mar 2016 01:43:47 +0100
Message-ID: <1466378.uUxCvZYPPQ@vostro.rjw.lan>
References: <1456945994-5616-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:42512 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755158AbcCCAmF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Mar 2016 19:42:05 -0500
In-Reply-To: <1456945994-5616-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org

On Wednesday, March 02, 2016 11:13:14 AM Srinivas Pandruvada wrote:
> Currently scaling_available_frequencies displays list of available
> frequencies which can be used to set max/min or current scaling frequency.
> 
> $ cat scaling_available_frequencies
> 2301000 2300000 2200000 2000000 1900000 1800000 1700000 1500000 1400000
> 1300000 1100000 1000000 900000 800000 600000 500000
> 
> Here traditionally it is assumed that only 2301000 is a turbo frequency,
> which is purely opportunistic, anything else user can request and may
> get it.
> 
> But because of configurable thermal design power implementation in several
> Intel CPUs, the opportunistic frequency start can be any frequency in this
> range. For example it can be 2300000 or any lower value.
> This change adds an optional new attribute called "base_frequency",
> which displays the max non-turbo frequency (base frequency). For example:
> 
> $ cat base_frequency
> 2200000
> 
> This will allow user to choose a certain frequency which is not
> opportunistic.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> v4
> - Changes for s/>/$ /
> - new lines commmit description after paragraph
> - coding style for for "if (ret)" in show_base_frequency
> 
> v3
> -Merged Documentation and code patch to one patch.
> -Created a common function to read tar which is used init and during read
> -Documentation and code changed suggested by Viresh
> -On unsupported CPUs, user when tries to read base_frequency
> "Operation not supported" error will be returned.
> 
> v2
> sysfs_create_file on policy->kobj is no longer possible on recent kernel
> versions. So we can't create selectively create base_frequency attribute
> on supported policies.
> This version creates a base_frequency attribute, if the boot cpu supports
> as part of cpufreq_driver->attributes. If for some CPUs the TAR can't be
> read, return error.
> 
> v1:
> Base version
> 
> 
>  Documentation/cpu-freq/acpi-cpufreq.txt | 27 ++++++++++++++++++++
>  drivers/cpufreq/acpi-cpufreq.c          | 45 +++++++++++++++++++++++++++++++++
>  2 files changed, 72 insertions(+)
>  create mode 100644 Documentation/cpu-freq/acpi-cpufreq.txt
> 
> diff --git a/Documentation/cpu-freq/acpi-cpufreq.txt b/Documentation/cpu-freq/acpi-cpufreq.txt
> new file mode 100644
> index 0000000..8f719cf
> --- /dev/null
> +++ b/Documentation/cpu-freq/acpi-cpufreq.txt
> @@ -0,0 +1,26 @@
> +Additional sysfs attributes for acpi-cpufreq
> +
> +acpi-cpufreq sysfs has following sysfs attributes in addition to standard
> +cpufreq attributes:
> +
> +base_frequency :		Max non-turbo frequency
> +				For example:
> +				scaling_available_frequencies displays list
> +				of available frequencies.
> +
> +				$ cat scaling_available_frequencies
> +				2301000 2300000 2200000 2000000 1900000
> +				1800000 1700000 1500000 1400000 1300000
> +				1100000 1000000 900000 800000 600000
> +				500000
> +
> +				If the base_frequency attribute is present
> +				and readable, then any frequency above
> +				base_frequency is turbo frequency. For example
> +
> +				$ cat base_frequency
> +				2200000
> +
> +				Then in the above displayed list of
> +				scaling_available_frequencies, 2300000 and
> +				2301000 are turbo frequencies.

I'd add "That is, if any of these frequencies is requested, the processor will
be allowed to run at a frequency of its choice above base_frequency that need
not be equal to any of them and may be above the maximum listed one."

> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 51eef87..2706bb5 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -646,6 +646,37 @@ static int acpi_cpufreq_blacklist(struct cpuinfo_x86 *c)
>  }
>  #endif
>  
> +static int x86_get_turbo_activation_ratio(int cpu, u64 *tar)
> +{
> +	u64 plat_info;
> +	int err;
> +
> +	err = rdmsrl_safe_on_cpu(cpu, MSR_PLATFORM_INFO, &plat_info);
> +	/* Check number of config TDP levels > 0 */
> +	if (!err && ((plat_info >> 33) & 0x03) > 0)
> +		err = rdmsrl_safe_on_cpu(cpu, MSR_TURBO_ACTIVATION_RATIO,
> +					 tar);
> +	else
> +		err = -EOPNOTSUPP;
> +
> +	return err;

What about

	err = rdmsrl_safe_on_cpu(cpu, MSR_PLATFORM_INFO, &plat_info);
	if (err)
		return err;

	if (plat_info >> 33) & 0x03 > 0)
		return rdmsrl_safe_on_cpu(cpu, MSR_TURBO_ACTIVATION_RATIO, tar);

	return -ENXIO;

> +}

And I'd add

static inline bool boot_cpu_has_turbo_activation_ratio(void)
{
	u64 tar;

	return !x86_get_turbo_activation_ratio(0, &tar);
}

> +
> +static ssize_t show_base_frequency(struct cpufreq_policy *policy, char *buf)
> +{
> +	u64 tar;
> +	int err;
> +
> +	err = x86_get_turbo_activation_ratio(policy->cpu, &tar);
> +	if (err)
> +		return err;
> +
> +	/* Refer to IA64, IA32 SDM table 35-20, unit = 100 MHz */
> +	return sprintf(buf, "%llu\n", tar * 100000);
> +}
> +
> +cpufreq_freq_attr_ro(base_frequency);
> +
>  static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  {
>  	unsigned int i;
> @@ -888,6 +919,7 @@ static struct freq_attr *acpi_cpufreq_attr[] = {
>  #ifdef CONFIG_X86_ACPI_CPUFREQ_CPB
>  	&cpb,
>  #endif
> +	NULL, /* Extra space for base_frequency attr, if required */
>  	NULL,
>  };
>  
> @@ -971,6 +1003,19 @@ static int __init acpi_cpufreq_init(void)
>  			}
>  	}
>  #endif
> +
> +	if (boot_cpu_has(X86_FEATURE_IDA)) {
> +		u64 tar;
> +
> +		if (!x86_get_turbo_activation_ratio(0, &tar)) {
> +			struct freq_attr **attr;
> +
> +			for (attr = acpi_cpufreq_attr; *attr; attr++)
> +			;
> +			*attr = &base_frequency;
> +		}
> +	}
> +

What about doing it the way it is done for the CPB, that is, pointing
the entry to &base_frequency and clearing it if not supported later?

If you put it in front of &cpb, you only need one loop for the both of
them (attr has to be declared earlier):

	for (attr = acpi_cpufreq_attr; *attr; attr++) {
		if (*attr == &base_frequency && (!boot_cpu_has(X86_FEATURE_IDA)
		    || !boot_cpu_has_turbo_activation_ratio())) {
			struct freq_attr **next = attr + 1;

			*attr = *next;
			*next = NULL;
		}
#ifdef CONFIG_X86_ACPI_CPUFREQ_CPB
		if (*attr == &cpb && !check_amd_hwpstate_cpu(0)) {
			pr_debug("CPB unsupported, do not expose it\n");
			*attr = NULL;
			continue;
		}
#endif
	}



>  	acpi_cpufreq_boost_init();
>  
>  	ret = cpufreq_register_driver(&acpi_cpufreq_driver);
> 

Thanks,
Rafael

