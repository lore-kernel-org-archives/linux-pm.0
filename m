From: Marcelo Tosatti <marcelo@kvack.org>
Subject: Re: Power Mangement Interfaces
Date: Tue, 19 Jun 2007 13:00:48 -0400
Message-ID: <20070619170048.GA342__16284.2207392261$1182272749$gmane$org@dmt.media.mit.edu>
References: <20070330235759.GC4252@cosmic.amd.com>
	<200703312001.55231.david-b@pacbell.net>
	<20070401165601.GA13389@cosmic.amd.com>
	<200704011728.10966.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200704011728.10966.david-b@pacbell.net>
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
Cc: linux-pm@lists.linux-foundation.org, devel@laptop.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi David,

On Sun, Apr 01, 2007 at 05:28:10PM -0700, David Brownell wrote:
> 
> > It seems 
> > to me to be more logical to move the wakeup intelligence to the PM subsystem,
> > and then let that code distribute it to where it is needed.  In the case
> > of x86, the logic would stay in the PM method, for other processors, it 
> > might involve a call to the interrupt mapper.
> 
> But why should a "PM subsystem" be created to abstract something that
> already works just fine?
> 
> It'd make much more sense to me to come up with a good way to handle
> the x86 issues first, and only then think about whether to try
> making that work on other systems.
> 
>  
> > > And for PCI based things, pci_enable_wake() encapsulates everything
> > > that needs doing.  Not that ACPI actually *does* anything yet!  But
> > > the stuff that writing /proc/acpi/wakeup enables should happen in that
> > > routine ... and eventually PCI runtime wake events should work too.
> > > (So:  no drivers would ever call ACPI directly, and they already have
> > > the generic call that ACPI should hook.)
> > > 
> > > That seems to cover most drivers in Linux, without a need for any
> > > new generic PM infrastructure.  Did I overlook something important?
> > 
> > No, I don't think so - we're very close on agreeing here.  I just don't know
> > if enable_irq_wake() is the best way to provide the generic call. 
> 
> It's not, and I didn't propose doing that either.
> 
> Having all drivers try to use the same calls to manage wakeup
> mechanisms doesn't seem like the right model.  When the mechanism
> is the same -- wakeup irqs, say -- then yes the calls should be
> the same.  But when the mechanisms differ -- PCI PME# is very
> different from wakeup IRQS, only one per device etc -- then the
> calls can reasonably be different.
> 
> 
> > Moving 
> > it into the PM infrastructure seems the best way to handle everybody
> > equally, regardless of the relative intelligence or stupidity of their 
> > hardware implementation.
> 
> I guess that's where we disagree:  you're assuming "one call to rule
> them all", where I'm thinking that IRQ calls should manage IRQs,
> PCI calls should manage PME#, and so on.
> 
> 
> > > > The only other issue then, is how we could define and manage wakeup events
> > > > for events that aren't associated with specific devices, like power button
> > > > and lid events.  We'll need some way to control those somewhere in sysfs -
> > > > if not in /sys/power/wakeup like I had proposed, then somewhere under the
> > > > platform or system hierarchy .
> > > 
> > > I see /sys/devices/acpi_system:00/button_power:00 on this system; and
> > > /sys/devices/acpi_system:00/device:00/PNP0C0D:00 has path \_SB_.LID_ ...
> > > such device nodes already exist, even though they're not really hooked
> > > up to anything much.  Notably, their "wakeup" state is not initialized.
> > > 
> > > And while it seems that the three USB controllers on this system show up
> > > as /sys/devices/acpi_system:00/device:00/PNP0A03:00/device:{01,02,03} I
> > > have no idea which one is /sys/devices/pci0000:00/0000:00:02.2 versus
> > > 0000:00:02.1 or 0000:00:02.0 ... I know that USB0 is device:01 and so
> > > on (by reading "path"), but associating one with a PCI device seems to
> > > involve pure guesswork.
> > 
> > I guess we'll probably have to do something similar for our OLPC PM code
> > - but thats the sort of platform specific fragmentation thing I was trying
> > to avoid.
> 
> Since OLPC isn't using ACPI,  it can be more like embedded Linux,
> and just Do The Right Thing ... create platform devices, etc.  :)

As you know we want user configuration of enabled wakeup events (unlike
embedded platforms where this is hardcoded). It seems that the current
interface available for that is /sys/devices/../power/wakeup hook (when
!ACPI).

However there are several wakeup capable devices in OLPC which do not
have drivers, thus no platform devices:

- power button 
- lid

It seems that creating platform devices for these two just for the
purpose of a having an interface for enabling wakeup events is overkill.

Given that, we probably want something similar to what was initially    
described in http://wiki.laptop.org/go/Power_Management_Interface ?     

The downside of doing that is a non-unified interface: platform
devices via /sys/devices/../power/wakeup and otherwise
/sys/whatever/wakeup/source?

> My point above was that ACPI isn't yet integrating with the things
> it needs to be integrating with.  If you're concerned about how to
> work with wakeup events in Linux, don't even bother looking at ACPI.
> Look at the embedded implementations; look at USB.  AT91 is by far
> the cleanest and most complete (simplest hardware too!!), but some
> of the other systems (OMAP, PXA, SA1100, etc) also implement wakeup
> using board-specific code.
> 
> OLPC _could_ use that same "board-specific hacks" approach found in
> most embedded platforms.  I'm glad you're thinking about how to
> avoid doing that.
> 
> - Dave
> _______________________________________________
> Devel mailing list
> Devel@laptop.org
> http://mailman.laptop.org/mailman/listinfo/devel
