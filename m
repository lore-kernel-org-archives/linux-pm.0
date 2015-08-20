From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [RFCv5, 18/46] arm: topology: Define TC2 energy and provide it
 to the scheduler
Date: Thu, 20 Aug 2015 12:19:29 -0700
Message-ID: <55D62841.7030501@arm.com>
References: <1436293469-25707-19-git-send-email-morten.rasmussen@arm.com> <20150817091942.GA754@leoy-linaro>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([146.101.78.143]:64939 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751585AbbHTTTh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 20 Aug 2015 15:19:37 -0400
In-Reply-To: <20150817091942.GA754@leoy-linaro>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>, Morten Rasmussen <Morten.Rasmussen@arm.com>
Cc: "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "yuyang.du@intel.com" <yuyang.du@intel.com>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Juri Lelli <Juri.Lelli@arm.com>, "sgurrappadi@nvidia.com" <sgurrappadi@nvidia.com>, "pang.xunlei@zte.com.cn" <pang.xunlei@zte.com.cn>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>

Hi Leo,

On 08/17/2015 02:19 AM, Leo Yan wrote:

[...]

>> diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
>> index b35d3e5..bbe20c7 100644
>> --- a/arch/arm/kernel/topology.c
>> +++ b/arch/arm/kernel/topology.c
>> @@ -274,6 +274,119 @@ void store_cpu_topology(unsigned int cpuid)
>>   		cpu_topology[cpuid].socket_id, mpidr);
>>   }
>>
>> +/*
>> + * ARM TC2 specific energy cost model data. There are no unit requirements for
>> + * the data. Data can be normalized to any reference point, but the
>> + * normalization must be consistent. That is, one bogo-joule/watt must be the
>> + * same quantity for all data, but we don't care what it is.
>> + */
>> +static struct idle_state idle_states_cluster_a7[] = {
>> +	 { .power = 25 }, /* WFI */
>
> This state is confused. Is this state corresponding to all CPUs have been
> powered off but L2 cache RAM array and SCU are still power on?

This is what we refer to as 'active idle'. All cpus of the cluster are 
in WFI but the cluster is not in cluster-sleep yet. We measure the 
corresponding energy value by disabling the 'cluster-sleep-[b,l]' state 
and let the cpus do nothing for a specific time period.
>
>> +	 { .power = 10 }, /* cluster-sleep-l */
>
> Is this status means all CPU and cluster have been powered off, if so
> then it will have no power consumption anymore...

The cluster is in cluster-sleep but there is still some peripheral 
related to the cluster active which explains this power value we 
calculated from the pre/post energy value diff (by reading the vexpress 
energy counter for this cluster) and the time period we were idling on 
this cluster.

>
>> +	};
>> +
>> +static struct idle_state idle_states_cluster_a15[] = {
>> +	 { .power = 70 }, /* WFI */
>> +	 { .power = 25 }, /* cluster-sleep-b */
>> +	};
>> +
>> +static struct capacity_state cap_states_cluster_a7[] = {
>> +	/* Cluster only power */
>> +	 { .cap =  150, .power = 2967, }, /*  350 MHz */
>
> For cluster level's capacity, does it mean need run benchmark on all
> CPUs within cluster?

We run an 'always running thread per cpu' workload on {n, n-1, ..., 1} 
cpus of a cluster (hotplug-out the other cpus) for a specific time 
period. Then we calculate the cluster power value by extrapolating from 
the power values for the {n, n-1, ... 1} test runs and use the delta 
between a n and n+1 test run value as core power value.

[...]

>> +static struct idle_state idle_states_core_a7[] = {
>> +	 { .power = 0 }, /* WFI */
>
> Should have two idle states for CPU level (WFI and CPU's power off)?

The ARM TC2 platform has only 2 idle states, there is no 'cpu power off':

# cat /sys/devices/system/cpu/cpu[0,2]/cpuidle/state*/name
WFI
cluster-sleep-b
WFI
cluster-sleep-l

[...]

