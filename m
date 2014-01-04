From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: how to know how long it takes on suspend/resume for platform
 usb driver
Date: Sat, 4 Jan 2014 11:44:12 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1401041127520.31700-100000@netrider.rowland.org>
References: <CANudz+uTBobmR5tCbtZLAzTnZ_9qXmWyKHvEm5hsAfgwG9Tcqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:42496 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754421AbaADQoN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 4 Jan 2014 11:44:13 -0500
In-Reply-To: <CANudz+uTBobmR5tCbtZLAzTnZ_9qXmWyKHvEm5hsAfgwG9Tcqw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: loody <miloody@gmail.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>

On Sat, 4 Jan 2014, loody wrote:

> hi Alan:
> 
> 
> 2014/1/1 Alan Stern <stern@rowland.harvard.edu>:
> > On Tue, 31 Dec 2013, loody wrote:
> >
> >> hi all:
> >> I am implementing platform layer suspend/resume usb driver.
> >> Is there kernel configuration or module parameter I can used to
> >> calculate suspend/resume time spend?
> >
> > Turn on CONFIG_PM_SLEEP_DEBUG, and before starting your test, do
> >
> >         echo 1 >/sys/power/pm_print_times
> >
> > Alan Stern
> >
> I can see log like below:
> 
> [  252.311771] call usb2+ returned 0 after 202 usecs
> [  252.311778] call usb1+ returned 0 after 239 usecs
> [  252.311961] call usb3+ returned 0 after 438 usecs
> .........................
> [  252.884923] ehci-pci 0000:00:1d.0: System wakeup enabled by ACPI
> [  252.900401] call 0000:00:1d.0+ returned 0 after 15495 usecs
> [  252.900403] calling  0000:00:1c.3+ @ 2587, parent: pci0000:00
> [  252.900475] call 0000:00:1c.3+ returned 0 after 68 usecs
> [  252.900477] calling  0000:00:1c.2+ @ 2587, parent: pci0000:00
> [  252.900547] call 0000:00:1c.2+ returned 0 after 67 usecs
> [  252.900548] calling  0000:00:1c.1+ @ 2587, parent: pci0000:00
> [  252.900618] call 0000:00:1c.1+ returned 0 after 67 usecs
> [  252.900620] calling  0000:00:1c.0+ @ 2587, parent: pci0000:00
> [  252.900691] call 0000:00:1c.0+ returned 0 after 68 usecs
> [  252.900692] calling  0000:00:1b.0+ @ 2587, parent: pci0000:00
> [  252.900694] call 0000:00:1b.0+ returned 0 after 0 usecs
> [  252.900695] calling  0000:00:1a.0+ @ 2587, parent: pci0000:00
> [  252.901149] ehci-pci 0000:00:1a.0: System wakeup enabled by ACPI
> [  252.916417] call 0000:00:1a.0+ returned 0 after 15334 usecs
> [  252.916419] calling  0000:00:16.0+ @ 2587, parent: pci0000:00
> [  252.916469] call 0000:00:16.0+ returned 0 after 47 usecs
> [  252.916470] calling  0000:00:14.0+ @ 2587, parent: pci0000:00
> 
> I have some questions:
> 1. "call 0000:00:1d.0+ returned 0 after 15495 usecs" mean all ports
> under this ehci host total cost 15495 us for resuming?

In the log messages above, 15495 us was the time required for
suspending, not resuming.  It means that putting the host controller
into D3 took 15495 us.  The times required to suspend the root hub and
each port are mentioned elsewhere in the log.

> 2. is it possible to change the order of calling resume callback?
>     for example, suppose the original sequence is "ehci -> xhci -> tty
> ..." and I want to change as "tty-> ehci -> xhci".

It is possible only to a very limited extent.  You can turn async
suspend/resume on or off, and this will affect the order.  Of course,
when async suspend/resume is off, the total time required will be
longer than when it is on.

Why do you want to change the order?  It shouldn't make any difference.

> 3. what is above "usb2+" mean? after trace source code, It seems "type" resume.
>     I can tell "bus" resume, since it is bus driver layer resume call back API.
>     What is "type" resume?

There can be several different "types" of devices all attached to the
same bus.  For example, on a USB bus we have devices representing USB
peripherals, USB interfaces, and USB ports -- three different types.  
A "type" resume is the type-specific resume callback API.  See how
usb_device_type is defined and used in drivers/usb/core/usb.c.

Alan Stern

