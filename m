From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v2 2/3] cpuidle: allow setting deepest idle
Date: Tue, 15 Nov 2016 08:52:17 -0800
Message-ID: <20161115085217.72bec126@jacob-builder>
References: <1479149278-12418-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1479149278-12418-3-git-send-email-jacob.jun.pan@linux.intel.com>
        <7184537.W21RKrGsQO@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:59848 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751359AbcKOQuj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 15 Nov 2016 11:50:39 -0500
In-Reply-To: <7184537.W21RKrGsQO@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Arjan van de Ven <arjan@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Petr Mladek <pmladek@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, jacob.jun.pan@linux.intel.com

On Mon, 14 Nov 2016 22:42:03 +0100
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> > diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> > index cb6442f..9e80f32 100644
> > --- a/kernel/sched/idle.c
> > +++ b/kernel/sched/idle.c
> > @@ -173,6 +173,9 @@ static void cpuidle_idle_call(void)
> >  
> >  		next_state = cpuidle_find_deepest_state(drv, dev);
> >  		call_cpuidle(drv, dev, next_state);
> > +	} else if (dev->use_deepest_state) {
> > +		next_state = cpuidle_find_deepest_state(drv, dev);
> > +		call_cpuidle(drv, dev, next_state);
> >  	} else {
> >  		/*
> >  		 * Ask the cpuidle framework to choose a
> > convenient idle state.  
> 
> I would arrange the code slightly differently here:
> 
> 	if (idle_should_freeze() || dev->use_deepest_state) {
> 		if (idle_should_freeze()) {
> 			entered_state = cpuidle_enter_freeze(drv,
> dev); if (entered_state > 0) {
> 				local_irq_enable();
> 				goto exit_idle;
> 			}
> 		}
> 
> 		next_state = cpuidle_find_deepest_state(drv, dev);
> 		call_cpuidle(drv, dev, next_state);
> 	} else {
> 
> 
> This way you'd avoid the ugly code duplication and the extra
> dev->use_deepest_state branch in the most frequent case.  I guess you
> could take the unlikely() thing away from idle_should_freeze() and
> use it directly here too.
Sounds good. Will change in the next version.
