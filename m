From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
Subject: Re: [v3 PATCH 2/4] timers: Identifying the existing
	pinned timers
Date: Wed, 18 Mar 2009 10:06:50 +0530
Message-ID: <20090318043650.GA7138__35374.779351014$1237351263$gmane$org@linux.vnet.ibm.com>
References: <20090316111045.GA4686@linux.vnet.ibm.com>
	<20090316111337.GC4686@linux.vnet.ibm.com>
	<alpine.LFD.2.00.0903171401190.29264@localhost.localdomain>
Reply-To: arun@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0903171401190.29264@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org, vatsa@linux.vnet.ibm.com, andi@firstfloor.org, linux-pm@lists.linux-foundation.org, mingo@elte.hu, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

* Thomas Gleixner <tglx@linutronix.de> [2009-03-17 14:07:44]:

> On Mon, 16 Mar 2009, Arun R Bharadwaj wrote:
> > * Arun R Bharadwaj <arun@linux.vnet.ibm.com> [2009-03-16 16:40:45]:
> > 
> > The following pinned hrtimers have been identified and marked:
> > 1)sched_rt_period_timer
> > 2)tick_sched_timer
> > 3)stack_trace_timer_fn
> 
> How did you verify that these are the only timers which need to be
> pinned ?
>

Until 2.6.28, there was a callback mode called HRTIMER_CB_IRQSAFE_PERCPU
which did not allow timers to be migrated, if set.
These were the only 3 hrtimers which were using that callback mode.

--arun

> Can we be sure that there is no code which relies on the current
> behaviour to keep functionality tied together ? Networking and block
> layer comes to mind.
> 
> Thanks,
> 
> 	tglx
