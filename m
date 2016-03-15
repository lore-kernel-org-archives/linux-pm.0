From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/8] sched/cpufreq: new cfs capacity margin helpers
Date: Tue, 15 Mar 2016 22:17:40 +0100
Message-ID: <20160315211740.GD6344@twins.programming.kicks-ass.net>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
 <1457932932-28444-4-git-send-email-mturquette+renesas@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:38598 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbcCOVRn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Mar 2016 17:17:43 -0400
Content-Disposition: inline
In-Reply-To: <1457932932-28444-4-git-send-email-mturquette+renesas@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri.Lelli@arm.com, steve.muckle@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>

On Sun, Mar 13, 2016 at 10:22:07PM -0700, Michael Turquette wrote:
> +/**
> + * cpufreq_set_cfs_capacity_margin - Set global cfs enqueue capacity margin
> + * @margin: new capacity margin
> + *
> + * margin is a percentage of capacity that is applied to the current
> + * utilization when selecting a new capacity state or cpu frequency. The value
> + * should be normalized to the range of [0..SCHED_CAPACITY_SCALE], where
> + * SCHED_CAPACITY_SCALE is 100% of the normalized capacity, or equivalent to
> + * multiplying the utilization by one.
> + *
> + * For instance, to add a 25% margin to a utilization, margin should be 1280,
> + * which is 1.25x 1024, the default for SCHED_CAPACITY_SCALE.
> + */
> +void cpufreq_set_cfs_capacity_margin(unsigned long margin)
> +{
> +	cfs_capacity_margin = margin;
> +}
> +EXPORT_SYMBOL_GPL(cpufreq_set_cfs_capacity_margin);

I don't like this as an interface; what's wrong with using percentiles
as per the discussion I had with Rafael last week?

Also, why is this exported?
