From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/4] sched: cpufreq: Keep track of cpufreq utilization
 update flags
Date: Wed, 20 Dec 2017 09:31:15 +0100
Message-ID: <20171220083115.n4mc4pdkvycakce2@hirez.programming.kicks-ass.net>
References: <cover.1513158452.git.viresh.kumar@linaro.org>
 <17ff0b5d83a1275a98f0d1b87daf275f3e964af3.1513158452.git.viresh.kumar@linaro.org>
 <20171219192504.nstxsfii6y7rh37w@hirez.programming.kicks-ass.net>
 <20171220040446.GS19815@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:43374 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754494AbdLTIbf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Dec 2017 03:31:35 -0500
Content-Disposition: inline
In-Reply-To: <20171220040446.GS19815@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, juri.lelli@redhat.com, tkjos@android.com, joelaf@google.com, linux-kernel@vger.kernel.org, patrick.bellasi@arm.com

On Wed, Dec 20, 2017 at 09:34:46AM +0530, Viresh Kumar wrote:
> On 19-12-17, 20:25, Peter Zijlstra wrote:
> > Yeah, not happy about this either; we had code that did the right thing
> > without this extra tracking I think.
> 
> Sure, but how do you suggest we fix the problems we are facing with
> the current design? Patrick had a completely different proposal for
> solving those problems, which I didn't like very much. This patchset
> replaced these patches from Patrick:

Please use the normal link format:

  https://lkml.kernel.org/r/$MSGID

Then I can find them without having to resort to a frigging browser
thing.

I'll try and dig through the email I have.

> > Also, we can look at the rq state if we want to, we don't need to
> > duplicate that state.
> 
> Well that also looks fine to me, and that would mean this:
> 
> - We remove SCHED_CPUFREQ_RT and SCHED_CPUFREQ_DL flags, but still
>   call the utilization callbacks from RT and DL classes.

Didn't juri have patches to make DL do something sane? But yes, I think
those flags are part of the problem.

> - From the utilization handler, we check runqueues of all three sched
>   classes to see if they have some work pending (this can be done
>   smartly by checking only RT first and skipping other checks if RT
>   has some work).

No that's wrong. DL should provide a minimum required based on existing
reservations, we can add the expected CFS average on top and request
that.

And for RT all we need to know is if current is of that class, otherwise
we don't care.
