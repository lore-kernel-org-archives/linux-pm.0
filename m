From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] swsusp regression [Was: 2.6.17-mm1]
Date: Thu, 22 Jun 2006 11:51:18 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0606221144190.8121-100000@iolanthe.rowland.org>
References: <20060622004648.f1912e34.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750834AbWFVPvU@vger.kernel.org>
In-Reply-To: <20060622004648.f1912e34.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, pavel@suse.cz, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

On Thu, 22 Jun 2006, Andrew Morton wrote:

> On Wed, 21 Jun 2006 23:19:05 -0700
> Greg KH <greg@kroah.com> wrote:
> 
> > > I have the same problems also with suspend to disk. BTW I can't resume
> > > from disk since 2.6.17-rc5-mm1, but I'll try to be more precise
> > > tomorrow, as it seems removing the usb stuff makes it do some more steps
> > > toward resumimg (eg: with usb modules this laptop immediately reboots
> > > after reading all pages, without them I can reach "resuming device.."
> > > stage).
> > 
> > Removing uhci-hcd causes all USB devices to be removed from the system.
> > 
> > Alan, you've been working in the "generic usb" section lately, any ideas
> > why we can't suspend that kind of device now?

See below...

> My laptop has the same problem.

> Shrinking memory... done (0 pages freed)
> hci_usb 3-1:1.1: no suspend for driver hci_usb?
> hci_usb 3-1:1.0: no suspend for driver hci_usb?
>  usbdev3.2_ep00: not suspended
> usb_generic_suspend(): verify_suspended+0x0/0x3c() returns -16
> suspend_device(): usb_generic_suspend+0x0/0x134() returns -16
> Could not suspend device 3-1: error -16
> hci_usb 3-1:1.0: no resume for driver hci_usb?
> hci_usb 3-1:1.1: no resume for driver hci_usb?
> Some devices failed to suspend
> Restarting tasks... done
> 
> 
> What's a usbdev3.2_ep00?

Evidently the regression was caused by Greg's patch making endpoints into 
real struct devices.  usbdev3.2_ep00 is the device corresponding to 
endpoint 0 on device 2 of USB bus 3.

Is it really true that this patch has been sitting in -mm for several
months (as stated in the cover message to Linus for the new batch of
changes for 2.6.17 sent in yesterday)?

There are several possible ways to fix this.  One is to add suspend and 
resume routines to the endpoint-device driver.  Another is to change the 
code that checks for the children being suspended, to make it check only 
for child USB devices and not child endpoints.

Alan Stern
