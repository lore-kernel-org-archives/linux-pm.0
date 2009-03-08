From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH][1/8] PM: Rework handling of interrupts
 during suspend-resume (rev. 5)
Date: Sat, 7 Mar 2009 22:53:31 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0903072248030.8870-100000__12650.2527310096$1236484603$gmane$org@netrider.rowland.org>
References: <200903071856.36230.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200903071856.36230.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Eric W. Biederman" <ebiederm@xmission.com>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Sat, 7 Mar 2009, Rafael J. Wysocki wrote:

> > One thing about this isn't clear: the distinction between "wake-up" 
> > interrupts and other interrupts.
> > 
> > In an ideal world, the only pending interrupts during sysdev_suspend
> > would be wake-up interrupts, because drivers would have prevented their
> > devices from generating any other kind of IRQ and would have done all
> > the necessary synchronization as part of their suspend (_not_
> > suspend_late) methods.  Thus there would be no need to distinguish
> > between wake-up and non-wake-up interrupts.
> > 
> > So perhaps you're worried about drivers that aren't sufficiently
> > clever.  Or is something deeper going on?
> 
> Some drivers leave interrupts enabled during suspend on purpose and mark
> them as "wake-up interrupts" so that the platform can abort suspend if any
> of them is pending at the time the "enter suspend" hook is called (this doesn't
> happen on x86 AFAICS).
> 
> However, after the $subject patch the CPU will ACK those interrupts if they
> happen between suspend_device_irqs() and local_irq_disable(), so the platform
> won't see them as pending.  Instead, they will have IRQ_PENDING set in
> desc->status, so we check if this is the case.

You didn't answer my question.  Why bother to distinguish between 
"wake-up" interrupts and non-"wake-up" interrupts?

In other words, why not simply abort the suspend if IRQ_PENDING is set
for _any_ interrupt during sysdev_suspend()?

Alan Stern
