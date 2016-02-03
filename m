From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH 5/5] cpufreq: Get rid of ->governor_enabled and its lock
Date: Wed, 3 Feb 2016 11:05:12 +0000
Message-ID: <20160203110512.GR3947@e106622-lin>
References: <cover.1454410226.git.viresh.kumar@linaro.org>
 <48d24fd180e1fdf1c06a6992748c6365be43e937.1454410226.git.viresh.kumar@linaro.org>
 <20160202164937.GK3947@e106622-lin>
 <20160203060554.GS31828@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33341 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751308AbcBCLEd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 3 Feb 2016 06:04:33 -0500
Content-Disposition: inline
In-Reply-To: <20160203060554.GS31828@vireshk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org

On 03/02/16 11:35, Viresh Kumar wrote:
> On 02-02-16, 16:49, Juri Lelli wrote:
> > There are still paths where we call __cpufreq_governor() without holding
> > policy->rwsem, but those should be fixed with my cleanups (that I intend
> > to refresh and post soon). So, I'm not sure we can safely remove this
> > yet.
> 
> No, we can't.. Though I haven't seen any races from happening even
> after removing it, but it doesn't mean we can't.
> 
> The deal is that, the entire sequence of events needs to be guaranteed
> to happen in a particular order without any other code performing
> similar operations concurrently.
> 
> And so we need to preserve the other sites with proper rwsem locking
> first.
> 

Right. I guess it is what I was trying to do with my cleanups, adding
assertions and fixing paths that didn't verify those.

It should be easy to rebase that set (or a part of it) on top of your
and/or Rafael changes. I realize that there are multiple sets of changes
under discussion; so, please tell me how do you, and Rafael, want to
proceed about this.

> > So, __cpufreq_governor() becomes effectively a wrapper around
> > ->governor() calls and governors are left responsible for implementing
> > the state machine with appropriate checks.
> 
> Not really. The core can now guarantee that the entire sequence
> happens atomically. For example, on governor switch, we need to
> guarantee that STOP/EXIT happen without any intervention for the old
> governor. Or, INIT/START/LIMITS happen without any intervention for
> the new governor, etc..
> 

OK, checking for invalid state transitions (for ondemand and
conservative) is still in done cpufreq_governor.c.

> > Maybe we add a comment somewhere stating exactly how things are meant to
> > work?

But, I guess any other governor that will bypass cpufreq_governor.c, it
will also have to implement such checks. I was just proposing to state
this somewhere, so that we don't forget.

Best,

- Juri
