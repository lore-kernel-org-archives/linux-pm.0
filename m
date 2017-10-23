From: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH v3 6/7] arm64: topology: Enable ACPI/PPTT based CPU
 topology.
Date: Mon, 23 Oct 2017 16:26:33 -0500
Message-ID: <47a192d0-33e8-4159-ed32-910d5ad7a743@arm.com>
References: <20171012194856.13844-1-jeremy.linton@arm.com>
 <20171012194856.13844-7-jeremy.linton@arm.com>
 <20171019155622.GC18883@red-moon>
 <6a9836f5-d31c-67fb-b2dd-bc0972ebb1c2@arm.com>
 <20171020091428.GA21060@red-moon>
 <e2772689-603b-f129-0643-f5d1f5e41a19@arm.com>
 <e4781c4d-005a-aa6f-6a48-2cec3eb04da2@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44746 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750835AbdJWV0j (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 23 Oct 2017 17:26:39 -0400
In-Reply-To: <e4781c4d-005a-aa6f-6a48-2cec3eb04da2@codeaurora.org>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jeffrey Hugo <jhugo@codeaurora.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, hanjun.guo@linaro.org, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org

Hi,

On 10/20/2017 02:55 PM, Jeffrey Hugo wrote:
> On 10/20/2017 10:14 AM, Jeremy Linton wrote:
>> Hi,
>>
>> On 10/20/2017 04:14 AM, Lorenzo Pieralisi wrote:
>>> On Thu, Oct 19, 2017 at 11:13:27AM -0500, Jeremy Linton wrote:
>>>> On 10/19/2017 10:56 AM, Lorenzo Pieralisi wrote:
>>>>> On Thu, Oct 12, 2017 at 02:48:55PM -0500, Jeremy Linton wrote:
>>>>>> Propagate the topology information from the PPTT tree to the
>>>>>> cpu_topology array. We can get the thread id, core_id and
>>>>>> cluster_id by assuming certain levels of the PPTT tree correspond
>>>>>> to those concepts. The package_id is flagged in the tree and can be
>>>>>> found by passing an arbitrary large level to 
>>>>>> setup_acpi_cpu_topology()
>>>>>> which terminates its search when it finds an ACPI node flagged
>>>>>> as the physical package. If the tree doesn't contain enough
>>>>>> levels to represent all of thread/core/cod/package then the package
>>>>>> id will be used for the missing levels.
>>>>>>
>>>>>> Since server/ACPI machines are more likely to be multisocket and 
>>>>>> NUMA,
>>>>>
>>>>> I think this stuff is vague enough already so to start with I would 
>>>>> drop
>>>>> patch 4 and 5 and stop assuming what machines are more likely to ship
>>>>> with ACPI than DT.
>>>>>
>>>>> I am just saying, for the umpteenth time, that these levels have no
>>>>> architectural meaning _whatsoever_, level is a hierarchy concept
>>>>> with no architectural meaning attached.
>>>>
>>>> ?
>>>>
>>>> Did anyone say anything about that? No, I think the only thing being
>>>> guaranteed here is that the kernel's physical_id maps to an ACPI
>>>> defined socket. Which seems to be the mindset of pretty much the
>>>> entire !arm64 community meaning they are optimizing their software
>>>> and the kernel with that concept in mind.
>>>>
>>>> Are you denying the existence of non-uniformity between threads
>>>> running on different physical sockets?
>>>
>>> No, I have not explained my POV clearly, apologies.
>>>
>>> AFAIK, the kernel currently deals with 2 (3 - if SMT) topology layers.
>>>
>>> 1) thread
>>> 2) core
>>> 3) package
>>>
>>> What I wanted to say is, that, to simplify this series, you do not need
>>> to introduce the COD topology level, since it is just another arbitrary
>>> topology level (ie there is no way you can pinpoint which level
>>> corresponds to COD with PPTT - or DT for the sake of this discussion)
>>> that would not be used in the kernel (apart from big.LITTLE cpufreq
>>> driver and PSCI checker whose usage of topology_physical_package_id() is
>>> questionable anyway).
>>
>> Oh! But, i'm at a loss as to what to do with those two users if I set 
>> the node which has the physical socket flag set, as the "cluster_id" 
>> in the topology.
>>
>> Granted, this being ACPI I don't expect the cpufreq driver to be 
>> active (given CPPC) and the psci checker might be ignored? Even so, 
>> its a bit of a misnomer what is actually happening. Are we good with 
>> this?
>>
>>
>>>
>>> PPTT allows you to define what level corresponds to a package, use
>>> it to initialize the package topology level (that on ARM internal
>>> variables we call cluster) and be done with it.
>>>
>>> I do not think that adding another topology level improves anything as
>>> far as ACPI topology detection is concerned, you are not able to use it
>>> in the scheduler or from userspace to group CPUs anyway.
>>
>> Correct, and AFAIK after having poked a bit at the scheduler its sort 
>> of redundant as the generic cache sharing levels are more useful anyway.
> 
> What do you mean, it can't be used?  We expect a followup series which 
> uses PPTT to define scheduling domains/groups.
> 
> The scheduler supports 4 types of levels, with an arbitrary number of 
> instances of each - NUMA, DIE (package, usually not used with NUMA), MC 
> (multicore, typically cores which share resources like cache), SMT 
> (threads).

It turns out to be pretty easy to map individual PPTT "levels" to MC 
layers simply by creating a custom sched_domain_topology_level and 
populating it with an equal number of MC layers. The only thing that 
changes is the "mask" portion of each entry.

Whether that is good/bad vs just using a topology like:

static struct sched_domain_topology_level arm64_topology[] = {
#ifdef CONFIG_SCHED_SMT
        { cpu_smt_mask, cpu_smt_flags, SD_INIT_NAME(SMT) },
#endif
        { cpu_cluster_mask, cpu_core_flags, SD_INIT_NAME(CLU) },
#ifdef CONFIG_SCHED_MC
        { cpu_coregroup_mask, cpu_core_flags, SD_INIT_NAME(MC) },
#endif
        { cpu_cpu_mask, SD_INIT_NAME(DIE) },
        { NULL, },
};

and using it on successful ACPI/PPTT parse, along with a new 
cpu_cluster_mask isn't clear to me either. Particularly, if one goes in 
and starts changing the "cpu_core_flags" for starters to the cpu_smt_flags.


But as mentioned I think this is a follow on patch which meshes with 
patches 4/5 here.



> 
> Our particular platform has a single socket/package, with multiple 
> "clusters", each cluster consisting of multiple cores that share caches. 
>   We represent all of this in PPTT, and expect it to be used.  Leaf 
> nodes are cores.  The level above is the cluster.  The top level is the 
> package.  We expect eventually (and understand that Jeremy is not 
> tackling this with his current series) that clusters get represented MC 
> so that migrated processes prefer their cache-shared siblings, and the 
> entire package is represented by DIE.
> 
> This will have to come from PPTT since you can't use core_siblings to 
> derive this.  Additionally, if we had multiple layers of clustering, we 
> would expect each layer to be represented by MC.  Topology.c has none of 
> this support today.
> 
> PPTT can refer to SLIT/SRAT to determine if a hirearchy level 
> corresponds to the "Cluster-on-Die" concept of other architectures 
> (which end up as NUMA nodes in NUMA scheduling domains).
> 
> What PPTT will have to do is parse the tree(s), determine what each 
> level is - SMT, MC, NUMA, DIE - and then use set_sched_topology() so 
> that the scheduler can build up groups/domains appropriately.
> 
> 
> Jeremy, we've tested v3 on our platform.  The topology part works as 
> expected, we no longer see lstopo reporting sockets where there are 
> none, but the scheduling groups are broken (expected).  Caches still 
> don't work right (no sizes reported, and the sched caches are not 
> attributed to the cores).  We will likely have additional comments as we 
> delve into it.
>>
>>>
>>> Does this answer your question ?
>> Yes, other than what to do with the two drivers.
>>
>>>
>>> Thanks,
>>> Lorenzo
>>>
>>
> 
> 
