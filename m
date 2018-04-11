From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] sched/fair: schedutil: update only with all info
 available
Date: Wed, 11 Apr 2018 18:15:48 +0200
Message-ID: <20180411161548.GP4082@hirez.programming.kicks-ass.net>
References: <20180406172835.20078-1-patrick.bellasi@arm.com>
 <CAKfTPtCkZ1x-LS7sfJ7K2cgsKK=hYnDo1Fi3toPcGT0331Vpog@mail.gmail.com>
 <20180410110412.GG14248@e110439-lin>
 <20180411151450.GK4043@hirez.programming.kicks-ass.net>
 <CAKfTPtC+-FR3ZD_t1vkGR2gVoUyxXpE=i4g9zqqLXu4jKKqgUA@mail.gmail.com>
 <20180411153710.GN4082@hirez.programming.kicks-ass.net>
 <CAKfTPtCNdxSmDfDO0Etf7fbYPeryrjdQChSGwMWxSRH8CcXqqg@mail.gmail.com>
 <20180411160000.GO4082@hirez.programming.kicks-ass.net>
 <CAKfTPtDjyjC5R7bhjGxhV8BN5J+LdzJmMgwaaVuE9ypvcSKapA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKfTPtDjyjC5R7bhjGxhV8BN5J+LdzJmMgwaaVuE9ypvcSKapA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, linux-kernel <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 11, 2018 at 06:10:47PM +0200, Vincent Guittot wrote:
> > Could is be that for some reason the nohz balancer now takes a very long
> > time to run?
> 
> Heiner mentions that is was a relatively slow celeron and he uses
> ondemand governor. So I was about to ask him to use performance
> governor to see if it can be because cpu runs slow and takes too muche
> time to enter idle

Maybe also hand him a patch with some trace_printk()s in and ask him to
send /debug/tracing/trace after it happens or somesuch. Maybe we can
find a clue that way.
