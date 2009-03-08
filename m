From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH][1/8] PM: Rework handling of interrupts
 during suspend-resume (rev. 5)
Date: Sun, 8 Mar 2009 16:40:16 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0903081629010.9313-100000__8062.95774314112$1236544974$gmane$org@netrider.rowland.org>
References: <alpine.LFD.2.00.0903081014430.19207@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0903081014430.19207@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Eric W. Biederman" <ebiederm@xmission.com>, pm list <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Sun, 8 Mar 2009, Linus Torvalds wrote:

> On Sat, 7 Mar 2009, Alan Stern wrote:
> > 
> > You didn't answer my question.  Why bother to distinguish between 
> > "wake-up" interrupts and non-"wake-up" interrupts?
> > 
> > In other words, why not simply abort the suspend if IRQ_PENDING is set
> > for _any_ interrupt during sysdev_suspend()?
> 
> .. because some drivers might not actually shut down the hardware until 
> they get to "suspend_late"? If even then, for that matter - a driver may 
> simply not care, knowing that the hardware will be powered off, and will 
> be re-initialized at resume.
> 
> The thinking that you have to shut your hardware down at "->suspend()" 
> time is a _disease_. There are literally classes of hardware out there 
> where that would be an outright _bug_, like for a PCI bridge device. For 
> many devices, "suspend()" has to be the phase where you shut down the 
> _external_ stuff (eg for a disk controller, it's when you'd flush and stop 
> your disks), but the controller itself may well be alive until later.

Yes, certainly.  I agree completely.

But there is a difference between shutting down the hardware and merely
preventing it from generating interrupt requests.  If a device remains
capable of generating IRQs after its driver's suspend method has run,
the driver runs the risk of having its handler called at a time when it
isn't prepared to cope correctly.  Of course, this will depend on the
details of how the driver is written.

There have been examples in the past of devices that, for one reason or
another, _did_ generate IRQs at inconvenient times.  The hardware or
the BIOS may have done improper initialization, for example.  On a
shared IRQ this led to interrupt storms.  IIRC, the solution was to add
a PCI quirk routine to disable IRQ generation at an early stage.  
Didn't e100 have this problem?

Alan Stern
