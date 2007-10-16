From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: Question about suspending a system
Date: Tue, 16 Oct 2007 15:49:39 +0200
Message-ID: <38b2ab8a0710160649r5085d5ccs3a7e298bbde7867a@mail.gmail.com>
References: <38b2ab8a0710150543k6d35ae12h6dceef96acb00a71@mail.gmail.com>
	<1192464239.3349.57.camel@johannes.berg>
	<20071015164159.3273923A692@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071015164159.3273923A692@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
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
To: David Brownell <david-b@pacbell.net>
Cc: johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 10/15/07, David Brownell <david-b@pacbell.net> wrote:
> > From: Johannes Berg <johannes@sipsolutions.net>
> > Date: Mon, 15 Oct 2007 18:03:59 +0200
> >
> > On Mon, 2007-10-15 at 14:43 +0200, Francis Moreau wrote:
> >
> > > So my question is that when we suspend the system, it seems that all
> > > IRQs are masked and I'm a bit suprise since the event that should wake
> > > up the system is an interrupt. This mask is done by
> > > arch_suspend_disable_irqs() and none of the arch is overriding this
> > > stub. If I'm right, how the system should be waked up ?
> >
> > No, well, in most cases the CPU is actually turned off by some other
> > chip (like the PMU on powermac systems) and turned on again by it when
> > the system should wake up.
>
> Not true on most embedded systems using ARM SOCs I've seen ... most
> of those have the SOC enter a low power state which doesn't power off
> the SOC, and moreover leaves the CPU (and most peripherals) in a low
> power data-retaining state.
>

And it's my case too.

> Coming back from suspend states (like "standby" or "suspend-to-RAM")
> then doesn't involve any kind of powerup/reset at all.  That's a goal,
> since it shrinks the suspend/resume cycle time substantially.
>

True, and once the cpu is in standy mode, it's definitely not the
thing which consumes power.

> In conjunction with that model, the last step of entering a system
> suspend state should involve disabling all IRQs that aren't flagged as
> wakeup sources by enable_irq_wake().

Ok, I missed that because I'm using a 2.6.17 kernel.

>  That's shortly before the magic
> which powers down memory and CPU, but after devices have all been told
> to suspend themselves.
>

Is it done in pm_ops->enter method ?

>
> Of course, the CPU itself is often only a small part of the system's
> power usage.  More power is saved by powering devices down, or even
> off.

I'm thinking of making powering the disk off because when suspended it
still uses more that 5W !

>  In that example of a disk drive, one way to handle that would
> be to introduce a power domain within which the drive's controller
> and the drive both live.  If that's properly located in the driver
> model tree, as a device node, then its suspend and resume methods
> could poer the drive off and on (respectively).
>


Do you have any examples that you could give ?

BTW I'm using a SATA hard drive.

Thanks
-- 
Francis
