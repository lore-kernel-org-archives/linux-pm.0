From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 12/12] PM / core: Add AVOID_RPM driver flag
Date: Tue, 17 Oct 2017 17:59:23 +0200
Message-ID: <2493317.bKYzDQ0iOo@aspire.rjw.lan>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <2517917.TZ0hdc7mRJ@aspire.rjw.lan> <1508254397.16112.481.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:50403 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752825AbdJQQJA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Oct 2017 12:09:00 -0400
In-Reply-To: <1508254397.16112.481.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Linux Documentation <linux-doc@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Lee Jones <lee.jones@linaro.org>

On Tuesday, October 17, 2017 5:33:17 PM CEST Andy Shevchenko wrote:
> On Mon, 2017-10-16 at 03:32 +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Define and document a new driver flag, DPM_FLAG_AVOID_RPM, to inform
> > the PM core and middle layer code that the driver has something
> > significant to do in its ->suspend and/or ->resume callbacks and
> > runtime PM should be disabled for the device when these callbacks
> > run.
> > 
> > Setting DPM_FLAG_AVOID_RPM (in addition to DPM_FLAG_SMART_SUSPEND)
> > causes runtime PM to be disabled for the device before invoking the
> > driver's ->suspend callback for it and to be enabled again for it
> > only after the driver's ->resume callback has returned.  In addition
> > to that, if the device is in runtime suspend right after disabling
> > runtime PM for it (which means that there was no reason to resume it
> > from runtime suspend beforehand), the invocation of the ->suspend
> > callback will be skipped for it and it will be left in runtime
> > suspend until the "noirq" phase of the subsequent system resume.
> > 
> > If DPM_FLAG_SMART_SUSPEND is not set, DPM_FLAG_AVOID_RPM has no
> > effect.
> > 
> 
> > +	if (dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) &&
> > +	    dev_pm_test_driver_flags(dev, DPM_FLAG_AVOID_RPM)) {
> 
> Wasn't interface designed to allow something like:
> 	if (dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND | DPM_FLAG_AVOID_RPM)) {
> instead?

That would return true if any of them was set and both are needed here.

> Does it make sense to have a separate definition for
> DPM_FLAG_SMART_SUSPEND | DPM_FLAG_AVOID_RPM ?

Yes, it does IMO, because if you don't provide ->suspend and ->resume
callbacks, it is sufficient if runtime PM is disabled for the device
in __device_suspend_late() which happens anyway.

DPM_FLAG_AVOID_RPM is about disabling it earlier.

Thanks,
Rafael
