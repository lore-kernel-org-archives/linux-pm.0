From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v4 14/16] sched/core: uclamp: request CAP_SYS_ADMIN by
 default
Date: Thu, 27 Sep 2018 11:00:40 +0100
Message-ID: <20180927100021.kpdyol44qpzassup@queper01-lin>
References: <20180828135324.21976-15-patrick.bellasi@arm.com>
 <20180904134748.GA4974@localhost.localdomain>
 <20180906144053.GD25636@e110439-lin>
 <20180914111003.GC24082@hirez.programming.kicks-ass.net>
 <20180914140732.GR1413@e110439-lin>
 <20180914142813.GM24124@hirez.programming.kicks-ass.net>
 <20180917122723.GS1413@e110439-lin>
 <20180921091308.GD24082@hirez.programming.kicks-ass.net>
 <20180924151400.GT1413@e110439-lin>
 <20180925154956.GA30146@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180925154956.GA30146@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday 25 Sep 2018 at 17:49:56 (+0200), Peter Zijlstra wrote:
> I really don't see how changing the unit changes anything. Either you
> want to relate to OPPs and those are exposed in 1/1024 unit capacity
> through the EAS files, or you don't and then the knob has no meaning.

FWIW, with the latest versions of the EAS series, we don't expose the
capacity of the various OPPs directly any more. You have 'frequency',
'power' and a more abstract thing called 'cost' (which is useful for
energy computations) in the sysfs files of the EM.

We decided to remove the 'capacity' file to simplify things quite a bit,
and because it wasn't helping much. I'm talking about this discussion w/
Dietmar on v4:

https://lore.kernel.org/lkml/20180717141955.GA4496@e108498-lin.cambridge.arm.com/

But it is also true that we could add back that 'capacity' file if it
makes sense for uclamp. It's just an additional show() function in
energy_model.c, so no problem on that side per se.

The only problem is if you want to use uclamp w/o EAS, I guess ...

Thanks,
Quentin
