From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM / Sleep: Add pm_generic functions to re-use runtime
 PM callbacks
Date: Fri, 22 Nov 2013 13:37:08 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1311221334070.1407-100000@iolanthe.rowland.org>
References: <1385124235-25484-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:37954 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932081Ab3KVShJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Nov 2013 13:37:09 -0500
In-Reply-To: <1385124235-25484-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-usb@vger.kernel.org, Kevin Hilman <khilman@linaro.org>

On Fri, 22 Nov 2013, Ulf Hansson wrote:

> To put devices into low power state during sleep, it sometimes makes
> sense at subsystem-level to re-use device's runtime PM callbacks.
> 
> The PM core will at device_suspend_late disable runtime PM, after that
> we can safely operate on these callbacks. At suspend_late the device
> will be put into low power state by invoking the device's
> runtime_suspend callback, unless the runtime status is already
> suspended. At resume_early the state is restored by invoking the
> device's runtime_resume callback. Soon after the PM core will re-enable
> runtime PM before returning from device_resume_early.
> 
> These are new pm_generic functions, which are supposed to be used in
> pairs:
> - pm_generic_suspend_late_runtime / pm_generic_resume_early_runtime
> - pm_generic_freeze_late_runtime / pm_generic_thaw_early_runtime
> - pm_generic_poweroff_late_runtime / pm_generic_restore_early_runtime

The last four aren't needed.  They do exactly the same things as the 
first two.  If you insist on having those names available for drivers,
just do:

#define pm_generic_freeze_late_runtime	pm_generic_suspend_late_runtime
... etc.

Aside from that, this looks okay.

Alan Stern

