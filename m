From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 1/3] cpufreq: add resolve_freq driver callback
Date: Tue, 31 May 2016 11:00:11 +0530
Message-ID: <20160531053011.GD9463@vireshk-i7>
References: <1464231181-30741-1-git-send-email-smuckle@linaro.org>
 <1464231181-30741-2-git-send-email-smuckle@linaro.org>
 <20160526062514.GU17585@vireshk-i7>
 <20160530153115.GE9864@graphite.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33415 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbcEaFaP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 May 2016 01:30:15 -0400
Received: by mail-pf0-f176.google.com with SMTP id b124so70628667pfb.0
        for <linux-pm@vger.kernel.org>; Mon, 30 May 2016 22:30:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160530153115.GE9864@graphite.smuckle.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

On 30-05-16, 08:31, Steve Muckle wrote:
> My goal here was to have the system operate in this case in a manner
> that is obviously not optimized (running at fmax), so the platform owner
> realizes that the cpufreq driver doesn't fully support the schedutil
> governor.
> 
> I was originally going to just return an error code but that also means
> having to check for it which would be nice to avoid if possible on this
> fast path.

Okay, I get what you are saying.

But all we are doing here is to make things fast by not sending IPIs,
etc. That should *not* lead to a behavior where the frequency stays at
MAX all the time even if the driver doesn't provide this callback or
the freq-table.

If we just return the target_freq in this case instead of UINT_MAX,
the platform may eventually have some unnecessary IPIs, wakeups, etc,
but its frequency will still be switched properly.

Wouldn't that be a better choice ?

-- 
viresh
