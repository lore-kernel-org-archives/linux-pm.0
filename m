From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
	during suspend-resume
Date: Tue, 24 Feb 2009 23:42:06 +0100
Message-ID: <200902242342.07721.rjw__33869.7600913749$1235515637$gmane$org@sisk.pl>
References: <200902221837.49396.rjw@sisk.pl> <200902232239.05926.rjw@sisk.pl>
	<m1iqn01ph3.fsf@fess.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <m1iqn01ph3.fsf@fess.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 24 February 2009, Eric W. Biederman wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > On Monday 23 February 2009, Eric W. Biederman wrote:
> >> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> >> 
> >> >> I don't know where in the state machine this is getting called but
> >> >> I would suggest doing this before we shutdown cpus.
> >> >
> >> > This is the plan.  In fact, I'm going to do this in the next patch after the
> >> > $subject one has been tested and found acceptable.
> >> 
> >> Good to hear.  Then let's please get a version of the irq disable that calls
> >> shutdown, so we can be certain we don't have hardware irqs in flight.
> >> 
> >> For the drivers it should not matter for clean cpu shutdown it will.
> >
> > OK, I will.
> 
> My apologies I was wrong.  Calling shutdown is not safe.
> 
> I just remembered that masking an ioapic from anywhere besides the
> irq handler can lock the ioapic state machine, and lead to non-recoverable
> interrupts.  It is rare but I have seen it happen.  I wanted to figure out
> how to migrate interrupts outside of interrupt context and this was what
> prevented me.  A suspend/resume cycle might be enough of a reset to
> get the ioapic out of that state but I don't know.
> 
> The only safe way on x86 to shutdown a level triggered ioapic irq
> outside of irq context is for the driver to program the hardware to
> not generate an irq.

Well, that changes things quite a bit, because it means we can't change the
suspend-resume sequence in a way we thought we could without fixing all
drivers first, but this is exactly what we'd like to avoid by changing the
core.

I think the most important source of level triggered interrupts are PCI
devices, so perhaps we can make the PCI PM core use bit 10 of the PCI Device
Control register to prevent devices from generating INTx after the drivers'
suspend routines have been executed?

> Therefore doing anything with the irqs at the point where we are
> suspending them is a formality, and perhaps simply code that ensures
> in-flight irqs don't make it past a certain point.
> 
> I believe we just need to call disable() and print a big nasty warning
> if any irq comes in after the suspend stage.

At the moment we're safe, since PCI devices are put into low power states
in the suspend stage.  However, we'd like to make that happen in the "late
suspend" stage to avoid a problem with a shared interrupt occuring after one
of the devices using it has been suspended and its driver's irq handler can't
cope with that.

Thanks,
Rafael
