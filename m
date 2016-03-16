From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 5/8] sched/cpufreq: pass sched class into
 cpufreq_update_util
Date: Wed, 16 Mar 2016 14:43:38 +0100
Message-ID: <20160316134338.GX6344@twins.programming.kicks-ass.net>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
 <1457932932-28444-6-git-send-email-mturquette+renesas@baylibre.com>
 <20160315212520.GF6344@twins.programming.kicks-ass.net>
 <20160315220609.30639.67271@quark.deferred.io>
 <20160316074123.GP6344@twins.programming.kicks-ass.net>
 <CAKfTPtA8hJUT4HGXjoyX4=qh9iup3_GUMwuJGgbXtBFGgAPFdQ@mail.gmail.com>
 <20160316085339.GU6344@twins.programming.kicks-ass.net>
 <CAJZ5v0jPtobKGR01D9obxhHibz4aPrPFjmuX19zAE5a5Uz8aEQ@mail.gmail.com>
 <20160316131008.GW6344@twins.programming.kicks-ass.net>
 <CAJZ5v0hMqZ2+6wKf8f1enmCWjaTQJFdBoyCQOUrnUYJ1zfUX5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from [198.137.202.9] ([198.137.202.9]:41881 "EHLO
	bombadil.infradead.org" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S966265AbcCPNoy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 09:44:54 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hMqZ2+6wKf8f1enmCWjaTQJFdBoyCQOUrnUYJ1zfUX5g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Juri Lelli <Juri.Lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Michael Turquette <mturquette+renesas@baylibre.com>

On Wed, Mar 16, 2016 at 02:23:21PM +0100, Rafael J. Wysocki wrote:
> On Wed, Mar 16, 2016 at 2:10 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> > (this would of course require we allocate struct update_util_data with
> > the proper alignment thingies etc..)

> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index ba49c9efd0b2..d34d75c5cc93 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -3236,8 +3236,10 @@ static inline unsigned long rlimit_max(unsigned int limit)
> >
> >  #ifdef CONFIG_CPU_FREQ
> >  struct update_util_data {
> > -       void (*func)(struct update_util_data *data,
> > -                    u64 time, unsigned long util, unsigned long max);
> > +       unsigned long *cfs_util_avg;
> > +       unsigned long *cfs_util_max;
> > +
> > +       void (*func)(struct update_util_data *data, u64 time);
> >  };

we should add: ____cacheline_aligned here

> How do we ensure proper alignment?

Depends on the allocator; not all of them respect the struct alignment
attribute.

kernel/sched/cpufreq.c:DEFINE_PER_CPU(struct update_util_data *, cpufreq_update_util_data);

That one could use:

DEFINE_PER_CPU_ALIGNED() instead

as would this one:

drivers/cpufreq/cpufreq_governor.c:static DEFINE_PER_CPU(struct cpu_dbs_info, cpu_dbs);

Because when you cacheline align dbs_info, its update_util_data member
will also get the correct alignment because of the structure attribute.


