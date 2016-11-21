From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: schedutil: add up/down frequency transition
 rate limits
Date: Mon, 21 Nov 2016 17:00:16 +0530
Message-ID: <20161121113016.GD10014@vireshk-i7>
References: <c6248ec9475117a1d6c9ff9aafa8894f6574a82f.1479359903.git.viresh.kumar@linaro.org>
 <20161121100805.GB10014@vireshk-i7>
 <20161121101946.GI3102@twins.programming.kicks-ass.net>
 <20161121104800.GC10014@vireshk-i7>
 <20161121111243.GK3102@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33032 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754175AbcKULaV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Nov 2016 06:30:21 -0500
Received: by mail-pf0-f180.google.com with SMTP id d2so64358670pfd.0
        for <linux-pm@vger.kernel.org>; Mon, 21 Nov 2016 03:30:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161121111243.GK3102@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Robin Randhawa <robin.randhawa@arm.com>, Steve Muckle <smuckle.linux@gmail.com>, tkjos@google.com, Morten Rasmussen <morten.rasmussen@arm.com>

On 21-11-16, 12:12, Peter Zijlstra wrote:
> I think it should be replaced by a value provided by the driver. It
> makes sense to have a rate-limit in so far as that it doesn't make sense
> to try and program the hardware faster than it can actually change
> frequencies and/or have a programming cost amortization. And this very
> clearly is a driver specific thing.

We already have something called as transition_latency for that (though it isn't
used much currently).

> It however doesn't make sense to me to fudge with this in order to
> achieve ramp up/down differences.

So if a platform, for example, can do DVFS in say 100-500 us, then the scheduler
should try to re-evaluate frequency (and update it) after that short of a
period? Wouldn't that scheme waste lots of time doing just freq updates? And
that's the primary reason why cpufreq governors have some sort of sampling-rate
or rate-limit until now.

-- 
viresh
