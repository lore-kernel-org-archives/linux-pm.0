From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [Update][PATCH] USB / PM: Drop CONFIG_PM_RUNTIME from the USB core
Date: Sat, 29 Nov 2014 23:33:07 +0100
Message-ID: <1620629.NGrQGDcfut@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1411291233560.23420-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1411291233560.23420-100000@netrider.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, USB development list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, November 29, 2014 12:34:36 PM Alan Stern wrote:
> On Sat, 29 Nov 2014, Rafael J. Wysocki wrote:
> 
> > > There are also one or two places in Documentation/usb that mention 
> > > CONFIG_PM_RUNTIME.
> > 
> > I found this in Documentation/usb/power-management.txt:
> > 
> > "Note: Dynamic PM support for USB is present only if the kernel was
> >  built with CONFIG_USB_SUSPEND enabled (which depends on
> >  CONFIG_PM_RUNTIME).  System PM support is present only if the kernel
> >  was built with CONFIG_SUSPEND or CONFIG_HIBERNATION enabled.
> > 
> >  (Starting with the 3.10 kernel release, dynamic PM support for USB is
> >  present whenever the kernel was built with CONFIG_PM_RUNTIME enabled.
> >  The CONFIG_USB_SUSPEND option has been eliminated.)"
> > 
> > but I'm quite unsure how to change it.  What about:
> > 
> > "System PM support is present only if the kernel was built with CONFIG_SUSPEND
> >  or CONFIG_HIBERNATION enabled.  Dynamic PM support for USB is present whenever
> >  the kernel was built with CONFIG_PM enabled.
> > 
> >  [Historically, dynamic PM support for USB was present only if the kernel
> >  had been built with CONFIG_USB_SUSPEND enabled (which depended on
> >  CONFIG_PM_RUNTIME).  Starting with the 3.10 kernel release, dynamic PM support
> >  for USB was present whenever the kernel was built with CONFIG_PM_RUNTIME
> >  enabled.  The CONFIG_USB_SUSPEND option had been eliminated.]
> 
> That sounds fine.  Thanks.

OK, thanks.

I'll add that to the patch and resend it, then.

Rafael
