From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC V2 2/2] sched: idle: IRQ based next prediction for idle
 period
Date: Thu, 21 Jan 2016 14:04:05 +0100
Message-ID: <56A0D745.9060109@linaro.org>
References: <alpine.DEB.2.11.1601201634520.3575@nanos>
 <1453305636-22156-1-git-send-email-daniel.lezcano@linaro.org>
 <1453305636-22156-6-git-send-email-daniel.lezcano@linaro.org>
 <alpine.LFD.2.20.1601201509070.2140@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35793 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965130AbcAUNEI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2016 08:04:08 -0500
Received: by mail-wm0-f41.google.com with SMTP id r129so171318248wmr.0
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2016 05:04:08 -0800 (PST)
In-Reply-To: <alpine.LFD.2.20.1601201509070.2140@knanqh.ubzr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: tglx@linutronix.de, peterz@infradead.org, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, vincent.guittot@linaro.org

On 01/20/2016 09:14 PM, Nicolas Pitre wrote:
> On Wed, 20 Jan 2016, Daniel Lezcano wrote:
> [...]
>
> One more comment:
>
>> +		/*
>> +		 * If the mean value is null, just ignore this wakeup
>> +		 * source.
>> +		 */
>> +		mean =3D stats_mean(&w->stats);
>> +		if (!mean)
>> +			continue;
>> +
>> +		variance =3D stats_variance(&w->stats, mean);
>> +		/*
>> +		 * We want to check the last interval is:
>> +		 *
>> +		 *  mean - stddev < interval < mean + stddev
>> +		 *
>> +		 * That simplifies to:
>> +		 *
>> +		 * -stddev < interval - mean < stddev
>> +		 *
>> +		 * abs(interval - mean) < stddev
>> +		 *
>> +		 * The standard deviation is the sqrt of the variance:
>> +		 *
>> +		 * abs(interval - mean) < sqrt(variance)
>> +		 *
>> +		 * and we want to prevent to do an sqrt, so we square
>> +		 * the equation:
>> +		 *
>> +		 * (interval - mean)^2 < variance
>> +		 *
>> +		 * So if the latest value of the stats complies with
>> +		 * this condition, then the wakeup source is
>> +		 * considered predictable and can be used to predict
>> +		 * the next event.
>> +		 */
>> +		interval =3D w->stats.values[w->stats.w_ptr];
>> +		if ((u64)((interval - mean) * (interval - mean)) > variance)
>> +			continue;
>> +
>> +		/*
>> +		 * Let's compute the next event: the wakeup source is
>> +		 * considered predictable, we add the average interval
>> +		 * time added to the latest interruption event time.
>> +		 */
>> +		next =3D ktime_add_us(w->timestamp, stats_mean(&w->stats));
>
> You don't need to call stats_mean() again as you have it in the 'mean=
'
> variable already.

Good point.


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

