From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: suspend_device_irqs(): don't disable
	wakeup IRQs
Date: Thu, 7 May 2009 13:54:07 +0200
Message-ID: <200905071354.08319.rjw__23093.5564301491$1241697437$gmane$org@sisk.pl>
References: <1241483224-7113-1-git-send-email-khilman@deeprootsystems.com>
	<200905062318.23572.rjw@sisk.pl>
	<87zldpu5rt.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87zldpu5rt.fsf@deeprootsystems.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 07 May 2009, Kevin Hilman wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > On Wednesday 06 May 2009, Kevin Hilman wrote:
> >> Kevin Hilman <khilman@deeprootsystems.com> writes:
> >> 
> >> > "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> >> >
> >> >> On Wednesday 06 May 2009, Kevin Hilman wrote:
> >> 
> >> [...]
> >> 
> >> >>> 
> >> >>> [...]
> >> >>> 
> >> >>> >>>
> >> >>> >>> If this fixes some bug then please provide a description of that bug?
> >> >>> >>
> >> >>> >> The bug is that on TI OMAP, interrupts that are used for wakeup events
> >> >>> >> are disabled by this code causing the system to no longer wake up.
> >> >>> >
> >> >>> > What do you do if the interrupt triggers right after your driver has
> >> >>> > returned from its late suspend hook?  
> >> >>> 
> >> >>> If it's a wakeup IRQ, I assume you want it to prevent suspend.
> >> >>> 
> >> >>> But I don't see how that can happen in the current code. IIUC, by the
> >> >>> time your late suspend hook is run, your device IRQ is already
> >> >>> disabled, so it won't trigger an interrupt that will be caught by
> >> >>> check_wakeup_irqs() anyways.
> >> >>
> >> >> My understanding of __disable_irq() was that it didn't actually disable the
> >> >> IRQ at the hardware level, allowing the CPU to actually receive the interrupt
> >> >> and acknowledge it, but preventing the device driver for receiving it.  
> >> >
> >> >> Does it work differently on the affected systems?
> >> >
> >> > Yes.
> >> >
> >> > __disable_irq() calls the irq_chip's disable method which is platform
> >> > specific.  On OMAP, this masks the IRQ at the hardware level
> >> > preventing the CPU from seeing the interrupt.
> >> 
> >> Looking at x86, the i8259 disable hook also seems to mask the IRQ at
> >> the PIC level.
> >> 
> >> The various IO-APIC irq_chips do not have a disable hook so the
> >> __disable_irq() here is a NOP.
> >
> > Except that it sets IRQ_DISABLED.
> >
> > All right there.
> 
> OK, right. I missed the setting of IRQ_DISABLED there.
> 
> > We can either avoid disabling wake-up interrupts, in which case we
> > should drop check_wakeup_irqs() IMO, or rework things so that
> > check_wakeup_irqs() will catch them.  Doing both doesn't seem to
> > make sense to me.
> >
> > Which one would be the right approach, then?
> 
> Not sure if there is right one as they are solving two different
> problems.
> 
> check_wakeup_irqs() seems meant to address handling interrupts that
> happen during the suspend path.  My fix for not disabling wakups is
> meant to allow those interrupts after suspend.

Still, with your fix in place, check_wakeup_irqs() is useless, because
the wake-up interrupts are not going to have IRQ_PENDING set.

> An alternative to my original approach is the one taken on x86
> IO-APICs where the irq_chip's disable hook is empty, thus not masking
> in HW but still preventing the ISR from running.

That sounds quite right.

> I need to explore whether just dropping the irq_chip's disable hook
> would work for us on OMAP.
> 
> There is at least one problem with that which is why Kyuwon Kim added
> the ->disable hook to OMAP's irq_chip.  The problem is with drivers
> that call disable_irq() in their suspend hook, usually done to prevent
> the device from waking the system since on OMAP, any IRQ can be
> configured to wake the system.
> 
> If a driver's suspend hook calls disable_irq() and the system is
> suspended before the lazy disable happens in the next handler, then
> the system will be suspended with that device's IRQ still enabled.
> Without an irq_chip->disable hook, that will result in that device IRQ
> waking up the system if it fires.
> 
> I now have a patch for this which ensures that the lazy-disable
> happens in the suspend path using the ->mask hook just like
> it does in the handler.  Will send to LKML and here shortly.

Great, thanks!

Best,
Rafael
