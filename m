From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [RFCv5 PATCH 31/46] sched: Consider spare cpu capacity at task
 wake-up
Date: Tue, 21 Jul 2015 16:12:23 +0100
Message-ID: <20150721151222.GB15088@e105550-lin.cambridge.arm.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-32-git-send-email-morten.rasmussen@arm.com>
 <55AD9440.8090802@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60409 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932124AbbGUPJa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 21 Jul 2015 11:09:30 -0400
Content-Disposition: inline
In-Reply-To: <55AD9440.8090802@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sai Gurrappadi <sgurrappadi@nvidia.com>
Cc: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, pboonstoppel@nvidia.com

On Mon, Jul 20, 2015 at 05:37:20PM -0700, Sai Gurrappadi wrote:
> Hi Morten,
> 
> On 07/07/2015 11:24 AM, Morten Rasmussen wrote:

[...]

> > @@ -5290,6 +5291,16 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
> >  				fit_capacity = capacity_of(i);
> >  				fit_group = group;
> >  			}
> > +
> > +			/*
> > +			 * Look for group which has most spare capacity on a
> > +			 * single cpu.
> > +			 */
> > +			spare_capacity = capacity_of(i) - get_cpu_usage(i);
> > +			if (spare_capacity > max_spare_capacity) {
> > +				max_spare_capacity = spare_capacity;
> > +				spare_group = group;
> > +			}
> 
> Another minor buglet: get_cpu_usage(i) here could be > capacity_of(i)
> because usage is bounded by capacity_orig_of(i). Should it be bounded by
> capacity_of() instead?

Yes, that code is clearly broken. For this use of get_cpu_usage() it
makes more sense to cap it by capacity_of(). However, I think we
actually need two versions of get_cpu_usage(): One that reports
CFS utilization which as capped by CFS capacity (capacity_of()), and one
that reports total utilization (all sched_classes and IRQ) which is
capped by capacity_orig_of(). The former for use in CFS scheduling
decisions like the one above, and the latter for energy estimates and
selecting DVFS frequencies where we should include all utilization, not
just CFS tasks.

I will fix get_cpu_usage() as you propose.

Thanks,
Morten
