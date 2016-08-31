From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/2] sched: cpufreq: ignore SMT when determining max cpu
 capacity
Date: Wed, 31 Aug 2016 16:34:37 +0200
Message-ID: <20160831143437.GW10121@twins.programming.kicks-ass.net>
References: <1472236848-17038-1-git-send-email-smuckle@linaro.org>
 <1472236848-17038-2-git-send-email-smuckle@linaro.org>
 <2411837.FJm8ec21FH@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2411837.FJm8ec21FH@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Steve Muckle <smuckle@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 31, 2016 at 03:27:30AM +0200, Rafael J. Wysocki wrote:
> On Friday, August 26, 2016 11:40:47 AM Steve Muckle wrote:
> > PELT does not consider SMT when scaling its utilization values via
> > arch_scale_cpu_capacity(). The value in rq->cpu_capacity_orig does
> > take SMT into consideration though and therefore may be smaller than
> > the utilization reported by PELT.
> > 
> > On an Intel i7-3630QM for example rq->cpu_capacity_orig is 589 but
> > util_avg scales up to 1024. This means that a 50% utilized CPU will show
> > up in schedutil as ~86% busy.
> > 
> > Fix this by using the same CPU scaling value in schedutil as that which
> > is used by PELT.
> > 
> > Signed-off-by: Steve Muckle <smuckle@linaro.org>
> 
> This is fine by me.
> 
> Peter, any objections?

No, looks good. Thanks
