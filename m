From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [RFC 1/3] sched/fair: add util_est on top of PELT
Date: Mon, 4 Sep 2017 11:59:40 +0100
Message-ID: <20170904105940.GB2618@e110439-lin>
References: <20170825102008.4626-1-patrick.bellasi@arm.com>
 <20170825102008.4626-2-patrick.bellasi@arm.com>
 <CAEU1=PmgWSi7hrLpQ2nQUi_Ki5Z6JsJMi-fV5ke1B26aC0kqSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56932 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753482AbdIDK7q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 Sep 2017 06:59:46 -0400
Content-Disposition: inline
In-Reply-To: <CAEU1=PmgWSi7hrLpQ2nQUi_Ki5Z6JsJMi-fV5ke1B26aC0kqSg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavan Kondeti <pkondeti@codeaurora.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Paul Turner <pjt@google.com>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <juri.lelli@arm.com>, Tim Murray <timmurray@google.com>, Todd Kjos <tkjos@android.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Viresh Kumar <viresh.kumar@linaro.org>

On 29-Aug 12:11, Pavan Kondeti wrote:
> On Fri, Aug 25, 2017 at 3:50 PM, Patrick Bellasi
> <patrick.bellasi@arm.com> wrote:
> > The util_avg signal computed by PELT is too variable for some use-cases.
> > For example, a big task waking up after a long sleep period will have its
> > utilization almost completely decayed. This introduces some latency before
> > schedutil will be able to pick the best frequency to run a task.
> >
> 
> <snip>
> 
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index c28b182c9833..8d7bc55f68d5 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -26,6 +26,7 @@
> >  #include <linux/signal_types.h>
> >  #include <linux/mm_types_task.h>
> >  #include <linux/task_io_accounting.h>
> > +#include <linux/average.h>
> >
> >  /* task_struct member predeclarations (sorted alphabetically): */
> >  struct audit_context;
> > @@ -277,6 +278,16 @@ struct load_weight {
> >         u32                             inv_weight;
> >  };
> >
> > +/**
> > + * Utilizaton's Exponential Weighted Moving Average (EWMA)
> > + *
> > + * Support functions to track an EWMA for the utilization of SEs and RQs. New
> > + * samples will be added to the moving average each time a task completes an
> > + * activation. Thus the weight is chosen so that the EWMA wil be relatively
> > + * insensitive to transient changes to the task's workload.
> > + */
> > +DECLARE_EWMA(util, 0, 4);
> > +
> >  /*
> 
> Should the factor be 1 instead of 0? i.e 25% contribution from the
> recent sample.

The weight of new samples is represented by the third parameter which
assigns them 1/4 (25%) weight.

That zero you are pointing out defines the "precision" in terms of
bits for the fractional part. In this first prototype I've just
disregarded any fractional precision but, considering that we use
this, EWMA to aggregate utilization values, I should probably better
set it to SCHED_CAPACITY_SHIFT.

> Thanks,
> Pavan

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
