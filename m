From: Marcelo Tosatti <marcelo@kvack.org>
Subject: rtc-cmos not supporting RTC_AIE?
Date: Sat, 7 Jul 2007 23:46:33 -0400
Message-ID: <20070708034633.GA19633__10190.8382298008$1183866399$gmane$org@dmt>
References: <20070330235759.GC4252@cosmic.amd.com>
	<200703312001.55231.david-b@pacbell.net>
	<20070401165601.GA13389@cosmic.amd.com>
	<200704011728.10966.david-b@pacbell.net>
	<20070402165511.GD5024@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070402165511.GD5024@cosmic.amd.com>
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

On Mon, Apr 02, 2007 at 10:55:11AM -0600, Jordan Crouse wrote:
> On 01/04/07 17:28 -0700, David Brownell wrote:
> > 
> > > So, for better or worse, we are implementing a new power management
> > > manger.  Here is the code: 
> > > 
> > > http://dev.laptop.org/git.do?p=olpc-2.6;a=blob;h=e6e19ac32a881be962db7190f2cb460e9f60a9da;hb=powermgmt;f=arch/i386/kernel/olpc-pm.c
> > 
> > Does that work yet with CONFIG_NO_HZ, so that the system idle loop
> > enters some "almost everyting is turned off" low power state?  Or
> > would that be something other than a "PM Manager"?
> 
> I think eventually we'll get into entering deeper states in the idle
> loop.  For now, we're just going into the classic C1 / hlt state, which
> is actually quite thrifty on the Geode, due to automatic hardware clock
> gating that happens throughout the chip(s).
>  
> > > > > On the Geode, we have 17 possible wake sources, all of which are ORed
> > > > 
> > > > What are those?  You mentioned four before.  (RTC alarm, two GPIOs,
> > > > and the power button.)  I'd guess various PCI devices can also issue
> > > > wakeups.  (And if USB is one of them, up to 126 USB devices hooked
> > > > up to each USB host controller!)
> > > 
> > > The silicon can handle wakeups from RTC, a sleep button, a power button, 
> > > 8 GPIO groups, the USB controller (covering any and all USB events),
> > > UART1, UART2, SMbus and the PIC.
> > > 
> > > OLPC really only cares about 4 of those, because our only sleep state
> > > is ~S3, and the PIC, smbus, UARTs and USB are off in S3.  We also only
> > > have the power button, and all the rest of the wakeup sources come from
> > > the GPIOs.
> > 
> > So it's a slightly deeper "S3" than I've usually seen, but not by much.
> > 
> > And correct me if I'm wrong, but your RTC can work with "rtc-cmos", and
> > the wake hooks I've posted (and which will be in the next MM release)
> > sound like they'll work just fine (given OLPC-specific implementation,
> > which is clearly not included in the code above).
> 
> Indeed, and thank you much for that work - we'll be sure to integrate
> it.
> 
> > > > > This looks very good, and is pretty close to what I was proposing.  
> > > > > Replace the acpi_*_event() calls with a generic pm_ infrastructure, and
> > > > 
> > > > Inside ACPI ... why?
> > > 
> > > I'm not saying inside ACPI - I'm saying at the driver level.
> > 
> > Whereas in that patch, the only ACPI calls were inside ACPI itself;
> > and that driver only had a callback.  FWIW that's the first time
> > I've ever needed to have indirection on wakeup event handling ...
> 
> This is the first real "embedded" scenario to pop its head up in x86 land,
> up to this point, most of the boards have just been really weak desktops.
> 
> > > And so forth.  Like the AT91, we enable the wakeup events prior to
> > > suspending. I'm willing to bet that other PM methods like ACPI
> > > could pick this up pretty quickly too. 
> > 
> > With AT91 (and most ARMs) the wake events are normal IRQs, and the
> > irq infrastructure already handles wake events cleanly.  So I'd
> > claim they don't _want_ to change something that's inexpensive,
> > already deployed (training, code, testing, etc), and working.
> > 
> > So I hope you'll tolerate me if I view this as less of a "how do
> > we get a generic solution" and more of a "how does _this_ x86-ish
> > issue get solved cleanly".
> 
> Thats fair.  x86 does live in a different world then the other embedded
> chips.  I think its reasonable for the x86 folks to get their story straight
> and then move on from there.
> 
> > > Moving 
> > > it into the PM infrastructure seems the best way to handle everybody
> > > equally, regardless of the relative intelligence or stupidity of their 
> > > hardware implementation.
> > 
> > I guess that's where we disagree:  you're assuming "one call to rule
> > them all", where I'm thinking that IRQ calls should manage IRQs,
> > PCI calls should manage PME#, and so on.
>  
> Thats fine - I am not sold on a "one call to rule them all", but I do
> want to avoid any #ifdef CONFIG_PM_ACPI #elsif CONFIG_OLPC_PM #else
> nonsense.  
>  
> > > I guess we'll probably have to do something similar for our OLPC PM code
> > > - but thats the sort of platform specific fragmentation thing I was trying
> > > to avoid.
> > 
> > Since OLPC isn't using ACPI,  it can be more like embedded Linux,
> > and just Do The Right Thing ... create platform devices, etc.  :)
> > 
> > My point above was that ACPI isn't yet integrating with the things
> > it needs to be integrating with.  If you're concerned about how to
> > work with wakeup events in Linux, don't even bother looking at ACPI.
> > Look at the embedded implementations; look at USB.  AT91 is by far
> > the cleanest and most complete (simplest hardware too!!), but some
> > of the other systems (OMAP, PXA, SA1100, etc) also implement wakeup
> > using board-specific code.
> > 
> > OLPC _could_ use that same "board-specific hacks" approach found in
> > most embedded platforms.  I'm glad you're thinking about how to
> > avoid doing that.
> 
> We are keenly aware that we're committing a minor sin by implementing
> yet another PM interface for x86.  But we believe that our heart is in the
> right place, and we are dedicated to doing the right thing, and trying
> our hardest not to contribute further to fragmenting the PM subsystem with
> implementation specific code. In many cases we're looking to help
> bring the others into the fold, especially our fellow x86 implementations
> that suffer from the same issues that we do.
> 
> I appreciate your comments, and the rtc-cmos code will go to good use.

David,

Is there any reason why programs using RTC_AIE/RTC_ALM_SET ioctls are    
unable to arm alarm irq's?                                              

I'm aware of the new RTC_WKALM_SET... but shouldnt backward
compatibility be kept?

The code seems to imply that its not supported anymore, however ioctl
returns success but no alarm is fired (for instance alarm.enabled is set
to 0):

        case RTC_ALM_SET:
                if (copy_from_user(&alarm.time, uarg, sizeof(tm)))
                        return -EFAULT;

                alarm.enabled = 0;
                alarm.pending = 0;
                alarm.time.tm_wday = -1;
                alarm.time.tm_yday = -1;
                alarm.time.tm_isdst = -1;

Thanks
