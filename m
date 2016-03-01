From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFCv7 PATCH 03/10] sched: scheduler-driven cpu frequency
 selection
Date: Tue, 1 Mar 2016 14:17:24 +0100
Message-ID: <20160301131724.GU6357@twins.programming.kicks-ass.net>
References: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
 <1456190570-4475-4-git-send-email-smuckle@linaro.org>
 <8427745.Y8N2bqC3SO@vostro.rjw.lan>
 <56CF9D8F.7010607@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:60250 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753707AbcCANRb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Mar 2016 08:17:31 -0500
Content-Disposition: inline
In-Reply-To: <56CF9D8F.7010607@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Ricky Liang <jcliang@chromium.org>

On Thu, Feb 25, 2016 at 04:34:23PM -0800, Steve Muckle wrote:
> >> +	/*
> >> +	 * Ensure that all CPUs currently part of this policy are out
> >> +	 * of the hot path so that if this policy exits we can free gd.
> >> +	 */
> >> +	preempt_disable();
> >> +	smp_call_function_many(policy->cpus, dummy, NULL, true);
> >> +	preempt_enable();
> > 
> > I'm not sure how this works, can you please tell me?
> 
> Peter correctly interpreted my intentions.
> 
> The RCU possibility also crossed my mind. They both seemed like a bit of
> a hack to me - this wouldn't really be doing any RCU per se, rather
> relying on its implementation. I'll switch to RCU since that seems to be
> preferred though. It's certainly cleaner to write.

RCU is widely used in this fashion. synchronize_sched() is explicitly
constructed to sync against preempt disable sections. This is not an
implementation detail.
