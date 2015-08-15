From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFCv5 PATCH 35/46] sched: Disable energy-unfriendly nohz kicks
Date: Sat, 15 Aug 2015 11:33:32 +0200
Message-ID: <20150815093332.GC10304@worktop.programming.kicks-ass.net>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-36-git-send-email-morten.rasmussen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:44992 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754069AbbHOTv3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 15 Aug 2015 15:51:29 -0400
Content-Disposition: inline
In-Reply-To: <1436293469-25707-36-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, Jul 07, 2015 at 07:24:18PM +0100, Morten Rasmussen wrote:
> With energy-aware scheduling enabled nohz_kick_needed() generates many
> nohz idle-balance kicks which lead to nothing when multiple tasks get
> packed on a single cpu to save energy. This causes unnecessary wake-ups
> and hence wastes energy. Make these conditions depend on !energy_aware()
> for now until the energy-aware nohz story gets sorted out.

The patch does slightly more; it also allows the kick if over utilized.

But disabling this will allow getting 'stuck' in certain over loaded
situations because we're not kicking the balancer.

I think you need more justification for doing this.

