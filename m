From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/2] cpufreq: scpi: remove arm_big_little dependency
Date: Wed, 10 Jan 2018 11:34:22 +0000
Message-ID: <65c2f2f9-b651-3608-2883-37cc9a3bd540@arm.com>
References: <1515516568-31359-1-git-send-email-sudeep.holla@arm.com>
 <1515516568-31359-3-git-send-email-sudeep.holla@arm.com>
 <20180110041905.GC3335@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180110041905.GC3335@vireshk-i7>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org



On 10/01/18 04:19, Viresh Kumar wrote:
> On 09-01-18, 16:49, Sudeep Holla wrote:
>> +static int
>> +scpi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
>>  {
>> -	return scpi_ops->get_transition_latency(cpu_dev);
>> +	int cpu, domain, tdomain;
>> +	struct device *tcpu_dev;
>> +
>> +	domain = scpi_ops->device_domain_id(cpu_dev);
>> +	if (domain < 0)
>> +		return domain;
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		if (cpu == cpu_dev->id)
>> +			continue;
>> +
>> +		tcpu_dev = get_cpu_device(cpu);
>> +		if (!tcpu_dev)
>> +			continue;
>> +
>> +		tdomain = scpi_ops->device_domain_id(tcpu_dev);
>> +		if (tdomain == domain)
>> +			cpumask_set_cpu(cpu, cpumask);
>> +	}
>> +
>> +	return 0;
>>  }
> 
> So this is the main thing you want to achieve ? i.e. get the
> policy->cpus from scpi_ops, right ?
> 

>From the looks of it yes, but...

> Why can't we update .init_opp_table() to include policy as a parameter
> and let individual stub drivers update policy->cpus then ?
> 

Possible, again but ...

There are few reasons why I would like remove scpi dependency on bL driver:

1. It has a notion of big and little which may not be true but that not
   much of a problem.

2. MAX_CLUSTER = 2 and scpi is getting used on multi-cluster systems
   though it was first tested on Juno which was bL system. There are
   quite a few internal FVP platforms that can manage to run with just
   proper DT with this change.

3. raw_cpu_to_cluster still calls topology_physical_package_id which
   breaks on these platforms and also with introduction of ACPI PPTT it
   will break on all ARM64 platforms.

4. We can still leave usage of topology_physical_package_id as is in
   arm_big_little.c worst case if it's going to be used only on ARM32
   For ARM64, topology_physical_package_id will be changed to give
   actual physical socket number which will be 0 for all multi-cluster
   (including bL) systems as along as they are single chip.

-- 
Regards,
Sudeep
