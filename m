From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFCv5 PATCH 30/46] sched: Add cpu capacity awareness to wakeup
 balancing
Date: Thu, 13 Aug 2015 20:24:09 +0200
Message-ID: <20150813182409.GB19282@twins.programming.kicks-ass.net>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-31-git-send-email-morten.rasmussen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:59460 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637AbbHMSYN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2015 14:24:13 -0400
Content-Disposition: inline
In-Reply-To: <1436293469-25707-31-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, Jul 07, 2015 at 07:24:13PM +0100, Morten Rasmussen wrote:
> 
> This patch adds capacity awareness to find_idlest_{group,queue} (used by
> SD_BALANCE_{FORK,EXEC}) such that groups/cpus that can accommodate the
> waking task based on task utilization are preferred. In addition, wakeup
> of existing tasks (SD_BALANCE_WAKE) is sent through
> find_idlest_{group,queue} if the task doesn't fit the capacity of the
> previous cpu to allow it to escape (override wake_affine) when
> necessary instead of relying on periodic/idle/nohz_idle balance to
> eventually sort it out.
> 

That's policy not guided by the energy model.. Also we need something
clever for the wakeup balancing, the current stuff all stinks :/
