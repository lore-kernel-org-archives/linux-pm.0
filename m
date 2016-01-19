From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 18/19] cpufreq: remove transition_lock
Date: Tue, 19 Jan 2016 15:00:36 +0100
Message-ID: <20160119140036.GG6344@twins.programming.kicks-ass.net>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-19-git-send-email-juri.lelli@arm.com>
 <20160112112409.GJ1084@ubuntu>
 <20160113005452.10884.77606@quark.deferred.io>
 <20160113063148.GJ6050@ubuntu>
 <20160113182131.1168.45753@quark.deferred.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:35332 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754176AbcASOAp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2016 09:00:45 -0500
Content-Disposition: inline
In-Reply-To: <20160113182131.1168.45753@quark.deferred.io>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

On Wed, Jan 13, 2016 at 10:21:31AM -0800, Michael Turquette wrote:
> RCU is absolutely not a magic bullet or elixir that lets us kick off
> DVFS transitions from the schedule() context. The frequency transitions
> are write-side operations, as we invariably touch struct cpufreq_policy.
> This means that the read-side stuff can live in the schedule() context,
> but write-side needs to be kicked out to a thread.

Why? If the state is per-cpu and acquired by RCU, updates should be no
problem at all.

If you need inter-cpu state, then things get to be a little tricky
though, but you can actually nest a raw_spinlock_t in there if you
absolutely have to.


