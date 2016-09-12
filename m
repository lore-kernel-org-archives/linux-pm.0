From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] sched: cpufreq: ignore SMT when determining max cpu capacity
Date: Tue, 13 Sep 2016 00:25:54 +0200
Message-ID: <10626645.IplgtjqW4B@vostro.rjw.lan>
References: <1472236848-17038-1-git-send-email-smuckle@linaro.org> <2411837.FJm8ec21FH@vostro.rjw.lan> <20160831143437.GW10121@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:58419 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1754928AbcILWTs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Sep 2016 18:19:48 -0400
In-Reply-To: <20160831143437.GW10121@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Steve Muckle <steve.muckle@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Steve Muckle <smuckle@linaro.org>

On Wednesday, August 31, 2016 04:34:37 PM Peter Zijlstra wrote:
> On Wed, Aug 31, 2016 at 03:27:30AM +0200, Rafael J. Wysocki wrote:
> > On Friday, August 26, 2016 11:40:47 AM Steve Muckle wrote:
> > > PELT does not consider SMT when scaling its utilization values via
> > > arch_scale_cpu_capacity(). The value in rq->cpu_capacity_orig does
> > > take SMT into consideration though and therefore may be smaller than
> > > the utilization reported by PELT.
> > > 
> > > On an Intel i7-3630QM for example rq->cpu_capacity_orig is 589 but
> > > util_avg scales up to 1024. This means that a 50% utilized CPU will show
> > > up in schedutil as ~86% busy.
> > > 
> > > Fix this by using the same CPU scaling value in schedutil as that which
> > > is used by PELT.
> > > 
> > > Signed-off-by: Steve Muckle <smuckle@linaro.org>
> > 
> > This is fine by me.
> > 
> > Peter, any objections?
> 
> No, looks good. Thanks

OK, thanks!

Applied.

