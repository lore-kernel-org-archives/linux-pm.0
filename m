From: "Joel Fernandes (Google)" <joel.opensrc@gmail.com>
Subject: Re: [RFC v3 1/5] sched/core: add capacity constraints to CPU controller
Date: Fri, 24 Mar 2017 00:02:15 -0700
Message-ID: <CAEi0qNmocGZxh-wcpayMt8rzeQfuk70Su=0vaZWBC8jZKP1gxw@mail.gmail.com>
References: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
 <1488292722-19410-2-git-send-email-patrick.bellasi@arm.com>
 <20170320171511.GB3623@htj.duckdns.org> <20170320180837.GB28391@e110439-lin>
 <CAEi0qNmQWxc+SWYPfbf7jzz3w4-k-uatUHT1r2m_68EOFAVp=A@mail.gmail.com> <20170323103254.GA11362@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170323103254.GA11362@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Tejun Heo <tj@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Patrick,

On Thu, Mar 23, 2017 at 3:32 AM, Patrick Bellasi
<patrick.bellasi@arm.com> wrote:
[..]
>> > which can be used to defined tunable root constraints when CGroups are
>> > not available, and becomes RO when CGroups are.
>> >
>> > Can this be eventually an acceptable option?
>> >
>> > In any case I think that this feature will be mainly targeting CGroup
>> > based systems. Indeed, one of the main goals is to collect
>> > "application specific" information from "informed run-times". Being
>> > "application specific" means that we need a way to classify
>> > applications depending on the runtime context... and that capability
>> > in Linux is ultimately provided via the CGroup interface.
>>
>> I think the concern raised is more about whether CGroups is the right
>> interface to use for attaching capacity constraints to task or groups
>> of tasks, or is there a better way to attach such constraints?
>
> Notice that CGroups based classification allows to easily enforce
> the concept of "delegation containment". I think this feature should
> be nice to have whatever interface we choose.
>
> However, potentially we can define a proper per-task API; are you
> thinking to something specifically?
>

I was thinking how about adding per-task constraints to the resource
limits API if it makes sense to? There's already RLIMIT_CPU and
RLIMIT_NICE. An informed-runtime could then modify the limits of tasks
using prlimit.

>> The other advantage of such interface is we don't have to
>> create a separate CGroup for every new constraint limit and can have
>> several tasks with different unique constraints.
>
> That's still possible using CGroups and IMO it will not be the "most
> common case".
> Don't you think that in general we will need to set constraints at
> applications level, thus group of tasks?

Some applications could be a single task, also not all tasks in an
application may need constraints right?

> As a general rule we should probably go for an interface which makes
> easy the most common case.

I agree.

Thanks,
Joel
