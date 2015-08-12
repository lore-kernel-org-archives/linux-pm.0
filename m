From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [RFCv5 PATCH 20/46] sched: Relocated get_cpu_usage() and change
 return type
Date: Wed, 12 Aug 2015 15:40:10 +0100
Message-ID: <20150812144010.GB29326@e105550-lin.cambridge.arm.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-21-git-send-email-morten.rasmussen@arm.com>
 <20150812105923.GX19282@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58736 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753075AbbHLOgw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 12 Aug 2015 10:36:52 -0400
Content-Disposition: inline
In-Reply-To: <20150812105923.GX19282@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Wed, Aug 12, 2015 at 12:59:23PM +0200, Peter Zijlstra wrote:
> On Tue, Jul 07, 2015 at 07:24:03PM +0100, Morten Rasmussen wrote:
> > +static unsigned long get_cpu_usage(int cpu)
> > +{
> > +	int sum;
> > +	unsigned long usage = cpu_rq(cpu)->cfs.utilization_load_avg;
> > +	unsigned long blocked = cpu_rq(cpu)->cfs.utilization_blocked_avg;
> > +	unsigned long capacity_orig = capacity_orig_of(cpu);
> > +
> > +	sum = usage + blocked;
> > +
> > +	if (sum >= capacity_orig)
> > +		return capacity_orig;
> > +
> > +	return sum;
> > +}
> 
> Should sum then not also be unsigned long?

Yes it should. So much for my attempt at fixing the types :(
