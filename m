From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] cpuidle: Change ktime_get() with local_clock()
Date: Wed, 20 Apr 2016 14:58:37 +0200
Message-ID: <20160420125837.GZ3430@twins.programming.kicks-ass.net>
References: <1460661834-5683-1-git-send-email-daniel.lezcano@linaro.org>
 <20160420121315.GC3408@twins.programming.kicks-ass.net>
 <20160420123011.GJ5862@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:38012 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487AbcDTM6j (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Apr 2016 08:58:39 -0400
Content-Disposition: inline
In-Reply-To: <20160420123011.GJ5862@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, mingo@kernel.org, "open list:CPUIDLE DRIVERS" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Wed, Apr 20, 2016 at 02:30:11PM +0200, Daniel Lezcano wrote:
> On Wed, Apr 20, 2016 at 02:13:15PM +0200, Peter Zijlstra wrote:
> > On Thu, Apr 14, 2016 at 09:23:54PM +0200, Daniel Lezcano wrote:
> > > @@ -217,7 +217,11 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
> > >  	if (!cpuidle_state_is_coupled(drv, entered_state))
> > >  		local_irq_enable();
> > >  
> > > -	diff = ktime_to_us(ktime_sub(time_end, time_start));
> > > +	/*
> > > +	 * local_clock() returns the time in nanosecond, let's shift
> > > +	 * by 10 (divide by 1024) to have microsecond based time.
> > > +	 */
> > > +	diff = (time_end - time_start) >> 10;
> > 
> > Changelog fails to explain the ramifications of this change...
> 
> Sorry, I don't get the point of your comment. Do you mean I should elaborate 
> the comment above in the changelog?

Yeah, why is /1024 good enough?
