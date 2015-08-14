From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [RFCv5 PATCH 30/46] sched: Add cpu capacity awareness to wakeup
 balancing
Date: Fri, 14 Aug 2015 17:20:32 +0100
Message-ID: <20150814162032.GF29326@e105550-lin.cambridge.arm.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-31-git-send-email-morten.rasmussen@arm.com>
 <20150813182409.GB19282@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39213 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755113AbbHNQRL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 14 Aug 2015 12:17:11 -0400
Content-Disposition: inline
In-Reply-To: <20150813182409.GB19282@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Thu, Aug 13, 2015 at 08:24:09PM +0200, Peter Zijlstra wrote:
> On Tue, Jul 07, 2015 at 07:24:13PM +0100, Morten Rasmussen wrote:
> > 
> > This patch adds capacity awareness to find_idlest_{group,queue} (used by
> > SD_BALANCE_{FORK,EXEC}) such that groups/cpus that can accommodate the
> > waking task based on task utilization are preferred. In addition, wakeup
> > of existing tasks (SD_BALANCE_WAKE) is sent through
> > find_idlest_{group,queue} if the task doesn't fit the capacity of the
> > previous cpu to allow it to escape (override wake_affine) when
> > necessary instead of relying on periodic/idle/nohz_idle balance to
> > eventually sort it out.
> > 
> 
> That's policy not guided by the energy model.. Also we need something
> clever for the wakeup balancing, the current stuff all stinks :/

Yes, it is a bit of a mess. This patch just attempting to make things
better for systems where cpu capacity differ. Use of the energy model is
introduced in later patch.

The current code only considers idle cpus and when no such can be found,
the least loaded cpu. This is one of the main reasons why mainline
performance is random on big.LITTLE.

I can write you a longer story, or we can discuss it in SEA next week
;-)
