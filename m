From: Paul Turner <pjt@google.com>
Subject: Re: [RFC v3 1/5] sched/core: add capacity constraints to CPU controller
Date: Thu, 30 Mar 2017 14:15:59 -0700
Message-ID: <CAPM31RJtWrvAk54gnjtDqpjmRf98D-aEqvcO39Qz7BiJWc457A@mail.gmail.com>
References: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
 <1488292722-19410-2-git-send-email-patrick.bellasi@arm.com>
 <20170320171511.GB3623@htj.duckdns.org> <20170320180837.GB28391@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.161.182]:33571 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbdC3VQb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Mar 2017 17:16:31 -0400
Received: by mail-yw0-f182.google.com with SMTP id v76so30427032ywg.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Mar 2017 14:16:30 -0700 (PDT)
In-Reply-To: <20170320180837.GB28391@e110439-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>

On Mon, Mar 20, 2017 at 11:08 AM, Patrick Bellasi
<patrick.bellasi@arm.com> wrote:
> On 20-Mar 13:15, Tejun Heo wrote:
>> Hello,
>>
>> On Tue, Feb 28, 2017 at 02:38:38PM +0000, Patrick Bellasi wrote:
>> > This patch extends the CPU controller by adding a couple of new
>> > attributes, capacity_min and capacity_max, which can be used to enforce
>> > bandwidth boosting and capping. More specifically:
>> >
>> > - capacity_min: defines the minimum capacity which should be granted
>> >                 (by schedutil) when a task in this group is running,
>> >                 i.e. the task will run at least at that capacity
>> >
>> > - capacity_max: defines the maximum capacity which can be granted
>> >                 (by schedutil) when a task in this group is running,
>> >                 i.e. the task can run up to that capacity
>>
>> cpu.capacity.min and cpu.capacity.max are the more conventional names.
>
> Ok, should be an easy renaming.
>
>> I'm not sure about the name capacity as it doesn't encode what it does
>> and is difficult to tell apart from cpu bandwidth limits.  I think
>> it'd be better to represent what it controls more explicitly.
>
> In the scheduler jargon, capacity represents the amount of computation
> that a CPU can provide and it's usually defined to be 1024 for the
> biggest CPU (on non SMP systems) running at the highest OPP (i.e.
> maximum frequency).
>
> It's true that it kind of overlaps with the concept of "bandwidth".
> However, the main difference here is that "bandwidth" is not frequency
> (and architecture) scaled.
> Thus, for example, assuming we have only one CPU with these two OPPs:
>
>    OPP | Frequency | Capacity
>      1 |    500MHz |      512
>      2 |      1GHz |     1024

I think exposing capacity in this manner is extremely challenging.
It's not normalized in any way between architectures, which places a
lot of the ABI in the API.

Have you considered any schemes for normalizing this in a reasonable fashion?
`
>
> a task running 60% of the time on that CPU when configured to run at
> 500MHz, from the bandwidth standpoint it's using 60% bandwidth but, from
> the capacity standpoint, is using only 30% of the available capacity.
>
> IOW, bandwidth is purely temporal based while capacity factors in both
> frequency and architectural differences.
> Thus, while a "bandwidth" constraint limits the amount of time a task
> can use a CPU, independently from the "actual computation" performed,
> with the new "capacity" constraints we can enforce much "actual
> computation" a task can perform in the "unit of time".
>
>> > These attributes:
>> > a) are tunable at all hierarchy levels, i.e. root group too
>>
>> This usually is problematic because there should be a non-cgroup way
>> of configuring the feature in case cgroup isn't configured or used,
>> and it becomes awkward to have two separate mechanisms configuring the
>> same thing.  Maybe the feature is cgroup specific enough that it makes
>> sense here but this needs more explanation / justification.
>
> In the previous proposal I used to expose global tunables under
> procfs, e.g.:
>
>  /proc/sys/kernel/sched_capacity_min
>  /proc/sys/kernel/sched_capacity_max
>
> which can be used to defined tunable root constraints when CGroups are
> not available, and becomes RO when CGroups are.
>
> Can this be eventually an acceptable option?
>
> In any case I think that this feature will be mainly targeting CGroup
> based systems. Indeed, one of the main goals is to collect
> "application specific" information from "informed run-times". Being
> "application specific" means that we need a way to classify
> applications depending on the runtime context... and that capability
> in Linux is ultimately provided via the CGroup interface.
>
>> > b) allow to create subgroups of tasks which are not violating the
>> >    capacity constraints defined by the parent group.
>> >    Thus, tasks on a subgroup can only be more boosted and/or more
>>
>> For both limits and protections, the parent caps the maximum the
>> children can get.  At least that's what memcg does for memory.low.
>> Doing that makes sense for memcg because for memory the parent can
>> still do protections regardless of what its children are doing and it
>> makes delegation safe by default.
>
> Just to be more clear, the current proposal enforces:
>
> - capacity_max_child <= capacity_max_parent
>
>   Since, if a task is constrained to get only up to a certain amount
>   of capacity, than its childs cannot use more than that... eventually
>   they can only be further constrained.
>
> - capacity_min_child >= capacity_min_parent
>
>   Since, if a task has been boosted to run at least as much fast, than
>   its childs cannot be constrained to go slower without eventually
>   impacting parent performance.
>
>> I understand why you would want a property like capacity to be the
>> other direction as that way you get more specific as you walk down the
>> tree for both limits and protections;
>
> Right, the protection schema is defined in such a way to never affect
> parent constraints.
>
>> however, I think we need to
>> think a bit more about it and ensure that the resulting interface
>> isn't confusing.
>
> Sure.
>
>> Would it work for capacity to behave the other
>> direction - ie. a parent's min restricting the highest min that its
>> descendants can get?  It's completely fine if that's weird.
>
> I had a thought about that possibility and it was not convincing me
> from the use-cases standpoint, at least for the ones I've considered.
>
> Reason is that capacity_min is used to implement a concept of
> "boosting" where, let say we want to "run a task faster then a minimum
> frequency". Assuming that this constraint has been defined because we
> know that this task, and likely all its descendant threads, needs at
> least that capacity level to perform according to expectations.
>
> In that case the "refining down the hierarchy" can require to boost
> further some threads but likely not less.
>
> Does this make sense?
>
> To me this seems to match quite well at least Android/ChromeOS
> specific use-cases. I'm not sure if there can be other different
> use-cases in the domain for example of managed containers.
>
>
>> Thanks.
>>
>> --
>> tejun
>
> --
> #include <best/regards.h>
>
> Patrick Bellasi
