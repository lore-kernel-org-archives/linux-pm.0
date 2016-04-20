From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle: Change ktime_get() with local_clock()
Date: Wed, 20 Apr 2016 18:47:48 +0200
Message-ID: <20160420164748.GL5862@linaro.org>
References: <1460661834-5683-1-git-send-email-daniel.lezcano@linaro.org>
 <20160420121315.GC3408@twins.programming.kicks-ass.net>
 <20160420123011.GJ5862@linaro.org>
 <20160420125837.GZ3430@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36732 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbcDTQrx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Apr 2016 12:47:53 -0400
Received: by mail-wm0-f47.google.com with SMTP id v188so211444113wme.1
        for <linux-pm@vger.kernel.org>; Wed, 20 Apr 2016 09:47:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160420125837.GZ3430@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, mingo@kernel.org, "open list:CPUIDLE DRIVERS" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Wed, Apr 20, 2016 at 02:58:37PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 20, 2016 at 02:30:11PM +0200, Daniel Lezcano wrote:
> > On Wed, Apr 20, 2016 at 02:13:15PM +0200, Peter Zijlstra wrote:
> > > On Thu, Apr 14, 2016 at 09:23:54PM +0200, Daniel Lezcano wrote:
> > > > @@ -217,7 +217,11 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
> > > >  	if (!cpuidle_state_is_coupled(drv, entered_state))
> > > >  		local_irq_enable();
> > > >  
> > > > -	diff = ktime_to_us(ktime_sub(time_end, time_start));
> > > > +	/*
> > > > +	 * local_clock() returns the time in nanosecond, let's shift
> > > > +	 * by 10 (divide by 1024) to have microsecond based time.
> > > > +	 */
> > > > +	diff = (time_end - time_start) >> 10;
> > > 
> > > Changelog fails to explain the ramifications of this change...
> > 
> > Sorry, I don't get the point of your comment. Do you mean I should elaborate 
> > the comment above in the changelog?
> 
> Yeah, why is /1024 good enough?

Ok.

The conversion between nanosec to microsec could be done with integer 
division (div 1000) or by 10 bits shifting (div 1024).

The following table gives some results at the limits.

 ------------------------------------------
|   nsec   |   div(1000)   |   div(1024)   |
 ------------------------------------------
|   1e3    |        1 usec |      976 nsec |
 ------------------------------------------
|   1e6    |     1000 usec |      976 usec |
 ------------------------------------------
|   1e9    |  1000000 usec |   976562 usec |
 ------------------------------------------

There is a linear deviation of 2.34%. This loss of precision is acceptable 
in the context of the resulting diff which is used for statistics. These 
ones are processed to guess estimate an approximation of the duration of the 
next idle period which ends up into an idle state selection. The selection 
criteria takes into account the next duration based on large intervals, 
represented by the idle state's target residency.

The 2^10 division is enough because the approximation regarding the 1e3 
division is lost in all the approximations done for the next idle duration 
computation.

Would be this explanation sufficient ?
