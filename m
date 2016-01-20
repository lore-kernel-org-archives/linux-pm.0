From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC V2 2/2] sched: idle: IRQ based next prediction for idle
 period
Date: Wed, 20 Jan 2016 20:34:49 +0100
Message-ID: <20160120193449.GV6357@twins.programming.kicks-ass.net>
References: <1453305636-22156-1-git-send-email-daniel.lezcano@linaro.org>
 <1453305636-22156-3-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:60223 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbcATTew (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2016 14:34:52 -0500
Content-Disposition: inline
In-Reply-To: <1453305636-22156-3-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: tglx@linutronix.de, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org

On Wed, Jan 20, 2016 at 05:00:33PM +0100, Daniel Lezcano wrote:
> +		variance = stats_variance(&w->stats, mean);
> +		/*
> +		 * We want to check the last interval is:
> +		 *
> +		 *  mean - stddev < interval < mean + stddev
> +		 *
> +		 * That simplifies to:
> +		 *
> +		 * -stddev < interval - mean < stddev
> +		 *
> +		 * abs(interval - mean) < stddev
> +		 *
> +		 * The standard deviation is the sqrt of the variance:
> +		 *
> +		 * abs(interval - mean) < sqrt(variance)
> +		 *
> +		 * and we want to prevent to do an sqrt, so we square
> +		 * the equation:
> +		 *
> +		 * (interval - mean)^2 < variance
> +		 *
> +		 * So if the latest value of the stats complies with
> +		 * this condition, then the wakeup source is
> +		 * considered predictable and can be used to predict
> +		 * the next event.
> +		 */
> +		interval = w->stats.values[w->stats.w_ptr];
> +		if ((u64)((interval - mean) * (interval - mean)) > variance)
> +			continue;
> +

Cute :-)

You could consider putting a simple 3 point median filter in front of
stat_add() to get rid of the worst input noise.

(I know, improving all this was a point for later)
