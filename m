From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Find transition latency dynamically
Date: Wed, 7 Jun 2017 09:30:01 +0530
Message-ID: <20170607040001.GF5103@vireshk-i7>
References: <8041a965fcca71231576ae77a141b1e4333a81cc.1496402967.git.viresh.kumar@linaro.org>
 <1496764110.28352.49.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35646 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750730AbdFGEAG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jun 2017 00:00:06 -0400
Received: by mail-pf0-f177.google.com with SMTP id l89so851375pfi.2
        for <linux-pm@vger.kernel.org>; Tue, 06 Jun 2017 21:00:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1496764110.28352.49.camel@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>

On 06-06-17, 18:48, Leonard Crestez wrote:
> I remember checking if transition latency is correct for imx6q-cpufreq
> and it does not appear to be. Maybe because i2c latency of regulator
> adjustments is not counted in?

+ software latency + other stuff based on platforms.

And that's why I am trying to introduce dynamic latencies.

> It seems to me it would be much nicer to have a special flag for this
> instead of overriding CPUFREQ_ETERNAL.

Well, CPUFREQ_ETERNAL is specially there for drivers which don't know their
latencies and so we aren't really overriding it here. We are just trying to do
something sensible for them.

Over that I intend to move as many of the current drivers as possible to specify
CPUFREQ_ETERNAL instead of passing a static transition latency. The field
transition_latency will stay for platforms which don't want kernel to find it
dynamically though.

The only case which is left from above is where a platform sets its latency to
CPUFREQ_ETERNAL and it doesn't want the core to find the latency dynamically. I
would like to learn about the reasons on why do we need that and that is still
doable by setting the latency to something high enough which disallows us to use
ondemand/conservative governors.

> Also, wouldn't it be possible to update this dynamically? Just measure
> the duration every time it happens and do an update like latency =
> (latency * 7 + latest_latency) / 8.

I had that in mind but I want to know of the cases where platforms don't get the
latencies right in the first go (at boot). Because if we update latencies then
there are other things we need to do as well, for example update rate_limit_us
of schedutil governor if it isn't overridden by the user yet. So its not that
straight forward.

Plus, we don't have to get the averages here like you suggested, we are
interested in the max rather (worst case latency).

Thanks for your reviews :)

-- 
viresh
