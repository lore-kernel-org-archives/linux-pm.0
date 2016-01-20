From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC V2 2/2] sched: idle: IRQ based next prediction for idle
 period
Date: Wed, 20 Jan 2016 20:40:06 +0100
Message-ID: <20160120194006.GW6357@twins.programming.kicks-ass.net>
References: <1453305636-22156-1-git-send-email-daniel.lezcano@linaro.org>
 <1453305636-22156-3-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:60498 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194AbcATTkK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2016 14:40:10 -0500
Content-Disposition: inline
In-Reply-To: <1453305636-22156-3-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: tglx@linutronix.de, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org

On Wed, Jan 20, 2016 at 05:00:33PM +0100, Daniel Lezcano wrote:
> +static inline u32 stats_mean(struct stats *s)
> +{
> +	/*
> +	 * gcc is smart enough to convert to a bits shift when the
> +	 * divisor is constant and multiple of 2^x.
> +	 *
> +	 * The number of values could have not reached STATS_NR_VALUES
> +	 * yet, but we can consider it acceptable as the situation is
> +	 * only at the beginning of the burst of irqs.
> +	 */
> +	return s->sum / STATS_NR_VALUES;
> +}

Note that ->sum is u64, so you're very prone to truncation.



