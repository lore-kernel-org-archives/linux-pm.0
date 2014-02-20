From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: how to know how long it takes on suspend/resume for platform
 usb driver
Date: Thu, 20 Feb 2014 12:08:17 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1402201204520.888-100000@iolanthe.rowland.org>
References: <CANudz+ujM_fhOCEKGhMVV3CWg5_zTJM+n5OVTm+7fHcVV8jK9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:42535 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754315AbaBTRIS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2014 12:08:18 -0500
In-Reply-To: <CANudz+ujM_fhOCEKGhMVV3CWg5_zTJM+n5OVTm+7fHcVV8jK9g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: loody <miloody@gmail.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>

On Fri, 21 Feb 2014, loody wrote:

> >> after tracing the kernel src, I found the usb resume call back is
> >> called in drivers/base/power/main.c -> dpm_resume.
> >>
> >> is that the only way usb resume functions could be called?
> >
> > Yes.
> I found all usb devices will be register as dev->power.async_suspend
> =1 in usb_new_device.
> 
> if all usb devices' resume will be finished in
> drivers/base/power/main.c -> dpm_resume, what is the difference to
> register these devices as async_suspend =1?
> Doesn't async_schedule in dpm_resume will let those async_suspend =1
> devices resume after calling dpm_resume?

Sorry, I should have been more careful in my reply.

The resume routines are always called from device_resume.  If
async_suspend is set to 0 then dpm_resume calls device_resume directly.  
If async_suspend is set to 1 then dpm_resume starts up an async thread,
which calls device_resume indirectly (by way of async_resume).

Alan Stern

