From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: suspend_device_irqs(): don't disable
	wakeup IRQs
Date: Wed, 6 May 2009 23:18:22 +0200
Message-ID: <200905062318.23572.rjw__27549.9190124266$1241645244$gmane$org@sisk.pl>
References: <1241483224-7113-1-git-send-email-khilman@deeprootsystems.com>
	<87y6tb3x6r.fsf@deeprootsystems.com>
	<871vr22upr.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <871vr22upr.fsf@deeprootsystems.com>
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

On Wednesday 06 May 2009, Kevin Hilman wrote:
> Kevin Hilman <khilman@deeprootsystems.com> writes:
> 
> > "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> >
> >> On Wednesday 06 May 2009, Kevin Hilman wrote:
> 
> [...]
> 
> >>> 
> >>> [...]
> >>> 
> >>> >>>
> >>> >>> If this fixes some bug then please provide a description of that bug?
> >>> >>
> >>> >> The bug is that on TI OMAP, interrupts that are used for wakeup events
> >>> >> are disabled by this code causing the system to no longer wake up.
> >>> >
> >>> > What do you do if the interrupt triggers right after your driver has
> >>> > returned from its late suspend hook?  
> >>> 
> >>> If it's a wakeup IRQ, I assume you want it to prevent suspend.
> >>> 
> >>> But I don't see how that can happen in the current code. IIUC, by the
> >>> time your late suspend hook is run, your device IRQ is already
> >>> disabled, so it won't trigger an interrupt that will be caught by
> >>> check_wakeup_irqs() anyways.
> >>
> >> My understanding of __disable_irq() was that it didn't actually disable the
> >> IRQ at the hardware level, allowing the CPU to actually receive the interrupt
> >> and acknowledge it, but preventing the device driver for receiving it.  
> >
> >> Does it work differently on the affected systems?
> >
> > Yes.
> >
> > __disable_irq() calls the irq_chip's disable method which is platform
> > specific.  On OMAP, this masks the IRQ at the hardware level
> > preventing the CPU from seeing the interrupt.
> 
> Looking at x86, the i8259 disable hook also seems to mask the IRQ at
> the PIC level.
> 
> The various IO-APIC irq_chips do not have a disable hook so the
> __disable_irq() here is a NOP.

Except that it sets IRQ_DISABLED.

All right there.

We can either avoid disabling wake-up interrupts, in which case we should
drop check_wakeup_irqs() IMO, or rework things so that check_wakeup_irqs() will
catch them.  Doing both doesn't seem to make sense to me.

Which one would be the right approach, then?

Rafael
