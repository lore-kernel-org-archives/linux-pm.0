From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 4/4] sched / idle: Call default_idle_call() from cpuidle_enter_state()
Date: Mon, 04 May 2015 23:11:06 +0200
Message-ID: <2497702.nlVf4K8ZSy@vostro.rjw.lan>
References: <3084951.QaIkFrZ3VU@vostro.rjw.lan> <3809765.j45t3RE71A@vostro.rjw.lan> <55478A68.8060902@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59177 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751818AbbEDUqF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2015 16:46:05 -0400
In-Reply-To: <55478A68.8060902@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Monday, May 04, 2015 05:04:08 PM Daniel Lezcano wrote:
> On 05/04/2015 03:58 PM, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The check of the cpuidle_enter() return value against -EBUSY
> > made in call_cpuidle() will not be necessary any more if
> > cpuidle_enter_state() calls default_idle_call() directly when it
> > is about to return -EBUSY, so make that happen and eliminate the
> > check.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>  >
> > ---
> >   drivers/cpuidle/cpuidle.c |    4 +++-
> >   drivers/cpuidle/cpuidle.h |    2 ++
> >   kernel/sched/idle.c       |   14 ++++++--------
> >   3 files changed, 11 insertions(+), 9 deletions(-)
> >
> > Index: linux-pm/drivers/cpuidle/cpuidle.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpuidle/cpuidle.c
> > +++ linux-pm/drivers/cpuidle/cpuidle.c
> > @@ -167,8 +167,10 @@ int cpuidle_enter_state(struct cpuidle_d
> >   	 * local timer will be shut down.  If a local timer is used from another
> >   	 * CPU as a broadcast timer, this call may fail if it is not available.
> >   	 */
> > -	if (broadcast && tick_broadcast_enter())
> > +	if (broadcast && tick_broadcast_enter()) {
> > +		default_idle_call();
> >   		return -EBUSY;
> > +	}
> >
> >   	trace_cpu_idle_rcuidle(index, dev->cpu);
> >   	time_start = ktime_get();
> > Index: linux-pm/drivers/cpuidle/cpuidle.h
> > ===================================================================
> > --- linux-pm.orig/drivers/cpuidle/cpuidle.h
> > +++ linux-pm/drivers/cpuidle/cpuidle.h
> > @@ -18,6 +18,8 @@ extern int cpuidle_enter_state(struct cp
> >   /* idle loop */
> >   extern void cpuidle_install_idle_handler(void);
> >   extern void cpuidle_uninstall_idle_handler(void);
> > +/* kernel/sched/idle.c */
> > +extern void default_idle_call(void);
> 
> There is a cyclic dependency introduced with this function.
> 
> idle.c <=> cpuidle.c
> 
> Are we sure we want them to be mutually dependent ?

Well, hadn't I think so, I wouldn't have posted the patch in the first place. :-)

Aesthetics is one thing and wasted cycles is another.  A redundant check
in the idle loop means a whole lot of wasted cycles throughout the life time
of a kernel.

Rafael

