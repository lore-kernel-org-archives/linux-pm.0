From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: schedutil: add up/down frequency transition
 rate limits
Date: Mon, 21 Nov 2016 15:38:05 +0530
Message-ID: <20161121100805.GB10014@vireshk-i7>
References: <c6248ec9475117a1d6c9ff9aafa8894f6574a82f.1479359903.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36624 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752469AbcKUKIJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Nov 2016 05:08:09 -0500
Received: by mail-pf0-f175.google.com with SMTP id 189so63998680pfz.3
        for <linux-pm@vger.kernel.org>; Mon, 21 Nov 2016 02:08:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <c6248ec9475117a1d6c9ff9aafa8894f6574a82f.1479359903.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Robin Randhawa <robin.randhawa@arm.com>, Steve Muckle <smuckle.linux@gmail.com>, tkjos@google.com

On 17-11-16, 10:48, Viresh Kumar wrote:
> From: Steve Muckle <smuckle.linux@gmail.com>
> 
> The rate-limit tunable in the schedutil governor applies to transitions
> to both lower and higher frequencies. On several platforms it is not the
> ideal tunable though, as it is difficult to get best power/performance
> figures using the same limit in both directions.
> 
> It is common on mobile platforms with demanding user interfaces to want
> to increase frequency rapidly for example but decrease slowly.
> 
> One of the example can be a case where we have short busy periods
> followed by similar or longer idle periods. If we keep the rate-limit
> high enough, we will not go to higher frequencies soon enough. On the
> other hand, if we keep it too low, we will have too many frequency
> transitions, as we will always reduce the frequency after the busy
> period.
> 
> It would be very useful if we can set low rate-limit while increasing
> the frequency (so that we can respond to the short busy periods quickly)
> and high rate-limit while decreasing frequency (so that we don't reduce
> the frequency immediately after the short busy period and that may avoid
> frequency transitions before the next busy period).
> 
> Implement separate up/down transition rate limits. Note that the
> governor avoids frequency recalculations for a period equal to minimum
> of up and down rate-limit. A global mutex is also defined to protect
> updates to min_rate_limit_us via two separate sysfs files.
> 
> Note that this wouldn't change behavior of the schedutil governor for
> the platforms which wish to keep same values for both up and down rate
> limits.
> 
> This is tested with the rt-app [1] on ARM Exynos, dual A15 processor
> platform.
> 
> Testcase: Run a SCHED_OTHER thread on CPU0 which will emulate work-load
> for X ms of busy period out of the total period of Y ms, i.e. Y - X ms
> of idle period. The values of X/Y taken were: 20/40, 20/50, 20/70, i.e
> idle periods of 20, 30 and 50 ms respectively. These were tested against
> values of up/down rate limits as: 10/10 ms and 10/40 ms.
> 
> For every test we noticed a performance increase of 5-10% with the
> schedutil governor, which was very much expected.
> 
> [Viresh]: Simplified user interface and introduced min_rate_limit_us +
> 	      mutex, rewrote commit log and included test results.
> 
> [1] https://github.com/scheduler-tools/rt-app/
> 
> Signed-off-by: Steve Muckle <smuckle.linux@gmail.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  kernel/sched/cpufreq_schedutil.c | 106 +++++++++++++++++++++++++++++++++------
>  1 file changed, 90 insertions(+), 16 deletions(-)

(Background story for others from my discussion with Rafael on IRC: Rafael
proposed that instead of this patch we can add down_rate_limit_delta_us (>0 =)
which can be added to rate_limit_us (rate limit while increasing freq) to find
the rate limit to be used in the downward direction. And I raised the point
that it looks much neater to have separate up and down rate_limit_us. I also
said that people may have a valid case where they want to keep down_rate_limit
lower than up_rate_limit and Rafael wasn't fully sure of any such cases).

Hi Rafael,

I gathered inputs from few people (including Google) and there are two cases
basically we need to support:

- Performance mode (normal phone mode): We want to have higher values of
  down_rate_limit and lower_values of up_rate_limit as performance is more
  important here and we want to avoid unnecessary transitions to lower
  frequencies for short bursts.

- Power-saving mode (like the Battery-saver mode in Android phones): We want to
  save power here but don't want to be too bad in performance at the same time.
  So, platform may not use powersave governor but schedutil. But in this case we
  may want to keep down_rate_limit to a value lower than up_rate_limit, as we
  want to switch back to lower frequencies as soon as the load reduces. This
  will also ensure that we move to higher frequencies at a slower pace, i.e.
  less aggressively.

-- 
viresh
