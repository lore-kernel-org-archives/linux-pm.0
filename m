From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] [PATCH 0/6] [-mm]: ACPI: duplicate ACPI procfs functions in sysfs
Date: Thu, 25 Jan 2007 01:54:19 -0800
Message-ID: <200701250154.20070.david-b@pacbell.net>
References: <1168083306.5619.34.camel@localhost.localdomain> <200701061421.41342.david-b@pacbell.net> <200701242228.17836.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200701242228.17836.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@lists.osdl.org, Zhang Rui <rui.zhang@intel.com>, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 24 January 2007 7:28 pm, Len Brown wrote:
> > 
> > The latest patches relevant to the RTC used by ACPI are:
> > 
> >  http://marc.theaimsgroup.com/?l=linux-kernel&m=116802017116195&w=2
> >  http://marc.theaimsgroup.com/?l=linux-kernel&m=116802044406838&w=2
> >  http://marc.theaimsgroup.com/?l=linux-kernel&m=116802044531547&w=2
> >  http://marc.theaimsgroup.com/?l=linux-kernel&m=116802044532646&w=2
> > 
> > (Only that last one touches ACPI directly.)
> 
> This looks promising, thanks.

And I see you've acked that last one now, thanks.  A patch to provide
system-specific callbacks during suspend/resume can now be on the way,
when I make time for it.  The ACPI version of that callback would mirror
the magic now done with /proc/acpi/wakeup, supporting both implementation
options for RTC wakeup.


> > > 	For those devices that support "wake" attribute,
> > 
> > Please tell me you mean "devices with a /sys/devices/.../power/wakeup"
> > attribute.  And that ACPI is finally going to start working with those
> > attributes ...
> > 
> > 
> > > 	two files, 
> > > 	"sleep_state" and "wakeup", are created for these devices. 
> > 
> > I'm going to be assuming your "wakeup" attribute has the same semantics
> > as that existing one.  If it doesn't, you should either fix your model,
> > or justify changing the Linux-wide model.
> 
> The Linux-wide model needs some work.
> 
> First, wakeup appears under devices that don't know or care about wakeup.

As an empty value.  It's sort of problematic to claim that a device
doesn't know or care ... consider a USB device, where the capability
is configuration-specific and is accordingly irrelevant when it's in a
configuration that doesn't support wakeup (or unconfigured).  Plus there
is the issue that it's in a sysfs "group", which doesn't have selectivity
about what attributes exist (or don't) ... or that driverless devices
are generally incapable of supporting wakeup.


> Second, it doesn't tell the user when it is useful -- which is what Rui
> tried to address with sleep_state below.

Nobody yet responded to my counter argument/questions on that claim...


> Third, it doesn't tell you if it is already enabled or not.

Erm, it most certainly does.  The values are null, "disabled", "enabled".

  
> > As for sleep_state:
> > 
> > > 	"sleep_state" indicates the lowest sleeping state that can be
> > > 	entered while still providing wake functionality. 
> > 
> > I understand that /proc/acpi/wakeup exposes this information.  I don't
> > understand how userspace is expected to use it.  Or, for that matter,
> > how this model ought to work on non-ACPI systems.  But most especially,
> > if it's useful, I don't understand why it would be ACPI-only.
> 
> Agreed that the user shouldn't know that it is ACPI only, but it may be that
> only ACPI systems have this concept.

No, it's pretty common that systems support sleep states that don't
provide things certain devices need to serve as wakeup devices.

One example would be a UART clock ... 115200x16 (=1843200) Hz unavailable
if the system's slow clock mode is 32 KHz.  Another would be the USB
clock, often 48 MHz.  (I think a lot of systems can actually detect
the resume signaling, but just can't get their oscillator and/or PLLs
working properly within the 10 msec allowed by USB.)

 
> We've seen this in practice.  For example some wakeup devices
> work only down to S4.  When STD used S5 instead of S4, these
> wakeup devices were unavailable.

Repeating the question:  how is userspace expected to use this?

It doesn't use the information in its /proc/acpi/wakeup form,
so why would that change in a sysfs form?  (Assuming ACPI wakeup
from S3 or S1 works correctly, which is vanishingly rare in my
own experience ...)

Plus, drivers no longer have a standard way to tell anything
about the target system state ... like whether it's an ACPI
S1, S3, S4, or S5; or whether it's even an ACPI state at all...

  
> > (Yes, there are huge gaps in Linux-PM wakeup support.  Weak ACPI suppport
> > for it, especially from STR -- without swsusp -- is a big factor.  I
> > was pleased to see RTC wakeup from ACPI S4 actually work ... first time
> > I've ever seen ACPI wakeup ever work correctly.)
> 
> Try your power button, sleep button, or lid switch.

I was thinking about stuff listed in /proc/acpi/wakeup, since
that's the specific issue being discussed here ... and yes, it's
after having enabled those devices using that file that I report
ACPI wakeup not working correctly.

 
> > > 	"wakeup" can be used to enable/disable the device's
> > > 	ability to wake a sleeping system. 
> > 
> > We've found a need to nuance that a bit.  So for example a USB root
> > hub sure ought to support the USB "remote wakeup" mechanism in that
> > way, and by and large the BIOS will declare that it does.  (Not that
> > I've ever observed that to work from ACPI STR, mind you!!)
> > 
> > However, it appears out that on some boards remote wakeup doesn't
> > work right ... either there's a chipset bug, or some board wiring
> > problem, or something of that ilk.  This impacts _runtime_ power
> > management as well as system-wide sleep states.  So "wakeup" also
> > gets used to disable runtime PM techniques like suspending USB
> > devices to reduce system power drain (since that relies on remote
> > wakeup).  The hardware mechanism isn't used only to wake sleeping
> > systems; so the sysfs attribute isn't limited to that role either.
> 
> I think it is a mistake to overload what wakeup does.

I don't follow.  Are you saying that wakeup from device runtime sleep
states is something different than wakeup from system sleep states,
even when it uses the **SAME** hardware mechanisms to achieve its goal?

Hardware docs I've seen (including things like RTL specs) don't make
those kinds of distinction about the context of the wakeup event.  So
I don't see why Linux should.


> It should enable system wakeup capability, and nothing else.

Considering that the driver and hardware action is often the same both for
device runtime sleep states, and for system sleep states, I don't see why...

- Dave

