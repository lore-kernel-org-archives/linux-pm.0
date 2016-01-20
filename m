From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC V2 2/2] sched: idle: IRQ based next prediction for idle
 period
Date: Wed, 20 Jan 2016 20:29:52 +0100
Message-ID: <20160120192952.GU6357@twins.programming.kicks-ass.net>
References: <1453305636-22156-1-git-send-email-daniel.lezcano@linaro.org>
 <1453305636-22156-3-git-send-email-daniel.lezcano@linaro.org>
 <20160120190205.GR6357@twins.programming.kicks-ass.net>
 <alpine.LFD.2.20.1601201408430.2140@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:60108 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754529AbcATT3z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2016 14:29:55 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1601201408430.2140@knanqh.ubzr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, tglx@linutronix.de, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, vincent.guittot@linaro.org

On Wed, Jan 20, 2016 at 02:17:57PM -0500, Nicolas Pitre wrote:
> > It is also a friggin pointless /1000. The cpuidle code also loves to do
> > this, and its silly, u64 add/sub are _way_ cheaper than u64 / 1000.
> 
> For the purpose of this code, nanoseconds simply provides too many bits 
> for what we care.  Computing the variance implies squared values.
> 
> *However* we can simply do diff = (timestamp - w->timestamp) >> 10 
> instead.  No need to have an exact microsecs base.

Right, you could also reduce bits at the variance computation, but yes.
