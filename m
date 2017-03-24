From: "Joel Fernandes (Google)" <joel.opensrc@gmail.com>
Subject: Re: [RFC v3 1/5] sched/core: add capacity constraints to CPU controller
Date: Thu, 23 Mar 2017 23:37:50 -0700
Message-ID: <CAEi0qNniGZPuuHmcz_YeYWxp4K=J7-VaiRYjJ3nFyGQ6WZK+_g@mail.gmail.com>
References: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
 <1488292722-19410-2-git-send-email-patrick.bellasi@arm.com>
 <20170320171511.GB3623@htj.duckdns.org> <20170320180837.GB28391@e110439-lin>
 <CAEi0qNmQWxc+SWYPfbf7jzz3w4-k-uatUHT1r2m_68EOFAVp=A@mail.gmail.com>
 <20170323103254.GA11362@e110439-lin> <20170323160112.GA5953@htj.duckdns.org>
 <20170323181533.GB11362@e110439-lin> <20170323183937.GC5953@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38631 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751601AbdCXGhx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Mar 2017 02:37:53 -0400
In-Reply-To: <20170323183937.GC5953@htj.duckdns.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>

Hi Tejun,

>> That's also why the proposed interface has now been defined as a extension of
>> the CPU controller in such a way to keep a consistent view.
>>
>> This controller is already used by run-times like Android to "scope" apps by
>> constraining the amount of CPUs resource they are getting.
>> Is that not a legitimate usage of the cpu controller?
>>
>> What we are doing here is just extending it a bit in such a way that, while:
>>
>>   {cfs,rt}_{period,runtime}_us limits the amount of TIME we can use a CPU
>>
>> we can also use:
>>
>>   capacity_{min,max} to limit the actual COMPUTATIONAL BANDWIDTH we can use
>>                      during that time.
>
> Yes, we do have bandwidth restriction as a cgroup only feature, which
> is different from how we handle nice levels and weights.  Given the
> nature of bandwidth limits, if necessary, it is straight-forward to
> expose per-task interface.
>
> capacity min/max isn't the same thing.  It isn't a limit on countable
> units of a specific resource and that's why the interface you
> suggested for .min is different.  It's restricting attribute set which
> can be picked in the subhierarchy rather than controlling distribution
> of atoms of the resource.
>
> That's also why we're gonna have problem if we later decide we need a
> thread based API for it.  Once we make cgroup the primary owner of the
> attribute, it's not straight forward to add another owner.

Sorry I don't immediately see why it is not straight forward to have a
per-task API later once CGroup interface is added? Maybe if you don't
mind giving an example that will help?

I can start with an example, say you have a single level hierarchy
(Top-app in Android terms is the set of tasks that are user facing and
we'd like to enforce some capacity minimums, background on the other
hand is the opposite):

                   ROOT (min = 0, max = 1024)
                   /                         \
                  /                           \
              TOP-APP (min = 200, max = 1024)  BACKGROUND (min = 0, max = 500)

If in the future, if we want to have a per-task API to individually
configure the task with these limits, it seems it will be straight
forward to implement IMO.

As Patrick mentioned, all of the usecases needing this right now is an
informed runtime placing a task in a group of tasks and not needing to
set attributes for each individual task. We are already placing tasks
in individual CGroups in Android based on the information the runtime
has so adding in the capacity constraints will make it fit naturally
while leaving the door open for any future per-task API additions IMO.

Thanks,

Joel
