From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFCv5 PATCH 16/46] sched: Allocate and initialize energy data
 structures
Date: Wed, 12 Aug 2015 12:04:42 +0200
Message-ID: <20150812100442.GU19282@twins.programming.kicks-ass.net>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-17-git-send-email-morten.rasmussen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:59776 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753644AbbHLKEx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Aug 2015 06:04:53 -0400
Content-Disposition: inline
In-Reply-To: <1436293469-25707-17-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, Jul 07, 2015 at 07:23:59PM +0100, Morten Rasmussen wrote:
> +
> +	sge->nr_idle_states = fn(cpu)->nr_idle_states;
> +	sge->nr_cap_states = fn(cpu)->nr_cap_states;
> +	memcpy(sge->idle_states, fn(cpu)->idle_states,
> +	       sge->nr_idle_states*sizeof(struct idle_state));
> +	memcpy(sge->cap_states, fn(cpu)->cap_states,
> +	       sge->nr_cap_states*sizeof(struct capacity_state));

> +			if (fn && fn(j)) {
> +				nr_idle_states = fn(j)->nr_idle_states;
> +				nr_cap_states = fn(j)->nr_cap_states;
> +				BUG_ON(!nr_idle_states || !nr_cap_states);
> +			}

> +	for_each_cpu(i, &mask) {
> +		int y;
> +
> +		BUG_ON(fn(i)->nr_idle_states != fn(cpu)->nr_idle_states);
> +
> +		for (y = 0; y < (fn(i)->nr_idle_states); y++) {
> +			BUG_ON(fn(i)->idle_states[y].power !=
> +					fn(cpu)->idle_states[y].power);
> +		}
> +
> +		BUG_ON(fn(i)->nr_cap_states != fn(cpu)->nr_cap_states);
> +
> +		for (y = 0; y < (fn(i)->nr_cap_states); y++) {
> +			BUG_ON(fn(i)->cap_states[y].cap !=
> +					fn(cpu)->cap_states[y].cap);
> +			BUG_ON(fn(i)->cap_states[y].power !=
> +					fn(cpu)->cap_states[y].power);
> +		}
> +	}
> +}

Might it not make more sense to have:

	const struct blah *const blah = fn();

and use blah afterwards, instead of the repeated invocation of fn()?
