From: David Brownell <david-b@pacbell.net>
Subject: Re: Question about suspending a system
Date: Mon, 15 Oct 2007 09:41:59 -0700
Message-ID: <20071015164159.3273923A692@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <38b2ab8a0710150543k6d35ae12h6dceef96acb00a71@mail.gmail.com>
	<1192464239.3349.57.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1192464239.3349.57.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: johannes@sipsolutions.net, francis.moro@gmail.com
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> From: Johannes Berg <johannes@sipsolutions.net>
> Date: Mon, 15 Oct 2007 18:03:59 +0200
>
> On Mon, 2007-10-15 at 14:43 +0200, Francis Moreau wrote:
>
> > So my question is that when we suspend the system, it seems that all
> > IRQs are masked and I'm a bit suprise since the event that should wake
> > up the system is an interrupt. This mask is done by
> > arch_suspend_disable_irqs() and none of the arch is overriding this
> > stub. If I'm right, how the system should be waked up ?
>
> No, well, in most cases the CPU is actually turned off by some other
> chip (like the PMU on powermac systems) and turned on again by it when
> the system should wake up.

Not true on most embedded systems using ARM SOCs I've seen ... most
of those have the SOC enter a low power state which doesn't power off
the SOC, and moreover leaves the CPU (and most peripherals) in a low
power data-retaining state.

Coming back from suspend states (like "standby" or "suspend-to-RAM")
then doesn't involve any kind of powerup/reset at all.  That's a goal,
since it shrinks the suspend/resume cycle time substantially.

In conjunction with that model, the last step of entering a system
suspend state should involve disabling all IRQs that aren't flagged as
wakeup sources by enable_irq_wake().  That's shortly before the magic
which powers down memory and CPU, but after devices have all been told
to suspend themselves.


Of course, the CPU itself is often only a small part of the system's
power usage.  More power is saved by powering devices down, or even
off.  In that example of a disk drive, one way to handle that would
be to introduce a power domain within which the drive's controller
and the drive both live.  If that's properly located in the driver
model tree, as a device node, then its suspend and resume methods
could poer the drive off and on (respectively).

- Dave
