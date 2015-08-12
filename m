From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [RFCv5 PATCH 16/46] sched: Allocate and initialize energy data
 structures
Date: Wed, 12 Aug 2015 18:09:59 +0100
Message-ID: <55CB7DE7.9060403@arm.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com> <1436293469-25707-17-git-send-email-morten.rasmussen@arm.com> <20150812101721.GV19282@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([146.101.78.143]:12007 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932325AbbHLRKH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 12 Aug 2015 13:10:07 -0400
In-Reply-To: <20150812101721.GV19282@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <Morten.Rasmussen@arm.com>
Cc: "mingo@redhat.com" <mingo@redhat.com>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "yuyang.du@intel.com" <yuyang.du@intel.com>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Juri Lelli <Juri.Lelli@arm.com>, "sgurrappadi@nvidia.com" <sgurrappadi@nvidia.com>, "pang.xunlei@zte.com.cn" <pang.xunlei@zte.com.cn>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 12/08/15 11:17, Peter Zijlstra wrote:
> On Tue, Jul 07, 2015 at 07:23:59PM +0100, Morten Rasmussen wrote:
>> @@ -6647,10 +6703,24 @@ static int __sdt_alloc(const struct cpumask *cpu_map)

[...]

>> @@ -6674,6 +6744,16 @@ static int __sdt_alloc(const struct cpumask *cpu_map)
>>  				return -ENOMEM;
>>  
>>  			*per_cpu_ptr(sdd->sgc, j) = sgc;
>> +
>> +			sge = kzalloc_node(sizeof(struct sched_group_energy) +
>> +				nr_idle_states*sizeof(struct idle_state) +
>> +				nr_cap_states*sizeof(struct capacity_state),
>> +				GFP_KERNEL, cpu_to_node(j));
>> +
>> +			if (!sge)
>> +				return -ENOMEM;
>> +
>> +			*per_cpu_ptr(sdd->sge, j) = sge;
>>  		}
>>  	}
>>  
> 
> One more question, if fn() returns a full structure, why are we
> allocating and copying the thing? Its all const read only data, right?
> 

Yeah, that's not strictly necessary. I could get rid of all the
allocation/copying/ and freeing code and just simply set sd->groups->sge
= fn(cpu) in init_sched_energy(). Plus delete the atomic_t ref in struct
sched_group_energy.

In this case, should I still keep the check_sched_energy_data() function
to verify that the scheduler got valid data via the struct
sched_domain_topology_level table from the arch, i.e. to make sure that
the per-cpu provided sd energy data is consistent for all cpus within
the sched group cpumask?

