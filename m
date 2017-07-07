From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH v2 2/6] cpufreq: schedutil: reset sg_cpus's flags at IDLE
 enter
Date: Fri, 7 Jul 2017 11:17:04 +0100
Message-ID: <20170707101704.qncj373s3eliit2y@e106622-lin>
References: <1499189651-18797-1-git-send-email-patrick.bellasi@arm.com>
 <1499189651-18797-3-git-send-email-patrick.bellasi@arm.com>
 <CAJWu+opGK6GTFiLoH9jSicnAx08Je9FoGevRmAk+Bfned42ncA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45748 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750768AbdGGKRL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 Jul 2017 06:17:11 -0400
Content-Disposition: inline
In-Reply-To: <CAJWu+opGK6GTFiLoH9jSicnAx08Je9FoGevRmAk+Bfned42ncA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joel Fernandes <joelaf@google.com>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Andres Oportus <andresoportus@google.com>, Todd Kjos <tkjos@android.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>

On 06/07/17 21:43, Joel Fernandes wrote:
> On Tue, Jul 4, 2017 at 10:34 AM, Patrick Bellasi
> <patrick.bellasi@arm.com> wrote:

[...]

> > @@ -304,6 +304,12 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
> >
> >         sg_cpu->util = util;
> >         sg_cpu->max = max;
> > +
> > +       /* CPU is entering IDLE, reset flags without triggering an update */
> > +       if (unlikely(flags & SCHED_CPUFREQ_IDLE)) {
> > +               sg_cpu->flags = 0;
> > +               goto done;
> > +       }
> 
> Instead of defining a new flag for idle, wouldn't another way be to
> just clear the flag from the RT scheduling class with an extra call to
> cpufreq_update_util with flags = 0 during dequeue_rt_entity? That
> seems to me to be also the right place to clear the flag since the
> flag is set in the corresponding class to begin with.
> 

Make sense to me too. Also considering that for DL (with my patches) we
don't generally want to clear the flag at dequeue time, but only when
the 0-lag timer fires.

Best,

- Juri
