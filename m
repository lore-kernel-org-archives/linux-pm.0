From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 7/8] cpufreq: Frequency invariant scheduler load-tracking
 support
Date: Tue, 15 Mar 2016 22:34:07 +0100
Message-ID: <20160315213407.GI6344@twins.programming.kicks-ass.net>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
 <1457932932-28444-8-git-send-email-mturquette+renesas@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:38951 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968AbcCOVee (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Mar 2016 17:34:34 -0400
Content-Disposition: inline
In-Reply-To: <1457932932-28444-8-git-send-email-mturquette+renesas@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri.Lelli@arm.com, steve.muckle@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>

On Sun, Mar 13, 2016 at 10:22:11PM -0700, Michael Turquette wrote:

> +static DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
> +
> +unsigned long cpufreq_scale_freq_capacity(struct sched_domain *sd, int cpu)
> +{
> +	return per_cpu(freq_scale, cpu);
> +}

These should be in a header so that we can avoid having to do a function
call.
