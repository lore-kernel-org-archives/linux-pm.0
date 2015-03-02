From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] cpuidle: Clean up fallback handling in cpuidle_idle_call()
Date: Mon, 02 Mar 2015 23:30:49 +0100
Message-ID: <1646614.U29HtKCHyB@vostro.rjw.lan>
References: <1424800730-32059-1-git-send-email-lorenzo.pieralisi@arm.com> <49170765.GVk6ROgF6X@vostro.rjw.lan> <20150302160536.GA5515@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57535 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753846AbbCBWHR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Mar 2015 17:07:17 -0500
In-Reply-To: <20150302160536.GA5515@red-moon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>

On Monday, March 02, 2015 04:05:36 PM Lorenzo Pieralisi wrote:
> On Mon, Mar 02, 2015 at 02:51:35PM +0000, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Move the fallback code path in cpuidle_idle_call() to the end of the
> > function to avoid jumping to a label in a an if () branch.
> 
> Nit: "in an if () branch"
> 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  kernel/sched/idle.c |   29 +++++++++++++++--------------
> >  1 file changed, 15 insertions(+), 14 deletions(-)
> > 
> > Index: linux-pm/kernel/sched/idle.c
> > ===================================================================
> > --- linux-pm.orig/kernel/sched/idle.c
> > +++ linux-pm/kernel/sched/idle.c
> > @@ -124,20 +124,8 @@ static void cpuidle_idle_call(void)
> >  	 * Fall back to the default arch idle method on errors.
> >  	 */
> >  	next_state = cpuidle_select(drv, dev);
> > -	if (next_state < 0) {
> > -use_default:
> > -		/*
> > -		 * We can't use the cpuidle framework, let's use the default
> > -		 * idle routine.
> > -		 */
> > -		if (current_clr_polling_and_test())
> > -			local_irq_enable();
> > -		else
> > -			arch_cpu_idle();
> > -
> > -		goto exit_idle;
> > -	}
> > -
> > +	if (next_state < 0)
> > +		goto use_default;
> >  
> >  	/*
> >  	 * The idle task must be scheduled, it is pointless to
> > @@ -195,6 +183,19 @@ exit_idle:
> >  
> >  	rcu_idle_exit();
> >  	start_critical_timings();
> > +	return;
> > +
> > +use_default:
> > +	/*
> > +	 * We can't use the cpuidle framework, let's use the default
> > +	 * idle routine.
> > +	 */
> > +	if (current_clr_polling_and_test())
> > +		local_irq_enable();
> > +	else
> > +		arch_cpu_idle();
> > +
> > +	goto exit_idle;
> 
> I wonder whether making the code at label use_default a function saves us
> some jumping around, not sure it is worth the churn, your call, I am ok as
> it is.

We'd need to jump anyway, we might only need to jump one time less and we'd
need to call the function for multiple times instead if I'm not mistaken.

I'm going to apply the current version.

Rafael

