From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH] thermal/intel_powerclamp: convert to smpboot thread
Date: Wed, 13 Apr 2016 07:20:36 -0700
Message-ID: <20160413072036.41350207@yairi>
References: <1457710701-3014-1-git-send-email-bigeasy@linutronix.de>
	<20160406094735.1bbb3c0c@icelake>
	<570B9CD0.5060904@linutronix.de>
	<20160411081915.585de6c2@icelake>
	<570BCB15.1010702@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <570BCB15.1010702@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, rt@linutronix.de, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>, Petr Mladek <pmladek@suse.com>, jacob.jun.pan@linux.intel.com
List-Id: linux-pm@vger.kernel.org

On Mon, 11 Apr 2016 18:04:37 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> If you raise_softirq() then softirqs are run on return from IRQ code.
> If raise them while holding a BH lock then then they are run after you
> drop the BH lock / enable BH again.
> If the softirq processing is deferred to ksoftirqd *then* you see the
> pending bits.
> 
you are right. there is no need to check in the thread context. the
forced idle only yield to softirqs that are not in ksoftirqd.
thanks for pointing it out. i will remove it.
> >>>> The timer is probably here if mwait would let it sleep too long.
> >>>>  
> >>> not sure i understand. could you explain?  
> >>
> >> The timer invokes noop_timer() which does nothing so the only thing
> >> you want is the interrupt. Your mwait_idle_with_hints() could let
> >> you sleep say for one second. But the timer ensures that you wake
> >> up no later than 100us.
> >>  
> > yeah, that is the idea to make sure we don't oversleep. You mean we
> > can optimize this but avoid extra wake ups? e.g. cancel timer if we
> > already sleep enough time?  
> 
> No, just stated / summarized what I *assumed* the timer was doing and
> just confirmed it.
> I don't see a way how you can cancel the timer.
i don't either, you have to wake up first to cancel.
> And that is why I
> suggest to run as an idle handler because those can sleep endless :)
can you be more specific about idle handler? and we don't want to sleep
more than user required length since the goal is to  get all cpus sleep
and wake up the same time to maximize the overlapped idle states.
> But since you have RT priority you need to make sure that a process
> with lower priority manages to get on the CPU at some point.
