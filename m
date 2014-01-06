From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: how to know how long it takes on suspend/resume for platform
 usb driver
Date: Mon, 6 Jan 2014 10:10:58 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1401061006470.1282-100000@iolanthe.rowland.org>
References: <CANudz+vLJCwDVfhc-8VSF6kumjW7fBOkWQLFF+UihQhE34eUVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:57949 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755197AbaAFPK7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jan 2014 10:10:59 -0500
In-Reply-To: <CANudz+vLJCwDVfhc-8VSF6kumjW7fBOkWQLFF+UihQhE34eUVg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: loody <miloody@gmail.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>

On Mon, 6 Jan 2014, loody wrote:

> >> 2. is it possible to change the order of calling resume callback?
> >>     for example, suppose the original sequence is "ehci -> xhci -> tty
> >> ..." and I want to change as "tty-> ehci -> xhci".
> >
> > It is possible only to a very limited extent.  You can turn async
> > suspend/resume on or off, and this will affect the order.  Of course,
> > when async suspend/resume is off, the total time required will be
> > longer than when it is on.
> >
> > Why do you want to change the order?  It shouldn't make any difference.
> Because I want the GUI and input part of driver resume as earlier as possible.
> Such that user can keep on their previous work more quicker.

I doubt it will make any noticeable difference.  Remember, userspace 
remains frozen until _all_ the devices have been resumed.  Until that 
happens, the user can't do anything.

> when I "echo 1 > /sys/power/pm_print_time" on my embedded system,
> there are some message I am curious.
> after we resume ehci by " call platform3-ehci.0+ returned 0 after 7746
> usecs" and
> type driver "call usb3+ returned 0 after 100475 usecs
> 
> why there come below resume message:
> "calling  ehci.2+ @ 63, parent: none
> bus resume
> call ehci.2+ returned 0 after 2 usecs
> "

Because your system has a device named "ehci.2".  If you look through
the dmesg log for boot-up you should be able to find it.

Alan Stern

