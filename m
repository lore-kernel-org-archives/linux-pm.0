From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V2] cpuidle: Change ktime_get() with local_clock()
Date: Fri, 22 Apr 2016 08:42:40 +0200
Message-ID: <20160422064240.GO3408@twins.programming.kicks-ass.net>
References: <1461228990-28957-1-git-send-email-daniel.lezcano@linaro.org>
 <CAJZ5v0je2kdDF6J4XVmWkySKUvby3bYpCTr51m3+MKGpWYcw=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:40144 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbcDVGmo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Apr 2016 02:42:44 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0je2kdDF6J4XVmWkySKUvby3bYpCTr51m3+MKGpWYcw=Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@kernel.org>, "open list:CPUIDLE DRIVERS" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Thu, Apr 21, 2016 at 09:41:14PM +0200, Rafael J. Wysocki wrote:
> On Thu, Apr 21, 2016 at 10:56 AM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> > The ktime_get() can have a non negligeable overhead, use local_clock()
> > instead.
> >
> > In order to test the difference between ktime_get() and local_clock(),
> > a quick hack has been added to trigger, via debugfs, 10000 times a
> > call to ktime_get() and local_clock() and measure the elapsed time.
> >
> > Then the average value, the min and max is computed for each call.
> >
> > From userspace, the test above was called 100 times every 2 seconds.
> >
> > So, ktime_get() and local_clock() have been called 1000000 times in
> > total.
> >
> > The results are:
> >
> > ktime_get():
> > ============
> >  * average: 101 ns (stddev: 27.4)
> >  * maximum: 38313 ns
> >  * minimum: 65 ns
> >
> > local_clock():
> > ==============
> >  * average: 60 ns (stddev: 9.8)
> >  * maximum: 13487 ns
> >  * minimum: 46 ns
> >
> > The local_clock() is faster and more stable.
> >
> > Even if it is a drop in the ocean, changing the ktime_get() by the
> > local_clock() allows to save 80ns at idle time (entry + exit). And
> > in some circumstances, especially when there are several CPUs racing
> > for the clock access, we save tens of microseconds.
> >
> > The idle duration resulting from a diff is converted from nanosec to
> > microsec. This could be done with integer division (div 1000) - which is
> > an expensive operation or by 10 bits shifting (div 1024) - which is fast
> > but unprecise.
> >
> > The following table gives some results at the limits.
> >
> >  ------------------------------------------
> > |   nsec   |   div(1000)   |   div(1024)   |
> >  ------------------------------------------
> > |   1e3    |        1 usec |      976 nsec |
> >  ------------------------------------------
> > |   1e6    |     1000 usec |      976 usec |
> >  ------------------------------------------
> > |   1e9    |  1000000 usec |   976562 usec |
> >  ------------------------------------------
> >
> > There is a linear deviation of 2.34%. This loss of precision is acceptable
> > in the context of the resulting diff which is used for statistics. These
> > ones are processed to guess estimate an approximation of the duration of the
> > next idle period which ends up into an idle state selection. The selection
> > criteria takes into account the next duration based on large intervals,
> > represented by the idle state's target residency.
> >
> > The 2^10 division is enough because the approximation regarding the 1e3
> > division is lost in all the approximations done for the next idle duration
> > computation.
> >
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Looks good to me.
> 
> Peter, are you happy with the changelog now?

Yep, works for me:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
