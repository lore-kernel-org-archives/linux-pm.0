From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/2] sched/fair: move cpufreq hook to
 update_cfs_rq_load_avg()
Date: Fri, 1 Apr 2016 11:20:19 +0200
Message-ID: <20160401092019.GN3430@twins.programming.kicks-ass.net>
References: <1458606068-7476-1-git-send-email-smuckle@linaro.org>
 <56F91D56.4020007@arm.com>
 <56F95D10.4070400@linaro.org>
 <56F97856.4040804@arm.com>
 <56F98832.3030207@linaro.org>
 <20160330193544.GD407@worktop>
 <56FC807C.80204@linaro.org>
 <20160331073743.GF3408@twins.programming.kicks-ass.net>
 <56FD95EE.6090007@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:42028 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbcDAJUX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2016 05:20:23 -0400
Content-Disposition: inline
In-Reply-To: <56FD95EE.6090007@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

On Thu, Mar 31, 2016 at 02:26:06PM -0700, Steve Muckle wrote:
> > Can't, the way the wakeup path is constructed we would be sending the
> > IPI way before we know about utilization.
> 
> Sorry I thought we were referring to the possibility of sending an IPI
> to just run the cpufreq driver rather than to conduct the whole wakeup
> operation.
> 
> My thinking was in CFS we get rid of the (cpu == smp_processor_id())
> condition for calling the cpufreq hook.
> 
> The sched governor can then calculate utilization and frequency required
> for cpu. If (cpu == smp_processor_id()), the update is processed
> normally. If (cpu != smp_processor_id()) and the new frequency is higher
> than cpu's Fcur, the sched gov IPIs cpu to continue running the update
> operation. Otherwise, the update is dropped.
> 
> Does that sound plausible?

Can be done I suppose..
