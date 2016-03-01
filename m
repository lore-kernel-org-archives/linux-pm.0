From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: acpi_cpufreq: base frequency attribute support
Date: Tue, 1 Mar 2016 07:58:30 +0530
Message-ID: <20160301022830.GX2791@vireshk-i7>
References: <1456778205-19197-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35828 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbcCAC2e (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Feb 2016 21:28:34 -0500
Received: by mail-pf0-f179.google.com with SMTP id w128so58285253pfb.2
        for <linux-pm@vger.kernel.org>; Mon, 29 Feb 2016 18:28:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1456778205-19197-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org

On 29-02-16, 12:36, Srinivas Pandruvada wrote:
> Currently scaling_available_frequencies displays list of available
> frequencies which can be used to set max/min or current scaling frequency.
> 
> >cat scaling_available_frequencies
> 2301000 2300000 2200000 2000000 1900000 1800000 1700000 1500000 1400000
> 1300000 1100000 1000000 900000 800000 600000 500000
> 
> Here traditionally it is assumed that only 2301000 is a turbo frequency,
> which is purely opportunistic, anything else user can request and may
> get it.
> But because of configurable thermal design power implementation in several
> Intel CPUs, the opportunistic frequency start can be any frequency in this
> range. For example it can be 2300000 or any lower value.
> This change adds an optional new attribute called "base_frequency",
> which displays the max non-turbo frequency (base frequency). For example:
> >cat base_frequency
> 2200000
> This will allow user to choose a certain frequency which is not
> opportunistic.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---

You missed adding a version log and V2 in subject :(

>  drivers/cpufreq/acpi-cpufreq.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 51eef87..76edd28 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -646,6 +646,21 @@ static int acpi_cpufreq_blacklist(struct cpuinfo_x86 *c)
>  }
>  #endif
>  
> +static ssize_t show_base_frequency(struct cpufreq_policy *policy, char *buf)
> +{
> +	u64 tar;
> +	int err;
> +
> +	err = rdmsrl_safe_on_cpu(policy->cpu, MSR_TURBO_ACTIVATION_RATIO, &tar);
> +	if (!err)

So, this will automatically take care of checking if a CPU has support
for it or not, right ?

> +		/* Refer to IA64, IA32 SDM table 35-20, unit = 100 MHz */
> +		return sprintf(buf, "%llu\n", tar * 100000);
> +
> +	return err;
> +}
> +
> +cpufreq_freq_attr_ro(base_frequency);
> +
>  static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  {
>  	unsigned int i;
> @@ -889,6 +904,7 @@ static struct freq_attr *acpi_cpufreq_attr[] = {
>  	&cpb,
>  #endif
>  	NULL,
> +	NULL,

Its not straight forward, so please add a comment (like cpufreq-dt),
that what the first NULL is going to be used for.

>  };
>  
>  static struct cpufreq_driver acpi_cpufreq_driver = {
> @@ -971,6 +987,26 @@ static int __init acpi_cpufreq_init(void)
>  			}
>  	}
>  #endif
> +
> +	if (boot_cpu_has(X86_FEATURE_IDA)) {
> +		u64 plat_info, tar;
> +		int err;
> +
> +		err = rdmsrl_safe_on_cpu(0, MSR_PLATFORM_INFO, &plat_info);
> +		/* Check number of config TDP levels > 0 */
> +		if (!err && ((plat_info >> 33) & 0x03) > 0) {
> +			err = rdmsrl_safe_on_cpu(0, MSR_TURBO_ACTIVATION_RATIO,
> +						 &tar);
> +			if (!err) {

Maybe just:
        if (!rdmsrl_safe_on_cpu(0, MSR_TURBO_ACTIVATION_RATIO, &tar)) {
                ...
        }

> +				struct freq_attr **attr;
> +
> +				for (attr = acpi_cpufreq_attr; *attr; attr++)
> +				;
> +				*attr = &base_frequency;

What about:

                                acpi_cpufreq_attr[ARRAY_SIZE(acpi_cpufreq_attr) - 2] = &base_frequency;

                                and a comment to describe that ?

> +			}
> +		}
> +	}
> +
>  	acpi_cpufreq_boost_init();
>  
>  	ret = cpufreq_register_driver(&acpi_cpufreq_driver);
> -- 
> 2.4.3

-- 
viresh
