From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v8] cpufreq: Add SFI based cpufreq driver support
Date: Fri, 19 Dec 2014 02:20:00 -0500
Message-ID: <CAJvTdKkpsVGoN=v8h_=4uW=MJ=THPL1C4SKAMM9MBrQM4k30FA@mail.gmail.com>
References: <20141218085900.GA31027@intel-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:38195 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbaLSHUB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Dec 2014 02:20:01 -0500
Received: by mail-yk0-f169.google.com with SMTP id 79so136184ykr.0
        for <linux-pm@vger.kernel.org>; Thu, 18 Dec 2014 23:20:00 -0800 (PST)
In-Reply-To: <20141218085900.GA31027@intel-desktop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, vishwesh.m.rudramuni@intel.com

> v8:
...

> diff --git a/drivers/cpufreq/sfi-cpufreq.c b/drivers/cpufreq/sfi-cpufreq.c
> new file mode 100644
> index 000000000000..f9a913242537
> --- /dev/null
> +++ b/drivers/cpufreq/sfi-cpufreq.c
> @@ -0,0 +1,144 @@
> +/*
> + *  SFI Performance States Driver
...
> +static int sfi_cpufreq_cpu_init(struct cpufreq_policy *policy)
> +{
> +       struct cpufreq_frequency_table *freq_table;
> +       unsigned int i, result;
> +
> +       freq_table = kzalloc(sizeof(*freq_table) *
> +                       (num_freq_table_entries + 1), GFP_KERNEL);
> +       if (!freq_table)
> +               return -ENOMEM;
> +
> +       policy->shared_type = CPUFREQ_SHARED_TYPE_HW;
> +
> +       policy->cpuinfo.transition_latency = 100000;    /* 100us */

It would be better to use CPUFREQ_ETERNAL here
than to make up a number (100us)  asserting that it is valid for all possible
cores that might run this driver.   If we put a real number here, then people
will argue about how real it is when a different core runs this driver.
The fact of the matter is that only ondemand *consumes* this number,
and it compares it to 10,000,000 to see if can load.  Then it compares
MIN_LATENCY_MULTIPLIER (20) * latency, as a floor for min_sampling_rate,
which would otherwise default to MICRO_FREQUENCY_MIN_SAMPLE_RATE (10000).

ie. all number you give here that are less than
MICRO_FREQUENCY_MIN_SAMPLE_RATE/MIN_LATENCY_MULTIPLIER = 500us
are equivalent.

So just use -1 and avoid getting into a debate as to what this number really is.

> +       for (i = 0; i < num_freq_table_entries; i++) {
> +               /* initialize the freq table */

above comment adds no value to the two lines below, so you can remove
the comment.

> +               freq_table[i].driver_data = i;
> +               freq_table[i].frequency = sfi_cpufreq_array[i].freq_mhz * 1000;
> +       }
> +       freq_table[i].frequency = CPUFREQ_TABLE_END;
> +
> +       result = cpufreq_table_validate_and_show(policy, freq_table);

policy is PER_CPU
and sfi_cpufreq_cpu_init() will be called for every CPU in the system, yes?
So here we are kzalloc-ing and initializing an identical freq_table
for all the CPUs in the system.

But it does not appears that there is any per-cpu-specific data in that table.

As they are identical, can we allocate just one
and point all cpus to it?  We would free that one
after the last CPU has exited.

> +       if (result)
> +               goto err_free;
> +
> +       pr_debug("CPU%u - SFI freq driver activated.\n", policy->cpu);
> +
> +       return result;
> +
> +err_free:
> +       kfree(freq_table);
> +
> +       return result;
> +}
> +
> +static int sfi_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> +{
> +       kfree(policy->freq_table);
> +       return 0;
> +}

If we have a single system-wide copy of the cpufreq_frequency_table,
then we don't have any per-cpu state to clean-up,
and you can delete sfi_cpufreq_cpu_exit() entirely.

> +
> +static struct cpufreq_driver sfi_cpufreq_driver = {
> +       .flags          = CPUFREQ_CONST_LOOPS,
> +       .verify         = cpufreq_generic_frequency_table_verify,
> +       .target_index   = sfi_cpufreq_target,
> +       .init           = sfi_cpufreq_cpu_init,
> +       .exit           = sfi_cpufreq_cpu_exit,
> +       .name           = "sfi-cpufreq",
> +       .attr           = cpufreq_generic_attr,
> +};
> +
> +static int __init sfi_cpufreq_init(void)
> +{
> +       int ret;
> +
> +       /* parse the freq table from SFI */
> +       ret = sfi_table_parse(SFI_SIG_FREQ, NULL, NULL, sfi_parse_freq);
> +       if (ret)
> +               return ret;
> +
> +       return cpufreq_register_driver(&sfi_cpufreq_driver);
> +}
> +late_initcall(sfi_cpufreq_init);
> +
> +static void __exit sfi_cpufreq_exit(void)
> +{
> +       cpufreq_unregister_driver(&sfi_cpufreq_driver);
> +       kfree(sfi_cpufreq_array);

Here is where you'd also kfree the single copy of the cpufreq_frequency_table

> +}
> +module_exit(sfi_cpufreq_exit);
> +
> +MODULE_AUTHOR("Vishwesh M Rudramuni <vishwesh.m.rudramuni@intel.com>");
> +MODULE_DESCRIPTION("SFI Performance-States Driver");
> +MODULE_LICENSE("GPL");
> --

cheers,
Len Brown, Intel Open Source Technology Center
