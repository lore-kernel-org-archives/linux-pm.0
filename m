From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH v2 1/3] cpufreq: add resolve_freq driver callback
Date: Tue, 31 May 2016 11:48:55 -0700
Message-ID: <20160531184855.GK9864@graphite.smuckle.net>
References: <1464231181-30741-1-git-send-email-smuckle@linaro.org>
 <1464231181-30741-2-git-send-email-smuckle@linaro.org>
 <20160526062514.GU17585@vireshk-i7>
 <20160530153115.GE9864@graphite.smuckle.net>
 <20160531053011.GD9463@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:32976 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960AbcEaSs7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 May 2016 14:48:59 -0400
Received: by mail-pf0-f177.google.com with SMTP id b124so77018984pfb.0
        for <linux-pm@vger.kernel.org>; Tue, 31 May 2016 11:48:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160531053011.GD9463@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

On Tue, May 31, 2016 at 11:00:11AM +0530, Viresh Kumar wrote:
> On 30-05-16, 08:31, Steve Muckle wrote:
> > My goal here was to have the system operate in this case in a manner
> > that is obviously not optimized (running at fmax), so the platform owner
> > realizes that the cpufreq driver doesn't fully support the schedutil
> > governor.
> > 
> > I was originally going to just return an error code but that also means
> > having to check for it which would be nice to avoid if possible on this
> > fast path.
> 
> Okay, I get what you are saying.
> 
> But all we are doing here is to make things fast by not sending IPIs,
> etc. That should *not* lead to a behavior where the frequency stays at
> MAX all the time even if the driver doesn't provide this callback or
> the freq-table.
> 
> If we just return the target_freq in this case instead of UINT_MAX,
> the platform may eventually have some unnecessary IPIs, wakeups, etc,
> but its frequency will still be switched properly.
> 
> Wouldn't that be a better choice ?

I'm still concerned that a platform owner may use this and accept
suboptimal perf/power because they aren't aware their cpufreq driver is
not fully compliant. But I agree it'd be better to have it work as well
as it can. I will make the change.

Maybe a warning message can be added when schedutil initializes if
resolve_freq is not supported.

thanks,
Steve
