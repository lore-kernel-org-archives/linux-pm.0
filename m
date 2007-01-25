From: Len Brown <lenb@kernel.org>
Subject: Re: [linux-pm] [PATCH 0/6] [-mm]: ACPI: duplicate ACPI procfs functions in sysfs
Date: Wed, 24 Jan 2007 22:28:17 -0500
Message-ID: <200701242228.17836.lenb@kernel.org>
References: <1168083306.5619.34.camel@localhost.localdomain> <200701061421.41342.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200701061421.41342.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org, Zhang Rui <rui.zhang@intel.com>, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

Thanks for your detailed reply, David..

> Third, stuff in /sys/power should be generic, and not depend on ACPI
> infrastructure or models ... it should for example work for embedded
> platforms where Linux runs on the bare metal.  Moreover, in general
> an ACPI-specific interface should be the very last (and non-portable,
> worst) choice, not the first/default/preferred one.

Agreed.

> Which means in particular that:
> 
> > Patch 03-05:
> > 	add ACPI sleep attributes in sysfs.
> > 	/proc/acpi/sleep is already deprecated by /sys/power/state.
> > 	/proc/acpi/alarm is deprecated by /sys/power/alarm.
> 
> A /sys/power/alarm thing conflicts with ongoing RTC framework work.
> 
> You may have missed the patches I've sent making RTCs be "just another
> wakeup-capable device" -- an interface that already works with multiple
> RTCs, is not in the least bit coupled to ACPI, and is on track to work
> with on more platforms -- or the proposal to provide sysfs support for
> activiting alarms within the RTC framework.
> 
> The latest patches relevant to the RTC used by ACPI are:
> 
>  http://marc.theaimsgroup.com/?l=linux-kernel&m=116802017116195&w=2
>  http://marc.theaimsgroup.com/?l=linux-kernel&m=116802044406838&w=2
>  http://marc.theaimsgroup.com/?l=linux-kernel&m=116802044531547&w=2
>  http://marc.theaimsgroup.com/?l=linux-kernel&m=116802044532646&w=2
> 
> (Only that last one touches ACPI directly.)

This looks promising, thanks.
 
> Note that like it says in the first message, this version doesn't
> have the "remove /proc/acpi/alarm" stuff, mostly to simplify merging
> of the core driver code; that will be done later, and in any case the
> old drivers/char/rtc.c code didn't interact with it either.  It worked
> in earlier versions of the patch.  (Modulo the fact that ACPI wakeup
> from STR seems to usually be a total lose.)  One such version:
> 
>  http://marc.theaimsgroup.com/?l=linux-kernel&m=116406177605472&w=2
> 
> You'll observe those ACPI bits are kind of messy.  The clean
> approach I have in mind is to have callbacks in platform_data,
> with which ACPI -- or EFI etc -- can do whatever nastiness it
> needs to let the RTC alarm trigger wakeup from system sleep state.
> A "bare metal" platform would just enable_irq_wake(); ACPI would
> set a magic PM1 bit or whatever; etc.
> 
> (In terms of userspace tools, I posted an "rtcwake.c" tool working
> on several platforms, including x86 PCs with the above patch plus
> some ARM systems, notably AT91rm9200, with rtc wakeup irqs.)
> 
> 
> > 	For those devices that support "wake" attribute,
> 
> Please tell me you mean "devices with a /sys/devices/.../power/wakeup"
> attribute.  And that ACPI is finally going to start working with those
> attributes ...
> 
> 
> > 	two files, 
> > 	"sleep_state" and "wakeup", are created for these devices. 
> 
> I'm going to be assuming your "wakeup" attribute has the same semantics
> as that existing one.  If it doesn't, you should either fix your model,
> or justify changing the Linux-wide model.

The Linux-wide model needs some work.

First, wakeup appears under devices that don't know or care about wakeup.
Second, it doesn't tell the user when it is useful -- which is what Rui
tried to address with sleep_state below.
Third, it doesn't tell you if it is already enabled or not.
 
> As for sleep_state:
> 
> > 	"sleep_state" indicates the lowest sleeping state that can be
> > 	entered while still providing wake functionality. 
> 
> I understand that /proc/acpi/wakeup exposes this information.  I don't
> understand how userspace is expected to use it.  Or, for that matter,
> how this model ought to work on non-ACPI systems.  But most especially,
> if it's useful, I don't understand why it would be ACPI-only.

Agreed that the user shouldn't know that it is ACPI only, but it may be that
only ACPI systems have this concept.

We've seen this in practice.  For example some wakeup devices
work only down to S4.  When STD used S5 instead of S4, these
wakeup devices were unavailable.
 
> (Yes, there are huge gaps in Linux-PM wakeup support.  Weak ACPI suppport
> for it, especially from STR -- without swsusp -- is a big factor.  I
> was pleased to see RTC wakeup from ACPI S4 actually work ... first time
> I've ever seen ACPI wakeup ever work correctly.)

Try your power button, sleep button, or lid switch.

> > 	"wakeup" can be used to enable/disable the device's
> > 	ability to wake a sleeping system. 
> 
> We've found a need to nuance that a bit.  So for example a USB root
> hub sure ought to support the USB "remote wakeup" mechanism in that
> way, and by and large the BIOS will declare that it does.  (Not that
> I've ever observed that to work from ACPI STR, mind you!!)
> 
> However, it appears out that on some boards remote wakeup doesn't
> work right ... either there's a chipset bug, or some board wiring
> problem, or something of that ilk.  This impacts _runtime_ power
> management as well as system-wide sleep states.  So "wakeup" also
> gets used to disable runtime PM techniques like suspending USB
> devices to reduce system power drain (since that relies on remote
> wakeup).  The hardware mechanism isn't used only to wake sleeping
> systems; so the sysfs attribute isn't limited to that role either.

I think it is a mistake to overload what wakeup does.
It should enable system wakeup capability, and nothing else.

cheers,
-Len
