From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 5/5] cpufreq: Get rid of ->governor_enabled and its lock
Date: Wed, 3 Feb 2016 11:35:54 +0530
Message-ID: <20160203060554.GS31828@vireshk>
References: <cover.1454410226.git.viresh.kumar@linaro.org>
 <48d24fd180e1fdf1c06a6992748c6365be43e937.1454410226.git.viresh.kumar@linaro.org>
 <20160202164937.GK3947@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35885 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755852AbcBCGF6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Feb 2016 01:05:58 -0500
Received: by mail-pf0-f169.google.com with SMTP id n128so7870481pfn.3
        for <linux-pm@vger.kernel.org>; Tue, 02 Feb 2016 22:05:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160202164937.GK3947@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org

On 02-02-16, 16:49, Juri Lelli wrote:
> There are still paths where we call __cpufreq_governor() without holding
> policy->rwsem, but those should be fixed with my cleanups (that I intend
> to refresh and post soon). So, I'm not sure we can safely remove this
> yet.

No, we can't.. Though I haven't seen any races from happening even
after removing it, but it doesn't mean we can't.

The deal is that, the entire sequence of events needs to be guaranteed
to happen in a particular order without any other code performing
similar operations concurrently.

And so we need to preserve the other sites with proper rwsem locking
first.

> So, __cpufreq_governor() becomes effectively a wrapper around
> ->governor() calls and governors are left responsible for implementing
> the state machine with appropriate checks.

Not really. The core can now guarantee that the entire sequence
happens atomically. For example, on governor switch, we need to
guarantee that STOP/EXIT happen without any intervention for the old
governor. Or, INIT/START/LIMITS happen without any intervention for
the new governor, etc..

> Maybe we add a comment somewhere stating exactly how things are meant to
> work?

Hmm.

-- 
viresh
