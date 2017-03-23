From: "Joel Fernandes (Google)" <joel.opensrc@gmail.com>
Subject: Re: [RFC v3 1/5] sched/core: add capacity constraints to CPU controller
Date: Wed, 22 Mar 2017 17:28:48 -0700
Message-ID: <CAEi0qNmQWxc+SWYPfbf7jzz3w4-k-uatUHT1r2m_68EOFAVp=A@mail.gmail.com>
References: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
 <1488292722-19410-2-git-send-email-patrick.bellasi@arm.com>
 <20170320171511.GB3623@htj.duckdns.org> <20170320180837.GB28391@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33211 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbdCWA2v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Mar 2017 20:28:51 -0400
In-Reply-To: <20170320180837.GB28391@e110439-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Tejun Heo <tj@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>

Hi,

On Mon, Mar 20, 2017 at 11:08 AM, Patrick Bellasi
<patrick.bellasi@arm.com> wrote:
> On 20-Mar 13:15, Tejun Heo wrote:
>> Hello,
>>
>> On Tue, Feb 28, 2017 at 02:38:38PM +0000, Patrick Bellasi wrote:
[..]
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

But then we would lose out on being able to attach capacity
constraints to specific tasks or groups of tasks?

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

I think the concern raised is more about whether CGroups is the right
interface to use for attaching capacity constraints to task or groups
of tasks, or is there a better way to attach such constraints?

I am actually looking at a workload where its desirable to attach such
constraints to only 1 thread or task, in this case it would be a bit
overkill to use CGroups to attach such property just for 1 task with
specific constraints and it would be beneficial that along with the
CGroup interface, there's also an interface to attach it to individual
tasks. The other advantage of such interface is we don't have to
create a separate CGroup for every new constraint limit and can have
several tasks with different unique constraints.

Regards,
Joel
