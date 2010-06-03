From: Ingo Molnar <mingo@elte.hu>
Subject: Re: suspend blockers & Android integration
Date: Fri, 4 Jun 2010 01:23:02 +0200
Message-ID: <20100603232302.GA16184__17765.316720079$1275607476$gmane$org@elte.hu>
References: <20100603193045.GA7188@elte.hu>
 <20100603231153.GA11302@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100603231153.GA11302@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: tytso@mit.edu
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Florian Mickler <florian@mickler.org>, Neil Brown <neilb@suse.de>, Brian Swetland <swetland@google.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Felipe Balbi <felipe.balbi@nokia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> * tytso@mit.edu <tytso@mit.edu> wrote:
> 
> > [...] Not only has the source code been made available, but hundreds of 
> > engineering hours have been made trying to accomodate the demands of LKML 
> > --- and LKML has said no to suspend blockers/wakelocks.
> 
> I dont think you are being fair here, at all.
> 
> Firstly, the suspend-blockers feature is not being rejected (fixing and 
> extending suspend is a worthwile goal), it's just that various different 
> schemes have been proposed by the people who'll eventually have to maintain 
> that code down the line.

Btw., i'd like to summarize the scheduler based suspend scheme proposed by 
Thomas Gleixner, Peter Zijlstra and myself. I found no good summary of it in 
the big thread, and there are also new elements of the proposal:

 - Create a 'deep idle' mode that suspends. This, if all constraints
   are met, is triggered by the scheduler automatically: just like the other
   idle modes are triggered currently. This approach fixes the wakeup
   races because an incoming wakeup event will set need_resched() and
   abort the suspend.

   ( This mode can even use the existing suspend code to bring stuff down,
     therefore it also solves the pending timer problem and works even on
     PC style x86. )

 - Introduce a 'minimum wakeup latency' task attribute (task->latency), 
   settable via a scheduler syscall. This is an ABI that influences the kernel 
   how idle the system can go. (i.e. the equivalent of suspend blockers, just
   not binary and not system-wide.)

 - Solve crappy app confinement via the scheduler:

   A first proposal was to use the existing cgroup mechanism, but we found
   a different and probably more elegant solution:

   We can slightly extend the scheduler and introduce another per task 'minimum
   latency other tasks are allowed to run' scheduling attribute 
   (task->exclude_latency) - set via a scheduler syscall as well. (only 
   settable by privileged tasks - such as the screensaver.)

   This allows a task to 'exclude' other tasks that dont have low-latency 
   requirements. Crappy apps would have a large latency value, so they'd
   be idled out when a privileged task sets the exclusion level low enough.

   In the case of Android, this would for example be used by the screensaver 
   to introduce different levels of runnability/idling.

   [ Note that this scheme would also be useful in a completely different
     scenario, for real-time tasks as well: it would allow extreme-RT tasks to 
     quiescence all lower prio tasks in a controlled manner. (even if the RT 
     task is sleeping) ]

 - Controlled auto-suspend: drivers (such as input) could on wakeup
   automatically set the 'minimum wakeup latency' value of wakee tasks to a 
   lower value. This automatically prevents another auto-suspend in the near 
   future: up to the point the wakee task increases its latency (via the 
   scheduler syscall) again and allows suspend again.

   This means there will be no surprise suspends for a task that may take a 
   bit longer than usual to finish its work. [ Detail: this would only be done 
   for tasks that have a non-default (non-infinity) task->latency value - to 
   prevent the input driver from lowering latency values (and preventing 
   future suspends) just because some unaware apps are running and using input 
   drivers. ]

All in one, this scheme allows everything without exception that 
suspend-blockers allows and supports all the important usecases:

 - allows agressive auto-idling

 - has no wakeup races

 - allows crappy-app confinement and other finegrained suspend control

 - it should be pretty easy to adopt by Android as well, as it goes
   along similar principles of kernel automatisms combined with
   user-space controlled task and system attributes.

It's straightforward to adapt and it is also more generic, more clean and more 
flexible than suspend-blockers.

Please mention any remaining technical issues that may still be are 
unaddressed.

Thanks,

	Ingo
