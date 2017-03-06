From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/6] cpufreq: schedutil: ignore the sugov kthread for
 frequencies selections
Date: Mon, 6 Mar 2017 10:38:05 +0530
Message-ID: <20170306050805.GF8206@vireshk-i7>
References: <1488469507-32463-1-git-send-email-patrick.bellasi@arm.com>
 <1488469507-32463-3-git-send-email-patrick.bellasi@arm.com>
 <20170303051943.GI13760@vireshk-i7>
 <20170303121247.GA10420@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:32811 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752890AbdCFFQP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Mar 2017 00:16:15 -0500
Received: by mail-pg0-f47.google.com with SMTP id 25so62178594pgy.0
        for <linux-pm@vger.kernel.org>; Sun, 05 Mar 2017 21:16:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170303121247.GA10420@e110439-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Todd Kjos <tkjos@android.com>, Tim Murray <timmurray@google.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Chris Redpath <chris.redpath@arm.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>

On 03-03-17, 12:12, Patrick Bellasi wrote:
> On 03-Mar 10:49, Viresh Kumar wrote:
> > I always wanted to avoid such hacks when I moved to the RT thread :(
> 
> Indeed, it is a bit of an hack... but still it's true that this is a
> "special" RT thread which must not bias OPP selection.

I agree. We have a problem in hand and we need to fix it somehow.

> > I was discussing the exact same problem with Vincent few days back and
> > one of the ideas we had was to clear the flags when any RT task is
> > dequeued from a rq.
> 
> That's a possible solution, however at dequeue time we don't know
> what's going on right after. We can end up picking up another RT task.
> Thus we can reset the flag when it's not really required, and this
> open for possible races...

I don't have much knowledge of the scheduler right now and so I will not be able
to tell the exact places where we can clear the flag. So, dequeue was just one
of the places I could think of logically.

My idea was to make sure that we clear the RT and DL flags once we know that we
don't have any more RT/DL work to do. Dequeue or any other place that would suit
better, but we should be clearing it.

And once that is done, we wouldn't be required to have hacks like what this
patch is doing.

> > AFAIU, the problem we are discussing here
> > shouldn't normally occur while the sugov RT thread is running as the
> > work_in_progress flag makes sure we don't reevaluate the load while
> > the RT thread is updating the frequency.
> 
> True...
> 
> > The problem perhaps occurs as the flag for CPU X is never cleared,
> > and so on the next callback from the scheduler (after the frequency
> > is updated and work_in_progress is cleared) we move to the highest
> > frequency.
> 
> ... right.
> 
> > So what about clearing the flags, just like the previous patch, when
> > the RT or DL task has finished?
> 
> As a general goal I think it would be useful to feed input only when
> the scheduler knows something is going to happen. That's why in the
> last patch of these series I'm proposing to remove updates from
> update_curr_rt() and replace it with calls in most interesting events,
> like enqueue/pickup instead of dequeue.

Sure, I liked that. I am just wondering if we can have such a location to clear
the RT/DL flags.

> > Sorry for the noise if it was all nonsense :)
> 
> That's absolutely not nonsense, thanks for the feedback.
> 
> I agree with you that the solution proposed by this patch sound a bit
> of an hack, but still we can argue that using an RT task to change an
> OPP is by itself a sort-of an hack.

Just for the sake of argument, why do you think so ? :)

That work needs to get done via some sort of task, wq or RT thread, etc. We
chose RT to make sure we do it in time and never delay it. The ugliness happened
because we hit max frequency on RT task, which will be optimized later on.

-- 
viresh
