From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [Update][PATCH] USB / PM: Drop CONFIG_PM_RUNTIME from the USB
 core
Date: Sat, 29 Nov 2014 12:34:36 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1411291233560.23420-100000@netrider.rowland.org>
References: <2562941.6pSKsRYOqk@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:55979 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751043AbaK2Reh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 29 Nov 2014 12:34:37 -0500
In-Reply-To: <2562941.6pSKsRYOqk@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, USB development list <linux-usb@vger.kernel.org>

On Sat, 29 Nov 2014, Rafael J. Wysocki wrote:

> > There are also one or two places in Documentation/usb that mention 
> > CONFIG_PM_RUNTIME.
> 
> I found this in Documentation/usb/power-management.txt:
> 
> "Note: Dynamic PM support for USB is present only if the kernel was
>  built with CONFIG_USB_SUSPEND enabled (which depends on
>  CONFIG_PM_RUNTIME).  System PM support is present only if the kernel
>  was built with CONFIG_SUSPEND or CONFIG_HIBERNATION enabled.
> 
>  (Starting with the 3.10 kernel release, dynamic PM support for USB is
>  present whenever the kernel was built with CONFIG_PM_RUNTIME enabled.
>  The CONFIG_USB_SUSPEND option has been eliminated.)"
> 
> but I'm quite unsure how to change it.  What about:
> 
> "System PM support is present only if the kernel was built with CONFIG_SUSPEND
>  or CONFIG_HIBERNATION enabled.  Dynamic PM support for USB is present whenever
>  the kernel was built with CONFIG_PM enabled.
> 
>  [Historically, dynamic PM support for USB was present only if the kernel
>  had been built with CONFIG_USB_SUSPEND enabled (which depended on
>  CONFIG_PM_RUNTIME).  Starting with the 3.10 kernel release, dynamic PM support
>  for USB was present whenever the kernel was built with CONFIG_PM_RUNTIME
>  enabled.  The CONFIG_USB_SUSPEND option had been eliminated.]

That sounds fine.  Thanks.

Alan Stern

