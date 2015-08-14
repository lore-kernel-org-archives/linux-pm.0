From: Sai Gurrappadi <sgurrappadi@nvidia.com>
Subject: Re: [RFCv5 PATCH 28/46] sched: Count number of shallower idle-states
 in struct sched_group_energy
Date: Fri, 14 Aug 2015 12:08:16 -0700
Message-ID: <55CE3CA0.3010407@nvidia.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com> <1436293469-25707-29-git-send-email-morten.rasmussen@arm.com> <20150813181025.GA19282@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10611 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbbHNTJ4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Aug 2015 15:09:56 -0400
In-Reply-To: <20150813181025.GA19282@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>
Cc: mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, pboonstoppel@nvidia.com


On 08/13/2015 11:10 AM, Peter Zijlstra wrote:
> On Tue, Jul 07, 2015 at 07:24:11PM +0100, Morten Rasmussen wrote:
>> cpuidle associates all idle-states with each cpu while the energy model
>> associates them with the sched_group covering the cpus coordinating
>> entry to the idle-state. To look up the idle-state power consumption in
>> the energy model it is therefore necessary to translate from cpuidle
>> idle-state index to energy model index. For this purpose it is helpful
>> to know how many idle-states that are listed in lower level sched_groups
>> (in struct sched_group_energy).
>>
>> Example: ARMv8 big.LITTLE JUNO (Cortex A57, A53) idle-states:
>> Idle-state              cpuidle         Energy model table indices
>>                         index           per-cpu sg      per-cluster sg
>> WFI                     0               0               (0)
>> Core power-down         1               1               0*
>> Cluster power-down      2               (1)             1
>>
>> For per-cpu sgs no translation is required. If cpuidle reports state
>> index 0 or 1, the cpu is in WFI or core power-down, respectively. We can
>> look the idle-power up directly in the sg energy model table.
> 
> OK..
> 
>> Idle-state
>> cluster power-down, is represented in the per-cluster sg energy model
>> table as index 1. Index 0* is reserved for cluster power consumption
>> when the cpus all are in state 0 or 1, but cpuidle decided not to go for
>> cluster power-down.
> 
> 0* is not an integer.
> 
>> Given the index from cpuidle we can compute the
>> correct index in the energy model tables for the sgs at each level if we
>> know how many states are in the tables in the child sgs. The actual
>> translation is implemented in a later patch.
> 
> And you've lost me... I've looked at that later patch (its the next one)
> and I cannot say I'm less confused.
> 

I think I understand this roughly but I don't understand why this isn't as simple as describing the power consumption at core and cluster level for each cpuidle state. If a particular cpuidle state has no real impact at the cluster level, then can't we just describe that in the power model? Sorry if this has already been discussed.

Every cpuidle state is essentially a Cx/CCx combination. For the WFI/core pd case above, the cluster state turns out to be CC0 (cluster 'active').

Thanks,
-Sai
