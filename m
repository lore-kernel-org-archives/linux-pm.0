From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [RFC V2 2/2] sched: idle: IRQ based next prediction for idle
 period
Date: Wed, 20 Jan 2016 15:14:26 -0500 (EST)
Message-ID: <alpine.LFD.2.20.1601201509070.2140@knanqh.ubzr>
References: <alpine.DEB.2.11.1601201634520.3575@nanos> <1453305636-22156-1-git-send-email-daniel.lezcano@linaro.org> <1453305636-22156-6-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:34807 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755020AbcATUO3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2016 15:14:29 -0500
Received: by mail-qg0-f45.google.com with SMTP id 6so15512823qgy.1
        for <linux-pm@vger.kernel.org>; Wed, 20 Jan 2016 12:14:28 -0800 (PST)
In-Reply-To: <1453305636-22156-6-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: tglx@linutronix.de, peterz@infradead.org, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, vincent.guittot@linaro.org

On Wed, 20 Jan 2016, Daniel Lezcano wrote:
[...]

One more comment:

> +		/*
> +		 * If the mean value is null, just ignore this wakeup
> +		 * source.
> +		 */
> +		mean = stats_mean(&w->stats);
> +		if (!mean)
> +			continue;
> +
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
> +		/*
> +		 * Let's compute the next event: the wakeup source is
> +		 * considered predictable, we add the average interval
> +		 * time added to the latest interruption event time.
> +		 */
> +		next = ktime_add_us(w->timestamp, stats_mean(&w->stats));

You don't need to call stats_mean() again as you have it in the 'mean' 
variable already.


Nicolas
