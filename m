From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/4] sched: cpufreq: Keep track of cpufreq utilization
 update flags
Date: Wed, 20 Dec 2017 14:18:59 +0530
Message-ID: <20171220084859.GY19815@vireshk-i7>
References: <cover.1513158452.git.viresh.kumar@linaro.org>
 <17ff0b5d83a1275a98f0d1b87daf275f3e964af3.1513158452.git.viresh.kumar@linaro.org>
 <20171219192504.nstxsfii6y7rh37w@hirez.programming.kicks-ass.net>
 <20171220040446.GS19815@vireshk-i7>
 <20171220083115.n4mc4pdkvycakce2@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:40816 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754775AbdLTItC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Dec 2017 03:49:02 -0500
Received: by mail-pg0-f65.google.com with SMTP id k15so11673630pgr.7
        for <linux-pm@vger.kernel.org>; Wed, 20 Dec 2017 00:49:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171220083115.n4mc4pdkvycakce2@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, juri.lelli@redhat.com, tkjos@android.com, joelaf@google.com, linux-kernel@vger.kernel.org, patrick.bellasi@arm.com

On 20-12-17, 09:31, Peter Zijlstra wrote:
> On Wed, Dec 20, 2017 at 09:34:46AM +0530, Viresh Kumar wrote:

> Please use the normal link format:
> 
>   https://lkml.kernel.org/r/$MSGID
> 
> Then I can find them without having to resort to a frigging browser
> thing.

Sure, and that would be much easier for me as well as that's how I got
to those links. Here they are again ..

https://lkml.kernel.org/r/20171130114723.29210-2-patrick.bellasi@arm.com
https://lkml.kernel.org/r/20171130114723.29210-3-patrick.bellasi@arm.com
https://lkml.kernel.org/r/20171130114723.29210-7-patrick.bellasi@arm.com

> I'll try and dig through the email I have.

Thanks.

> > Well that also looks fine to me, and that would mean this:
> > 
> > - We remove SCHED_CPUFREQ_RT and SCHED_CPUFREQ_DL flags, but still
> >   call the utilization callbacks from RT and DL classes.
> 
> Didn't juri have patches to make DL do something sane? But yes, I think
> those flags are part of the problem.

Sure, DL will be more like CFS going forward. I was just commenting
based on what we have upstream today.

> > - From the utilization handler, we check runqueues of all three sched
> >   classes to see if they have some work pending (this can be done
> >   smartly by checking only RT first and skipping other checks if RT
> >   has some work).
> 
> No that's wrong. DL should provide a minimum required based on existing
> reservations, we can add the expected CFS average on top and request
> that.

Right, that should be the case after Juri's patches.

> And for RT all we need to know is if current is of that class, otherwise
> we don't care.

What about this case: A CFS task is running currently and an RT task
is enqueued.

- Is it always the case that the CFS task is preempted immediately and
  the CPU is given to RT task ? I was talking to Vincent earlier and
  he told me that for certain configurations the CFS task may keep
  running until the next tick.

- What if the CFS task has disabled preemption ?

- More corner cases like this ?

Above cases may not let schedutil to raise frequency to MAX even when
we have RT stuff enqueued. And that's why I tried to track all sched
classes for which we have work enqueued for. There are great chances
that my understanding here is wrong though :)

-- 
viresh
