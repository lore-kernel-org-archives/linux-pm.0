From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH][1/8] PM: Rework handling of interrupts
 during suspend-resume (rev. 5)
Date: Mon, 9 Mar 2009 11:13:26 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0903091106010.3778-100000__2959.18279230154$1236615788$gmane$org@iolanthe.rowland.org>
References: <alpine.LFD.2.00.0903090748350.19207@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0903090748350.19207@localhost.localdomain>
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

On Mon, 9 Mar 2009, Linus Torvalds wrote:

> On Sun, 8 Mar 2009, Alan Stern wrote:
> > 
> > There have been examples in the past of devices that, for one reason or
> > another, _did_ generate IRQs at inconvenient times.  The hardware or
> > the BIOS may have done improper initialization, for example.  On a
> > shared IRQ this led to interrupt storms.  IIRC, the solution was to add
> > a PCI quirk routine to disable IRQ generation at an early stage.  
> > Didn't e100 have this problem?
> 
> .. and this is exactly the reason why we've done all these changes.
> 
> There are tons of drivers that are unable to cope with interrupts that 
> happen after they've done their "pci_set_power_state(PCI_D3hot)".
> 
> With shared interrupts (and _another_ device still live), they do stupid 
> things like read the interrupt status register, getting all-ones (because 
> the device is dead), and then deciding that that means that that need to 
> handle the interrupt. And that goes on in a loop. Forever.
> 
> Or they do _that_ part right, but their suspend also free'd some data 
> structure, so now the interrupt handler will follow a NULL pointer and/or 
> scribble to freed memory. The source of bugs is infinite, and not fixable 
> (because, quite frankly, most device driver writers are very focused on 
> the hardware, and have a hard time thinking about it as part of the bigger 
> system - and even if they happen test suspend/resume, they probably won't 
> be testing it with shared interrupts, so it will work _for_them_ even if 
> it's totally broken).
> 
> So what all the PCI changes try to do is to basically not have the driver 
> do the "pci_set_power_state(PCI_D3)" at _all_, an do it in the PCI layer. 
> But more importantly, it needs to be done _after_ interrupts have been 
> disabled for this all to work. And, for exactly the same reason, the PCI 
> layer needs to wake the device up and restore its config space _before_ 
> enabling interrupts again, and _before_ doing any ->resume calls.
> 
> And that, in turn, means that since we have all these ACPI ordering 
> things, and many cases want to use ACPI to wake things up, and/or have 
> delays etc, we end up actually wanting things like timer interrupts 
> working at that time - but not normal "device" interrupts. Because many 
> delays do need them, even as simple delays as the (fairly short, but not 
> "busy loop" short) one for turning the device back into PCI_D0 again.
> 
> So this literally explains all the re-ordering, and all the interrupt 
> games we now play in Rafael's patch-set. The _whole_ (and only) point is 
> to make it easier for device drivers, while also changing the environment 
> so that we can call ACPI and we can sleep even before the devices have 
> really resumed (or even early_resume'd).

I see.  The unstated key point is this:

	Unsophisticated drivers can still be expected to work if they
	get an interrupt after their suspend method has run, _provided_
	the device is still in D0.  Likewise, unsophisticated drivers 
	can be expected to fail if they get an interrupt after the 
	device has been put in D3.

Hence you don't require drivers to disable interrupt generation in 
their suspend methods, and you do prevent interrupts from being 
delivered to drivers before changing device power states.

And hence you also go to some trouble to distinguish between IRQs
which might be received merely because the driver didn't bother to
suppress them vs. IRQs which indicate a genuine wakeup request.

Got it.

Alan Stern
