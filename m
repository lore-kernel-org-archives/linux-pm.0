From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: any global parameter to know system power state
Date: Thu, 10 Oct 2013 10:35:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1310101032110.1307-100000@iolanthe.rowland.org>
References: <CANudz+ur37HRgygXrzgDPHrg-2LCRfR23sPZ4DWo_R5bRjetxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:56800 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754751Ab3JJOfS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Oct 2013 10:35:18 -0400
In-Reply-To: <CANudz+ur37HRgygXrzgDPHrg-2LCRfR23sPZ4DWo_R5bRjetxg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: loody <miloody@gmail.com>
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On matters concerning xHCI, you really should CC: the xHCI maintainer.

On Thu, 10 Oct 2013, loody wrote:

> in xhci_resume, we will do xhci_halt usually.
> But our embedded system has something wrong and xhci_halt will make it
> core dump during resume.
> 
> I try to know whether there is any global parameter to let us do the
> sw workaround.
> (just like below + line)
> 
> 
> int xhci_resume(struct xhci_hcd *xhci, bool hibernated)
> {
>     u32            command, temp = 0;
>     struct usb_hcd        *hcd = xhci_to_hcd(xhci);
>     struct usb_hcd        *secondary_hcd;
>     int            retval = 0;
>     ....
>     ......
>     xhci_dbg(xhci, "Stop HCD\n");
> +    if (global_pm_state !=resume){
>         xhci_halt(xhci);
> +    }
>     xhci_reset(xhci);
>     spin_unlock_irq(&xhci->lock);
>     ......

Wouldn't it be better to test the platform?  Then the xhci_halt() could 
be skipped on your embedded systems but nowhere else.

Alan Stern

