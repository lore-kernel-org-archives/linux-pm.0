From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/3] cpufreq: schedutil: move slow path from workqueue to
 SCHED_FIFO task
Date: Sun, 13 Nov 2016 23:44:39 +0100
Message-ID: <CAJZ5v0hGVq7SQE-m7Pi-WTv7f+OP=sFwAuzp08sFKAMBS2Mzyg@mail.gmail.com>
References: <cover.1478858983.git.viresh.kumar@linaro.org> <85bf45982709e06f7f42e1b8f8315945e9d9b6d0.1478858983.git.viresh.kumar@linaro.org>
 <CAJZ5v0jODn1gJtTtpTigA=7QwK04wzdFopr-R6GeoSchqgpgiQ@mail.gmail.com>
 <582670FD.7080203@codeaurora.org> <CAJZ5v0gdZZ-h5JvRYacv2OH+gzG-wwHWevRmp04GNPNzUWwYeA@mail.gmail.com>
 <20161113194722.GC29583@graphite.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36498 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934791AbcKMWol (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Nov 2016 17:44:41 -0500
In-Reply-To: <20161113194722.GC29583@graphite.smuckle.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <smuckle.linux@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Saravana Kannan <skannan@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Robin Randhawa <robin.randhawa@arm.com>

On Sun, Nov 13, 2016 at 8:47 PM, Steve Muckle <smuckle.linux@gmail.com> wrote:
> On Sun, Nov 13, 2016 at 03:37:18PM +0100, Rafael J. Wysocki wrote:
>> > Hold on a sec. I thought during LPC someone (Peter?) made a point that when
>> > RT thread run, we should bump the frequency to max? So, schedutil is going
>> > to trigger schedutil to bump up the frequency to max, right?
>>
>> No, it isn't, or at least that is unlikely.
>>
>> sugov_update_commit() sets sg_policy->work_in_progress before queuing
>> the IRQ work and it is not cleared until the frequency changes in
>> sugov_work().
>>
>> OTOH, sugov_should_update_freq() checks sg_policy->work_in_progress
>> upfront and returns false when it is set, so the governor won't see
>> its own worker threads run, unless I'm overlooking something highly
>> non-obvious.
>
> FWIW my intention with the original version of this patch (which I
> neglected to communicate to Viresh) was that it would depend on changing
> the frequency policy for RT. I had been using rt_avg. It sounds like
> during LPC there were talks of using another metric.
>
> It does appear things would work okay without that but it also seems
> a bit fragile.

Yes, it does.

To a minimum, there should be a comment regarding that in the patches.

> There's the window between when the work_in_progress
> gets cleared and the RT kthread yields. I have not thought through the
> various scenarios there, what is possible and tested to see if it is
> significant enough to impact power-sensitive platforms.

Well, me neither, to be entirely honest. :-)

That said, there is a limited number of call sites for
update_curr_rt(), where SCHED_CPUFREQ_RT is passed to cpufreq
governors: dequeue_task_rt(), put_prev_task_rt(), pick_next_task_rt(),
and task_tick_rt().  I'm not sure how pick_next_task_rt() can be
relevant here at all, though, and task_tick_rt() would need to be
running exactly during the window mentioned above, so it probably is
negligible either, at least on the average.

>From the quick look at the scheduler core, put_prev_task() is mostly
called for running tasks, so that case doesn't look like something to
worry about too, although it would need to be looked through in
detail.  The dequeue part I'm totally unsure about.

In any case, the clearing of work_in_progress might still be deferred
by queuing a regular (non-RT) work item to do that from the kthread
work (that will guarantee "hiding" the kthread work from the
governor), but admittedly that would be a sledgehammer of sorts (and
it might defeat the purpose of the whole exercise) ...

Thanks,
Rafael
