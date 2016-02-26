From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFCv7 PATCH 03/10] sched: scheduler-driven cpu frequency
 selection
Date: Fri, 26 Feb 2016 10:18:43 +0100
Message-ID: <20160226091843.GX6356@twins.programming.kicks-ass.net>
References: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
 <8427745.Y8N2bqC3SO@vostro.rjw.lan>
 <20160225092837.GD6357@twins.programming.kicks-ass.net>
 <1792311.cuUNhUde5n@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:57175 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbcBZJSt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2016 04:18:49 -0500
Content-Disposition: inline
In-Reply-To: <1792311.cuUNhUde5n@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Ricky Liang <jcliang@chromium.org>

On Thu, Feb 25, 2016 at 10:08:48PM +0100, Rafael J. Wysocki wrote:
> On Thursday, February 25, 2016 10:28:37 AM Peter Zijlstra wrote:
> > Its vile though; one should not spray IPIs if one can avoid it. Such
> > things are much better done with RCU. Sure sync_sched() takes a little
> > longer, but this isn't a fast path by any measure.
> 
> I see, thanks!
> 
> BTW, when cpufreq_update_util() callbacks are removed, I use synchronize_rcu()
> to wait for the running ones, but would it be better to use synchronize_sched()
> in there instead?

So I think we only call the callback with rq->lock held, in which case
sync_sched() is good enough.

It would allow you to get rid of the rcu_read_{,un}lock() calls as well.

The down-side is that it all makes the code a little harder to get,
because you're relying on caller context to DTRT.
