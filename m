From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/4] sched / idle: Move the default idle call code to a separate function
Date: Mon, 04 May 2015 23:08:29 +0200
Message-ID: <4693756.ntBpWDU92s@vostro.rjw.lan>
References: <3084951.QaIkFrZ3VU@vostro.rjw.lan> <1607938.mB5HZupMYV@vostro.rjw.lan> <20150504142245.GL23123@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62462 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750997AbbEDUn3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2015 16:43:29 -0400
In-Reply-To: <20150504142245.GL23123@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>

On Monday, May 04, 2015 04:22:45 PM Peter Zijlstra wrote:
> On Mon, May 04, 2015 at 03:56:24PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Move the code under the "use_default" label in cpuidle_idle_call()
> > into a separate (new) function.
> > 
> > This just allows the subsequent changes to be more stratightforward.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  kernel/sched/idle.c |   42 +++++++++++++++++++++++-------------------
> >  1 file changed, 23 insertions(+), 19 deletions(-)
> > 
> > Index: linux-pm/kernel/sched/idle.c
> > ===================================================================
> > --- linux-pm.orig/kernel/sched/idle.c
> > +++ linux-pm/kernel/sched/idle.c
> > @@ -67,6 +67,17 @@ void __weak arch_cpu_idle(void)
> >  	local_irq_enable();
> >  }
> >  
> > +static void default_idle_call(void) {
> 
> Please put opening brace of function on a new line.

Ah that's weird.  I wonder why I haven't noticed this myself.

Rafael

